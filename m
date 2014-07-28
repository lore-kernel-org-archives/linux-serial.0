From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Support for RS485 on 8250 clone
Date: Mon, 28 Jul 2014 16:40:15 +0000 (UTC)
Message-ID: <lr5ude$f27$1@ger.gmane.org>
References: <CAPybu_2XurwztXTo+KwqKw1NpKFTLgPQ5AHyuO-z7-=65oAGqw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55885 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbaG1Qkb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Jul 2014 12:40:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1XBnyQ-0007vP-2C
	for linux-serial@vger.kernel.org; Mon, 28 Jul 2014 18:40:30 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2014 18:40:30 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2014 18:40:30 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-07-28, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> Hello
>
> I have a device with a Fintek F81216A  LPC to 4 Uart device.
>
> One of the uarts is used as half duplex rs485 serial port. This means
> that it needs to be configured properly (logical level of rts, delays,
> etc...)
>
> I see that there is an API on the kernel to do this (TIOCGRS485),
> unfortunately the 8250 driver does not support it.

That's mostly due to how crappy the 8250 UART design is.

> 1) Is there any interest on supporting this kind of hardware on the
>    kernel?

Sure.  That would be brilliant.

Many years ago, I tried to do implement half-duplex support for the
8250 but failed.  It would work on one motherboard but not the next.
There didn't seem to be a reliable way to know when the last stop bit
had been sent: the tx shift register empty status didn't go active at
a predicatble point. On some implementations it went true before the
stop bit was sent.  On some afterwards.  On some, part way through the
stop bit.

Even if the tx shift register empty bit did work predictably, you have
to do a busy/wait polling loop because that status bit can't generate
an interrupt, so there's no way trigger the required action (shut off
RTS or start a delay timer to do the same).

> 2) Some driver that I could use for inspiration?

Not that I know of.

-- 
Grant Edwards               grant.b.edwards        Yow! Are we THERE yet?
                                  at               
                              gmail.com            

