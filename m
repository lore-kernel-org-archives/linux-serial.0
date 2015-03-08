From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Sun, 08 Mar 2015 02:11:45 +0100
Message-ID: <2616799.fRG1k0Q6sR@vostro.rjw.lan>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com> <20150307103939.GA17964@amd> <20150307110645.GW3989@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150307110645.GW3989@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sylvain Rochet <gradator@gradator.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Wim Van Sebroeck <wim@iguana.be>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Saturday, March 07, 2015 12:06:45 PM Alexandre Belloni wrote:
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
> Trying to change the mode register will result in a reset of the SoC.
> 
> It is documented in the datasheet and any user wanting another behaviour
> is out of luck.
> 
> So basically, when using a watchdog, you have to wake up every 15-16s to
> restart it.

So question is if we need a separate interrupt handler for that, expecially
since it is shared with the PIT timer anyway.

Seems to me that the simplest way out of this conundrum would be to simply
make the timer's interrupt handler kick the watchdog every once a while and
get rid of the separate watchdog interrupt handler entirely.

While at it, can anyone explain to me please how the suspend state (full
suspend) looks like on that platform?  What's different from the working
state in particular.



-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
