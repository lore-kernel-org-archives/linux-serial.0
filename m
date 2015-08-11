From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 7/8] serial: imx: add pm_qos request
Date: Mon, 10 Aug 2015 18:35:48 -0700
Message-ID: <1439256949-626-8-git-send-email-edubezval@gmail.com>
References: <1439256949-626-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1439256949-626-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

This change introduces pm_qos requests in the imx serial driver.
The idea is to skip deeper C-state in case we need a strict
latency requirement in the uart port. The latency is
computed based on the buffer size and the current baud rate.
We schedule a work queue to set the pm qos requirement.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7d97a26..5053c82 100644
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
 
@@ -1321,6 +1326,14 @@ static void imx_flush_buffer(struct uart_port *port)
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
@@ -1394,6 +1407,12 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2011,7 +2030,12 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	imx_ports[sport->port.line] = sport;
 
+	sport->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	sport->calc_latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	sport->dev = &pdev->dev;
+	pm_qos_add_request(&sport->pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
+			   sport->latency);
+	INIT_WORK(&sport->qos_work, serial_imx_uart_qos_work);
 	platform_set_drvdata(pdev, sport);
 
 	device_init_wakeup(sport->dev, true);
@@ -2041,6 +2065,7 @@ static int serial_imx_remove(struct platform_device *pdev)
 	clk_unprepare(sport->clk_per);
 	clk_unprepare(sport->clk_ipg);
 	ret = uart_remove_one_port(&imx_reg, &sport->port);
+	pm_qos_remove_request(&sport->pm_qos_request);
 	device_init_wakeup(&pdev->dev, false);
 
 	return ret;
-- 
2.5.0

