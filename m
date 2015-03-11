From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Wed, 11 Mar 2015 02:03:08 +0100
Message-ID: <2194398.CCV6AEYQ7u@vostro.rjw.lan>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com> <1901056.Mqyykpv3e9@vostro.rjw.lan> <20150310223305.GN9188@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150310223305.GN9188-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sylvain Rochet <gradator-XWGZPxRNpGHk1uMJSBkQmQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tuesday, March 10, 2015 11:33:05 PM Alexandre Belloni wrote:
> On 10/03/2015 at 23:31:52 +0100, Rafael J. Wysocki wrote :
> > On Tuesday, March 10, 2015 10:33:17 PM Alexandre Belloni wrote:
> > > Hi,
> > > 
> > > On 09/03/2015 at 15:30:01 +0100, Rafael J. Wysocki wrote :
> > > > > > > Actaully, your platform should just refuse to enter suspend-to-RAM
> > > > > > > when hw watchdog is enabled.
> > > > > > 
> > > > > > Quite likely, depending on how exactly the suspend is implemented.
> > > > > >
> > > > > 
> > > > > We've had absolutely zero complain on that. It is quite clear in the
> > > > > datasheet that failing to refresh the watchdog once started will lead to
> > > > > a reset and that it is impossible to stop.
> > > > > It is actually quite convenient to also ensure that you can actually
> > > > > wake up from suspend because that can obviously go wrong.
> > > > 
> > > > I gather then that the suspend implementation is such that touching the
> > > > watchdog periodically while suspended is not a problem.
> > > > 
> > > > Again, can you please tell me how suspend is implemented on at91?
> > > > 
> > > 
> > > It actually depends on the architecture (at91rm9200, at91sam9 or sama5)
> > > but basically, the clocks are switched off in almost all the peripheral
> > > drivers then the ram self refresh activated, the master clock is
> > > switched off using code running from SRAM and the core is then waiting
> > > for interrupt.
> > 
> > OK, so it looks like enable_irq_wake() doesn't actually affect the hardware
> > on those platforms, is that correct?
> > 
> 
> I didn't exactly look in details but apart from the wakeup from gpio
> handling (keeping the pio controller clocked in the case one of its gpio
> has wakeup enabled), I don't think it does much more. It uses
> irq_gc_set_wake().

Well, that only modifies gc->wake_active, so no hardware interactions.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
