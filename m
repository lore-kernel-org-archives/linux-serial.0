From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver for SPI-based 8250 serial port
Date: Wed, 5 Sep 2012 14:12:18 +0100
Message-ID: <20120905141218.7556f902@pyramind.ukuu.org.uk>
References: <504749CF.50709@mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44760 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab2IENHh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 09:07:37 -0400
In-Reply-To: <504749CF.50709@mind.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnout Vandecappelle <arnout@mind.be>
Cc: linux-serial@vger.kernel.org

> - I guess I should preferably write it as generically as possible, even though
> I can test it on only one device?

There is a balance between making it generic and getting it done and
useful. I would say it is more important to make it possible for someone
else to make it also handle their hardware than attempt to guess what is
needed. Make it possible, but don't do the work.

> - Should I add a UPIO_SPI to the global I/O types, or should I override the
> serial_in/serial_out functions in struct plat_serial8250_port?

I am not sure you'll make the 8250 driver handle the device because I
suspect a lot of the serial_in/serial_out calls occur with interrupts
disabled on the assumption that they are basically atomic fast operations.

> - I guess there should be a 8250_spi file that registers the platform
> device?

Probably, but also allowing people to create those platform devices in
their architecture code or via firmware.

> - I guess it doesn't make sense to try autoconfig_irq for such a device?
> The IRQ is typically a gpio which the platform code has to configure as an IRQ.

Agreed. autoconfigure IRQ really only applies for PC ISA bus type
devices. Most sane architectures know the IRQ to use.

> - I'm not sure how to set the uartclk. The XR20M1280's BRG is derived from a
> 24MHz clock, but other devices or other boards may have different values.
> Should it be part of platform data?  Should I define a new platform data struct
> for that?

platform data would be my guess.

>   Any other suggestions are also welcome.

Take a look at the locking assumptions of 8250.c. If they make it hard to
do the spi driver that way then I would suggest doing a small, clean
platform driver specifically for 16C950 over SPI. Pass the device type
(even if only 950 is supported), baud rate in via the platform struct.
That way others can tackle extending it for different devices as they
need.

Architecturally I think that will be what is needed - you end up wanting
a threaded IRQ handler and other major design differences the moment your
register writes are asynchronous and slow. You may well find that the
uart layer isn't a help either and it's best to go straight from the
tty/tty_port helpers.

Alan
