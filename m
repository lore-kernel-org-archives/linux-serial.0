From: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH v2 6/9] arm: twr-k70f120m: extend Freescale eDMA driver
 with the ability to support Kinetis SoC
Date: Sun, 5 Jul 2015 11:45:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507051141370.15162@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-7-git-send-email-pawelo@king.net.pl> <20150705064546.GY3246@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150705064546.GY3246@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Uwe
List-Id: linux-serial@vger.kernel.org

Hi Vinod,

You're right, this should be separate patchset. Having patchset too big
leads to huge list of maintainers and lack of focusing on details 
(on-error return values are total mess now!).

I plan to split it into three: 1) initial support (so the proof that 
platform is living could be read only on JTAG), 2) DMA support and 3) UART 
support.

Also in my view extending this DMA driver requires acceptance of initial
platform support first - there's no point in extending this driver without
having support for a platform for which we are extending it.

Thanks,
Paul

On Sun, 5 Jul 2015, Vinod Koul wrote:

> On Tue, Jun 30, 2015 at 02:27:27PM +0200, Paul Osmialowski wrote:
> The patch title is not per subsystem semantics, pls fix that
>
>> Surprisingly small amount of work was required in order to extend already
>> existing eDMA driver with the support for Kinetis SoC architecture.
> And this doesn't tell me the stuff you added/removed/fixed in current driver
> to extend to Kinetis. Our changelog should tell what changed and why
>
> Btw is this patch dependent upon the rest of the series?
>
>>
>>  static int
>> -fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
>> +fsl_edma_irq_init(struct platform_device *pdev,
>> +		  struct fsl_edma_engine *fsl_edma)
> please keep style changes in a separate patch
>
>>  {
>> +	struct device_node *np = pdev->dev.of_node;
>> +	int irq, errirq;
>>  	int ret;
>>
>> -	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
>> -	if (fsl_edma->txirq < 0) {
>> -		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
>> -		return fsl_edma->txirq;
>> -	}
>> -
>> -	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
>> -	if (fsl_edma->errirq < 0) {
>> +	errirq = platform_get_irq_byname(pdev, "edma-err");
>> +	if (errirq < 0) {
>>  		dev_err(&pdev->dev, "Can't get edma-err irq.\n");
>> -		return fsl_edma->errirq;
>> +		return irq;
> shouldn't this be errirq
>
>>  	}
>>
>> -	if (fsl_edma->txirq == fsl_edma->errirq) {
>> -		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
>> -				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
>> -		if (ret) {
>> -			dev_err(&pdev->dev, "Can't register eDMA IRQ.\n");
>> -			 return  ret;
>> +	if (fsl_edma->kinetis) {
>> +		int i;
>> +		int irqs = of_irq_count(np);
>> +
>> +		if (irqs <= 1) {
>> +			dev_err(&pdev->dev, "Wrong eDMA irq count %d\n", irqs);
>> +			return -EINVAL;
> why not return irqs?
>
>>  		}
>> -	} else {
>> -		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
>> +
>> +		for (i = 0; i < (irqs - 1); i++) {
>> +			char irq_name[32];
>> +
>> +			sprintf(irq_name, "edma-tx-%d,%d", i, 16 + i);
>> +			irq = platform_get_irq_byname(pdev, irq_name);
>> +			if (irq < 0) {
>> +				dev_err(&pdev->dev, "Can't get %s irq.\n",
>> +							irq_name);
>> +				return irq;
>> +			}
>> +
>> +			ret = devm_request_irq(&pdev->dev, irq,
>>  				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
>> -		if (ret) {
>> -			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
>> -			return  ret;
>> +			if (ret) {
>> +				dev_err(&pdev->dev, "Can't register %s IRQ.\n",
>> +							irq_name);
>> +				return  ret;
>> +			}
>>  		}
>>
>> -		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
>> -				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
>> +		ret = devm_request_irq(&pdev->dev, errirq,
>> +			fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
>>  		if (ret) {
>>  			dev_err(&pdev->dev, "Can't register eDMA err IRQ.\n");
>> -			return  ret;
>> +		return  ret;
>> +		}
>> +	} else {
>> +		irq = platform_get_irq_byname(pdev, "edma-tx");
>> +		if (irq < 0) {
>> +			dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
>> +			return irq;
>> +		}
>> +
>> +		if (irq == errirq) {
>> +			ret = devm_request_irq(&pdev->dev, irq,
>> +				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
>> +			if (ret) {
>> +				dev_err(&pdev->dev,
>> +						"Can't register eDMA IRQ.\n");
>> +				return  ret;
>> +			}
>> +		} else {
>> +			ret = devm_request_irq(&pdev->dev, irq,
>> +				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
>> +			if (ret) {
>> +				dev_err(&pdev->dev,
>> +					    "Can't register eDMA tx IRQ.\n");
>> +				return  ret;
>> +			}
>> +
>> +			ret = devm_request_irq(&pdev->dev, errirq,
>> +				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
>> +			if (ret) {
>> +				dev_err(&pdev->dev,
>> +					    "Can't register eDMA err IRQ.\n");
>> +				return  ret;
>> +			}
>>  		}
>>  	}
> Okay here we have a bunch of changes without explanation on why these are
> required and what are they supposed to do. So it is kind of very difficult to
> review!
>
> So please split these up in sequence of patches where each patch does only
> ONE thing with right changelog messages
>
> Thanks
>
> -- 
> ~Vinod
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
