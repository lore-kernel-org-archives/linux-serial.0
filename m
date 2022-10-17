Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D874C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 17 Oct 2022 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJQOL4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Oct 2022 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJQOLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Oct 2022 10:11:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272AA28719
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 07:11:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1okQqK-0004up-JC; Mon, 17 Oct 2022 16:11:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okQqI-0025y5-O3; Mon, 17 Oct 2022 16:11:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okQqI-008ZgG-5E; Mon, 17 Oct 2022 16:11:46 +0200
Date:   Mon, 17 Oct 2022 16:11:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     kernel@pengutronix.de,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: UART on MPC83xx in irq loop
Message-ID: <20221017141142.2otrfh5y3afosdvq@pengutronix.de>
References: <20221017094500.3wwd2njnao7rru4n@pengutronix.de>
 <97de1514-ecd4-68ae-2e9a-d821cb1c7b22@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kqdcuienc3mdiggw"
Content-Disposition: inline
In-Reply-To: <97de1514-ecd4-68ae-2e9a-d821cb1c7b22@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--kqdcuienc3mdiggw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 03:27:19PM +0300, Ilpo J=E4rvinen wrote:
> On Mon, 17 Oct 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > Hello,
> >=20
> > I have a system based on MPC8313ERDB here that in some situations gets
> > stuck in an irq loop. I have a reproducer here that works reliably. A
> > workaround is:
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 45b8a59d937c..5ab32b6ba701 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2009,6 +2009,14 @@ int serial8250_handle_irq(struct uart_port *port=
, unsigned int iir)
> > =20
> >  	status =3D serial_port_in(port, UART_LSR);
> > =20
> > +	/*
> > +	 * Sometimes a "Character time-out" (IID3:0 =3D=3D 0xc) happens on MP=
C8313,
> > +	 * but LSR doesn't report "Data ready". To clear the former the recei=
ve
> > +	 * buffer must be read. It's unclear if the char read is valid or not.
> > +	 */
> > +	if ((iir & UART_IIR_ID) =3D=3D UART_IIR_RX_TIMEOUT)
> > +		status |=3D UART_LSR_DR;
> > +
> >  	/*
> >  	 * If port is stopped and there are no error conditions in the
> >  	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
> >=20
> > I havn't debugged that further than written in the comment but I wonder
> > if this is a known issue (didn't find it in the errata though) and/or if
> > someone with hardware knowledge could confirm this to be a hardware
> > fault.
> >=20
> > Without feedback from NXP I'd look in more detail into that to for
> > example find out the timing and so maybe more hints about the hardware
> > and a better SW workaround/fix.
> >=20
> > Any input is very welcome.
>=20
> I find it bit odd you seem to assume w/o any justification that the data=
=20
> would be valid (that workaround will read one byte and consider it=20
> valid, no?). According to the comments & workarounds to the same problem
> (just look for IIR_RX_TIMEOUT and you'll find a few), they all do dummy=
=20
> reads rather than assume the data is valid.

AFAICT the irq doesn't stop being pending without the read. But yes,
there are some details to research/explain, for example what is read
=66rom the data register and if this byte is valid or not.

Also without status having the DR (or BI) bit set, UART_IIR_RX_TIMEOUT
doesn't kick in?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kqdcuienc3mdiggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNNYpwACgkQwfwUeK3K
7AmDuwgAoHel9/Xfa6Jb601oc+ecuL+7qifJtkfsxEhy9lNYdlA7U6by2JKEMWyu
7Lx1PntVAhborTR13WpLQRzmYP2zDxnhZTh8R6W7jrKS+PeqJ1ibG8lTRB+FK5fg
NacJQrT4DSpqwKMsAPgtD+draIyBJUq/b+ImJ33XgXWE/5U2uFwCP9qhWIlLDG+J
W/LZE6FIH3ig5A5pXHCw3Dy0pNeaKC68L3EiEgepIgiugSNmcfsYP0UmRCCHxIeL
Dq2wzqHLj5w7w5ZQh55L7Rao4WBnGDTzYse/d8eOMCJ75zthr1UiEUOPPGADsIGl
3Dwj8+vKWsIx2aq5YQqNg/jpp4GOxw==
=ZlSE
-----END PGP SIGNATURE-----

--kqdcuienc3mdiggw--
