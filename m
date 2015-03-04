From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Wed, 04 Mar 2015 22:41:24 +0100
Message-ID: <14143668.0aRkeVrc3Q@vostro.rjw.lan>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com> <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com> <20150304183809.GD22156@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150304183809.GD22156@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electron>
List-Id: linux-serial@vger.kernel.org

On Wednesday, March 04, 2015 06:38:09 PM Mark Rutland wrote:
> Hi Boris,
> 
> On Mon, Mar 02, 2015 at 09:18:17AM +0000, Boris Brezillon wrote:
> > The watchdog interrupt (only used when activating software watchdog)
> > shouldn't be suspended when entering suspend mode, because it is shared
> > with a timer device (which request the line with IRQF_NO_SUSPEND) and once
> > the watchdog "Mode Register" has been written, it cannot be changed (which
> > means we cannot disable the watchdog interrupt when entering suspend).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/watchdog/at91sam9_wdt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> > index 6df9405..1443b3c 100644
> > --- a/drivers/watchdog/at91sam9_wdt.c
> > +++ b/drivers/watchdog/at91sam9_wdt.c
> > @@ -208,7 +208,8 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
> >  
> >  	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
> >  		err = request_irq(wdt->irq, wdt_interrupt,
> > -				  IRQF_SHARED | IRQF_IRQPOLL,
> > +				  IRQF_SHARED | IRQF_IRQPOLL |
> > +				  IRQF_NO_SUSPEND,
> 
> I'm a little confused by this. What happens if the watchdog fires when
> we're actually in the suspended state (when IRQF_NO_SUSPEND interrupts
> aren't guaranteed to be delivered).

Why wouldn't they be delivered?

If that's suspend-to-idle, we'll handle them normally.  If that's full suspend,
they may not be handled at the last stage (when we run on one CPU with interrupts
off), but that was the case before the wakeup interrupts rework already and I'd
expect it to be taken into account somehow in the existing code (or if it isn't
taken into account, we have a bug, but it is not related to this series).

> Does this rely on the watchdog IRQ being taken while in the actual
> suspended state (but not waking up the system while handling it)?

It is going to work this way at least AFAICT.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
