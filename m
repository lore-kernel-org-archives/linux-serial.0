From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 09:17:52 +0800
Message-ID: <20150226011750.GB20028@dragon>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
 <54EE38E9.3060405@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54EE38E9.3060405@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 25, 2015 at 01:04:41PM -0800, Stephen Boyd wrote:
> > diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> > index 75870c0ea2c9..91eb3aef7f02 100644
> > --- a/sound/soc/fsl/fsl_spdif.c
> > +++ b/sound/soc/fsl/fsl_spdif.c
> > @@ -1049,7 +1049,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
> >  				enum spdif_txrate index, bool round)
> >  {
> >  	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
> > -	bool is_sysclk = clk == spdif_priv->sysclk;
> > +	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
> >  	u64 rate_ideal, rate_actual, sub;
> >  	u32 sysclk_dfmin, sysclk_dfmax;
> >  	u32 txclk_df, sysclk_df, arate;
> > @@ -1143,7 +1143,7 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
> >  			spdif_priv->txclk_src[index], rate[index]);
> >  	dev_dbg(&pdev->dev, "use txclk df %d for %dHz sample rate\n",
> >  			spdif_priv->txclk_df[index], rate[index]);
> > -	if (spdif_priv->txclk[index] == spdif_priv->sysclk)
> > +	if (clk_is_match(spdif_priv->txclk[index], spdif_priv->sysclk))
> >  		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
> >  				spdif_priv->sysclk_df[index], rate[index]);
> >  	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",
> 
> Couldn't this be fixed like this?

It could.  But this fix is less-intuitive and makes the code change
unnecessarily complex, considering we are introducing helper
clk_is_match() anyway.

Shawn

> 
> ----8<----
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index af0429421fc8..1878dd62a247 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/regmap.h>
> +#include <linux/stringify.h>
>  
>  #include <sound/asoundef.h>
>  #include <sound/dmaengine_pcm.h>
> @@ -46,6 +47,8 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
>  
>  #define DEFAULT_RXCLK_SRC	1
>  
> +#define SYSCLK_NUM		5
> +
>  /*
>   * SPDIF control structure
>   * Defines channel status, subcode and Q sub
> @@ -1051,10 +1054,10 @@ static const struct regmap_config fsl_spdif_regmap_config = {
>  
>  static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  				struct clk *clk, u64 savesub,
> -				enum spdif_txrate index, bool round)
> +				enum spdif_txrate index, bool round,
> +				bool is_sysclk)
>  {
>  	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
> -	bool is_sysclk = clk == spdif_priv->sysclk;
>  	u64 rate_ideal, rate_actual, sub;
>  	u32 sysclk_dfmin, sysclk_dfmax;
>  	u32 txclk_df, sysclk_df, arate;
> @@ -1131,7 +1134,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
>  			continue;
>  
>  		ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
> -					     i == STC_TXCLK_SPDIF_ROOT);
> +					     i == STC_TXCLK_SPDIF_ROOT,
> +					     i == SYSCLK_NUM);
>  		if (savesub == ret)
>  			continue;
>  
> @@ -1210,7 +1214,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Get system clock for rx clock rate calculation */
> -	spdif_priv->sysclk = devm_clk_get(&pdev->dev, "rxtx5");
> +	spdif_priv->sysclk = devm_clk_get(&pdev->dev,
> +					  "rxtx" __stringify(SYSCLK_NUM));
>  	if (IS_ERR(spdif_priv->sysclk)) {
>  		dev_err(&pdev->dev, "no sys clock (rxtx5) in devicetree\n");
>  		return PTR_ERR(spdif_priv->sysclk);
> 
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
