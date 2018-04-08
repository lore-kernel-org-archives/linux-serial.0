From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Sun, 8 Apr 2018 16:57:40 -0700
Message-ID: <20180408235740.GN5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408190600.GA24342@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180408 19:07]:
> Hi!
> 
> > > Do you have a tool to use and a script?
> > 
> > Yes I used the shell script I posted earlier, but forgot it also
> > needs the ldattach done.
> > 
> > Anyways, last night and today I wrote a quick test utility called
> > droid4-ngsm that initializes things and I can use to do some
> > experiments to get the ts27010 channel proxying to W3GLTE also
> > going:
> > 
> > http://github.com/tmlind/droid4-ngsm/
> 
> Ok, now i'm confused. It wants to bind to ttyS0, but modem is on
> ttyUSB4 AFAICT? Or is the modem connected to serial port, too? (Do I
> need to enable some more drivers for that?)
> 
> I do have ttyS0, but I don't think there's anything attached there. Or
> is ttyS0 for the LTE modem?

The ttyS0 is connected to mdm6600, and ttyUSB4 seems to be
some buggy subset of ttyS0 n_gsm dlci1. You need need at least
the following commits in current mainline kernel:

984c7706ff18 ("ARM: dts: omap4-droid4: Configure uart1 pins")
e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")

And then you need PHY_MAPPHONE_MDM6600 and CONFIG_N_GSM enabled.

Regards,

Tony
