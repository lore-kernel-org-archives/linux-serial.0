From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 3/6] tty: atmel_serial: switch pm ops
Date: Sun,  7 Oct 2012 09:27:17 +0200
Message-ID: <1349594840-11374-3-git-send-email-plagnioj@jcrosoft.com>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

so we can detect when we enter in slow_clock mode and drop
at91_suspend_entering_slow_clock

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/atmel_serial.c |   52 +++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3d7e1ee..7a51a0c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1720,20 +1720,10 @@ static struct uart_driver atmel_uart = {
 };
 
 #ifdef CONFIG_PM
-static bool atmel_serial_clk_will_stop(void)
+static int atmel_serial_suspend(struct device *dev, int slow_clock)
 {
-#ifdef CONFIG_ARCH_AT91
-	return at91_suspend_entering_slow_clock();
-#else
-	return false;
-#endif
-}
-
-static int atmel_serial_suspend(struct platform_device *pdev,
-				pm_message_t state)
-{
-	struct uart_port *port = platform_get_drvdata(pdev);
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct atmel_uart_port *atmel_port = dev_get_drvdata(dev);
+	struct uart_port *port = &atmel_port->uart;
 
 	if (atmel_is_console_port(port) && console_suspend_enabled) {
 		/* Drain the TX shifter */
@@ -1742,30 +1732,43 @@ static int atmel_serial_suspend(struct platform_device *pdev,
 	}
 
 	/* we can not wake up if we're running on slow clock */
-	atmel_port->may_wakeup = device_may_wakeup(&pdev->dev);
-	if (atmel_serial_clk_will_stop())
-		device_set_wakeup_enable(&pdev->dev, 0);
+	atmel_port->may_wakeup = device_may_wakeup(dev);
+	if (slow_clock)
+		device_set_wakeup_enable(dev, 0);
 
 	uart_suspend_port(&atmel_uart, port);
 
 	return 0;
 }
 
-static int atmel_serial_resume(struct platform_device *pdev)
+static int atmel_serial_suspend_standby(struct device *dev)
 {
-	struct uart_port *port = platform_get_drvdata(pdev);
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	return atmel_serial_suspend(dev, 0);
+}
+
+static int atmel_serial_suspend_mem(struct device *dev)
+{
+	return atmel_serial_suspend(dev, 1);
+}
+
+static int atmel_serial_resume(struct device *dev)
+{
+	struct atmel_uart_port *atmel_port = dev_get_drvdata(dev);
+	struct uart_port *port = &atmel_port->uart;
 
 	uart_resume_port(&atmel_uart, port);
-	device_set_wakeup_enable(&pdev->dev, atmel_port->may_wakeup);
+	device_set_wakeup_enable(dev, atmel_port->may_wakeup);
 
 	return 0;
 }
-#else
-#define atmel_serial_suspend NULL
-#define atmel_serial_resume NULL
 #endif
 
+static struct dev_pm_ops atmel_serial_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(atmel_serial_suspend_standby, atmel_serial_resume)
+	SET_SYSTEM_SLEEP_STANDBY_MEM_PM_OPS(atmel_serial_suspend_standby,
+				atmel_serial_suspend_mem)
+};
+
 static int __devinit atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
@@ -1877,11 +1880,10 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
 static struct platform_driver atmel_serial_driver = {
 	.probe		= atmel_serial_probe,
 	.remove		= __devexit_p(atmel_serial_remove),
-	.suspend	= atmel_serial_suspend,
-	.resume		= atmel_serial_resume,
 	.driver		= {
 		.name	= "atmel_usart",
 		.owner	= THIS_MODULE,
+		.pm	= &atmel_serial_pm_ops,
 		.of_match_table	= of_match_ptr(atmel_serial_dt_ids),
 	},
 };
-- 
1.7.10.4
