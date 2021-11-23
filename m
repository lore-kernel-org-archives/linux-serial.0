Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB0C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 13:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhKWNG1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhKWNG1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 08:06:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD681C061574
        for <linux-serial@vger.kernel.org>; Tue, 23 Nov 2021 05:03:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpVS7-0007Kh-8T; Tue, 23 Nov 2021 14:03:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpVS6-000bGh-Qm; Tue, 23 Nov 2021 14:03:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpVS5-0008HJ-QC; Tue, 23 Nov 2021 14:03:13 +0100
Date:   Tue, 23 Nov 2021 14:03:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
 instead of .shutdown()
Message-ID: <20211123130313.gdxjfav6ides6mkg@pengutronix.de>
References: <20211123105122.7913-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjbt3goy2mxbdjt6"
Content-Disposition: inline
In-Reply-To: <20211123105122.7913-1-sherry.sun@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--wjbt3goy2mxbdjt6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 06:51:22PM +0800, Sherry Sun wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
>=20
> Disable the UCR4_OREN bit in .stop_rx() before the uart receiver is disab=
led
> maybe better than in the .shutdown() function.

There should be a better incentive than "maybe it's better to do this".
My expectation is that you verify there is indeed an issue and then fix
that with a descriptive commit log that convinces this is indeed a fix.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wjbt3goy2mxbdjt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGc5o4ACgkQwfwUeK3K
7Anu4Qf9H4eu58akjZCWwLK0/sBZzzy+u9GRjlVRheYxRv6lNb/bzPYFLyyH+ZgR
auP9WxWPM1hdk+MHiep/CFGdx9PBQqspRIC08Xldn9WeykRat+ECSCE+JTjp1Utb
0fZO7mrzYH5QyZsXtP1knJ9ehjBhBR7fT16dxnnlexmwz3IVXFW16ZZ2vg0/ll38
dNq+oVIR+mCO+eeHDyaHg3bIkwfcx/CB9QJI3QHMnphvYqS72hql3fKampLNsdj8
WwXPBNfgW+xrcKgOjxqPpcbL/lzQkcn8PZAK1pDA3mppDOPApXAeTEda6Pp5+Aip
cvpTHrI/CBM8NEqFmVHEmXoFZmv5jw==
=pFUE
-----END PGP SIGNATURE-----

--wjbt3goy2mxbdjt6--
