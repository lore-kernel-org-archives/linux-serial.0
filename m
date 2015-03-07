From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Date: Sat, 7 Mar 2015 10:12:04 +0100
Message-ID: <20150307091204.GM23367@worktop.ger.corp.intel.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
 <20150305163227.GF14093@leverpostej>
 <1696230.CygTkv53VA@vostro.rjw.lan>
 <20150306110618.GC8700@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150306110618.GC8700@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexan
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 06, 2015 at 11:06:18AM +0000, Mark Rutland wrote:
> [...]
> 
> > > The request_irq path never results in a call to chip->irq_set_wake(),
> > > even with the IRQF_NO_SUSPEND flag. So requesting an irq with
> > > IRQF_NO_SUSPEND does not guarantee wakeup; it only guarantees that the
> > > CPU can take the interrupt _around_ the suspended state, not necessarily
> > > while _in_ the suspended state.
> > 
> > Right.  "Suspended state" meaning full suspend here I suppose?
> 
> Yes; any state deeper than suspend-to-idle.

I don't think we should want to make such distinction; we should treat
all suspend states the same.

Drivers should not want to rely on the fact that one state
(suspend-to-idle) might maybe deal with interrupts while other states do
not.

> > > We seem to be conflating some related properties:
> > > 
> > > [a] The IRQ will be left unmasked.
> > > [b] The IRQ will be handled immediately when taken.
> > > [c] The IRQ will wake the system from suspend.
> > > 
> > > Requesting an IRQ with IRQF_NO_SUSPEND guarantees [a,b], but does not
> > > guarantee [c].
> > 
> > That's correct.  IRQF_NO_SUSPEND does not guarantee that interrupts from
> > that IRQ will have any effect after arch_suspend_disable_irqs() in
> > suspend_enter().
> 
> [...]
> 
> > > It sounds like for this kind of watchdog device we want [a,b,c], even if
> > > the IRQ is not shared with an IRQF_NO_SUSPEND user.
> > 
> > We can't guarantee that, though.  arch_suspend_disable_irqs() disables
> > interrupts on the last working CPU and it won't get any.  It may be
> > brought out of a low-power state by a pending interrupt, but it won't act
> > upon that interrupt immediately anyway, only after the arch_suspend_enable_irqs()
> > in suspend_enter().
> 
> Ok, so [b] needs the caveat that it's only handled "immediately" outside
> of the arch_suspend_disable_irqs() ... arch_suspend_enable_irqs()
> section.
> 
> > But then it might as well be deferred until after
> > resume_device_irqs().
> 
> That was my original line of thinking, in which case the watchdog driver
> should use IRQF_COND_SUSPEND rather than IRQF_NO_SUSPEND, with
> enable_irq_wake() if we care about the watchdog during suspend. I'm
> happy with this.

Note that COND_SUSPEND must have SHARED set.

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

While I appreciate the use-case; we should be careful not to make of
mess of things either.
