From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/6] ARM: at91: fix irq_pm_install_action WARNING
Date: Tue, 3 Mar 2015 09:56:46 +0100
Message-ID: <20150303085646.GA3892@piout.net>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 02/03/2015 at 10:18:12 +0100, Boris Brezillon wrote :
> My apologies to those of you who already received this series, but I
> didn't increment the patch version and forgot some subsystem maintainers
> and MLs.
> 
> Commit cab303be91dc47942bc25de33dc1140123540800 [1] introduced a WARN_ON
> test which triggers a WARNING backtrace on at91 platforms.
> While this WARN_ON is absolutely necessary to warn users that they should
> not mix request with and without IRQF_NO_SUSPEND flags on shared IRQs,
> there is no easy way to solve this issue on at91 platforms.
> 
> The main reason is that the init timer is often using a shared irq line
> and thus request this irq with IRQF_NO_SUSPEND flag set, while other
> peripherals request the same irq line without this flag.
> 
> This problem has recently been addressed by this patch [2] which adds
> a new IRQF_COND_SUSPEND flag, that authorize mixing IRQF_NO_SUSPEND and
> !IRQF_NO_SUSPEND as long as irq handlers setting IRQF_COND_SUSPEND
> can safely be called in suspended state.
> 
> Doing this also implies taking care of system wakeup in devices handlers
> if they tag the IRQ line as a wakeup source.
> The first patch of this series exports the pm_system_wakeup symbol so
> that drivers can call pm_system_wakeup from their interrupt handler.
> 
> This series then patches all at91 drivers that can have devices sharing
> their IRQ line with a timer.
> 
> This series depends on [2].
> 

For the whole series:
Reviewed-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
