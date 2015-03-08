From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Sun, 08 Mar 2015 02:12:53 +0100
Message-ID: <1615214.0rkGfM1gZL@vostro.rjw.lan>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com> <20150307110645.GW3989@piout.net> <20150307112932.GA1372@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150307112932.GA1372@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sylvain Rochet <gradator@gradator.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Wim Van Sebroeck <wim@iguana.be>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, linux-ar
List-Id: linux-serial@vger.kernel.org

On Saturday, March 07, 2015 12:29:33 PM Pavel Machek wrote:
> On Sat 2015-03-07 12:06:45, Alexandre Belloni wrote:
> > On 07/03/2015 at 11:39:39 +0100, Pavel Machek wrote :
> > > > The Atmel watchdog can't be stopped once it's started. This is actually 
> > > > very useful so we can reset if suspend or resume failed, the only 
> > > > drawback is that you have to wake up from time to time (e.g. by using 
> > > > the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
> > > 
> > > Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
> > > after watchdog kills the system. But you did not ask for dead system,
> > > you asked for suspend.
> > > 
> > > And while that behaviour is useful for you, I don't think it is
> > > exactly useful behaviour, nor it is the behaviour user would expect.
> > > 
> > 
> > I think you misunderstood, that is exactly the expected behaviour. This
> > is hardware defined. Once the watchdog is started, nobody can stop it.
> > Trying to change the mode register will result in a reset of the
> > SoC.
> 
> Well, it boils down to "what is stronger". Desire to suspend the
> system, or desire to reboot the system.
> 
> It is "echo mem > state", not "echo reboot > state".
> 
> > It is documented in the datasheet and any user wanting another behaviour
> > is out of luck.
> 
> Actaully, your platform should just refuse to enter suspend-to-RAM
> when hw watchdog is enabled.

Quite likely, depending on how exactly the suspend is implemented.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
