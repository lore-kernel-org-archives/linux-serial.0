Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B31C388F9
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 09:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBDD20729
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 09:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKKJ5G (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbgKKJ5G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Nov 2020 04:57:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51173C0613D1
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2020 01:57:05 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcmsB-00050V-Gs; Wed, 11 Nov 2020 10:57:03 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcmsB-0007jl-5Y; Wed, 11 Nov 2020 10:57:03 +0100
Date:   Wed, 11 Nov 2020 10:57:01 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
        linux-serial@vger.kernel.org, fugang.duan@nxp.com
Subject: Re: [PATCH] serial: imx: Remove unused platform data support
Message-ID: <20201111095701.rnsuajzfgkstiwa5@pengutronix.de>
References: <20201110214840.16768-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="463zvuxy3rkfl4lt"
Content-Disposition: inline
In-Reply-To: <20201110214840.16768-1-festevam@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--463zvuxy3rkfl4lt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 10, 2020 at 06:48:40PM -0300, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
> platform data support in this driver was only useful for old non-devicetr=
ee
> platforms.
>=20
> Get rid of the platform data support since it is no longer used.

Great, I missed that platform data support is gone.

Is it a problem if you build with SERIAL_IMX=3Dy, COMPILE_TEST=3Dy and
ARCH_MXC + CONFIG_OF unset?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--463zvuxy3rkfl4lt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+rtWoACgkQwfwUeK3K
7AlkMAgAly/UNzwIiIV1WTAzIDXKm4EtmzLF2c8qZpnYPm77QzpUQGDxfxiwY83M
0hDtLPuK70XbbW1oKFF6CBmHw/7A67TqCPFDMwa1FqbCSYyM7Z1EAfLHejHz8nmA
ULt7iG0uS1VU8HzkyiKbsEBzgusXRqZ1iPXRzL227TY3Z/rxakH0dPpM2OktVSGf
4cG6WMdCsNPXZs+05Ye+1172MWfNkWjJhxRRKJkVZoKERUJiOW8XCZFNKwZjR3tg
4EsOgOmsK3Ij7PLGnzDWwAGmpLr79wj8YvlsIz+r1AWAY65+liEZDt0V8KQGyWfm
syEaLjbWcmfwoDw8QxUHJJS0zkF4vQ==
=2l0R
-----END PGP SIGNATURE-----

--463zvuxy3rkfl4lt--
