From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: earlycon: no match?
Date: Mon, 4 May 2015 22:52:41 +0200
Message-ID: <20150504205241.GT15254@pengutronix.de>
References: <20150503211054.GR15254@pengutronix.de>
 <55477BC1.6000805@hurleysoftware.com>
 <20150504194229.GR15254@pengutronix.de>
 <5547D4DB.8060300@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5547D4DB.8060300@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Mon, May 04, 2015 at 04:21:47PM -0400, Peter Hurley wrote:
> >>>   earlycon: no match for ttyAMA0,38400n8
> >>
> >> This shouldn't impact any previous earlycon setup. Are you saying
> >> you're seeing a regression?
> > 
> > Well, it is a warning, and the system was warning-free on mainline with
> > the last kernels. People assume something is wrong if they read such a
> > message, so I'm searching for a way to do it right and get rid of the
> > warning again.
> 
> It's not a warning; it's simply a diagnostic in case the earlycon was
> misspelled.

Just that in my case nothing is misspelled...?

The message is on the same level as "firmware not found" or any other
message that tells the casual observer that something unexpected is
going on, which is bad behaviour if the system really wants to say that
everything is ok.

I enabled all necessary drivers, I configure the system console to be on
ttyAMA0, and still it tells me about "no match".

And, as I wrote in my last mail, there is nothing I can do to actually
*make* it match.

> Since 2007, 'console=' is a early param synonym for 'earlycon='; IOW,
> the message is new but not the behavior.

"console=" had nothing to do with early param before.

> > > How do you have early console enabled, via the command line or via DT?
> > 
> > Neither nor: the same SD card image runs on qemu (vexpress) and on an
> > AM335x. It has its primary console on the serial console:
> > 
> > - console=ttyAMA0,38400  (amba-pl011.c, vexpress)
> > - console=ttyO2,115200n8 (omap-serial.c, AM335x)
> > 
> > There is no "earlycon" on the commandline and nothing earlycon related I
> > did on purpose in the oftree.
> 
> Ok. In your first email, you said "my boxes with early console enabled",
> so I thought you meant that you were starting an earlycon. I see now
> you meant enabled, as in built-in (not enabled as in started).

Sorry, I was imprecise here. I meant "CONFIG_SERIAL_EARLYCON=y".

> > My expectation would be to configure the system in a way that I have
> > everything necessary for earlecon usage compiled into the kernel, so I
> > can enable it manually from the bootloader whenever I need it (i.e. by
> > adding 'earlycon' to the kernel commandline, or by modifying the oftree
> > before it is handled over to the kernel).
> 
> Ok.
> 
> >>> The box was booted with "console=ttyAMA0,38400n8" on the commandline.
> >>> If I understand this right, the code in drivers/tty/serial/earlycon.c
> >>> calls setup_earlycon() with the string above ("ttyAMA0,38400n8") and
> >>> fails to find that string in the "names" part of the __earlycon_table,
> >>> because for the pl011 component on vexpress, the early console was
> >>> registered in drivers/tty/serial/amba-pl011.c with:
> >>>
> >>> OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
> >>>                     ^^^^^ name
> >>>
> >>> So isn't that trying to match "ttyAMA0" against "arm,pl011"? I have the
> >>> feeling that I didn't understand the logic behind that.
> >>>
> >>> Can you elaborate about how this is supposed to work correctly?
> 
> The facility I describe below is to enable earlycon->console handoff.
> If you're not interested in that, please disregard.
> 
> I provided the description because it wasn't clear to me from your
> original email if that was something you were trying to implement and
> couldn't get working.

No, I'm using vanilla 4.1-rc1, without any patch, and I don't want to
implement something. As the involved drivers have support for early
console, all I want to do is to use it the way it was intended. This
fails so far.
 
> >> Yeah, I've been meaning to write about this but simply haven't had the
> >> time yet; apologies for that.
> >>
> >> The facility is hopefully best explained by the existing 8250 exemplar.
> >> Normally, an 8250 early console is started via command line with a
> >> command line parameter like:
> >>
> >> 	earlycon=uart,io,0x2f8,115200n8
> > 
> > What happens if you don't have this parameter on the kernel commandline,
> > but use the same port for your serial console? i.e. 'console=ttyS0'?
> >
> > I would expect the same warning I see on my boxes.
> 
> The diagnostic was added in commit 470ca0de69feaba5df215ad804cec1859883a5ed
> ("serial: earlycon: Enable earlycon without command line param").
> 
> Previously, if earlycon failed to start because of an error, such as because the
> earlycon name was misspelled, there was no diagnostic.

That's a good intention :-)

However, you seem to have a different usecase, any my one is broken.

> >> Since 2007, an 8250 early console can also be started via command line
> >> using console= instead, like:
> >>
> >> 	console=uart,io,0x2f8,115200n8
> > 
> > No: "console=..." puts the console on that port, not the early console.
> > The semantic for console= was always to specify the name of the device
> > there, so "console=ttyS0...", not "console=uart...", right?
> 
> From Documentation/kernel-parameters:
> 
> 	console=	[KNL] Output console device and options.
> 
> 		....
> 
> 		uart[8250],io,<addr>[,options]
> 		uart[8250],mmio,<addr>[,options]
> 		uart[8250],mmio32,<addr>[,options]
> 		uart[8250],0x<addr>[,options]
> 			Start an early, polled-mode console on the 8250/16550
> 			UART at the specified I/O port or MMIO address,
> 			switching to the matching ttyS device later.
> 			MMIO inter-register address stride is either 8-bit
> 			(mmio) or 32-bit (mmio32).
> 			If none of [io|mmio|mmio32], <addr> is assumed to be
> 			equivalent to 'mmio'. 'options' are specified in the
> 			same format described for ttyS above; if unspecified,
> 			the h/w is not re-initialized.
> 
> This behavior was added in Jul 2007 with commit 18a8bd949d6adb311
> ("serial: convert early_uart to earlycon for 8250").

In order to let you better understand the setup here: My AM335x device
(same CPU as on BeagleBone) is a headless embedded system, the only
input/output device it has is a serial port. No display, no touch. For
development, a pretty similar system is simulated in QEMU, with
vexpress.

Until recently, specifying "console=ttyAMA0" was the correct way to get
the kernel + userspace output out of that serial line. On ARM, there was
no "early" mechanism, only early_printk.

I wouldn't mind if your citation from kernel-parameters above was true
and I could get an (early and non-early) serial console with a unified
"console=ttyAMA0".

However, it doesn't work, as "ttyAMA0" doesn't match "pl011".

> AFAICT nothing is broken; you're only seeing a new diagnostic from code that
> was always running.

So I'm doing the right thing here, and it doesn't work.

Do we agree that this is a bug?

Or how do you suggest I should use the code correctly?

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
