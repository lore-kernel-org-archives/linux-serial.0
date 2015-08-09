From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 8/8] serial: imx: add pm_qos request
Date: Sun,  9 Aug 2015 11:19:09 -0700
Message-ID: <1439144349-10494-9-git-send-email-edubezval@gmail.com>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This change introduces pm_qos requests in the imx serial driver.
The idea is to skip deeper C-state in case we need a strict
latency requirement in the uart port. The latency is
computed based on the buffer size and the current baud rate.
We schedule a work queue to set the pm qos requirement.

Cc: Fabio Stevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e30d8c0..fe62349 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -42,6 +42,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeup.h>
+#include <linux/pm_qos.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
@@ -223,6 +224,10 @@ struct imx_port {
 	bool			context_saved;
 
 	struct device		*dev;
+	struct pm_qos_request	pm_qos_request;
+	u32			latency;
+	u32			calc_latency;
+	struct work_struct	qos_work;
 	bool			is_suspending;
 };
 
@@ -1316,6 +1321,14 @@ static void imx_flush_buffer(struct uart_port *port)
 	pm_runtime_put_autosuspend(sport->dev);
 }
 
+static void serial_imx_uart_qos_work(struct work_struct *work)
+{
+	struct imx_port *sport = container_of(work, struct imx_port,
+						qos_work);
+
+	pm_qos_update_request(&sport->pm_qos_request, sport->latency);
+}
+
 static void
 imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		   struct ktermios *old)
@@ -1389,6 +1402,12 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
 	quot = uart_get_divisor(port, baud);
 
+	/* calculate wakeup latency constraint */
+	sport->calc_latency = (USEC_PER_SEC * sport->port.fifosize) /
+								(baud / 8);
+	sport->latency = sport->calc_latency;
+	schedule_work(&sport->qos_work);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	sport->port.read_status_mask = 0;
@@ -1923,6 +1942,7 @@ static int serial_imx_suspend(struct device *dev)
 {
 	struct imx_port *sport = dev_get_drvdata(dev);
 
+	flush_work(&sport->qos_work);
 	serial_imx_save_context(sport);
 	/* enable wakeup from i.MX UART */
 	serial_imx_enable_wakeup(sport, true);
@@ -2088,7 +2108,12 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	imx_ports[sport->port.line] = sport;
 
+	sport->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	sport->calc_latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	sport->dev = &pdev->dev;
+	pm_qos_add_request(&sport->pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
+			   sport->latency);
+	INIT_WORK(&sport->qos_work, serial_imx_uart_qos_work);
 	platform_set_drvdata(pdev, sport);
 
 	device_init_wakeup(sport->dev, true);
@@ -2118,6 +2143,7 @@ static int serial_imx_remove(struct platform_device *pdev)
 	clk_unprepare(sport->clk_per);
 	clk_unprepare(sport->clk_ipg);
 	ret = uart_remove_one_port(&imx_reg, &sport->port);
+	pm_qos_remove_request(&sport->pm_qos_request);
 	device_init_wakeup(&pdev->dev, false);
 
 	return ret;
@@ -2144,6 +2170,8 @@ static int serial_imx_runtime_suspend(struct device *dev)
 	serial_imx_save_context(sport);
 	serial_imx_enable_wakeup(sport, true);
 
+	sport->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	schedule_work(&sport->qos_work);
 	clk_disable(sport->clk_per);
 	clk_disable(sport->clk_ipg);
 
@@ -2158,6 +2186,8 @@ static int serial_imx_runtime_resume(struct device *dev)
 	clk_enable(sport->clk_ipg);
 	serial_imx_enable_wakeup(sport, false);
 
+	sport->latency = sport->calc_latency;
+	schedule_work(&sport->qos_work);
 	serial_imx_restore_context(sport);
 
 	return 0;
-- 
2.5.0

