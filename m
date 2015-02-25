From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 6/8] ASoC: fsl_esai: fix struct clk pointer comparing
Date: Wed, 25 Feb 2015 22:53:36 +0800
Message-ID: <1424876018-17852-7-git-send-email-shawn.guo@linaro.org>
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
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5c7597191e3f..6e00e51b98c2 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -269,7 +269,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	}
 
 	/* Only EXTAL source can be output directly without using PSR and PM */
-	if (ratio == 1 && clksrc == esai_priv->extalclk) {
+	if (ratio == 1 && clk_is_match(clksrc, esai_priv->extalclk)) {
 		/* Bypass all the dividers if not being needed */
 		ecr |= tx ? ESAI_ECR_ETO : ESAI_ECR_ERO;
 		goto out;
-- 
1.9.1

