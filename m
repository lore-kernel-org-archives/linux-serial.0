From: Tony Lindgren <tony@atomide.com>
Subject: Re: Serdev runtime PM (was: Re: [PATCH 4/7] dt-bindings: gnss: add
 u-blox binding)
Date: Wed, 9 May 2018 07:05:50 -0700
Message-ID: <20180509140550.GC98604@atomide.com>
References: <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180508155608.3bzcbepsmoskhlox@earth.universe>
 <20180509091831.GA2285@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180509091831.GA2285@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

* Johan Hovold <johan@kernel.org> [180509 09:20]:
> On Tue, May 08, 2018 at 05:56:08PM +0200, Sebastian Reichel wrote:
> > I think using open/close for runtime pm is good enough for GPS,
> > since it regularly sends data and draws lots of power anyways.
> > But devices, that have an out-of-band wakeup signal can do proper
> > runtime PM of the serial port without loosing characters.
> 
> Yeah, there may be some applications where this is possible. And this is
> not the case for GPS, but not just because of a generally higher power
> consumption, but due to the fact that we cannot afford having the first
> message in every report burst be dropped.

Well most of the phone implementations use one or two out of band
GPIOs to first wake the UART before any data is sent. For serdev
this can be called from the serdev consumer write function for TX.
For RX, the serdev consumer needs to implement an interrupt handler
and wake up the parent UART before serdev RX.

> > Note, that OMAP does not reach deep idle states with active
> > serial port. This is not acceptable for low power devices.
> 
> Sure, but note that OMAP is the only serial driver which currently
> implements this kind of aggressive runtime PM (besides a couple of
> usb-serial drivers). This means that a serdev driver can never rely on
> this being the case, and therefore needs to be restrictive about how
> long the port is kept open if it cares about power at all.

Well by default we don't allow lossy UART. It needs to be manually
configured via /sys for the timeout. With serdev, this can all be
done with no /sys configuration needed for the cases with GPIO
wake irqs :)

Regards,

Tony
