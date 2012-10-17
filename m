From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Wed, 17 Oct 2012 15:24:06 -0500
Message-ID: <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk> <20121016023226.GA17446@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39736 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab2JQUY2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Oct 2012 16:24:28 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so4456235vcb.19
        for <linux-serial@vger.kernel.org>; Wed, 17 Oct 2012 13:24:27 -0700 (PDT)
In-Reply-To: <20121016023226.GA17446@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Mon, Oct 15, 2012 at 9:32 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Oct 16, 2012 at 12:26:08AM +0100, Alan Cox wrote:
>> > That sounds reasonable but I am not sure what you mean my the "method
>> > documented in the Exar data sheet."  I've been through this thing
>> > quite a bit and I don't see anything about how one might detect the
>> > ports without the PCI id numbers.  Could you explain what you mean by
>> > this?
>>
>> I don't believe you can identify the new Exars except by PCI id - which
>> is fine as the type can be passed via the 8250_pci driver.
>
> Yeah, I just checked out the data sheet, and it looks like there isn't
> a way to do this.  That's unfortunate, since board vendors can change
> the PCI vendor and device ID.  So if they reprogram the EEPROM to use
> their own id numbers, we won't be able to support that new board
> without modifying the kernel source.  This is why I had tried to
> implement ways where if the PCI class indicated a 16550 compatible
> port, we would try to probe the UART registers to figure out exactly
> what type of advanced features beyond those supported by the standard
> 16550A UART.  Sigh, it looks like we won't be able to do things that
> way.

Which is exactly what I do to the device id :)

>> > * I need to change two UART specific registers to change the sampling
>> > mode (16x, 8x and 4x).
>>
>> What determines this.
>
> We have support for things like this already; see
> serial8250_get_divisor and UPF_MAGIC_MULTIPLIER.  In general you only
> want to change the sampling mode when you need it (i.e, for the high
> speed baud rates).

I'm not sure the UPF_MAGIC_MULTIPLIER is the same as the sampling rate
that I'm looking for, though I might be able to come up with a way to
hijack the flag to do what I want.

>> They should provide the basics.
>>
>> > * I need to be able to enable 9-bit mode, what they call Normal
>> > Multi-drop as well as the Auto Address Detection Mode used in
>> > conjunction with the Multi-drop mode.
>>
>> That may actually be the most "fun" bit - the entire Linux tty layer is
>> devoutly 5-8bit, although people do some horrible hacks with  "8 plus
>> parity".
>
> That's what is actually recommended by the Exar application note;
> since setting the 9th bit is only used for indicating that the lower 8
> bits is the "address" bit for demultiplexing destination "drop", you
> don't need to do it very often compared to the data bytes.  So
> toggling the parity bit is the best way to deal with the fact you can
> only use outb to send 8 bits.

What I would need to have happen is for a flag to be set that says
"enable 9-bit mode transmit" or something.  When set, the first byte
of data of a given write will go out with mark parity, then the rest
of the bytes will have space parity.  The one byte with mark is the
address byte.

In the receive direction I would need to optionally enable a station
address which the chip will use to verify all incoming data and will
reject anything that is not of the appropriate address.

Matt Schulte
