From: Stephen Boyd <swboyd@chromium.org>
Subject: [RFC/PATCH 2/5] OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
Date: Mon, 28 Jan 2019 17:55:44 -0800
Message-ID: <20190129015547.213276-3-swboyd@chromium.org>
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

For devices with performance state, we use dev_pm_opp_set_rate()
to set the appropriate clk rate and the performance state.
We do need a way to *remove* the performance state vote when
we idle the device and turn the clocks off. Use dev_pm_opp_set_rate()
with freq=0 to achieve this.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/opp/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b6516d623c5a..ac5099c237de 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -709,18 +709,24 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct clk *clk;
 	int ret;
 
-	if (unlikely(!target_freq)) {
-		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
-			target_freq);
-		return -EINVAL;
-	}
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
 	}
 
+	if (unlikely(!target_freq)) {
+		if (opp_table->required_opp_tables) {
+			/* drop the performance state vote */
+			dev_pm_genpd_set_performance_state(dev, 0);
+			return 0;
+		} else {
+			dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
+				target_freq);
+			return -EINVAL;
+		}
+	}
+
 	clk = opp_table->clk;
 	if (IS_ERR(clk)) {
 		dev_err(dev, "%s: No clock available for the device\n",
-- 
Sent by a computer through tubes
