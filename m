From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New serial card development
Date: Tue, 16 Oct 2012 00:26:08 +0100
Message-ID: <20121016002608.64b33de5@pyramind.ukuu.org.uk>
References: <5074703E.408@commtech-fastcom.com>
	<20121014093704.GA6207@thunk.org>
	<CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:40438 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab2JOXVJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Oct 2012 19:21:09 -0400
In-Reply-To: <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-serial@vger.kernel.org

> That sounds reasonable but I am not sure what you mean my the "method
> documented in the Exar data sheet."  I've been through this thing
> quite a bit and I don't see anything about how one might detect the
> ports without the PCI id numbers.  Could you explain what you mean by
> this?

I don't believe you can identify the new Exars except by PCI id - which
is fine as the type can be passed via the 8250_pci driver.

> * This new Exar UART does not use a crystal it uses a clock from the
> PCI Express bus.  Also it has a fractional divisor that gets them
> 1/16th (0.0625) resolution on their divisors.  The normal DLL and DLM
> registers contain the integer part of the divisor and the DLD register
> provides the fractional component.  The divisor is able to be set to
> anything between 1 and (2^16 - 0.0625) in increments of 0.0625.

That probably needs a bit of tweaking to getthe best results

> * These UARTs have 256 byte FIFOs per port per direction.  I would
> like to utilize these to their fullest potential.

We already handle other similar fifos so again in theory you just need to
set the size and it works.

> * I need to toggle 16-bit general purpose IO signals to control two
> things on my card: Receive Echo Cancel (useful for 2-wire 485) and the
> selectable termination resistance on my receiver chips.

Ok - we don't have a generalized way of doing that in the RS485 bits but
anything liek this should get added generically (in case other chips want
to do it)
 
> * I need to change two UART specific registers to change the sampling
> mode (16x, 8x and 4x).

What determines this.

> * I need to figure out if the new RS485 elements that have been added
> to 8250 can be used on these Exar parts and if not I need something
> that can enable RS485 for us.

They should provide the basics.

> * I need to be able to enable 9-bit mode, what they call Normal
> Multi-drop as well as the Auto Address Detection Mode used in
> conjunction with the Multi-drop mode.

That may actually be the most "fun" bit - the entire Linux tty layer is
devoutly 5-8bit, although people do some horrible hacks with  "8 plus
parity".

> With this laundry list of items that I would like to include, do you
> still feel like this is something that should be included in the
> kernel's 8250.c/8250_pci.c drivers?

I think so. It's also the path that lets you do basic enabling, get
it working upstream and then extend as is needed for the other features.

The one area 8250 really can't hack properly is DMA driven 8250 devices.

Alan
