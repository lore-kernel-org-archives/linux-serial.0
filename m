From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: New serial card development
Date: Mon, 15 Oct 2012 22:32:26 -0400
Message-ID: <20121016023226.GA17446@thunk.org>
References: <5074703E.408@commtech-fastcom.com>
 <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:55650 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab2JPCcb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Oct 2012 22:32:31 -0400
Content-Disposition: inline
In-Reply-To: <20121016002608.64b33de5@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Schulte <matts@commtech-fastcom.com>, linux-serial@vger.kernel.org

On Tue, Oct 16, 2012 at 12:26:08AM +0100, Alan Cox wrote:
> > That sounds reasonable but I am not sure what you mean my the "method
> > documented in the Exar data sheet."  I've been through this thing
> > quite a bit and I don't see anything about how one might detect the
> > ports without the PCI id numbers.  Could you explain what you mean by
> > this?
> 
> I don't believe you can identify the new Exars except by PCI id - which
> is fine as the type can be passed via the 8250_pci driver.

Yeah, I just checked out the data sheet, and it looks like there isn't
a way to do this.  That's unfortunate, since board vendors can change
the PCI vendor and device ID.  So if they reprogram the EEPROM to use
their own id numbers, we won't be able to support that new board
without modifying the kernel source.  This is why I had tried to
implement ways where if the PCI class indicated a 16550 compatible
port, we would try to probe the UART registers to figure out exactly
what type of advanced features beyond those supported by the standard
16550A UART.  Sigh, it looks like we won't be able to do things that
way.

> > * I need to change two UART specific registers to change the sampling
> > mode (16x, 8x and 4x).
> 
> What determines this.

We have support for things like this already; see
serial8250_get_divisor and UPF_MAGIC_MULTIPLIER.  In general you only
want to change the sampling mode when you need it (i.e, for the high
speed baud rates).

> They should provide the basics.
> 
> > * I need to be able to enable 9-bit mode, what they call Normal
> > Multi-drop as well as the Auto Address Detection Mode used in
> > conjunction with the Multi-drop mode.
> 
> That may actually be the most "fun" bit - the entire Linux tty layer is
> devoutly 5-8bit, although people do some horrible hacks with  "8 plus
> parity".

That's what is actually recommended by the Exar application note;
since setting the 9th bit is only used for indicating that the lower 8
bits is the "address" bit for demultiplexing destination "drop", you
don't need to do it very often compared to the data bytes.  So
toggling the parity bit is the best way to deal with the fact you can
only use outb to send 8 bits.

						- Ted

