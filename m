From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 8/8] ASoC: kirkwood: fix struct clk pointer comparing
Date: Wed, 25 Feb 2015 22:53:38 +0800
Message-ID: <1424876018-17852-9-git-send-email-shawn.guo@linaro.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-serial@vger.kernel.org

Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
instances"), clk API users can no longer check if two struct clk
pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
simply comparing two pointers.  That's because with the per-user clk
change, a brand new struct clk is created whenever clients try to look
up the clock by calling clk_get() or sister functions like clk_get_sys()
and of_clk_get().  This changes the original behavior where the struct
clk is only created for once when clock driver registers the clock to
CCF in the first place.  The net change here is before commit
035a61c314eb the struct clk pointer is unique for given hardware
clock, while after the commit the pointers returned by clk lookup calls
become different for the same hardware clock.

That said, the struct clk pointer comparing in the code doesn't work any
more.  Call helper function clk_is_match() instead to fix the problem.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index def7d8260c4e..d19483081f9b 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -579,7 +579,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 	} else {
-		if (priv->extclk == priv->clk) {
+		if (clk_is_match(priv->extclk, priv->clk)) {
 			devm_clk_put(&pdev->dev, priv->extclk);
 			priv->extclk = ERR_PTR(-EINVAL);
 		} else {
-- 
1.9.1

