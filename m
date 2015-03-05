From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Thu, 5 Mar 2015 16:10:16 +0100
Message-ID: <CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
	<1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
	<20150304183809.GD22156@leverpostej>
	<14143668.0aRkeVrc3Q@vostro.rjw.lan>
	<20150305105729.GB13617@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150305105729.GB13617@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandr
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 5, 2015 at 11:57 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
>
>> > >           err = request_irq(wdt->irq, wdt_interrupt,
>> > > -                           IRQF_SHARED | IRQF_IRQPOLL,
>> > > +                           IRQF_SHARED | IRQF_IRQPOLL |
>> > > +                           IRQF_NO_SUSPEND,
>> >
>> > I'm a little confused by this. What happens if the watchdog fires when
>> > we're actually in the suspended state (when IRQF_NO_SUSPEND interrupts
>> > aren't guaranteed to be delivered).
>>
>> Why wouldn't they be delivered?
>>
>> If that's suspend-to-idle, we'll handle them normally.  If that's full suspend,
>> they may not be handled at the last stage (when we run on one CPU with interrupts
>> off), but that was the case before the wakeup interrupts rework already and I'd
>> expect it to be taken into account somehow in the existing code (or if it isn't
>> taken into account, we have a bug, but it is not related to this series).
>
> There's no enable_irq_wake(wdt->irq), and I was under the impression this
> is for full suspend.

enable_irq_wake() has no effect on IRQF_NO_SUSPEND interrupts, so if the
driver uses IRQF_NO_SUSPEND, it does not need to use enable_irq_wake()
in addition to that.

Drivers using IRQF_COND_SUSPEND generally should use enable_irq_wake() too
in case they end up in a situation without sharing a NO_SUSPEND interrupt, in
which case their interrupt handlers won't be called after suspend_device_irqs(),
so they need to rely on the core to do the wakeup.

> I agree that if problematic, it's an existing bug. Given Boris's
> comments in the other thread this may just a minor semantic issue w.r.t.
> IRQF_NO_SUSPEND vs IRQF_COND_SUSPEND.

It depends on whether or not the watchdog's interrupt handler has to be
called immediately after receiving an interrupt (IRQF_NO_SUSPEND is
better then) or it can be deferred till the resume_device_irqs() time.

Rafael
