From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/1] tty: serial: qcom_geni_serial: Update the oversampling rate
Date: Thu,  1 Aug 2019 17:41:53 +0530
Message-ID: <20190801121153.10613-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

For QUP IP versions 2.5 and above the oversampling rate is halved
from 32 to 16. Update this rate after reading hardware version
register, so that the clock divider value is correctly set to
achieve required baud rate.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 35e5f9c5d5be..318f811585cc 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -920,12 +920,13 @@ static unsigned long get_clk_cfg(unsigned long clk_freq)
 	return 0;
 }
 
-static unsigned long get_clk_div_rate(unsigned int baud, unsigned int *clk_div)
+static unsigned long get_clk_div_rate(unsigned int baud,
+			unsigned int sampling_rate, unsigned int *clk_div)
 {
 	unsigned long ser_clk;
 	unsigned long desired_clk;
 
-	desired_clk = baud * UART_OVERSAMPLING;
+	desired_clk = baud * sampling_rate;
 	ser_clk = get_clk_cfg(desired_clk);
 	if (!ser_clk) {
 		pr_err("%s: Can't find matching DFS entry for baud %d\n",
@@ -951,12 +952,20 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	u32 ser_clk_cfg;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	unsigned long clk_rate;
+	u32 ver, sampling_rate;
 
 	qcom_geni_serial_stop_rx(uport);
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
 	port->baud = baud;
-	clk_rate = get_clk_div_rate(baud, &clk_div);
+
+	sampling_rate = UART_OVERSAMPLING;
+	/* Sampling rate is halved for IP versions >= 2.5 */
+	ver = geni_se_get_qup_hw_version(&port->se);
+	if (GENI_SE_VERSION_MAJOR(ver) >= 2 && GENI_SE_VERSION_MINOR(ver) >= 5)
+		sampling_rate /= 2;
+
+	clk_rate = get_clk_div_rate(baud, sampling_rate, &clk_div);
 	if (!clk_rate)
 		goto out_restart_rx;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
