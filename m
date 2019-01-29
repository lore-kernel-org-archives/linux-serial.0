From: Stephen Boyd <swboyd@chromium.org>
Subject: [RFC/PATCH 3/5] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
Date: Mon, 28 Jan 2019 17:55:45 -0800
Message-ID: <20190129015547.213276-4-swboyd@chromium.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129015547.213276-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-serial@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

geni serial needs to express a perforamnce state requirement on CX
depending on the frequency of the clock rates. Use OPP table from
DT to register with OPP framework and use dev_pm_opp_set_rate() to
set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a72d6d9fb983..dca8f6845463 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/qcom-geni-se.h>
 #include <linux/serial.h>
@@ -119,6 +120,7 @@ struct qcom_geni_serial_port {
 	bool brk;
 
 	unsigned int tx_remaining;
+	struct device *dev;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -1028,7 +1030,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		goto out_restart_rx;
 
 	uport->uartclk = clk_rate;
-	clk_set_rate(port->se.clk, clk_rate);
+	dev_pm_opp_set_rate(port->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1265,8 +1267,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
 		geni_se_resources_on(&port->se);
 	else if (new_state == UART_PM_STATE_OFF &&
-			old_state == UART_PM_STATE_ON)
+			old_state == UART_PM_STATE_ON) {
+		dev_pm_opp_set_rate(port->dev, 0);
 		geni_se_resources_off(&port->se);
+	}
 }
 
 static const struct uart_ops qcom_geni_console_pops = {
@@ -1332,6 +1336,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid line %d\n", line);
 		return PTR_ERR(port);
 	}
+	port->dev = &pdev->dev;
 
 	uport = &port->uport;
 	/* Don't allow 2 drivers to access the same port */
@@ -1353,6 +1358,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return -EINVAL;
 	uport->mapbase = res->start;
 
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init OPP table: %d\n", ret);
+		return ret;
+	}
+
 	port->tx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
-- 
Sent by a computer through tubes
