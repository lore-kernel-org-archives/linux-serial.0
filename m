From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH 2/4] serial: uartps: Use dynamic array for console port
Date: Fri, 21 Jul 2017 11:32:25 +0200
Message-ID: <d12d636176b330f5ccfe1325286f902ee0f10680.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Driver console functions are using pointer to static array with fixed
size. There can be only one serial console at the time which is found
by register_console(). register_console() is filling cons->index to
port->line value.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4614349403c1..e6470a3111ce 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1211,6 +1211,10 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 
+
+/* Static pointer to console port */
+static struct uart_port *console_port;
+
 /**
  * cdns_uart_console_write - perform write operation
  * @co: Console handle
@@ -1220,7 +1224,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 static void cdns_uart_console_write(struct console *co, const char *s,
 				unsigned int count)
 {
-	struct uart_port *port = &cdns_uart_port[co->index];
+	struct uart_port *port = console_port;
 	unsigned long flags;
 	unsigned int imr, ctrl;
 	int locked = 1;
@@ -1266,15 +1270,13 @@ static void cdns_uart_console_write(struct console *co, const char *s,
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
@@ -1570,6 +1572,17 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
@@ -1577,6 +1590,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
1.9.1
