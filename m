Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CCC64EC4
	for <linux-serial@archiver.kernel.org>; Fri, 10 Mar 2023 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjCJPn2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjCJPm7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Mar 2023 10:42:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD371717A
        for <linux-serial@vger.kernel.org>; Fri, 10 Mar 2023 07:30:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paege-0005hj-UM; Fri, 10 Mar 2023 16:29:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paegc-003Cqr-Km; Fri, 10 Mar 2023 16:29:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paegb-003pM3-UU; Fri, 10 Mar 2023 16:29:37 +0100
Date:   Fri, 10 Mar 2023 16:29:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Timur Tabi <timur@kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Use of_property_read_bool() for boolean
 properties
Message-ID: <20230310152936.2tnlkvxku5scmzas@pengutronix.de>
References: <20230310144727.1545699-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="moa2k34gvhpherg2"
Content-Disposition: inline
In-Reply-To: <20230310144727.1545699-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--moa2k34gvhpherg2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 08:47:27AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--moa2k34gvhpherg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLTN0ACgkQwfwUeK3K
7AlMWQf/Zm20f4rcaPFvA8qfhp+Yp2jpASyGHUgc6kgHLie5qVh5Bf2how/DE/mE
kkGN1bDZkJQApqOKDpjmaJE+HXDsfxzV5I8xaNQ3pFrC4tnwnLHnVREyB+iQrXJD
g5+ZX3bGoz691c4y0Kbb7q6mjcjefR9+GWZyOVuHnUxeR23Vi5Jt1imJcmdPpD0i
oCDFScZatYUSuApeVuviFQ96RLQ7BkPnsue+AjAkyrWlBPM74lDzbNbiLyzjRNre
mcYBlOQEdGL5QMFi0z61cRJsHEWbgRJyXAxMRxvDkyIZqM2PIiAhwoHUWwF0IMZN
aA0NykBHEIRpeAiznrNCeElFHp61mA==
=hz+L
-----END PGP SIGNATURE-----

--moa2k34gvhpherg2--
