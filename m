From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH v2] mxs: uart: allow setting RTS from software
Date: Thu, 13 Dec 2012 14:19:12 +0100
Message-ID: <20121213131912.GB27832@pengutronix.de>
References: <1355388135-3676-1-git-send-email-s.trumtrar@pengutronix.de>
 <50C9ABB4.8010900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52220 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab2LMNTO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Dec 2012 08:19:14 -0500
Content-Disposition: inline
In-Reply-To: <50C9ABB4.8010900@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: linux-serial@vger.kernel.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Thu, Dec 13, 2012 at 06:19:32PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2012=E5=B9=B412=E6=9C=8813=E6=97=A5 16:42, Steffen Trumtrar=
 =E5=86=99=E9=81=93:
> > With the patch "serial: mxs-auart: fix the wrong RTS hardware flow =
control" the
> > mainline mxs-uart driver now sets RTSEN only when hardware flow con=
trol is
> > enabled via software. It is not possible any longer to set RTS manu=
ally via
> > software. However, the manual modification is a valid operation.
> > Regain the possibility to set RTS via software and only set RTSEN w=
hen hardware
> > flow control is explicitly enabled via settermios cflag CRTSCTS.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  drivers/tty/serial/mxs-auart.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mx=
s-auart.c
> > index 6db23b0..21d9b12 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_p=
ort *u, unsigned mctrl)
> > =20
> >  	u32 ctrl =3D readl(u->membase + AUART_CTRL2);
> > =20
> > -	ctrl &=3D ~AUART_CTRL2_RTSEN;
> > +	ctrl &=3D ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
> >  	if (mctrl & TIOCM_RTS) {
> >  		if (tty_port_cts_enabled(&u->state->port))
> >  			ctrl |=3D AUART_CTRL2_RTSEN;
> > +		else
> > +			ctrl |=3D AUART_CTRL2_RTS;
> >  	}
> > =20
> >  	s->ctrl =3D mctrl;
> > @@ -676,8 +678,10 @@ static void mxs_auart_settermios(struct uart_p=
ort *u,
> >  				ctrl2 |=3D AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
> >  				       | AUART_CTRL2_DMAONERR;
> >  		}
> > +		u->flags |=3D ASYNC_CTS_FLOW;
> >  		ctrl2 |=3D AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
> >  	} else {
> > +		u->flags &=3D ~ASYNC_CTS_FLOW;
> I think these two lines is not needed.
> uart_change_speed() has set/unset ASYNC_CTS_FLOW for us.

I don't know that much of the inner workings of the serial framework, b=
ut it
seems like it is guaranteed, that uart_change_speed is called before th=
e
mxs_auart_settermios. And therefore you are right and the two lines can=
 be
dropped.

Regards,
Steffen

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
