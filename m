From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/9] arm: twr-k70f120m: extend Freescale eDMA driver
 with the ability to support Kinetis SoC
Date: Sun, 5 Jul 2015 12:15:46 +0530
Message-ID: <20150705064546.GY3246@localhost>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-7-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1435667250-28299-7-git-send-email-pawelo@king.net.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <r.herring@freescale.com>, Alexander Potashev <aspotashev@emcraft.com>, Jiri Slaby <jslaby@suse.cz>, linux-clk@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Anson Huang <b20788@freescale.com>, Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri Tikhonov <yur@emcraft.com>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.inf
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 30, 2015 at 02:27:27PM +0200, Paul Osmialowski wrote:
The patch title is not per subsystem semantics, pls fix that

> Surprisingly small amount of work was required in order to extend already
> existing eDMA driver with the support for Kinetis SoC architecture.
And this doesn't tell me the stuff you added/removed/fixed in current driver
to extend to Kinetis. Our changelog should tell what changed and why

Btw is this patch dependent upon the rest of the series?

>  
>  static int
> -fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
> +fsl_edma_irq_init(struct platform_device *pdev,
> +		  struct fsl_edma_engine *fsl_edma)
please keep style changes in a separate patch

>  {
> +	struct device_node *np = pdev->dev.of_node;
> +	int irq, errirq;
>  	int ret;
>  
> -	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
> -	if (fsl_edma->txirq < 0) {
> -		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
> -		return fsl_edma->txirq;
> -	}
> -
> -	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
> -	if (fsl_edma->errirq < 0) {
> +	errirq = platform_get_irq_byname(pdev, "edma-err");
> +	if (errirq < 0) {
>  		dev_err(&pdev->dev, "Can't get edma-err irq.\n");
> -		return fsl_edma->errirq;
> +		return irq;
shouldn't this be errirq

>  	}
>  
> -	if (fsl_edma->txirq == fsl_edma->errirq) {
> -		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
> -				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't register eDMA IRQ.\n");
> -			 return  ret;
> +	if (fsl_edma->kinetis) {
> +		int i;
> +		int irqs = of_irq_count(np);
> +
> +		if (irqs <= 1) {
> +			dev_err(&pdev->dev, "Wrong eDMA irq count %d\n", irqs);
> +			return -EINVAL;
why not return irqs?

>  		}
> -	} else {
> -		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
> +
> +		for (i = 0; i < (irqs - 1); i++) {
> +			char irq_name[32];
> +
> +			sprintf(irq_name, "edma-tx-%d,%d", i, 16 + i);
> +			irq = platform_get_irq_byname(pdev, irq_name);
> +			if (irq < 0) {
> +				dev_err(&pdev->dev, "Can't get %s irq.\n",
> +							irq_name);
> +				return irq;
> +			}
> +
> +			ret = devm_request_irq(&pdev->dev, irq,
>  				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
> -			return  ret;
> +			if (ret) {
> +				dev_err(&pdev->dev, "Can't register %s IRQ.\n",
> +							irq_name);
> +				return  ret;
> +			}
>  		}
>  
> -		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
> -				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
> +		ret = devm_request_irq(&pdev->dev, errirq,
> +			fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
>  		if (ret) {
>  			dev_err(&pdev->dev, "Can't register eDMA err IRQ.\n");
> -			return  ret;
> +		return  ret;
> +		}
> +	} else {
> +		irq = platform_get_irq_byname(pdev, "edma-tx");
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
> +			return irq;
> +		}
> +
> +		if (irq == errirq) {
> +			ret = devm_request_irq(&pdev->dev, irq,
> +				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +						"Can't register eDMA IRQ.\n");
> +				return  ret;
> +			}
> +		} else {
> +			ret = devm_request_irq(&pdev->dev, irq,
> +				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					    "Can't register eDMA tx IRQ.\n");
> +				return  ret;
> +			}
> +
> +			ret = devm_request_irq(&pdev->dev, errirq,
> +				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					    "Can't register eDMA err IRQ.\n");
> +				return  ret;
> +			}
>  		}
>  	}
Okay here we have a bunch of changes without explanation on why these are
required and what are they supposed to do. So it is kind of very difficult to
review!

So please split these up in sequence of patches where each patch does only
ONE thing with right changelog messages

Thanks

-- 
~Vinod
