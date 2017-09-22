From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 1/9] clk: at91: pmc: Wait for clocks when resuming
Date: Fri, 22 Sep 2017 14:13:26 +0200
Message-ID: <e5e1fb83-3106-3f8f-26d6-8b2d3cb4748a@microchip.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
 <20170915140411.31716-2-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20170915140411.31716-2-romain.izard.pro@gmail.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 15/09/2017 at 16:04, Romain Izard wrote:
> Wait for the syncronization of all clocks when resuming, not only the
> UPLL clock. Do not use regmap_read_poll_timeout, as it will call BUG()
> when interrupts are masked, which is the case in here.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

And here is my:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  drivers/clk/at91/pmc.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 775af473fe11..5c2b26de303e 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -107,10 +107,20 @@ static int pmc_suspend(void)
>  	return 0;
>  }
>  
> +static bool pmc_ready(unsigned int mask)
> +{
> +	unsigned int status;
> +
> +	regmap_read(pmcreg, AT91_PMC_SR, &status);
> +
> +	return ((status & mask) == mask) ? 1 : 0;
> +}
> +
>  static void pmc_resume(void)
>  {
> -	int i, ret = 0;
> +	int i;
>  	u32 tmp;
> +	u32 mask = AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
>  
>  	regmap_read(pmcreg, AT91_PMC_MCKR, &tmp);
>  	if (pmc_cache.mckr != tmp)
> @@ -134,13 +144,11 @@ static void pmc_resume(void)
>  			     AT91_PMC_PCR_CMD);
>  	}
>  
> -	if (pmc_cache.uckr & AT91_PMC_UPLLEN) {
> -		ret = regmap_read_poll_timeout(pmcreg, AT91_PMC_SR, tmp,
> -					       !(tmp & AT91_PMC_LOCKU),
> -					       10, 5000);
> -		if (ret)
> -			pr_crit("USB PLL didn't lock when resuming\n");
> -	}
> +	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
> +		mask |= AT91_PMC_LOCKU;
> +
> +	while (!pmc_ready(mask))
> +		cpu_relax();
>  }
>  
>  static struct syscore_ops pmc_syscore_ops = {
> 


-- 
Nicolas Ferre
