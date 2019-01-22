From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date: Tue, 22 Jan 2019 12:03:33 +0530
Message-ID: <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org
List-Id: linux-serial@vger.kernel.org

Get the interconnect paths for I2C based Serial Engine device
and vote accordingly based on maximum supported I2C frequency.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index db075bc..e8fe63a 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
 #include <linux/spinlock.h>
+#include <linux/interconnect.h>
 
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
@@ -508,6 +509,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Set the bus quota to a reasonable value */
+	gi2c->se.avg_bw = Bps_to_icc(1000);
+	gi2c->se.peak_bw = Bps_to_icc(76800000);
+	ret = geni_interconnect_init(&gi2c->se);
+	if (ret) {
+		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
+		return ret;
+	}
+
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
 							&gi2c->clk_freq_out);
 	if (ret) {
@@ -611,6 +621,8 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		gi2c->suspended = 1;
 	}
 
+	geni_icc_update_bw(&gi2c->se, false);
+
 	return 0;
 }
 
@@ -619,6 +631,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
+	geni_icc_update_bw(&gi2c->se, true);
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
