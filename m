From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH 6/8] tty/serial: pl011: add generic earlycon support
Date: Fri, 21 Mar 2014 16:08:46 -0500
Message-ID: <1395436128-11244-7-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Add earlycon support for the pl011 serial port. This allows enabling
the pl011 for console when early_params are processed. This is based
on the arm64 earlyprintk support and is intended to replace it.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/kernel-parameters.txt |  5 +++--
 drivers/tty/serial/amba-pl011.c     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5ce8b7a..81bdd52 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -887,8 +887,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		uart[8250],io,<addr>[,options]
 		uart[8250],mmio,<addr>[,options]
 		uart[8250],mmio32,<addr>[,options]
-			Start an early, polled-mode console on the 8250/16550
-			UART at the specified I/O port or MMIO address.
+		pl011,<addr>
+			Start an early, polled-mode console on a serial port
+			at the specified I/O port or MMIO address. 8250
 			MMIO inter-register address stride is either 8-bit
 			(mmio) or 32-bit (mmio32).
 			The options are the same as for ttyS, above.
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d4eda24..4227c0a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -303,7 +303,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 
 	/* Optionally make use of an RX channel as well */
 	chan = dma_request_slave_channel(dev, "rx");
-	
+
 	if (!chan && plat->dma_rx_param) {
 		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
 
@@ -2045,6 +2045,34 @@ static struct console amba_console = {
 };
 
 #define AMBA_CONSOLE	(&amba_console)
+
+static void pl011_putc(struct uart_port *port, int c)
+{
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		;
+	writeb(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+		;
+}
+
+static void pl011_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, pl011_putc);
+}
+
+static int __init pl011_early_console_setup(struct earlycon_device *device,
+					    const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = pl011_early_write;
+	return 0;
+}
+EARLYCON_DECLARE(pl011, pl011_early_console_setup);
+
 #else
 #define AMBA_CONSOLE	NULL
 #endif
-- 
1.8.3.2
