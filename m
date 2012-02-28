From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Clear previous interrupts after fifo is disabled
Date: Tue, 28 Feb 2012 09:21:40 +0000
Message-ID: <20120228092140.GD18045@n2100.arm.linux.org.uk>
References: <CAOAMb1ASB0zznSSOAU9HgPNW2e=Do+8hSJ6JZ00DxtAxqsXyXQ@mail.gmail.com> <20120227104858.GR22562@n2100.arm.linux.org.uk> <20120227110204.GA30199@n2100.arm.linux.org.uk> <CAOAMb1BjC2bF=rpJAhRUrB_U2mp8HGWxfcp+=TZ1etWzjUEwig@mail.gmail.com> <20120228083545.GA18045@n2100.arm.linux.org.uk> <CAOAMb1CJ=G45G3JsxwP23GSdEOnDmY5xVoQmWLXaKJJv2cLOLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOAMb1CJ=G45G3JsxwP23GSdEOnDmY5xVoQmWLXaKJJv2cLOLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanho Min <chanho0207@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, "Kim, Jong-Sung" <neidhard.kim@lge.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 28, 2012 at 06:16:10PM +0900, Chanho Min wrote:
> > RXFE _will_ be set. =A0Think about it - RXFE means Receive Fifo Emp=
ty.
> > If the receive fifo is empty, it _will_ be set.
> I know meaning of the RXFE. I also don't understand why RXFE is set b=
y
> clearing FEN. We checked this by bellow debug codes.
>=20
>  fr_before =3D readw(uap->port.membase + UART01x_FR);
>  writew(0, uap->port.membase + uap->lcrh_rx);
>  fr_after =3D readw(uap->port.membase + UART01x_FR);
>=20
> If rx interrupt is ocurred before, fr_after becomes 0x90 but fr_befor=
e is 0x80.

Because the flags are manipulated to give the illusion of a one byte
=46IFO, as stated in the TRM.

> > And RIS is the _Raw_ interrupt status. =A0That's the status _before=
_ the
> > mask is acted upon.
> >
> > But it won't be delivered because the mask register is zero.
> It can be delivered just after mask register is set to 1.

And we don't set the mask register to 1 until later.

> >> Root cause is that Rx interrupt set but Rx fifo is empty. If we ju=
st
> >> remove the sentence for clearing LCRH, nothing happens and interru=
pt
> >> handler don't this misbehave.
> >
> > No.
> When we just removed the sentence for clearing LCRH, this hangup does=
n't
> happen.

But we want to do the transmit interrupt provocation with the FIFO disa=
bled.
