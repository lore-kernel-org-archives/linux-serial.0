From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/6] clk: at91: implement suspend/resume for the PMC irqchip
Date: Mon, 09 Mar 2015 15:34:06 -0700
Message-ID: <20150309223406.14952.5669@quantum>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-5-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425287898-15093-5-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Quoting Boris Brezillon (2015-03-02 01:18:16)
> The irq line used by the PMC block is shared with several peripherals
> including the init timer which is registering its handler with
> IRQF_NO_SUSPEND.
> Implement the appropriate suspend/resume callback for the PMC irqchip,
> and inform irq core that PMC irq handler can be safely called while
> the system is suspended by setting IRQF_COND_SUSPEND.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Looks OK to me. I'm not picking it due to the dependency you listed in
the cover letter.

Regards,
Mike

> ---
>  drivers/clk/at91/pmc.c | 20 +++++++++++++++++++-
>  drivers/clk/at91/pmc.h |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index f07c815..3f27d21 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -89,12 +89,29 @@ static int pmc_irq_set_type(struct irq_data *d, unsigned type)
>         return 0;
>  }
>  
> +static void pmc_irq_suspend(struct irq_data *d)
> +{
> +       struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
> +
> +       pmc->imr = pmc_read(pmc, AT91_PMC_IMR);
> +       pmc_write(pmc, AT91_PMC_IDR, pmc->imr);
> +}
> +
> +static void pmc_irq_resume(struct irq_data *d)
> +{
> +       struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
> +
> +       pmc_write(pmc, AT91_PMC_IER, pmc->imr);
> +}
> +
>  static struct irq_chip pmc_irq = {
>         .name = "PMC",
>         .irq_disable = pmc_irq_mask,
>         .irq_mask = pmc_irq_mask,
>         .irq_unmask = pmc_irq_unmask,
>         .irq_set_type = pmc_irq_set_type,
> +       .irq_suspend = pmc_irq_suspend,
> +       .irq_resume = pmc_irq_resume,
>  };
>  
>  static struct lock_class_key pmc_lock_class;
> @@ -224,7 +241,8 @@ static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
>                 goto out_free_pmc;
>  
>         pmc_write(pmc, AT91_PMC_IDR, 0xffffffff);
> -       if (request_irq(pmc->virq, pmc_irq_handler, IRQF_SHARED, "pmc", pmc))
> +       if (request_irq(pmc->virq, pmc_irq_handler,
> +                       IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc))
>                 goto out_remove_irqdomain;
>  
>         return pmc;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 52d2041..69abb08 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -33,6 +33,7 @@ struct at91_pmc {
>         spinlock_t lock;
>         const struct at91_pmc_caps *caps;
>         struct irq_domain *irqdomain;
> +       u32 imr;
>  };
>  
>  static inline void pmc_lock(struct at91_pmc *pmc)
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
