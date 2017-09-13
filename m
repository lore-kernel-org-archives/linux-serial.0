From: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v1 02/10] clk: at91: pmc: Save SCSR during suspend
Date: Wed, 13 Sep 2017 14:10:41 +0200
Message-ID: <318420d4-044f-d018-f70e-3ed4fcfb0fd0@microchip.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-3-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170908153604.28383-3-romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 08/09/2017 at 17:35, Romain Izard wrote:
> The contents of the System Clock Status Register (SCSR) needs to be
> restored into the System Clock Enable Register (SCER).
> 
> As the bootloader will restore some clocks by itself, the issue can be
> missed as only the USB controller, the LCD controller, the Image Sensor
> controller and the programmable clocks will be impacted.
> 
> Fix the obvious typo in the suspend/resume code, as the IMR register
> does not need to be saved twice.
> 
> Signed-off-by: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Yes, it looks like a typo:
Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

I didn't experienced the issue with LCD nor USB though.

Regards,

> ---
>  drivers/clk/at91/pmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 5c2b26de303e..07dc2861ad3f 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -86,7 +86,7 @@ static int pmc_suspend(void)
>  {
>  	int i;
>  
> -	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.scsr);
> +	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
>  	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
>  	regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
>  	regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
> @@ -129,7 +129,7 @@ static void pmc_resume(void)
>  	if (pmc_cache.pllar != tmp)
>  		pr_warn("PLLAR was not configured properly by the firmware\n");
>  
> -	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.scsr);
> +	regmap_write(pmcreg, AT91_PMC_SCER, pmc_cache.scsr);
>  	regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
>  	regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
>  	regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
> 


-- 
Nicolas Ferre
