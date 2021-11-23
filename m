Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81586C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 07:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhKWHyg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbhKWHyg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 02:54:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F28C061574
        for <linux-serial@vger.kernel.org>; Mon, 22 Nov 2021 23:51:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpQaM-0000rd-Mn; Tue, 23 Nov 2021 08:51:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpQaM-000aUe-Ey; Tue, 23 Nov 2021 08:51:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpQaL-0007At-IJ; Tue, 23 Nov 2021 08:51:25 +0100
Date:   Tue, 23 Nov 2021 08:51:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: imx: disable UCR4_OREN in .stop_rx()
Message-ID: <20211123075122.2cwhrdwrsyjgebnk@pengutronix.de>
References: <20211123070437.20153-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dfufdpmzqbray4ol"
Content-Disposition: inline
In-Reply-To: <20211123070437.20153-1-sherry.sun@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--dfufdpmzqbray4ol
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 03:04:37PM +0800, Sherry Sun wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
>=20
> Disable UCR4_OREN bit in .stop_rx() to avoid endless
> interrupt happen while tty port is closing.
>=20
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index fb75e3e0d828..9ecaf051249d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -486,18 +486,21 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  static void imx_uart_stop_rx(struct uart_port *port)
>  {
>  	struct imx_port *sport =3D (struct imx_port *)port;
> -	u32 ucr1, ucr2;
> +	u32 ucr1, ucr2, ucr4;
> =20
>  	ucr1 =3D imx_uart_readl(sport, UCR1);
>  	ucr2 =3D imx_uart_readl(sport, UCR2);
> +	ucr4 =3D imx_uart_readl(sport, UCR4);
> =20
>  	if (sport->dma_is_enabled) {
>  		ucr1 &=3D ~(UCR1_RXDMAEN | UCR1_ATDMAEN);
>  	} else {
>  		ucr1 &=3D ~UCR1_RRDYEN;
>  		ucr2 &=3D ~UCR2_ATEN;
> +		ucr4 &=3D ~UCR4_OREN;
>  	}
>  	imx_uart_writel(sport, ucr1, UCR1);
> +	imx_uart_writel(sport, ucr4, UCR4);

I don't understand this yet, but I guess this is just a matter of
improving the commit log. How does the endless irq happen?

=2E.. some time later after thinking and reading the driver source ...

Hmm, when the OR event is triggered the handler does

	imx_uart_writel(sport, USR2_ORE, USR2);

and so clears the event. I would expect that this should be good enough
to prevent an irq storm even if the receiver is disabled. Doesn't acking
work with the receiver disabled?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dfufdpmzqbray4ol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGcnXcACgkQwfwUeK3K
7AnXKQf+Oxo2fSuleEXcVEnt9y39g5vWnIK9KzWpvdcMnoiFe9+fRMVjpTMTKcaI
g2SGoArSUjxRY1Fl51Vfp+7t6fUneB6IebpZ4ZnQ59CGqkrLSKiOcMIVN19bWPZA
mZWNhOZovC0m4l2gx2msfRyrzg4bPjoxUY19oYDUkh3FALMwhBOLlFonZwSMro72
0LrYBHnBMGaKFQt1/b1kidFj3guZISPn63pW969YBXZa/w7S7LXRm/mvxDiYsmeS
uhpP6WsrnFg1JFWpAxAPanpiYcHHBCv7D8rFfbpEbovKAW0Fi5crMlZCQnxJrVbh
eqMHsORqldYHjD15a6IYDwkB1luinw==
=fZth
-----END PGP SIGNATURE-----

--dfufdpmzqbray4ol--
