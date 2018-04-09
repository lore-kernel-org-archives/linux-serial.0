From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Mon, 9 Apr 2018 06:42:59 -0700
Message-ID: <20180409134259.GO5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409105407.GA15315@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180409 10:56]:
> Ok, I should have all that enabled. But droid4-ngsm still fails:
> 
> user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
> Starting ngsm..
> Testing ngsm..
> Could not open /dev/gsmtty1: Level 2 halted
> Trying to start ngsm again: Level 2 halted
> Starting ngsm..

I guess you must have phy-mapphone-mdm6600 enabled as you a have
working modem over USB. What do you see in dmesg if you enable n_gsm
debug with modprobe n_gsm debug=0xff or on kernel cmdline?

> commit 984c7706ff180e33096c57183435d925cb644576 says:
> 
>     ARM: dts: omap4-droid4: Configure uart1 pins
> 
>     These are needed to use the n_gsm driver for TS 27.010 UART
>         multiplexing. Note that support for the OOB wake gpio is still
> 	    missing so the UART is not yet usable for n_gsm.
> 
> ...am I still missing the OOB wake gpio support?

We can get away without OOB wake gpio for a while as mdm6600 is not
yet suspended over USB. But if you have manually suspended mdm6600
USB interface via /sys, then it won't respond properly on n_gsm
either.

Regards,

Tony
