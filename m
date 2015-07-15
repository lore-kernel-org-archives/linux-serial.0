From: Juergen Borleis <jbe@pengutronix.de>
Subject: Re: [PATCH] serial: mxs-auart: keep the AUART unit in reset state when not in use
Date: Wed, 15 Jul 2015 09:34:07 +0200
Message-ID: <201507150934.07249.jbe@pengutronix.de>
References: <1436884864-6782-1-git-send-email-jbe@pengutronix.de> <1463261573.74606.1436895184420.JavaMail.open-xchange@oxbsltgw03.schlund.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463261573.74606.1436895184420.JavaMail.open-xchange@oxbsltgw03.schlund.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Stefan,

On Tuesday 14 July 2015 19:33:04 Stefan Wahren wrote:
> [...]
> > diff --git a/drivers/tty/serial/mxs-auart.c=20
> > b/drivers/tty/serial/mxs-auart.c index 13cf773..f42b6ad 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -858,6 +858,30 @@ static void mxs_auart_reset(struct uart_port *=
u)
> > writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> > }
> >
> > +static void mxs_auart_do_reset(struct uart_port *u)
>
> i think the naming of this new function is too similiar to
> mxs_auart_reset() and doesn't represent the exact behavior. How about
> mxs_auart_keep_reset() or mxs_auart_gate()?

Hmm, maybe mxs_auart_reset() should be renamed instead, because it term=
inates=20
the reset to this unit and make it work (called when the driver's probe=
=20
function is running). But okay, mxs_auart_keep_reset() names more what =
it=20
really does.

> [...]
> > + udelay(10);
>
> The delay in mxs_auart_reset() has a value of 3 microseconds. Why not=
 the
> same here?

Hmm, good question. And why 3 us? :) I'm going to change it to 3 us as =
well.

> [...]
> > + /* reset the unit if not aready done */
>
> Just a typo: already?

Ups. Yes. Will fix.

Thanks!

Juergen

--=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Borleis =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
