Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C254AC4361B
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784FA222BB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 14:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408171AbgLNOiT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392136AbgLNOiO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 09:38:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED64C0613CF
        for <linux-serial@vger.kernel.org>; Mon, 14 Dec 2020 06:37:34 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kooyc-0002NZ-5D; Mon, 14 Dec 2020 15:37:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kooyb-0001gp-1T; Mon, 14 Dec 2020 15:37:25 +0100
Date:   Mon, 14 Dec 2020 15:37:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tty/serial/imx: convert comma to semicolon
Message-ID: <20201214143724.kmkuog7vmwfahvxt@pengutronix.de>
References: <20201214133719.3893-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7dexzmpulaqljoul"
Content-Disposition: inline
In-Reply-To: <20201214133719.3893-1-zhengyongjun3@huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7dexzmpulaqljoul
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2020 at 09:37:19PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>=20
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index cacf7266a262..4a959efb7849 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2312,7 +2312,7 @@ static int imx_uart_probe(struct platform_device *p=
dev)
>  	sport->port.dev =3D &pdev->dev;
>  	sport->port.mapbase =3D res->start;
>  	sport->port.membase =3D base;
> -	sport->port.type =3D PORT_IMX,
> +	sport->port.type =3D PORT_IMX;

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7dexzmpulaqljoul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/XeKIACgkQwfwUeK3K
7AlfvAf+LHvjVmvUNlWusL91Eo8RaGvbSZlF1WW3QfwIXF5+zfzsYuUncMaBiu8D
hbGpesK8uu5oGDsBZZ/3zyqhSQUTBC3VIIDtwzvtPHLynVP2246UMkSVamY8a/Mj
kfBb497Y+CThlJPVZ9uJIuKhXRZ5bZW3R5+QFo9YUjb0CTQWONiA6bJC5m6JERl9
5+Vu4ky5WH4rTpkcjguTLcgthXyjtbCo/Fwg/42XBqithwsQKfqEC60VMDFb7ejx
kXL3dddiJ7vAZwiY5M0jQxQBhm+Y5woeIwVKx5ceCBbJ9GOdrvuWorHMwT8WycCN
q4fWJnWDUbaJL3IoQvUGg8ejNJ0hFA==
=nQfB
-----END PGP SIGNATURE-----

--7dexzmpulaqljoul--
