From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date: Tue, 22 Jan 2019 12:03:34 +0530
Message-ID: <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, Alok Chauhan <alokc@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Get the interconnect paths for SPI based Serial Engine device
and vote accordingly based on maximum supported SPI frequency.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fdb7cb88..7bbbe9d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/qcom-geni-se.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
+#include <linux/interconnect.h>
 
 /* SPI SE specific registers and respective register fields */
 #define SE_SPI_CPHA		0x224
@@ -589,6 +590,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spin_lock_init(&mas->lock);
 	pm_runtime_enable(&pdev->dev);
 
+	/* Set the bus quota to a reasonable value */
+	mas->se.avg_bw = Bps_to_icc(2500);
+	mas->se.peak_bw = Bps_to_icc(200000000);
+	ret = geni_interconnect_init(&mas->se);
+	if (ret) {
+		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
+		return ret;
+	}
+
 	ret = spi_geni_init(mas);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
@@ -628,8 +638,15 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
 
-	return geni_se_resources_off(&mas->se);
+	ret = geni_se_resources_off(&mas->se);
+	if (ret)
+		return ret;
+
+	geni_icc_update_bw(&mas->se, false);
+
+	return 0;
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
@@ -637,6 +654,7 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	geni_icc_update_bw(&mas->se, true);
 	return geni_se_resources_on(&mas->se);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
