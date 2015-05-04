From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Mon, 04 May 2015 12:52:51 -0400
Message-ID: <5547A3E3.2060200@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55477BC1.6000805@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 05/04/2015 10:01 AM, Peter Hurley wrote:
> Hi Robert,
> 
> On 05/03/2015 05:10 PM, Robert Schwebel wrote:
>> Hi Peter,
>>
>> with 4.1-rc1, my boxes with early console enabled show something like
>> this (the example is vexpress, but it for example also happens on an
>> AM335x board):
>>
>>   earlycon: no match for ttyAMA0,38400n8
> 
> This shouldn't impact any previous earlycon setup. Are you saying
> you're seeing a regression?
> 
> How do you have early console enabled, via the command line or via DT?
> 
> 
>> The box was booted with "console=ttyAMA0,38400n8" on the commandline.
>> If I understand this right, the code in drivers/tty/serial/earlycon.c
>> calls setup_earlycon() with the string above ("ttyAMA0,38400n8") and
>> fails to find that string in the "names" part of the __earlycon_table,
>> because for the pl011 component on vexpress, the early console was
>> registered in drivers/tty/serial/amba-pl011.c with:
>>
>> OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>>                     ^^^^^ name
>>
>> So isn't that trying to match "ttyAMA0" against "arm,pl011"? I have the
>> feeling that I didn't understand the logic behind that.
>>
>> Can you elaborate about how this is supposed to work correctly?
> 
> Yeah, I've been meaning to write about this but simply haven't had the
> time yet; apologies for that.
> 
> The facility is hopefully best explained by the existing 8250 exemplar.
> Normally, an 8250 early console is started via command line with a
> command line parameter like:
> 
> 	earlycon=uart,io,0x2f8,115200n8
> 
> Since 2007, an 8250 early console can also be started via command line
> using console= instead, like:
> 
> 	console=uart,io,0x2f8,115200n8
> 
> In this alternate form, this early console will go on to become the
> corresponding ttyS console.
> 
> However, that functionality was exclusive to 8250 console/earlycon.
> To get this same behavior for the amba-pl011 console would look
> something like:
> 
> /* drivers/tty/serial/amba-pl011.c */
> 
> /* returns 0 if the console matches; otherwise, non-zero to use default matching */
> static int pl011_console_match(struct console *co, char *name, int idx, char *options)
> {
> 	unsigned char iotype;
> 	unsigned long addr;
> 
> 	if (strncmp(name, "pl" 2) != 0 || idx != 11)
                              ^
                              ,
Sorry, missed that.

> 		return -ENODEV;
> 
> 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
> 		return -ENODEV;
> 
> 	/* find the port from the addr */
> 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
> 		if (amba_ports[i] == NULL)
> 			continue;
> 		if (port->mapbase != addr)
> 			continue;
> 
> 		co->index = i;
> 		return pl011_console_setup(co, options);
> 	}
> 
> 	return -ENODEV;
> }
> 
> ...
> 
> static struct console amba_console = {
> 	...
> 	.match		= pl011_console_match,
> 	...
> };
> 
> 
> Regards,
> Peter Hurley
> 
