From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Mon, 04 May 2015 16:21:47 -0400
Message-ID: <5547D4DB.8060300@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150504194229.GR15254@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 05/04/2015 03:42 PM, Robert Schwebel wrote:
> Hi Peter,
> 
> On Mon, May 04, 2015 at 10:01:37AM -0400, Peter Hurley wrote:
>>> with 4.1-rc1, my boxes with early console enabled show something like
>>> this (the example is vexpress, but it for example also happens on an
>>> AM335x board):
>>>
>>>   earlycon: no match for ttyAMA0,38400n8
>>
>> This shouldn't impact any previous earlycon setup. Are you saying
>> you're seeing a regression?
> 
> Well, it is a warning, and the system was warning-free on mainline with
> the last kernels. People assume something is wrong if they read such a
> message, so I'm searching for a way to do it right and get rid of the
> warning again.

It's not a warning; it's simply a diagnostic in case the earlycon was
misspelled. Since 2007, 'console=' is a early param synonym for 'earlycon=';
IOW, the message is new but not the behavior.

>> How do you have early console enabled, via the command line or via DT?
> 
> Neither nor: the same SD card image runs on qemu (vexpress) and on an
> AM335x. It has its primary console on the serial console:
> 
> - console=ttyAMA0,38400  (amba-pl011.c, vexpress)
> - console=ttyO2,115200n8 (omap-serial.c, AM335x)
> 
> There is no "earlycon" on the commandline and nothing earlycon related I
> did on purpose in the oftree.

Ok. In your first email, you said "my boxes with early console enabled",
so I thought you meant that you were starting an earlycon. I see now
you meant enabled, as in built-in (not enabled as in started).

> My expectation would be to configure the system in a way that I have
> everything necessary for earlecon usage compiled into the kernel, so I
> can enable it manually from the bootloader whenever I need it (i.e. by
> adding 'earlycon' to the kernel commandline, or by modifying the oftree
> before it is handled over to the kernel).

Ok.

>>> The box was booted with "console=ttyAMA0,38400n8" on the commandline.
>>> If I understand this right, the code in drivers/tty/serial/earlycon.c
>>> calls setup_earlycon() with the string above ("ttyAMA0,38400n8") and
>>> fails to find that string in the "names" part of the __earlycon_table,
>>> because for the pl011 component on vexpress, the early console was
>>> registered in drivers/tty/serial/amba-pl011.c with:
>>>
>>> OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>>>                     ^^^^^ name
>>>
>>> So isn't that trying to match "ttyAMA0" against "arm,pl011"? I have the
>>> feeling that I didn't understand the logic behind that.
>>>
>>> Can you elaborate about how this is supposed to work correctly?

The facility I describe below is to enable earlycon->console handoff.
If you're not interested in that, please disregard.

I provided the description because it wasn't clear to me from your
original email if that was something you were trying to implement and
couldn't get working.

>> Yeah, I've been meaning to write about this but simply haven't had the
>> time yet; apologies for that.
>>
>> The facility is hopefully best explained by the existing 8250 exemplar.
>> Normally, an 8250 early console is started via command line with a
>> command line parameter like:
>>
>> 	earlycon=uart,io,0x2f8,115200n8
> 
> What happens if you don't have this parameter on the kernel commandline,
> but use the same port for your serial console? i.e. 'console=ttyS0'?
>
> I would expect the same warning I see on my boxes.

The diagnostic was added in commit 470ca0de69feaba5df215ad804cec1859883a5ed
("serial: earlycon: Enable earlycon without command line param").

Previously, if earlycon failed to start because of an error, such as because the
earlycon name was misspelled, there was no diagnostic.

  
>> Since 2007, an 8250 early console can also be started via command line
>> using console= instead, like:
>>
>> 	console=uart,io,0x2f8,115200n8
> 
> No: "console=..." puts the console on that port, not the early console.
> The semantic for console= was always to specify the name of the device
> there, so "console=ttyS0...", not "console=uart...", right?

>From Documentation/kernel-parameters:

	console=	[KNL] Output console device and options.

		....

		uart[8250],io,<addr>[,options]
		uart[8250],mmio,<addr>[,options]
		uart[8250],mmio32,<addr>[,options]
		uart[8250],0x<addr>[,options]
			Start an early, polled-mode console on the 8250/16550
			UART at the specified I/O port or MMIO address,
			switching to the matching ttyS device later.
			MMIO inter-register address stride is either 8-bit
			(mmio) or 32-bit (mmio32).
			If none of [io|mmio|mmio32], <addr> is assumed to be
			equivalent to 'mmio'. 'options' are specified in the
			same format described for ttyS above; if unspecified,
			the h/w is not re-initialized.

This behavior was added in Jul 2007 with commit 18a8bd949d6adb311
("serial: convert early_uart to earlycon for 8250").


>> In this alternate form, this early console will go on to become the
>> corresponding ttyS console.
>>
>> However, that functionality was exclusive to 8250 console/earlycon.
>> To get this same behavior for the amba-pl011 console would look
>> something like:
>>
>> /* drivers/tty/serial/amba-pl011.c */
>>
>> /* returns 0 if the console matches; otherwise, non-zero to use default matching */
>> static int pl011_console_match(struct console *co, char *name, int idx, char *options)
>> {
>> 	unsigned char iotype;
>> 	unsigned long addr;
>>
>> 	if (strncmp(name, "pl" 2) != 0 || idx != 11)
>> 		return -ENODEV;
>>
>> 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
>> 		return -ENODEV;
>>
>> 	/* find the port from the addr */
>> 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
>> 		if (amba_ports[i] == NULL)
>> 			continue;
>> 		if (port->mapbase != addr)
>> 			continue;
>>
>> 		co->index = i;
>> 		return pl011_console_setup(co, options);
>> 	}
>>
>> 	return -ENODEV;
>> }
>>
>> ...
>>
>> static struct console amba_console = {
>> 	...
>> 	.match		= pl011_console_match,
>> 	...
>> };
> 
> pl011 already has:
> 
> ----------8<----------8<----------8<----------8<----------8<----------8<----------
> 
> static void pl011_early_write(struct console *con, const char *s, unsigned n)
> {
>         struct earlycon_device *dev = con->data;
> 
>         uart_console_write(&dev->port, s, n, pl011_putc);
> }
> 
> static int __init pl011_early_console_setup(struct earlycon_device *device,
>                                             const char *opt)
> {
>         if (!device->port.membase)
>                 return -ENODEV;
> 
>         device->con->write = pl011_early_write;
>         return 0;
> }
> EARLYCON_DECLARE(pl011, pl011_early_console_setup);
> OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
> 
> ----------8<----------8<----------8<----------8<----------8<----------8<----------
> 
> So on oftree based systems it registers an __earlycon_table with name=pl011 and
> compatible=arm,pl011. In order to see something, I need to add
> 
> 	console=ttyAMA0
> 
> In that case, it doesn't matter if I add an earlycon= parameter on the
> commandline or not. The system takes the console= entry and hands it over to
> setup_earlycon(), which tries to match it against the __earlycon_table, where
> it doesn't find anything. Simply because it is pl011 there.
> 
> So switching earlycon on is broken.
> 
> If I leave out earlycon, I'd expect to switch off earlycon, which doesn't work,
> because exactly the same as above happens.
> 
> So switching earlycon off is also broken.
> 
> This is either buggy or I didn't understand how it is supposed to be used.

AFAICT nothing is broken; you're only seeing a new diagnostic from code that
was always running.

Regards,
Peter Hurley
