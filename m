From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] serial: fsl_lpuart: add earlycon support
Date: Sat, 17 Oct 2015 00:45:55 -0700
Message-ID: <1445067955-26378-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: robh@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

Add support for DT and command line based earlycon support for
lpuart and lpuart32 used on Freescale Vybrid and and QorIQ LS1021A
processors.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/kernel-parameters.txt |  7 +++++++
 drivers/tty/serial/Kconfig          |  1 +
 drivers/tty/serial/fsl_lpuart.c     | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22a4b68..8d9dd53 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1023,6 +1023,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			serial port must already be setup and configured.
 			Options are not yet supported.
 
+		lpuart,<addr>
+		lpuart32,<addr>
+			Use early console provided by Freescale LP UART driver
+			found on Freescale Vybrid and QorIQ LS1021A processors.
+			A valid base address must be provided, and the serial
+			port must already be setup and configured.
+
 	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k]
 			earlyprintk=vga
 			earlyprintk=efi
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 687b1ea..3a26854 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1538,6 +1538,7 @@ config SERIAL_FSL_LPUART
 	tristate "Freescale lpuart serial port support"
 	depends on HAS_DMA
 	select SERIAL_CORE
+	select SERIAL_EARLYCON
 	help
 	  Support for the on-chip lpuart on some Freescale SOCs.
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 08ce76f..3d79003 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1746,6 +1746,45 @@ static struct console lpuart32_console = {
 	.data		= &lpuart_reg,
 };
 
+static void lpuart_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, lpuart_console_putchar);
+}
+
+static void lpuart32_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, lpuart32_console_putchar);
+}
+
+static int __init lpuart_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = lpuart_early_write;
+	return 0;
+}
+
+static int __init lpuart32_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = lpuart32_early_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
+EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
+EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
+
 #define LPUART_CONSOLE	(&lpuart_console)
 #define LPUART32_CONSOLE	(&lpuart32_console)
 #else
-- 
2.6.1
