From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Wed, 17 Oct 2012 15:23:45 -0500
Message-ID: <CAJp1Oe7zyDh9w7Nc-xtbPQrbg7FEBr73QmYh_er3UX53KcGL8A@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk> <CAJp1Oe6k7NWqdbYkJnd787JiT55-wSbG+tX1tP7Cy-oPShdVaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39901 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab2JQUYH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Oct 2012 16:24:07 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so7844338vbb.19
        for <linux-serial@vger.kernel.org>; Wed, 17 Oct 2012 13:24:06 -0700 (PDT)
In-Reply-To: <CAJp1Oe6k7NWqdbYkJnd787JiT55-wSbG+tX1tP7Cy-oPShdVaA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Forgot to reply to all.
---------- Forwarded message ----------
From: Matt Schulte <matts@commtech-fastcom.com>
Date: Wed, Oct 17, 2012 at 2:10 PM
Subject: Re: New serial card development
To: Alan Cox <alan@lxorguk.ukuu.org.uk>


On Mon, Oct 15, 2012 at 6:26 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> That sounds reasonable but I am not sure what you mean my the "method
>> documented in the Exar data sheet."  I've been through this thing
>> quite a bit and I don't see anything about how one might detect the
>> ports without the PCI id numbers.  Could you explain what you mean by
>> this?
>
> I don't believe you can identify the new Exars except by PCI id - which
> is fine as the type can be passed via the 8250_pci driver.
>
>> * This new Exar UART does not use a crystal it uses a clock from the
>> PCI Express bus.  Also it has a fractional divisor that gets them
>> 1/16th (0.0625) resolution on their divisors.  The normal DLL and DLM
>> registers contain the integer part of the divisor and the DLD register
>> provides the fractional component.  The divisor is able to be set to
>> anything between 1 and (2^16 - 0.0625) in increments of 0.0625.
>
> That probably needs a bit of tweaking to getthe best results

Does this make you lean one way or the other in how I would best
implement this driver?

>> * These UARTs have 256 byte FIFOs per port per direction.  I would
>> like to utilize these to their fullest potential.
>
> We already handle other similar fifos so again in theory you just need to
> set the size and it works.

Good, I'm sure it will be fine ;)

>> * I need to toggle 16-bit general purpose IO signals to control two
>> things on my card: Receive Echo Cancel (useful for 2-wire 485) and the
>> selectable termination resistance on my receiver chips.
>
> Ok - we don't have a generalized way of doing that in the RS485 bits but
> anything liek this should get added generically (in case other chips want
> to do it)

I have two features, one that could be considered part of RS485 and
one that has nothing at all to do with RS485.

>> * I need to change two UART specific registers to change the sampling
>> mode (16x, 8x and 4x).
>
> What determines this.

User would have to decide to turn on non-standard 8x or 4x sampling mode.

>> * I need to figure out if the new RS485 elements that have been added
>> to 8250 can be used on these Exar parts and if not I need something
>> that can enable RS485 for us.
>
> They should provide the basics.

Where will I take the built in 485 flags and turn them into whatever
my board needs?

>> * I need to be able to enable 9-bit mode, what they call Normal
>> Multi-drop as well as the Auto Address Detection Mode used in
>> conjunction with the Multi-drop mode.
>
> That may actually be the most "fun" bit - the entire Linux tty layer is
> devoutly 5-8bit, although people do some horrible hacks with  "8 plus
> parity".

Transmitting is a little bit interesting but manageable.  In the
receive direction the chip can detect the 9th bit and recognize it as
an address bit and then check that byte against a preset station
address that has been specified by the user.

>> With this laundry list of items that I would like to include, do you
>> still feel like this is something that should be included in the
>> kernel's 8250.c/8250_pci.c drivers?
>
> I think so. It's also the path that lets you do basic enabling, get
> it working upstream and then extend as is needed for the other features.

So is there an example of a device already in the kernel that you
think I should try to emulate? Will I be best served with something
like 8250_dw.c or do you think I should try to get all of my things
directly into 8250 and 8250_pci?

Matt Schulte
