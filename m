From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Date: Thu, 5 Mar 2015 12:31:01 +0100
Message-ID: <20150305123101.07f4f372@bbrezillon>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
	<1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
	<20150304183809.GD22156@leverpostej>
	<20150305095306.3db98ac8@bbrezillon>
	<20150305105308.GA13617@leverpostej>
	<20150305121723.1da0d016@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150305121723.1da0d016@bbrezillon>
Sender: linux-pm-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexan>
List-Id: linux-serial@vger.kernel.org

On Thu, 5 Mar 2015 12:17:23 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Boris,

     ^ Mark,

I'm suffering from a dual personality disorder :-)

> 
> On Thu, 5 Mar 2015 10:53:08 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi Boris,
> > 
> > I'd missed the fact that this was for SW watchdog as opposed to HW
> > watchdog, which may explain my confusion.
> > 
> > [...]
> > 
> > > > >  		err = request_irq(wdt->irq, wdt_interrupt,
> > > > > -				  IRQF_SHARED | IRQF_IRQPOLL,
> > > > > +				  IRQF_SHARED | IRQF_IRQPOLL |
> > > > > +				  IRQF_NO_SUSPEND,
> > > > 
> > > > I'm a little confused by this. What happens if the watchdog fires when
> > > > we're actually in the suspended state (when IRQF_NO_SUSPEND interrupts
> > > > aren't guaranteed to be delivered).
> > > 
> > > It reboot the system.
> > 
> > Is the timer we use to ping the watchdog guaranted to result in a wakeup
> > before an interrupt will be triggered? If so, then I think we're ok.
> 
> It should be (I don't recall exactly what the logic is, but it's at
> least half the watchdog time limit).
> 
> > 
> > If not, then don't we need to clear a potentially pending watchdog irq
> > at resume time so at to not immediately reboot the machine? I couldn't
> > see any logic to that effect in the driver.
> 
> That depends on what we want.
> If we want the watchdog to be inactive when entering suspend, then we
> shouldn't reboot the machine when receiving a watchdog irq while the
> system is suspended.
> ITOH, with the hardware mode (reset handled by the watchdog IP) you
> can't disable the watchdog when entering suspend, so I would expect the
> same behavior for the SW mode.
> 
> > 
> > Regardless, if the only reason we care about taking the interrupt during
> > the suspend/resume phases is due to the timer sharing the IRQ, then
> > shouldn't we be using IRQF_COND_SUSPEND?
> 
> I'm not sure, but IMO this interrupt should be flagged as NO_SUSPEND,
> because it's here to reset the system (even if it is suspended).
> If you flag the irq line as COND_SUSPEND, and atmel decide to give this
> peripheral its own IRQ line (on new SoCs), then your watchdog will not
> reboot the system when it is suspended.
> Another solution would be to support wakeup for this peripheral and
> delay the system reboot until it has resumed.
> 
> Anyway, if we decide to go for the wakeup approach, I'd prefer to post
> another patch on top of this one.
> 
> Best Regards,
> 
> Boris
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
