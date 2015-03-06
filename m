From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Fri, 6 Mar 2015 13:39:14 +0100
Message-ID: <CAJZ5v0jA-hRUnP_+mOdFw7vN7CGZ4o0FjUVu81rq7foi92f63g@mail.gmail.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
	<CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
	<20150305163227.GF14093@leverpostej>
	<1696230.CygTkv53VA@vostro.rjw.lan>
	<20150306110618.GC8700@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150306110618.GC8700@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 6, 2015 at 12:06 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> [...]
>
>> > The request_irq path never results in a call to chip->irq_set_wake(),
>> > even with the IRQF_NO_SUSPEND flag. So requesting an irq with
>> > IRQF_NO_SUSPEND does not guarantee wakeup; it only guarantees that the
>> > CPU can take the interrupt _around_ the suspended state, not necessarily
>> > while _in_ the suspended state.
>>
>> Right.  "Suspended state" meaning full suspend here I suppose?
>
> Yes; any state deeper than suspend-to-idle.
>
> [...]
>
>> > We seem to be conflating some related properties:
>> >
>> > [a] The IRQ will be left unmasked.
>> > [b] The IRQ will be handled immediately when taken.
>> > [c] The IRQ will wake the system from suspend.
>> >
>> > Requesting an IRQ with IRQF_NO_SUSPEND guarantees [a,b], but does not
>> > guarantee [c].
>>
>> That's correct.  IRQF_NO_SUSPEND does not guarantee that interrupts from
>> that IRQ will have any effect after arch_suspend_disable_irqs() in
>> suspend_enter().
>
> [...]
>
>> > It sounds like for this kind of watchdog device we want [a,b,c], even if
>> > the IRQ is not shared with an IRQF_NO_SUSPEND user.
>>
>> We can't guarantee that, though.  arch_suspend_disable_irqs() disables
>> interrupts on the last working CPU and it won't get any.  It may be
>> brought out of a low-power state by a pending interrupt, but it won't act
>> upon that interrupt immediately anyway, only after the arch_suspend_enable_irqs()
>> in suspend_enter().
>
> Ok, so [b] needs the caveat that it's only handled "immediately" outside
> of the arch_suspend_disable_irqs() ... arch_suspend_enable_irqs()
> section.
>
>> But then it might as well be deferred until after
>> resume_device_irqs().
>
> That was my original line of thinking, in which case the watchdog driver
> should use IRQF_COND_SUSPEND rather than IRQF_NO_SUSPEND, with
> enable_irq_wake() if we care about the watchdog during suspend. I'm
> happy with this.
>
> Considering that the use-case of a watchdog is to alert us to something
> going hideously wrong in the kernel, we want to handle the IRQ after
> executing the smallest amount of kernel code possible. For that, they
> need to have their handlers to be called "immediately" outside of the
> arch_suspend_disable_irqs() ... arch_suspend_enable_irqs() window, and
> need to be enabled during suspend to attempt to catch bad wakeup device
> configuration.
>
> I think it's possible (assuming the caveats on [b] above) to provide
> [a,b,c] for this case.

OK

But in this case the request_irq() passing IRQF_NO_SUSPEND *and* requiring
enable_irq_wake() in addition to that needs a big fat comment explaining the
whole thing or we'll forget about the gory details at one point and no one will
know what's going on in there.

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
