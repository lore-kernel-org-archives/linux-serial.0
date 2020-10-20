Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F358C433E7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 07:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB2223C6
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 07:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgJTHiB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgJTHiB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 03:38:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50655C061755
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2020 00:38:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUmDO-0005aE-0I; Tue, 20 Oct 2020 09:37:50 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUmDN-0006Dc-6N; Tue, 20 Oct 2020 09:37:49 +0200
Date:   Tue, 20 Oct 2020 09:37:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     trix@redhat.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: remove unneeded break
Message-ID: <20201020073749.rxfdggobl5gv7vn4@pengutronix.de>
References: <20201019175915.3718-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfcchpa22t5gbr4t"
Content-Disposition: inline
In-Reply-To: <20201019175915.3718-1-trix@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--tfcchpa22t5gbr4t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 10:59:15AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> A break is not needed if it is preceded by a return
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/tty/serial/imx.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1731d9728865..09703079db7b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -320,7 +320,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32=
 offset)
>  	switch (offset) {
>  	case UCR1:
>  		return sport->ucr1;
> -		break;
>  	case UCR2:
>  		/*
>  		 * UCR2_SRST is the only bit in the cached registers that might
> @@ -331,16 +330,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u=
32 offset)
>  		if (!(sport->ucr2 & UCR2_SRST))
>  			sport->ucr2 =3D readl(sport->port.membase + offset);
>  		return sport->ucr2;
> -		break;
>  	case UCR3:
>  		return sport->ucr3;
> -		break;
>  	case UCR4:
>  		return sport->ucr4;
> -		break;
>  	case UFCR:
>  		return sport->ufcr;
> -		break;
>  	default:
>  		return readl(sport->port.membase + offset);
>  	}

this might be subjective, but I like the break being there for clearity.
So I object to make a patch to remove them. In case I'm outvoted I'd at
least want empty lines instead.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tfcchpa22t5gbr4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+Ok8oACgkQwfwUeK3K
7AmutQgAl6jVgjKWwNF43KjCQWe0NKy9bCuHoGhhs6JNBOw0ODnglhn8nOADzFWb
YJia9YC8rjqdPKBiKk/46Xdk0IH2NR/9rICG4nXCjYMCEezRA9+xRZc1g6nJfb6w
Rd5h2jZZCXNMdx1wFlYoySbB0EmwMje/0acPiBK0NwSSsfbOZUnpiqGfr6UdMAIA
LkuNkFKyTh4dAhnAiLsQlLYCBB2q/aQjhzcL10WnfLrdJ6B/RdnmXhHBlWKZ/vOL
C+QTtRUXBOA99n1WAujw0XeHJHGK4zHD2sEJX9EcDtx6/OSPZmTeCpVLTDHSKyzb
kq9VGoVRb7dvhBJyzULubMmUYatU3w==
=It2d
-----END PGP SIGNATURE-----

--tfcchpa22t5gbr4t--
