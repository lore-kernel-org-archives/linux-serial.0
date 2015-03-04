From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/6] rtc: at91sam9: rework wakeup and interrupt
 handling
Date: Wed, 4 Mar 2015 18:23:56 +0000
Message-ID: <20150304182356.GC22156@leverpostej>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425287898-15093-3-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>lin
List-Id: linux-serial@vger.kernel.org

Hi Boris,

On Mon, Mar 02, 2015 at 09:18:14AM +0000, Boris Brezillon wrote:
> The IRQ line used by the RTC device is usually shared with the system timer
> (PIT) on at91 platforms.
> Since timers are registering their handlers with IRQF_NO_SUSPEND, we should
> expect being called in suspended state, and properly wake the system up
> when this is the case.
> 
> Set IRQF_COND_SUSPEND flag when registering the IRQ handler to inform
> irq core that it can safely be called while the system is suspended.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/rtc/rtc-at91sam9.c | 73 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 61 insertions(+), 12 deletions(-)

[...]

> +/*
> + * IRQ handler for the RTC
> + */
> +static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
> +{
> +	struct sam9_rtc *rtc = _rtc;
> +	int ret;
> +
> +	spin_lock(&rtc->lock);
> +
> +	ret = at91_rtc_cache_events(rtc);
> +
> +	/* We're called in suspended state */
> +	if (rtc->suspended) {
> +		/* Mask irqs coming from this peripheral */
> +		rtt_writel(rtc, MR,
> +			   rtt_readl(rtc, MR) &
> +			   ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
> +		/* Trigger a system wakeup */
> +		pm_system_wakeup();
> +	} else {
> +		at91_rtc_flush_events(rtc);
> +	}
> +
> +	spin_unlock(&rtc->lock);
> +
> +	return ret;

[...]

> @@ -421,7 +456,8 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  
>  	/* register irq handler after we know what name we'll use */
>  	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
> -				IRQF_SHARED, dev_name(&rtc->rtcdev->dev), rtc);
> +			       IRQF_SHARED | IRQF_COND_SUSPEND,
> +			       dev_name(&rtc->rtcdev->dev), rtc);

To try to avoid thie getting cargo-culted, it's probably worth expanding
the comment to cover the IRQF_COND_SUSPEND usage. Something like:

	/* 
	 * Register irq handler after we know what name we'll use.
	 *
	 * The interrupt line may be shared with a timer (the PIT), so
	 * we must use IRQF_COND_SUSPEND and call pm_system_wakeup()
	 * when a genuine wakeup event occurs.
	 */

Otherwise this looks good to me.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
