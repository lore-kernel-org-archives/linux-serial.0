From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 2/4] serial: uartps: Use dynamic array for console port
Date: Mon, 23 Apr 2018 11:51:01 +0200
Message-ID: <4878fdc4564d4574b18307f80f1e9a0c00c63111.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Driver console functions are using pointer to static array with fixed
size. There can be only one serial console at the time which is found
by register_console(). register_console() is filling cons->index to
port->line value.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/xilinx_uartps.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 932210331484..789423d081ed 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1206,6 +1206,10 @@ OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p8", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 
+
+/* Static pointer to console port */
+static struct uart_port *console_port;
+
 /**
  * cdns_uart_console_write - perform write operation
  * @co: Console handle
@@ -1215,7 +1219,7 @@ OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 static void cdns_uart_console_write(struct console *co, const char *s,
 				unsigned int count)
 {
-	struct uart_port *port = &cdns_uart_port[co->index];
+	struct uart_port *port = console_port;
 	unsigned long flags;
 	unsigned int imr, ctrl;
 	int locked = 1;
@@ -1261,15 +1265,13 @@ static void cdns_uart_console_write(struct console *co, const char *s,
  */
 static int __init cdns_uart_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port = &cdns_uart_port[co->index];
+	struct uart_port *port = console_port;
+
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
 
-	if (co->index < 0 || co->index >= CDNS_UART_NR_PORTS)
-		return -EINVAL;
-
 	if (!port->membase) {
 		pr_debug("console on " CDNS_UART_TTY_NAME "%i not present\n",
 			 co->index);
@@ -1565,6 +1567,17 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	/*
+	 * If console hasn't been found yet try to assign this port
+	 * because it is required to be assigned for console setup function.
+	 * If register_console() don't assign value, then console_port pointer
+	 * is cleanup.
+	 */
+	if (cdns_uart_uart_driver.cons->index == -1)
+		console_port = port;
+#endif
+
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
 		dev_err(&pdev->dev,
@@ -1572,6 +1585,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_pm_disable;
 	}
 
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	/* This is not port which is used for console that's why clean it up */
+	if (cdns_uart_uart_driver.cons->index == -1)
+		console_port = NULL;
+#endif
+
 	return 0;
 
 err_out_pm_disable:
-- 
2.17.0
