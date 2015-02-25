From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
Date: Wed, 25 Feb 2015 22:53:37 +0800
Message-ID: <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
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
 sound/soc/fsl/fsl_spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 75870c0ea2c9..91eb3aef7f02 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1049,7 +1049,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				enum spdif_txrate index, bool round)
 {
 	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
-	bool is_sysclk = clk == spdif_priv->sysclk;
+	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
 	u32 sysclk_dfmin, sysclk_dfmax;
 	u32 txclk_df, sysclk_df, arate;
@@ -1143,7 +1143,7 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			spdif_priv->txclk_src[index], rate[index]);
 	dev_dbg(&pdev->dev, "use txclk df %d for %dHz sample rate\n",
 			spdif_priv->txclk_df[index], rate[index]);
-	if (spdif_priv->txclk[index] == spdif_priv->sysclk)
+	if (clk_is_match(spdif_priv->txclk[index], spdif_priv->sysclk))
 		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
 				spdif_priv->sysclk_df[index], rate[index]);
 	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",
-- 
1.9.1

