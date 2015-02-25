From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
Date: Wed, 25 Feb 2015 13:04:41 -0800
Message-ID: <54EE38E9.3060405@codeaurora.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>, Mike Turquette <mturquette@linaro.org>
Cc: linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 02/25/15 06:53, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> simply comparing two pointers.  That's because with the per-user clk
> change, a brand new struct clk is created whenever clients try to look
> up the clock by calling clk_get() or sister functions like clk_get_sys()
> and of_clk_get().  This changes the original behavior where the struct
> clk is only created for once when clock driver registers the clock to
> CCF in the first place.  The net change here is before commit
> 035a61c314eb the struct clk pointer is unique for given hardware
> clock, while after the commit the pointers returned by clk lookup calls
> become different for the same hardware clock.
>
> That said, the struct clk pointer comparing in the code doesn't work any
> more.  Call helper function clk_is_match() instead to fix the problem.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/fsl/fsl_spdif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 75870c0ea2c9..91eb3aef7f02 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1049,7 +1049,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  				enum spdif_txrate index, bool round)
>  {
>  	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
> -	bool is_sysclk = clk == spdif_priv->sysclk;
> +	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
>  	u64 rate_ideal, rate_actual, sub;
>  	u32 sysclk_dfmin, sysclk_dfmax;
>  	u32 txclk_df, sysclk_df, arate;
> @@ -1143,7 +1143,7 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
>  			spdif_priv->txclk_src[index], rate[index]);
>  	dev_dbg(&pdev->dev, "use txclk df %d for %dHz sample rate\n",
>  			spdif_priv->txclk_df[index], rate[index]);
> -	if (spdif_priv->txclk[index] == spdif_priv->sysclk)
> +	if (clk_is_match(spdif_priv->txclk[index], spdif_priv->sysclk))
>  		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
>  				spdif_priv->sysclk_df[index], rate[index]);
>  	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",

Couldn't this be fixed like this?

----8<----

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index af0429421fc8..1878dd62a247 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 
 #include <sound/asoundef.h>
 #include <sound/dmaengine_pcm.h>
@@ -46,6 +47,8 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
 
 #define DEFAULT_RXCLK_SRC	1
 
+#define SYSCLK_NUM		5
+
 /*
  * SPDIF control structure
  * Defines channel status, subcode and Q sub
@@ -1051,10 +1054,10 @@ static const struct regmap_config fsl_spdif_regmap_config = {
 
 static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				struct clk *clk, u64 savesub,
-				enum spdif_txrate index, bool round)
+				enum spdif_txrate index, bool round,
+				bool is_sysclk)
 {
 	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
-	bool is_sysclk = clk == spdif_priv->sysclk;
 	u64 rate_ideal, rate_actual, sub;
 	u32 sysclk_dfmin, sysclk_dfmax;
 	u32 txclk_df, sysclk_df, arate;
@@ -1131,7 +1134,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			continue;
 
 		ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
-					     i == STC_TXCLK_SPDIF_ROOT);
+					     i == STC_TXCLK_SPDIF_ROOT,
+					     i == SYSCLK_NUM);
 		if (savesub == ret)
 			continue;
 
@@ -1210,7 +1214,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	/* Get system clock for rx clock rate calculation */
-	spdif_priv->sysclk = devm_clk_get(&pdev->dev, "rxtx5");
+	spdif_priv->sysclk = devm_clk_get(&pdev->dev,
+					  "rxtx" __stringify(SYSCLK_NUM));
 	if (IS_ERR(spdif_priv->sysclk)) {
 		dev_err(&pdev->dev, "no sys clock (rxtx5) in devicetree\n");
 		return PTR_ERR(spdif_priv->sysclk);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
