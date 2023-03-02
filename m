Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E582C6FA8E
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 11:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCBLzy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 06:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCBLzw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 06:55:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0C332501
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 03:55:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhXJ-0007ij-RH; Thu, 02 Mar 2023 12:55:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhXI-001Jku-Kt; Thu, 02 Mar 2023 12:55:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhXI-001Xke-2Z; Thu, 02 Mar 2023 12:55:48 +0100
Date:   Thu, 2 Mar 2023 12:55:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: imx: Simplify imx_uart_type
Message-ID: <20230302115547.sacjk4ekwmfev2xz@pengutronix.de>
References: <20230302114810.1859500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njc7y6q7e4kphywj"
Content-Disposition: inline
In-Reply-To: <20230302114810.1859500-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--njc7y6q7e4kphywj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 02, 2023 at 12:48:10PM +0100, Uwe Kleine-K=F6nig wrote:
> There is no point in casting a struct uart_port to a struct imx_port
> just to access the first member of the latter (a struct uart_port).
>=20
> This introduces code changes.

Please disregard this patch. While the patch is fine as is, I just
noticed a few more functions in this driver that can be simplified
accordingly. I'm about to send out an improved version (with a different
subject, so not called v2).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--njc7y6q7e4kphywj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQAjsAACgkQwfwUeK3K
7AmE/AgAn/H7Wfk5eHlQC+pgoSGO6U641t2brUcEJYE7hO/oJVng5dxUBx7mplrA
fI7HNNbh9h7H3v4BMQj4mOi6uW4AtP45yWyDqYNOxV7agKHNo/Z5hvhWIw/pLXnR
1HDlsIZZGFBdIkBLbGJChGZY38Kwwk6HnH1+u9weWaeecB4C2mUQ8xoEIAmcwYfd
m4g74lQMib8HSfoSPBxuhCwsbeiushMaltUScl3cFCYKFaQkwDBr8o5eNf8rFurx
8UmYmypmdp83ozlSyCzjrs4devEJOhKjrwY6B+0Dca8pf4VdZHIVo6gl+5WT9A/A
Og4jhyx6xqaEg4uvinnhWwciXNq94A==
=5w10
-----END PGP SIGNATURE-----

--njc7y6q7e4kphywj--
