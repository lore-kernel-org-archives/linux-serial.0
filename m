From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg access
Date: Thu,  5 Nov 2015 18:37:47 -0600
Message-ID: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew.Jackson@arm.com, andre.przywara@arm.com, jun.nie@linaro.or, peter@hurleysoftware.com, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-serial@vger.kernel.org

Add the "sbsa32" command-line option to earlycon to specify that the
pl011 registers should be accessed with 32-bit accessors only.  This is
SBSA platforms

Similarly, also add the "zte" option for the ZTE UART.  It's functionally
similar to the standard PL011, but some registers are at different
offsets.

Normal console uses the "access_32b" field of the vendor data structure
to determine whether the registers needs 32-bit accessors.  Early console
is used before the vendor data is available, so we need a different
mechanism to choose the accessor.

Example:

	earlycon=pl011,0x3ced1000,sbsa32

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---

This patch applies on top of Russell's 12-part amba-pl011.c patchset.

 drivers/tty/serial/amba-pl011.c | 46 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 373b152..58eda89 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2301,10 +2301,10 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		;
-	writeb(c, port->membase + REG_DR);
-	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
+	writeb(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
 		;
 }
 
@@ -2315,13 +2315,51 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, pl011_putc);
 }
 
+static void pl011_putc_sbsa32(struct uart_port *port, int c)
+{
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		cpu_relax();
+	writel(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+		cpu_relax();
+}
+
+static void pl011_early_write_sbsa32(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, pl011_putc_sbsa32);
+}
+
+static void pl011_putc_zte(struct uart_port *port, int c)
+{
+	while (readl(port->membase + ZX_UART011_FR) & UART01x_FR_TXFF)
+		cpu_relax();
+	writel(c, port->membase + ZX_UART011_DR);
+	while (readl(port->membase + ZX_UART011_FR) & UART01x_FR_BUSY)
+		cpu_relax();
+}
+
+static void pl011_early_write_zte(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, pl011_putc_zte);
+}
+
 static int __init pl011_early_console_setup(struct earlycon_device *device,
 					    const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = pl011_early_write;
+	if (strcmp(device->options, "sbsa32") == 0)
+		device->con->write = pl011_early_write_sbsa32;
+	else if (strcmp(device->options, "zte") == 0)
+		device->con->write = pl011_early_write_zte;
+	else
+		device->con->write = pl011_early_write;
+
 	return 0;
 }
 EARLYCON_DECLARE(pl011, pl011_early_console_setup);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
