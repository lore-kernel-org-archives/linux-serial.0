From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 04/10] serial: uartps: Do not use static struct uart_driver out of probe()
Date: Mon,  3 Sep 2018 15:10:52 +0200
Message-ID: <f8084742bbd28b7b9bc6e3374ead4294600ee51e.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

cdns_uart_suspend()/resume() and remove() are using static reference
to struct uart_driver. Assign this reference to private data structure
as preparation step for dynamic struct uart_driver allocation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fc0ecaf3615d..5bd2b0607df6 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -180,6 +180,7 @@
  * @port:		Pointer to the UART port
  * @uartclk:		Reference clock
  * @pclk:		APB clock
+ * @cdns_uart_driver:	Pointer to UART driver
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
@@ -188,6 +189,7 @@ struct cdns_uart {
 	struct uart_port	*port;
 	struct clk		*uartclk;
 	struct clk		*pclk;
+	struct uart_driver	*cdns_uart_driver;
 	unsigned int		baud;
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
@@ -1272,6 +1274,7 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 static int cdns_uart_suspend(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
+	struct cdns_uart *cdns_uart = port->private_data;
 	int may_wake;
 
 	may_wake = device_may_wakeup(device);
@@ -1295,7 +1298,7 @@ static int cdns_uart_suspend(struct device *device)
 	 * Call the API provided in serial_core.c file which handles
 	 * the suspend.
 	 */
-	return uart_suspend_port(&cdns_uart_uart_driver, port);
+	return uart_suspend_port(cdns_uart->cdns_uart_driver, port);
 }
 
 /**
@@ -1307,6 +1310,7 @@ static int cdns_uart_suspend(struct device *device)
 static int cdns_uart_resume(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
+	struct cdns_uart *cdns_uart = port->private_data;
 	unsigned long flags = 0;
 	u32 ctrl_reg;
 	int may_wake;
@@ -1314,8 +1318,6 @@ static int cdns_uart_resume(struct device *device)
 	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && !may_wake) {
-		struct cdns_uart *cdns_uart = port->private_data;
-
 		clk_enable(cdns_uart->pclk);
 		clk_enable(cdns_uart->uartclk);
 
@@ -1349,7 +1351,7 @@ static int cdns_uart_resume(struct device *device)
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-	return uart_resume_port(&cdns_uart_uart_driver, port);
+	return uart_resume_port(cdns_uart->cdns_uart_driver, port);
 }
 #endif /* ! CONFIG_PM_SLEEP */
 static int __maybe_unused cdns_runtime_suspend(struct device *dev)
@@ -1413,6 +1415,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
+
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
 		const struct cdns_platform_data *data = match->data;
@@ -1570,7 +1574,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
-	rc = uart_remove_one_port(&cdns_uart_uart_driver, port);
+	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
-- 
1.9.1
