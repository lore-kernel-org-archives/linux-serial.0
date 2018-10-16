From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 3/9] serial-uartlite: Do not use static struct uart_driver out of probe()
Date: Tue, 16 Oct 2018 15:48:02 +0530
Message-ID: <1539685088-13465-4-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

ulite_uart_suspend()/resume() and remove() are using static reference
to struct uart_driver. Assign this referece to private data structure
as preparation step for dynamic struct uart_driver allocation.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 441a216..64c7248 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -63,6 +63,7 @@ static struct uart_port *console_port;
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
 	struct clk *clk;
+	struct uart_driver *ulite_uart_driver;
 };
 
 struct uartlite_reg_ops {
@@ -691,10 +692,11 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 static int ulite_release(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
 	int rc = 0;
 
 	if (port) {
-		rc = uart_remove_one_port(&ulite_uart_driver, port);
+		rc = uart_remove_one_port(pdata->ulite_uart_driver, port);
 		dev_set_drvdata(dev, NULL);
 		port->mapbase = 0;
 	}
@@ -711,9 +713,10 @@ static int ulite_release(struct device *dev)
 static int __maybe_unused ulite_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
 
 	if (port)
-		uart_suspend_port(&ulite_uart_driver, port);
+		uart_suspend_port(pdata->ulite_uart_driver, port);
 
 	return 0;
 }
@@ -727,9 +730,10 @@ static int __maybe_unused ulite_suspend(struct device *dev)
 static int __maybe_unused ulite_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
 
 	if (port)
-		uart_resume_port(&ulite_uart_driver, port);
+		uart_resume_port(pdata->ulite_uart_driver, port);
 
 	return 0;
 }
@@ -804,6 +808,7 @@ static int ulite_probe(struct platform_device *pdev)
 		pdata->clk = NULL;
 	}
 
+	pdata->ulite_uart_driver = &ulite_uart_driver;
 	ret = clk_prepare_enable(pdata->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clock\n");
-- 
2.1.1
