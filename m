Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7351C77B6C
	for <linux-serial@archiver.kernel.org>; Thu, 13 Apr 2023 07:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDMHV1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Apr 2023 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDMHV0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Apr 2023 03:21:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D786759F4
        for <linux-serial@vger.kernel.org>; Thu, 13 Apr 2023 00:21:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmrGm-0000hI-7Q; Thu, 13 Apr 2023 09:21:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmrGk-00Auuf-0F; Thu, 13 Apr 2023 09:21:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmrGj-00Coc2-D4; Thu, 13 Apr 2023 09:21:21 +0200
Date:   Thu, 13 Apr 2023 09:21:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2] serial: imx: Drop a few unneeded casts
Message-ID: <20230413072121.irgwuhsrgk5ybbes@pengutronix.de>
References: <20230412165015.3560730-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2sg5bjzuqw7g4jb"
Content-Disposition: inline
In-Reply-To: <20230412165015.3560730-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--r2sg5bjzuqw7g4jb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 12, 2023 at 06:50:15PM +0200, Uwe Kleine-K=F6nig wrote:
> There is no point in casting a struct uart_port to a struct imx_port
> just to access the first member of the latter (a struct uart_port).
>=20
> This introduces no code changes.
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1:
>=20
>  - Add Ilpo's Ack
>  - Add a "no" to the commit log (Thanks to Ilpo for pointing that out).

oh, I just noticed that you already picked up my patch and fixed the
commit log (-> 46ce64bbfe0c84d1cf14fb325c8c7c323cabf3b8 in next). So
please just drop this patch.

Thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r2sg5bjzuqw7g4jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ3rXAACgkQj4D7WH0S
/k5Q8ggAoLDTZVVc+Z8eG0MEE3gi5evvnYrwXR9Gg6LijlOwuDD71hjwVXfPEdPI
HZ4kH9HDhmzRhjreoglpNDrUsGDtQVKDqrjzGvFIcjVUyQ7WUATDg9IYlclm4S6t
1uKSJMC5/apFBB2c0UNmZrARqpPRTeUCRZpZBBdhDVn2/Sz/Q2KQf+xTLD0XMgoB
nkcdn5s8IaWPs7jJ6i/Qk8tfzXKVvWirwUb+/9VQZiH3rqYVMElGRLXiVlEGlRD4
RDiABv91ZVXzTuAhadQJnUW/k2ulbHvNwrvZrrrbeelsYFtoq8PbJ4HRD0MgKaS8
jxCIARSuRmBcMXVQT4kgzyBgvdU7kQ==
=CElx
-----END PGP SIGNATURE-----

--r2sg5bjzuqw7g4jb--
