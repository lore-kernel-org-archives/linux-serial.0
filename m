From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
Date: Wed, 1 Jul 2015 15:28:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507011527380.3916@nanos>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-5-git-send-email-pawelo@king.net.pl> <alpine.DEB.2.11.1507010944580.3916@nanos> <alpine.LNX.2.00.1507011031050.9009@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1507011031050.9009@localhost.localdomain>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Bolle <pebolle@tiscali.nl>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Anson
List-Id: linux-serial@vger.kernel.org

On Wed, 1 Jul 2015, Paul Osmialowski wrote:

> Hi Thomas,
> 
> On Wed, 1 Jul 2015, Thomas Gleixner wrote:
> 
> > > +		clockevents_register_device(
> > > +				&kinetis_clockevent_tmrs[chan].evtdev);
> > > +
> > > +		kinetis_pit_init(&kinetis_clockevent_tmrs[chan],
> > > +						(rate / HZ) - 1);
> > > +		kinetis_pit_enable(&kinetis_clockevent_tmrs[chan], 1);
> > 
> > No point doing this. The core code has invoked the set_periodic call
> > back via clockevents_register_device() already.
> > 
> 
> As I removed this kinetis_pit_enable() line, the timer did not start,
> therefore the system became unusable. What could be possible reason for that?

Well, you need to move both, the init and the enable into
set_periodic().

Thanks,

	tglx

