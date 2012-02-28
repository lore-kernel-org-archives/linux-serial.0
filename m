From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Clear previous interrupts after fifo is disabled
Date: Tue, 28 Feb 2012 08:35:45 +0000
Message-ID: <20120228083545.GA18045@n2100.arm.linux.org.uk>
References: <CAOAMb1ASB0zznSSOAU9HgPNW2e=Do+8hSJ6JZ00DxtAxqsXyXQ@mail.gmail.com> <20120227104858.GR22562@n2100.arm.linux.org.uk> <20120227110204.GA30199@n2100.arm.linux.org.uk> <CAOAMb1BjC2bF=rpJAhRUrB_U2mp8HGWxfcp+=TZ1etWzjUEwig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39542 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541Ab2B1IgQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Feb 2012 03:36:16 -0500
Content-Disposition: inline
In-Reply-To: <CAOAMb1BjC2bF=rpJAhRUrB_U2mp8HGWxfcp+=TZ1etWzjUEwig@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chanho Min <chanho0207@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, "Kim, Jong-Sung" <neidhard.kim@lge.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Feb 28, 2012 at 10:35:30AM +0900, Chanho Min wrote:
> On Mon, Feb 27, 2012 at 8:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Feb 27, 2012 at 10:48:58AM +0000, Russell King - ARM Linux =
wrote:
> >> I'd much prefer to only clear those interrupts which actually need=
 to be
> >> cleared at this point. =A0So, I'd suggest this approach instead:
> >
> > Thinking about this a little more, we definitely want to mask and c=
lear
> > interrupts at probe time as well:
> >
> I'm not satisfied with this completely. RIS has some pending
> interrupts even if interrupts are masked/disabled in IMSC. If your
> patch is applied, interrupt can be pended as bellows and RXFE of the
> flag register is set as well.

RXFE _will_ be set.  Think about it - RXFE means Receive Fifo Empty.
If the receive fifo is empty, it _will_ be set.

And RIS is the _Raw_ interrupt status.  That's the status _before_ the
mask is acted upon.

> writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
>        UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
> ...
> Interrupt is occured and pended in RIS

But it won't be delivered because the mask register is zero.

> ..
> writew(uap->im, uap->port.membase + UART011_IMSC);
>=20
> Root cause is that Rx interrupt set but Rx fifo is empty. If we just
> remove the sentence for clearing LCRH, nothing happens and interrupt
> handler don't this misbehave.

No.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
