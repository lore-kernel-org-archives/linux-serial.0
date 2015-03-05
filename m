From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Date: Thu, 5 Mar 2015 10:53:08 +0000
Message-ID: <20150305105308.GA13617@leverpostej>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150305095306.3db98ac8@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>lin
List-Id: linux-serial@vger.kernel.org

Hi Boris,

I'd missed the fact that this was for SW watchdog as opposed to HW
watchdog, which may explain my confusion.

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
> It reboot the system.

Is the timer we use to ping the watchdog guaranted to result in a wakeup
before an interrupt will be triggered? If so, then I think we're ok.

If not, then don't we need to clear a potentially pending watchdog irq
at resume time so at to not immediately reboot the machine? I couldn't
see any logic to that effect in the driver.

Regardless, if the only reason we care about taking the interrupt during
the suspend/resume phases is due to the timer sharing the IRQ, then
shouldn't we be using IRQF_COND_SUSPEND?

Thanks,
Mark.
