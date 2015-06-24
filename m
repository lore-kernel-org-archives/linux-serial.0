From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/9] arm: twr-k70f120m: extend Freescale eDMA driver with
 ability to support Kinetis SoC
Date: Wed, 24 Jun 2015 21:44:23 +0530
Message-ID: <20150624161423.GO19530@localhost>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl>
 <1435094387-20146-9-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435094387-20146-9-git-send-email-pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Nathan Lynch <nathan_lynch-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Nicolas
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 23, 2015 at 11:19:46PM +0200, Paul Osmialowski wrote:
> Surprisingly small amount of work was required in order to extend already
> existing eDMA driver with the support for Kinetis SoC architecture.
> 
> Note that <mach/memory.h> is needed (which is denoted by
> CONFIG_NEED_MACH_MEMORY_H) as it provides macros required for proper
> operation of DMA allocation functions.
> 
> Signed-off-by: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/dma/fsl-edma.txt | 38 +++++++++-
>  arch/arm/Kconfig                                   |  4 ++
>  arch/arm/boot/dts/kinetis.dtsi                     | 34 +++++++++
>  arch/arm/mach-kinetis/include/mach/memory.h        | 61 ++++++++++++++++
>  drivers/clk/clk-kinetis.c                          | 15 ++++
>  drivers/dma/fsl-edma.c                             | 81 +++++++++++++++++++++-
>  include/dt-bindings/clock/kinetis-mcg.h            |  5 +-
having so many change into one patch is not a great idea, please breka them
up. I am looking for single/multiple patches which only touch dmaengine
files


> +#ifdef CONFIG_ARCH_KINETIS
> +static const char * const txirq_names[] = {
> +	"edma-tx-0,16",
> +	"edma-tx-1,17",
> +	"edma-tx-2,18",
> +	"edma-tx-3,19",
> +	"edma-tx-4,20",
> +	"edma-tx-5,21",
> +	"edma-tx-6,22",
> +	"edma-tx-7,23",
> +	"edma-tx-8,24",
> +	"edma-tx-9,25",
> +	"edma-tx-10,26",
> +	"edma-tx-11,27",
> +	"edma-tx-12,28",
> +	"edma-tx-13,29",
> +	"edma-tx-14,30",
> +	"edma-tx-15,31",
> +};
why do we need this array, these seem to come from DT, right?
> +#endif
> +
>  struct fsl_edma_engine {
>  	struct dma_device	dma_dev;
>  	void __iomem		*membase;
> +#ifdef CONFIG_ARCH_KINETIS
> +	struct clk		*clk;
> +#endif
>  	void __iomem		*muxbase[DMAMUX_NR];
>  	struct clk		*muxclk[DMAMUX_NR];
>  	struct mutex		fsl_edma_mutex;
>  	u32			n_chans;
> +#ifdef CONFIG_ARCH_KINETIS
> +	int			txirq[ARRAY_SIZE(txirq_names)];
> +#else
>  	int			txirq;
> +#endif
>  	int			errirq;
>  	bool			big_endian;
>  	struct fsl_edma_chan	chans[];
we can define these bits and only be used on kinetis machines?

> @@ -709,6 +737,7 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifndef CONFIG_ARCH_KINETIS
>  static irqreturn_t fsl_edma_irq_handler(int irq, void *dev_id)
>  {
>  	if (fsl_edma_tx_handler(irq, dev_id) == IRQ_HANDLED)
> @@ -716,6 +745,7 @@ static irqreturn_t fsl_edma_irq_handler(int irq, void *dev_id)
>  
>  	return fsl_edma_err_handler(irq, dev_id);
>  }
> +#endif
>  
>  static void fsl_edma_issue_pending(struct dma_chan *chan)
>  {
> @@ -788,15 +818,29 @@ static void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  }
>  
>  static int
> -fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
> +fsl_edma_irq_init(struct platform_device *pdev,
> +		  struct fsl_edma_engine *fsl_edma)
>  {
>  	int ret;
> +#ifdef CONFIG_ARCH_KINETIS
> +	int i;
>  
> +	for (i = 0; i < ARRAY_SIZE(txirq_names); i++) {
> +		fsl_edma->txirq[i] = platform_get_irq_byname(pdev,
> +					txirq_names[i]);
> +		if (fsl_edma->txirq[i] < 0) {
> +			dev_err(&pdev->dev, "Can't get %s irq.\n",
> +						txirq_names[i]);
> +			return fsl_edma->txirq[i];
> +		}
> +	}
> +#else
>  	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
>  	if (fsl_edma->txirq < 0) {
>  		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
>  		return fsl_edma->txirq;
>  	}
> +#endif
can you have two routines and with one of them onvoked based on machine type
which should be configured based on DT data rather

>  
>  	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
>  	if (fsl_edma->errirq < 0) {
> @@ -804,6 +848,16 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
>  		return fsl_edma->errirq;
>  	}
>  
> +#ifdef CONFIG_ARCH_KINETIS
> +	for (i = 0; i < ARRAY_SIZE(txirq_names); i++) {
> +		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq[i],
> +			fsl_edma_tx_handler, 0, txirq_names[i], fsl_edma);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
> +			return  ret;
> +		}
> +	}
> +#else
>  	if (fsl_edma->txirq == fsl_edma->errirq) {
>  		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
>  				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
> @@ -818,6 +872,7 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
>  			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
>  			return  ret;
>  		}
> +#endif
only one of them will be populated so if-else should work too

please get rid of these ifdef stuff and make it based on DT data based flags

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
