From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 1/2] serial: samsung: Add support for early console
Date: Fri, 23 Jan 2015 14:47:41 +0100
Message-ID: <1422020862-10169-2-git-send-email-m.szyprowski@samsung.com>
References: <1422020862-10169-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422020862-10169-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, thomas.ab@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene@kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Tomasz Figa <t.figa@samsung.com>

This patch adds support for early console initialized from device tree
and kernel command line to all variants of Samsung serial driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
[mszyprow: added support for command line based initialization,
           fixed comments, added documentation]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/kernel-parameters.txt |  12 +++++
 drivers/tty/serial/Kconfig          |   1 +
 drivers/tty/serial/samsung.c        | 103 ++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 7dbe5ec9d9cd..24f363108ab3 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -961,6 +961,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 		smh	Use ARM semihosting calls for early console.
 
+		s3c2410,<addr>
+		s3c2412,<addr>
+		s3c2440,<addr>
+		s3c6400,<addr>
+		s5pv210,<addr>
+		exynos4210,<addr>
+			Use early console provided by serial driver available
+			on Samsung SoCs, requires selecting proper type and
+			a correct base address of the selected UART port. The
+			serial port must already be setup and configured.
+			Options are not yet supported.
+
 	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k]
 			earlyprintk=vga
 			earlyprintk=efi
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 649b784081c7..50997be6cf6d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -241,6 +241,7 @@ config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
 	depends on PLAT_SAMSUNG || ARCH_EXYNOS
 	select SERIAL_CORE
+	select SERIAL_EARLYCON
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
 	  providing /dev/ttySAC0, 1 and 2 (note, some machines may not
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c78f43a481ce..8ad453a5d845 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1856,6 +1856,109 @@ static struct platform_driver samsung_serial_driver = {
 
 module_platform_driver(samsung_serial_driver);
 
+/*
+ * Early console.
+ */
+
+struct samsung_early_console_data {
+	u32 txfull_mask;
+};
+
+static void samsung_early_busyuart(struct uart_port *port)
+{
+	while (!(readl(port->membase + S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXFE))
+		;
+}
+
+static void samsung_early_busyuart_fifo(struct uart_port *port)
+{
+	struct samsung_early_console_data *data = port->private_data;
+
+	while (readl(port->membase + S3C2410_UFSTAT) & data->txfull_mask)
+		;
+}
+
+static void samsung_early_putc(struct uart_port *port, int c)
+{
+	if (readl(port->membase + S3C2410_UFCON) & S3C2410_UFCON_FIFOMODE)
+		samsung_early_busyuart_fifo(port);
+	else
+		samsung_early_busyuart(port);
+
+	writeb(c, port->membase + S3C2410_UTXH);
+}
+
+static void samsung_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, samsung_early_putc);
+}
+
+static int __init samsung_early_console_setup(struct earlycon_device *device,
+					      const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = samsung_early_write;
+	return 0;
+}
+
+/* S3C2410 */
+static struct samsung_early_console_data s3c2410_early_console_data = {
+	.txfull_mask = S3C2410_UFSTAT_TXFULL,
+};
+
+static int __init s3c2410_early_console_setup(struct earlycon_device *device,
+					      const char *opt)
+{
+	device->port.private_data = &s3c2410_early_console_data;
+	return samsung_early_console_setup(device, opt);
+}
+OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
+			s3c2410_early_console_setup);
+EARLYCON_DECLARE(s3c2410, s3c2410_early_console_setup);
+
+/* S3C2412, S3C2440, S3C64xx */
+static struct samsung_early_console_data s3c2440_early_console_data = {
+	.txfull_mask = S3C2440_UFSTAT_TXFULL,
+};
+
+static int __init s3c2440_early_console_setup(struct earlycon_device *device,
+					      const char *opt)
+{
+	device->port.private_data = &s3c2440_early_console_data;
+	return samsung_early_console_setup(device, opt);
+}
+OF_EARLYCON_DECLARE(s3c2412, "samsung,s3c2412-uart",
+			s3c2440_early_console_setup);
+OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
+			s3c2440_early_console_setup);
+OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
+			s3c2440_early_console_setup);
+EARLYCON_DECLARE(s3c2412, s3c2440_early_console_setup);
+EARLYCON_DECLARE(s3c2440, s3c2440_early_console_setup);
+EARLYCON_DECLARE(s3c6400, s3c2440_early_console_setup);
+
+/* S5PV210, EXYNOS */
+static struct samsung_early_console_data s5pv210_early_console_data = {
+	.txfull_mask = S5PV210_UFSTAT_TXFULL,
+};
+
+static int __init s5pv210_early_console_setup(struct earlycon_device *device,
+					      const char *opt)
+{
+	device->port.private_data = &s5pv210_early_console_data;
+	return samsung_early_console_setup(device, opt);
+}
+OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
+			s5pv210_early_console_setup);
+OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
+			s5pv210_early_console_setup);
+EARLYCON_DECLARE(s5pv210, s5pv210_early_console_setup);
+EARLYCON_DECLARE(exynos4210, s5pv210_early_console_setup);
+
 MODULE_ALIAS("platform:samsung-uart");
 MODULE_DESCRIPTION("Samsung SoC Serial port driver");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-- 
1.9.2
