From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Mon, 09 Mar 2015 15:30:01 +0100
Message-ID: <1592385.fqRVVyPSPE@vostro.rjw.lan>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com> <1615214.0rkGfM1gZL@vostro.rjw.lan> <20150309075546.GY3989@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150309075546.GY3989@piout.net>
Sender: linux-pm-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sylvain Rochet <gradator@gradator.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Wim Van Sebroeck <wim@iguana.be>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Monday, March 09, 2015 08:55:46 AM Alexandre Belloni wrote:
> Hi,
> 
> On 08/03/2015 at 02:12:53 +0100, Rafael J. Wysocki wrote :
> > > > I think you misunderstood, that is exactly the expected behaviour. This
> > > > is hardware defined. Once the watchdog is started, nobody can stop it.
> > > > Trying to change the mode register will result in a reset of the
> > > > SoC.
> > > 
> > > Well, it boils down to "what is stronger". Desire to suspend the
> > > system, or desire to reboot the system.
> > > 
> > > It is "echo mem > state", not "echo reboot > state".
> > > 
> > > > It is documented in the datasheet and any user wanting another behaviour
> > > > is out of luck.
> > > 
> > > Actaully, your platform should just refuse to enter suspend-to-RAM
> > > when hw watchdog is enabled.
> > 
> > Quite likely, depending on how exactly the suspend is implemented.
> >
> 
> We've had absolutely zero complain on that. It is quite clear in the
> datasheet that failing to refresh the watchdog once started will lead to
> a reset and that it is impossible to stop.
> It is actually quite convenient to also ensure that you can actually
> wake up from suspend because that can obviously go wrong.

I gather then that the suspend implementation is such that touching the
watchdog periodically while suspended is not a problem.

Again, can you please tell me how suspend is implemented on at91?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
