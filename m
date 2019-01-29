From: Stephen Boyd <swboyd@chromium.org>
Subject: [RFC/PATCH 4/5] spi: spi-geni-qcom: Use OPP API to set clk/perf state
Date: Mon, 28 Jan 2019 17:55:46 -0800
Message-ID: <20190129015547.213276-5-swboyd@chromium.org>
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

geni spi needs to express a perforamnce state requirement on CX
depending on the frequency of the clock rates. Use OPP table from
DT to register with OPP framework and use dev_pm_opp_set_rate() to
set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fdb7cb88fb56..3ffb6b25b58d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -116,9 +116,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = clk_set_rate(se->clk, sclk_freq);
+	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
 	return ret;
 }
 
@@ -564,6 +564,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (!spi)
 		return -ENOMEM;
 
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init OPP table: %d\n", ret);
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
 	mas->irq = irq;
@@ -629,6 +635,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	/* Drop the performance state vote */
+	dev_pm_opp_set_rate(dev, 0);
 	return geni_se_resources_off(&mas->se);
 }
 
-- 
Sent by a computer through tubes
