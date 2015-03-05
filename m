From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Date: Thu, 5 Mar 2015 10:57:29 +0000
Message-ID: <20150305105729.GB13617@leverpostej>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <14143668.0aRkeVrc3Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <14143668.0aRkeVrc3Q-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni@free-electron>
List-Id: linux-serial@vger.kernel.org

[...]

> > >  		err = request_irq(wdt->irq, wdt_interrupt,
> > > -				  IRQF_SHARED | IRQF_IRQPOLL,
> > > +				  IRQF_SHARED | IRQF_IRQPOLL |
> > > +				  IRQF_NO_SUSPEND,
> > 
> > I'm a little confused by this. What happens if the watchdog fires when
> > we're actually in the suspended state (when IRQF_NO_SUSPEND interrupts
> > aren't guaranteed to be delivered).
> 
> Why wouldn't they be delivered?
> 
> If that's suspend-to-idle, we'll handle them normally.  If that's full suspend,
> they may not be handled at the last stage (when we run on one CPU with interrupts
> off), but that was the case before the wakeup interrupts rework already and I'd
> expect it to be taken into account somehow in the existing code (or if it isn't
> taken into account, we have a bug, but it is not related to this series).

There's no enable_irq_wake(wdt->irq), and I was under the impression this
is for full suspend.

I agree that if problematic, it's an existing bug. Given Boris's
comments in the other thread this may just a minor semantic issue w.r.t.
IRQF_NO_SUSPEND vs IRQF_COND_SUSPEND.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
