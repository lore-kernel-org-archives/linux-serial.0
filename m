Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9843C6FA8E
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCBNTf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 08:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBNTe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 08:19:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6769D1ADFA
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 05:19:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXiqI-0002fC-M9; Thu, 02 Mar 2023 14:19:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXiqH-001LCS-Iz; Thu, 02 Mar 2023 14:19:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXiqG-001Z2D-Jb; Thu, 02 Mar 2023 14:19:28 +0100
Date:   Thu, 2 Mar 2023 14:19:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: Simplify imx_uart_type
Message-ID: <20230302131928.craiexp4kknxxlza@pengutronix.de>
References: <20230302114810.1859500-1-u.kleine-koenig@pengutronix.de>
 <20230302115547.sacjk4ekwmfev2xz@pengutronix.de>
 <5912297.lOV4Wx5bFT@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajklvk6mi4oxn6fb"
Content-Disposition: inline
In-Reply-To: <5912297.lOV4Wx5bFT@steina-w>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--ajklvk6mi4oxn6fb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 02, 2023 at 01:20:25PM +0100, Alexander Stein wrote:
> Am Donnerstag, 2. M=E4rz 2023, 12:55:47 CET schrieb Uwe Kleine-K=F6nig:
> > * PGP Signed by an unknown key
> >=20
> > Hello,
> >=20
> > On Thu, Mar 02, 2023 at 12:48:10PM +0100, Uwe Kleine-K=F6nig wrote:
> > > There is no point in casting a struct uart_port to a struct imx_port
> > > just to access the first member of the latter (a struct uart_port).
> > >=20
> > > This introduces code changes.
> >=20
> > Please disregard this patch. While the patch is fine as is, I just
> > noticed a few more functions in this driver that can be simplified
> > accordingly. I'm about to send out an improved version (with a different
> > subject, so not called v2).
>=20
> Shouldn't this cast on the other locations be converted into a to_imx_por=
t()=20
> function using container_of as well?

Yeah, I wondered about that, too, but didn't tackle that (yet). I'll
keep that for another day (or someone else, don't hesitate if you're
motivated).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ajklvk6mi4oxn6fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQAol0ACgkQwfwUeK3K
7Amu+Qf+JKBCYcw8hoDdGjgEOVXS1ukwpI9iyjGxfM+N/4aQP3GKtXWSPyHnZRUo
Rybp4MnUpDmqifiJvLxi2QYLUHtM/XUPs77M/cLnAPvzf0kZZTW86zi5zejlGyj2
aLRxoFuiKUENX3EYed1m15F4WJOdQE7wS9Z6jDdMKecZ4XVwAR3CD54tj/QXzEHL
iX6V8jRSjIxTNTSs5jwFGGcYWBqCGRK9n+PhVCZ8j35vN3LqDMR0bxaSplU+5Nkv
LgFP0wMtMGm7gS6l6vZ3xOQVjpOuW0rWOXjGY0X5gktwF4gv2CeNsby62SExqN9c
pCkVExE5jitP8JShjewbcL4sJmC8ZQ==
=KpnN
-----END PGP SIGNATURE-----

--ajklvk6mi4oxn6fb--
