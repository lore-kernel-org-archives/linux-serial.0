From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 3/9] clk: at91: pmc: Support backup for programmable
 clocks
Date: Fri, 22 Sep 2017 12:31:12 +0200
Message-ID: <d6359e89-7c78-fdec-fbab-eb885017ec58@microchip.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
 <20170915140411.31716-4-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20170915140411.31716-4-romain.izard.pro@gmail.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Romain Izard <romain.izard@mobile-devices.fr>
List-Id: linux-serial@vger.kernel.org

On 15/09/2017 at 16:04, Romain Izard wrote:
> From: Romain Izard <romain.izard@mobile-devices.fr>
> 
> When an AT91 programmable clock is declared in the device tree, register
> it into the Power Management Controller driver. On entering suspend mode,
> the driver saves and restores the Programmable Clock registers to support
> the backup mode for these clocks.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Romain,

Some nitpicking and one comment. But on the overall patch, here is my:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

See below:

> ---
> Changes in v2:
> * register PCKs on clock startup
> 
>  drivers/clk/at91/clk-programmable.c |  2 ++
>  drivers/clk/at91/pmc.c              | 27 +++++++++++++++++++++++++++
>  drivers/clk/at91/pmc.h              |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
> index 85a449cf61e3..0e6aab1252fc 100644
> --- a/drivers/clk/at91/clk-programmable.c
> +++ b/drivers/clk/at91/clk-programmable.c
> @@ -204,6 +204,8 @@ at91_clk_register_programmable(struct regmap *regmap,
>  	if (ret) {
>  		kfree(prog);
>  		hw = ERR_PTR(ret);

Nit: "else" not needed.

> +	} else {
> +		pmc_register_pck(id);
>  	}
>  
>  	return hw;
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 07dc2861ad3f..3910b7537152 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -22,6 +22,7 @@
>  #include "pmc.h"
>  
>  #define PMC_MAX_IDS 128
> +#define PMC_MAX_PCKS 8
>  
>  int of_at91_get_clk_range(struct device_node *np, const char *propname,
>  			  struct clk_range *range)
> @@ -50,6 +51,7 @@ EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
>  static struct regmap *pmcreg;
>  
>  static u8 registered_ids[PMC_MAX_IDS];
> +static u8 registered_pcks[PMC_MAX_PCKS];
>  
>  static struct
>  {
> @@ -66,8 +68,10 @@ static struct
>  	u32 pcr[PMC_MAX_IDS];
>  	u32 audio_pll0;
>  	u32 audio_pll1;
> +	u32 pckr[PMC_MAX_PCKS];
>  } pmc_cache;
>  
> +/* Clock ID 0 is invalid */

(read: so we can use the 0 value as an indicator that this place in the
table hasn't been filled, so unused)

>  void pmc_register_id(u8 id)
>  {
>  	int i;
> @@ -82,6 +86,21 @@ void pmc_register_id(u8 id)
>  	}
>  }
>  
> +/* Programmable Clock 0 is valid */

I understand the rationale behind these ^^ two comments, but I would
like that it's more explicit. Saying that you will store the pck id as
(id + 1) and that you would have to invert this operation while using
the stored id.
Maybe add a comment about this transformation to the struct definition
as well...


> +void pmc_register_pck(u8 pck)
> +{
> +	int i;
> +
> +	for (i = 0; i < PMC_MAX_PCKS; i++) {
> +		if (registered_pcks[i] == 0) {
> +			registered_pcks[i] = pck + 1;
> +			break;
> +		}
> +		if (registered_pcks[i] == (pck + 1))
> +			break;
> +	}
> +}
> +
>  static int pmc_suspend(void)
>  {
>  	int i;
> @@ -103,6 +122,10 @@ static int pmc_suspend(void)
>  		regmap_read(pmcreg, AT91_PMC_PCR,
>  			    &pmc_cache.pcr[registered_ids[i]]);
>  	}
> +	for (i = 0; registered_pcks[i]; i++) {
> +		u8 num = registered_pcks[i] - 1;

Nit: declaration are better made at the beginning of the function. This
lead to a checkpatch warning:
"WARNING: Missing a blank line after declarations"

> +		regmap_read(pmcreg, AT91_PMC_PCKR(num), &pmc_cache.pckr[num]);
> +	}
>  
>  	return 0;
>  }
> @@ -143,6 +166,10 @@ static void pmc_resume(void)
>  			     pmc_cache.pcr[registered_ids[i]] |
>  			     AT91_PMC_PCR_CMD);
>  	}
> +	for (i = 0; registered_pcks[i]; i++) {
> +		u8 num = registered_pcks[i] - 1;

Ditto

> +		regmap_write(pmcreg, AT91_PMC_PCKR(num), pmc_cache.pckr[num]);
> +	}
>  
>  	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
>  		mask |= AT91_PMC_LOCKU;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 858e8ef7e8db..d22b1fa9ecdc 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -31,8 +31,10 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
>  
>  #ifdef CONFIG_PM
>  void pmc_register_id(u8 id);
> +void pmc_register_pck(u8 pck);
>  #else
>  static inline void pmc_register_id(u8 id) {}
> +static inline void pmc_register_pck(u8 pck) {}
>  #endif
>  
>  #endif /* __PMC_H_ */
> 


-- 
Nicolas Ferre
