From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Mon, 15 Oct 2012 14:08:40 -0500
Message-ID: <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56927 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2JOTJB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Oct 2012 15:09:01 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so2167844vcb.19
        for <linux-serial@vger.kernel.org>; Mon, 15 Oct 2012 12:09:00 -0700 (PDT)
In-Reply-To: <20121014093704.GA6207@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org

On Sun, Oct 14, 2012 at 4:37 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Oct 09, 2012 at 01:43:10PM -0500, Matt Schulte wrote:
> > Hello, my name is Matt and I have recently developed a PCIe card based
> > on the Exar 17v35x series of PCIe multiport UART chips.
> >
> > We have written Linux drivers for our other products in the past but
> > they have never been what I would call the best practice for Linux
> > development.
> >
> > This time I would like to write a driver that uses the best practices
> > and possibly submit it to the kernel when I'm done.
> >
> > I am a little bit confused about what method would be best for this
> > device.   I have been examining the sample driver provided by Exar
> > and it seems that the only things that they have that are really
> > different from the generic 8250 serial driver are the interrupt
> > handler (optimized for their multiple ports), the transmit and
> > receive character functions (modified to use their 256 byte FIFOs)
> > and the function that calculates the baud.  Also I have two features
> > specific to my card that I would likely need to use an ioctl for.
>
> Hi Matt,
>
> It's been a while since I've done serial development (probably close
> to a decade ago), but way back when I was responsible for most of the
> code which is now in drivers/tty/serial/8250/serial.c, I had added
> support for the Exar 16C850 UART; since then someone else has added
> support for the Exar XR17D15x UART.
>
> The EXAR 16C850 had a 128 byte FIFO; it sounds like this EXAR variant
> is similar to the 16C850, although it's been further extended.
>
> > If these are the only differences would I be able to create a driver
> > like what is seen in the /drivers/tty/serial/8250 directory (8250_dw.c
> > for example)?  Or would I need to do something similar to what I find in
> > the /drviers/tty/serial directory?
>
> We support a very large number of 8250-like UART's already.  It
> doesn't make sense create a new driver which is essentially a clone of
> the 8250.c driver.  Instead, the 8250.c driver should be extended to
> support this new Exar UART variant.  The preferred way to do this is
> to detect the EXAR UART directly, via the method documented in the
> EXAR data sheet, instead of using the PCI id numbers to make this
> determination.  This way, we will be able to support that UART on
> other PCI serial cards, and not just yours.


That sounds reasonable but I am not sure what you mean my the "method
documented in the Exar data sheet."  I've been through this thing
quite a bit and I don't see anything about how one might detect the
ports without the PCI id numbers.  Could you explain what you mean by
this?
>
>
> If you have some features which are explicitly specific to your card,
> and which are not specific to the UART, then that may need to be
> separately triggered via the PCI vendor/device id numbers.  What
> feature is it, by the way?  If it has to do with controlling the clock
> crystal, there's infrastructure to deal with this already that you may
> be able to leverage.

* This new Exar UART does not use a crystal it uses a clock from the
PCI Express bus.  Also it has a fractional divisor that gets them
1/16th (0.0625) resolution on their divisors.  The normal DLL and DLM
registers contain the integer part of the divisor and the DLD register
provides the fractional component.  The divisor is able to be set to
anything between 1 and (2^16 - 0.0625) in increments of 0.0625.

* These UARTs have 256 byte FIFOs per port per direction.  I would
like to utilize these to their fullest potential.

* I need to toggle 16-bit general purpose IO signals to control two
things on my card: Receive Echo Cancel (useful for 2-wire 485) and the
selectable termination resistance on my receiver chips.

* I need to change two UART specific registers to change the sampling
mode (16x, 8x and 4x).

* I need to figure out if the new RS485 elements that have been added
to 8250 can be used on these Exar parts and if not I need something
that can enable RS485 for us.

* I need to be able to enable 9-bit mode, what they call Normal
Multi-drop as well as the Auto Address Detection Mode used in
conjunction with the Multi-drop mode.

* There is an interruptible hardware timer/counter that I might like
to utilize at some point.

With this laundry list of items that I would like to include, do you
still feel like this is something that should be included in the
kernel's 8250.c/8250_pci.c drivers?

Thanks for helping me think this through.

Matt
