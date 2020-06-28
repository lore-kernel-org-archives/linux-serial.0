Return-Path: <SRS0=iRHZ=AJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41016C433E0
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A26206F1
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgF1QAI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Jun 2020 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgF1QAI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Jun 2020 12:00:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D9C03E979
        for <linux-serial@vger.kernel.org>; Sun, 28 Jun 2020 09:00:08 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpZiw-00044m-8u; Sun, 28 Jun 2020 18:00:06 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpZiu-0000z3-Lj; Sun, 28 Jun 2020 18:00:04 +0200
Date:   Sun, 28 Jun 2020 18:00:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Fugang Duan <fugang.duan@nxp.com>, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, lukas@wunner.de, kernel@pengutronix.de,
        jslaby@suse.com
Subject: Re: [PATCH tty/serial 1/1] tty: serial: imx: enable imx serial
 console port as module
Message-ID: <20200628160001.nmogndgajqbalzfo@pengutronix.de>
References: <20200605084321.26255-1-fugang.duan@nxp.com>
 <20200627142315.GA1959761@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hf2eqksat5nwcmp6"
Content-Disposition: inline
In-Reply-To: <20200627142315.GA1959761@kroah.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--hf2eqksat5nwcmp6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 04:23:15PM +0200, Greg KH wrote:
> On Fri, Jun 05, 2020 at 04:43:21PM +0800, Fugang Duan wrote:
> > GKI kernel requires drivers built as modules including
> > console driver, so add the support that imx serial console
> > driver can be built as module.
> >=20
> > The changes of the patch:
> > - imx console driver can be built as module.
> > - move out earlycon code to separated driver like imx_earlycon.c,
> >   and imx earlycon driver only support build-in.
> >=20
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > ---
> >  drivers/tty/serial/Kconfig        | 17 +++++++----
> >  drivers/tty/serial/Makefile       |  1 +
> >  drivers/tty/serial/imx.c          | 37 ++---------------------
> >  drivers/tty/serial/imx_earlycon.c | 50 +++++++++++++++++++++++++++++++
> >  4 files changed, 65 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index adf9e80e7dc9..890cbf214561 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -502,20 +502,27 @@ config SERIAL_IMX
> >  	  can enable its onboard serial port by enabling this option.
> > =20
> >  config SERIAL_IMX_CONSOLE
> > -	bool "Console on IMX serial port"
> > -	depends on SERIAL_IMX=3Dy
> > +	tristate "Console on IMX serial port"
> > +	depends on SERIAL_IMX
> >  	select SERIAL_CORE_CONSOLE
> > -	select SERIAL_EARLYCON if OF
> >  	help
> >  	  If you have enabled the serial port on the Freescale IMX
> > -	  CPU you can make it the console by answering Y to this option.
> > +	  CPU you can make it the console by answering Y/M to this option.
> > =20
> > -	  Even if you say Y here, the currently visible virtual console
> > +	  Even if you say Y/M here, the currently visible virtual console
> >  	  (/dev/tty0) will still be used as the system console by default, but
> >  	  you can alter that using a kernel command line option such as
> >  	  "console=3Dttymxc0". (Try "man bootparam" or see the documentation =
of
> >  	  your bootloader about how to pass options to the kernel at boot tim=
e.)
> > =20
> > +config SERIAL_IMX_EARLYCON
> > +	bool "Earlycon on IMX serial port"
> > +	depends OF
> > +	select SERIAL_EARLYCON if OF

Given that SERIAL_IMX_EARLYCON depends on OF, the select can be
unconditional.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hf2eqksat5nwcmp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl74vn4ACgkQwfwUeK3K
7An0gAf/Sv8ijJw0umWo1goFPdoPfipQpyJhWzJ8ESdz7K9IvOS1LV0Uhx+BKLmP
4pe2F33csYn5LXsxi5QaqolDeaJfyMRnUx1CepmI8/itTK7hjzpbEh+f3vdWgfEF
uKoI+BhJ28DxIDVKBVKGXDkUDHJ7aUUS5sT+hRpBFYEVFFyrgV51gWCNcEkOlyJT
Z7GiuP+fnK0ZtloLQWFk7fZAyU4stU+Z2eMlOu8fOZaY2I52wqTRqg2mUR0sz/ij
RYjCRlwtBw8/61OSgX5FQfMbNmEBxmvAD6BQzs+ca1bclsg+AbZs/op9mpLIU6V/
59uMVGeezTgtVnBsBFFPmY3KZx6s0Q==
=PibU
-----END PGP SIGNATURE-----

--hf2eqksat5nwcmp6--
