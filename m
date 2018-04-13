From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Thu, 12 Apr 2018 17:24:15 -0700
Message-ID: <20180413002415.GC5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
 <20180412212412.GA29243@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180412212412.GA29243@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180412 21:25]:
> sudo insmod /tmp/n_gsm.ko debug=0xff
> 
> user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
> Starting ngsm..
> Testing ngsm..
> Could not open /dev/gsmtty1: Level 2 halted
> Trying to start ngsm again: Level 2 halted
> Starting ngsm..
> Testing ngsm..
> Could not open /dev/gsmtty1: Level 2 halted
> Trying to start ngsm again: Level 2 halted
> Starting ngsm..
> ^CCould not set conf: Interrupted system call
> Could not start ngsm: Interrupted system call
> 
> [ 3378.381134] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> [ 3408.460937] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> [ 3413.633239] Q>  0) R: UIH(F)
> [ 3413.639190] C3
> [ 3413.642761] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
> ~....~
> [ 3413.653564] gsmld_output: 00000000: 7e 01 ef c3 aa 7e

OK so no response from the modem. After few of the above
packets, you should then also see something coming back:

gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
gsmld_output: 00000000: 7e 01 ef c3 aa 7e
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_receive: 00000000: f9 03 1f 01 36 f9
<-- 0) C: DM(P)
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_receive: 00000000: f9 03 1f 01 36 f9
<-- 0) C: DM(P)
DLCI 0 opening in ADM mode.

Do you have phy-mapphone-mdm6600 loaded? That is still needed to
configure all the boot mode pins for the modem so it is usable..
The UART will then work also without ohci-platform, just the
USB PHY is disabled without ohci-platform.

I have these in my .config:
CONFIG_SERIAL_8250_OMAP=y
CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=y
CONFIG_PHY_MAPPHONE_MDM6600=m
CONFIG_N_GSM=m

And then the two patches from $subject thread. I just tried
it with today's mainline kernel and it's still working for
me.

Maybe you're missing some related patch though if usingv4.16?

984c7706ff18 ("ARM: dts: omap4-droid4: Configure uart1 pins")
e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
bca809d8183c ("ARM: omap2plus_defconfig: Enable MDM6600 USB PHY")
077e1cde78c3 ("ARM: omap2plus_defconfig: Enable 8250_OMAP"

So maybe you're still using CONFIG_SERIAL_OMAP=y instead of
CONFIG_SERIAL_8250_OMAP=y?

Regards,

Tony
