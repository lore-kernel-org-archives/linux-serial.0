From: Chanho Min <chanho0207@gmail.com>
Subject: Re: [PATCH] Clear previous interrupts after fifo is disabled
Date: Tue, 28 Feb 2012 18:16:10 +0900
Message-ID: <CAOAMb1CJ=G45G3JsxwP23GSdEOnDmY5xVoQmWLXaKJJv2cLOLg@mail.gmail.com>
References: <CAOAMb1ASB0zznSSOAU9HgPNW2e=Do+8hSJ6JZ00DxtAxqsXyXQ@mail.gmail.com>
	<20120227104858.GR22562@n2100.arm.linux.org.uk>
	<20120227110204.GA30199@n2100.arm.linux.org.uk>
	<CAOAMb1BjC2bF=rpJAhRUrB_U2mp8HGWxfcp+=TZ1etWzjUEwig@mail.gmail.com>
	<20120228083545.GA18045@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56412 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab2B1JQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Feb 2012 04:16:10 -0500
In-Reply-To: <20120228083545.GA18045@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, "Kim, Jong-Sung" <neidhard.kim@lge.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> RXFE _will_ be set. =A0Think about it - RXFE means Receive Fifo Empty=
=2E
> If the receive fifo is empty, it _will_ be set.
I know meaning of the RXFE. I also don't understand why RXFE is set by
clearing FEN. We checked this by bellow debug codes.

 fr_before =3D readw(uap->port.membase + UART01x_FR);
 writew(0, uap->port.membase + uap->lcrh_rx);
 fr_after =3D readw(uap->port.membase + UART01x_FR);

If rx interrupt is ocurred before, fr_after becomes 0x90 but fr_before =
is 0x80.

> And RIS is the _Raw_ interrupt status. =A0That's the status _before_ =
the
> mask is acted upon.
>
> But it won't be delivered because the mask register is zero.
It can be delivered just after mask register is set to 1.

>> Root cause is that Rx interrupt set but Rx fifo is empty. If we just
>> remove the sentence for clearing LCRH, nothing happens and interrupt
>> handler don't this misbehave.
>
> No.
When we just removed the sentence for clearing LCRH, this hangup doesn'=
t happen.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
