Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8ABC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 07:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhKWHpg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhKWHpf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 02:45:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1410C061574
        for <linux-serial@vger.kernel.org>; Mon, 22 Nov 2021 23:42:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpQRc-0008Iv-8z; Tue, 23 Nov 2021 08:42:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpQRc-000aTk-0B; Tue, 23 Nov 2021 08:42:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpQRa-0006gu-T5; Tue, 23 Nov 2021 08:42:22 +0100
Date:   Tue, 23 Nov 2021 08:42:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: imx: clear RTSD status before suspend
Message-ID: <20211123074219.wn5jfjr6ph7uutyo@pengutronix.de>
References: <20211123070349.20099-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4l4f62vkmjup6i2g"
Content-Disposition: inline
In-Reply-To: <20211123070349.20099-1-sherry.sun@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--4l4f62vkmjup6i2g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 03:03:49PM +0800, Sherry Sun wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
>=20
> Clear RTSD status before suspend due to the port also
> use RTS pin as wakeup source, need to clear the flag first.

I'd write:

	Clear RTSD status before enabling the irq event for RTSD.

That this happens in the context of suspend isn't that important.

> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 90f82e6c54e4..fb75e3e0d828 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2482,10 +2482,12 @@ static void imx_uart_enable_wakeup(struct imx_por=
t *sport, bool on)
> =20
>  	if (sport->have_rtscts) {
>  		u32 ucr1 =3D imx_uart_readl(sport, UCR1);
> -		if (on)
> +		if (on) {
> +			imx_uart_writel(sport, USR1_RTSD, USR1);
>  			ucr1 |=3D UCR1_RTSDEN;
> -		else
> +		} else {
>  			ucr1 &=3D ~UCR1_RTSDEN;
> +		}
>  		imx_uart_writel(sport, ucr1, UCR1);
>  	}

The change looks fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4l4f62vkmjup6i2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGcm1gACgkQwfwUeK3K
7AlRDggAm6qkIUGQGWyAX0QRPDZFfXjgeM9USm7yoTNbBfhib62Vt6ZGYjBAstYv
nsPuiRgru0ZWgLsd+YFs6+77lzaOVWxTu/AUNsMhbdnQFodZpUKJLIsEe6ts8RD2
OQp837KzMj9E6sl2EyfkF0XCHHQO1vgCkChEI9C4/MMYiecFRoOucr+QIa+Mrl9F
apfJ/AeUlo/6dBP948Z+hVumBaQR8IpMwpl8+ZU4l2/r4JXtDUaY+Dh76gaRETo7
Wc7/+VEo/omAHCs0OYbOK/hGVGui5u0Wvh/+4ezJIxQabEsv/Idgqe2qGMtq3ZAO
K9nUWUdt+2XbC4cJjJ9KqwGmoUj5kg==
=Q/Aq
-----END PGP SIGNATURE-----

--4l4f62vkmjup6i2g--
