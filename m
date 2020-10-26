Return-Path: <SRS0=yy8S=EB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02889C4363A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 16:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC67B2224A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 16:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421929AbgJZQc6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:32:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59219 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421201AbgJZQc5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Oct 2020 12:32:57 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kX5QQ-0006mY-Gm; Mon, 26 Oct 2020 17:32:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kX5QP-0001bZ-NK; Mon, 26 Oct 2020 17:32:49 +0100
Date:   Mon, 26 Oct 2020 17:32:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     trix@redhat.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: imx: remove unneeded break
Message-ID: <20201026163247.q4bmvrifrdbtgsia@pengutronix.de>
References: <20201020130709.28096-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzimvxfmuac2j7x3"
Content-Disposition: inline
In-Reply-To: <20201020130709.28096-1-trix@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--vzimvxfmuac2j7x3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Oct 20, 2020 at 06:07:09AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> A break is not needed if it is preceded by a return
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>

Just for the record: I commented for v1:

> this might be subjective, but I like the break being there for clearity.
> So I object to make a patch to remove them. In case I'm outvoted I'd at
> least want empty lines instead.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vzimvxfmuac2j7x3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+W+i0ACgkQwfwUeK3K
7AnpoAf/Y8OoGJ+UtuOHsBVBS6E+pOdwlh7CYmtGnrCSLOUvkiIUJBMTbIIePCaC
1ahyEPKCdhtTZCV0UU/GegMsfm65jLlzSQiLn1Vu9OZbuI2mU1XL84LBRROBclNq
PGnwTvCJmXf/TcJnJzrfct+NaF9ew4+dKgJ0Fg+6X/KQ5yycIs9FcmFzOJ+yvcT6
fYD3z/7H0GG1pkuk38IMUfFJVyvsOmtBTMNgM/1GoxAKB1N3GbV80o/IrQpGdKWo
CCt3Lj6Fcv1qv+mCvHUWqJKZAc2VWqOsMg8/TRJ5LWXG+AVZcvoGACT3OUPKL6z/
2rFBqvdoqBAqH9vNb1gJGRWuodFGew==
=2rL2
-----END PGP SIGNATURE-----

--vzimvxfmuac2j7x3--
