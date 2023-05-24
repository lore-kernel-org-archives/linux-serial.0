Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B260C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjEXOiK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEXOiJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 10:38:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B202E5C
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 07:37:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1pbl-0008OG-2v; Wed, 24 May 2023 16:36:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1pbj-002VdH-1t; Wed, 24 May 2023 16:36:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1pbi-007aLK-8B; Wed, 24 May 2023 16:36:54 +0200
Date:   Wed, 24 May 2023 16:36:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/3] serial: 8250: Clear IIR.RDI in
 serial8250_clear_fifos()
Message-ID: <20230524143654.dfkbo22vdpc73nqs@pengutronix.de>
References: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
 <20230524122754.481816-3-u.kleine-koenig@pengutronix.de>
 <576799f0-1d18-c9ed-bf12-cb2bed1f8bb@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pzfm22acgqp7xfct"
Content-Disposition: inline
In-Reply-To: <576799f0-1d18-c9ed-bf12-cb2bed1f8bb@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--pzfm22acgqp7xfct
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 04:02:58PM +0300, Ilpo J=E4rvinen wrote:
> On Wed, 24 May 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > At least on MPC83xx (but I suspect also on other implementations) it can
> > happen that after irqs are disabled but before the FIFOs are cleared a
> > character is received. Resetting the FIFO throws away that character,
> > but doesn't clear the IIR.RDI event that signals that there is read data
> > available.
> >=20
> > Read from RX to clear IIR.RDI and throw away the result.
> >=20
> > This fixes a infinite loop after the above described race happened: The
> > irq handler (here: fsl8250_handle_irq()) triggers, but LSR.DR isn't set,
> > so RX isn't read and the irq handler returns just to be called again.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index fe8d79c4ae95..8b47ec000922 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -556,6 +556,18 @@ static void serial8250_clear_fifos(struct uart_825=
0_port *p)
> >  		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
> >  			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> >  		serial_out(p, UART_FCR, 0);
> > +
> > +		/*
> > +		 * When doing rs485 on MPC8313 it can happen that in the short
> > +		 * window when switching from RX to TX there is a character in
> > +		 * the RX FIFO which isn't processed any more and then discarded
> > +		 * in here by clearing the FIFO. In that case IIR signals an RX
> > +		 * timeout once irqs are reenabled (i.e. in
> > +		 * serial8250_em485_stop_tx()) but LSR shows no pending event.
> > +		 * The RX timeout event can only be cleared by reading RX. Do
> > +		 * this here before reenabling the FIFO and irqs.
> > +		 */
> > +		serial_port_in(&p->port, UART_RX);
> >  	}
> >  }
>=20
> This solution has too wide impact, I think.

What is the impact? After the FIFO is reset reading the RX register
shouldn't matter?

> It should be made driver specific.

I'm not a big fan, the 8250 driver is already very fragmented.

> Can't you read IIR to see if the event indication is there before
> doing this UART_RX read?

Assuming reading IIR and reading RX take approx the same amount of
time, I don't see an upside of checking IIR first?!

> Maybe add an UART specific function for fifo clearing/reset.

See above. And with the theory that reading RX doesn't hurt after the
FIFO was just cleared, adding this to generic code has the upside that
other variants that might have the same issue get fixed, too.

> I've long wondered this related thing:
>=20
> Does anyone have idea why serial8250_clear_and_reinit_fifos() and=20
> serial8250_clear_fifos() are separate, what is the benefit of not setting=
=20
> FCR back to up->fcr? That is that intermediate FCR <=3D 0 really required=
=20
> for the FIFO reset sequence or is it just an artifact of how the code is=
=20
> structured into those two functions.
>=20
> It might make sense to drop serial8250_clear_and_reinit_fifos() and=20
> change serial8250_clear_fifos() into something like this (depending on=20
> the answers):
>=20
> static void serial8250_clear_fifos(struct uart_8250_port *p, bool disable)
> {
>         if (p->capabilities & UART_CAP_FIFO) {
>                 serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
>                 serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
>                                UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> 	        serial_out(p, UART_FCR, disable ? 0 : p->fcr);
>         }
> }

I'd say this should work. Apart from skipping

	serial_out(p, UART_FCR, 0);

it has the side effect of skipping

	serial_out(p, UART_FCR, p->fcr);

if !(p->capabilities & UART_CAP_FIFO). That shouldn't matter though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pzfm22acgqp7xfct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRuIQUACgkQj4D7WH0S
/k4VWQf+P1tkqYy6Kd4Q2QHr5P9XwvOucbB+V2hNue5Ve48YBhkid2O3HmpllwXN
u/XKHDN+XqnRkvmDHnPofbF8lbdGus6i24oxfD2wZyjpgJfWrlV70VIUR2Xq2bxb
kW70d0A/v7/VLExAfFR3K4hp73fiDYl9z13WS98PYWwCrXlIqJJN8iz65C3UQnXN
RZpcr6w6vWg0MEHXgy3Ko27eABlzlM+y3uGVn8GYH0VfzH0xnEYWQNWb95wplxWL
QlU9G4tW8WyCtGKDFGmq5RMr59Zx8mGZsPXMOGXL7wlYVyjmJKxjzIP8Xd05WI+8
rBIQectfQcd39oiFPwDif3G2rU9Tvw==
=3en7
-----END PGP SIGNATURE-----

--pzfm22acgqp7xfct--
