From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 08/13] irqchip: exynos-combiner: set irq base as 256 for Exynos5420
Date: Sat, 08 Jun 2013 13:24:08 +0200
Message-ID: <10384466.JjqLnPF4lt@flatron>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org> <1370516488-25860-8-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1370516488-25860-8-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Thursday 06 of June 2013 16:31:22 Chander Kashyap wrote:
> Exynos5420 uses 256 GIC interrupts unlike the previous Exynos SoCs which
> had upto 160 GIC interrupts. Since the exynos-combiner driver uses irq
> domain simple to support some of the Exynos4 non-dt platforms, the
> irq_base is set temporarily to 256 for Exynos5420 combiner interrupts.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/irqchip/exynos-combiner.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/exynos-combiner.c
> b/drivers/irqchip/exynos-combiner.c index a9d2b2f..465271f 100644
> --- a/drivers/irqchip/exynos-combiner.c
> +++ b/drivers/irqchip/exynos-combiner.c
> @@ -267,7 +267,10 @@ static int __init combiner_of_init(struct
> device_node *np, * get their IRQ from DT, remove this in order to get
> dynamic * allocation.
>  	 */
> -	irq_base = 160;
> +	if (soc_is_exynos5420())
> +		irq_base = 256;
> +	else
> +		irq_base = 160;

I'm not sure if this is needed in any way, since Exynos4 non-DT support is 
going to be removed in 3.11.

Even if yes, IMHO a much better solution would be:

	if (of_have_populated_dt())
		irq_base = 0;
	else
		irq_base = 160;

This way, when running with DT, combiner would get a linear IRQ domain, 
without any hardcoded IRQ base.

Best regards,
Tomasz

>  	combiner_init(combiner_base, np, max_nr, irq_base);
