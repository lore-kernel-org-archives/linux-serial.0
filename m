From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Date: Sat, 7 Mar 2015 12:29:33 +0100
Message-ID: <20150307112932.GA1372@amd>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
 <20150307102056.GA28436@gradator.net>
 <20150307103939.GA17964@amd>
 <20150307110645.GW3989@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150307110645.GW3989-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Sylvain Rochet <gradator-XWGZPxRNpGHk1uMJSBkQmQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sat 2015-03-07 12:06:45, Alexandre Belloni wrote:
> On 07/03/2015 at 11:39:39 +0100, Pavel Machek wrote :
> > > The Atmel watchdog can't be stopped once it's started. This is actually 
> > > very useful so we can reset if suspend or resume failed, the only 
> > > drawback is that you have to wake up from time to time (e.g. by using 
> > > the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
> > 
> > Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
> > after watchdog kills the system. But you did not ask for dead system,
> > you asked for suspend.
> > 
> > And while that behaviour is useful for you, I don't think it is
> > exactly useful behaviour, nor it is the behaviour user would expect.
> > 
> 
> I think you misunderstood, that is exactly the expected behaviour. This
> is hardware defined. Once the watchdog is started, nobody can stop it.
> Trying to change the mode register will result in a reset of the
> SoC.

Well, it boils down to "what is stronger". Desire to suspend the
system, or desire to reboot the system.

It is "echo mem > state", not "echo reboot > state".

> It is documented in the datasheet and any user wanting another behaviour
> is out of luck.

Actaully, your platform should just refuse to enter suspend-to-RAM
when hw watchdog is enabled.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
