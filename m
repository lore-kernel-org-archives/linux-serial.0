From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: New serial card development
Date: Sun, 14 Oct 2012 05:37:04 -0400
Message-ID: <20121014093704.GA6207@thunk.org>
References: <5074703E.408@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:55433 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136Ab2JNOlw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 10:41:52 -0400
Content-Disposition: inline
In-Reply-To: <5074703E.408@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org

On Tue, Oct 09, 2012 at 01:43:10PM -0500, Matt Schulte wrote:
> Hello, my name is Matt and I have recently developed a PCIe card based
> on the Exar 17v35x series of PCIe multiport UART chips.
> 
> We have written Linux drivers for our other products in the past but
> they have never been what I would call the best practice for Linux
> development.
> 
> This time I would like to write a driver that uses the best practices
> and possibly submit it to the kernel when I'm done.
> 
> I am a little bit confused about what method would be best for this
> device.   I have been examining the sample driver provided by Exar
> and it seems that the only things that they have that are really
> different from the generic 8250 serial driver are the interrupt
> handler (optimized for their multiple ports), the transmit and
> receive character functions (modified to use their 256 byte FIFOs)
> and the function that calculates the baud.  Also I have two features
> specific to my card that I would likely need to use an ioctl for.

Hi Matt,

It's been a while since I've done serial development (probably close
to a decade ago), but way back when I was responsible for most of the
code which is now in drivers/tty/serial/8250/serial.c, I had added
support for the Exar 16C850 UART; since then someone else has added
support for the Exar XR17D15x UART.

The EXAR 16C850 had a 128 byte FIFO; it sounds like this EXAR variant
is similar to the 16C850, although it's been further extended.

> If these are the only differences would I be able to create a driver
> like what is seen in the /drivers/tty/serial/8250 directory (8250_dw.c
> for example)?  Or would I need to do something similar to what I find in
> the /drviers/tty/serial directory?

We support a very large number of 8250-like UART's already.  It
doesn't make sense create a new driver which is essentially a clone of
the 8250.c driver.  Instead, the 8250.c driver should be extended to
support this new Exar UART variant.  The preferred way to do this is
to detect the EXAR UART directly, via the method documented in the
EXAR data sheet, instead of using the PCI id numbers to make this
determination.  This way, we will be able to support that UART on
other PCI serial cards, and not just yours.

If you have some features which are explicitly specific to your card,
and which are not specific to the UART, then that may need to be
separately triggered via the PCI vendor/device id numbers.  What
feature is it, by the way?  If it has to do with controlling the clock
crystal, there's infrastructure to deal with this already that you may
be able to leverage.

Regards,

						- Ted
