From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 5/6] tty: serial: qcom_geni_serial: Add interconnect support
Date: Mon, 21 Jan 2019 16:51:42 +0530
Message-ID: <1548069703-26595-6-git-send-email-alokc@codeaurora.org>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, Alok Chauhan <alokc@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Get the interconnect paths for Uart based Serial Engine device
and vote accordingly based on maximum supported Uart frequency.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a72d6d9..e2ea499 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/interconnect.h>
 
 /* UART specific GENI registers */
 #define SE_UART_LOOPBACK_CFG		0x22c
@@ -1348,6 +1349,22 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Set the bus quota to a reasonable value */
+	port->se.avg_bw = console ? Bps_to_icc(1000) : Bps_to_icc(2500);
+	port->se.peak_bw = Bps_to_icc(76800000);
+	ret = geni_interconnect_init(&port->se);
+	if (ret) {
+		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Vote for interconnect path early. This has to move as part of
+	 * Runtime PM APIs when implemented for better control betwen
+	 * console and non-console usecases
+	 */
+	geni_icc_update_bw(&port->se, true);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
@@ -1385,8 +1402,15 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
+	int ret;
+
+	ret = uart_suspend_port(uport->private_data, uport);
+	if (ret)
+		return ret;
+
+	geni_icc_update_bw(&port->se, false);
 
-	return uart_suspend_port(uport->private_data, uport);
+	return 0;
 }
 
 static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
@@ -1394,6 +1418,7 @@ static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
+	geni_icc_update_bw(&port->se, true);
 	return uart_resume_port(uport->private_data, uport);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
