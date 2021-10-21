Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CD6C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1193610EA
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 08:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhJUIlz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhJUIly (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Oct 2021 04:41:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54400C06161C
        for <linux-serial@vger.kernel.org>; Thu, 21 Oct 2021 01:39:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdTbm-0000Vy-Bv; Thu, 21 Oct 2021 10:39:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdTbk-00081Y-Pw; Thu, 21 Oct 2021 10:39:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdTbk-0000A3-Oj; Thu, 21 Oct 2021 10:39:28 +0200
Date:   Thu, 21 Oct 2021 10:39:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: imx: disable console clocks on unregister
Message-ID: <20211021083915.4rpku6mtwzb2gqiv@pengutronix.de>
References: <20211020192643.476895-1-francesco.dolcini@toradex.com>
 <20211020192643.476895-3-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6gglve2xlbipk5d"
Content-Disposition: inline
In-Reply-To: <20211020192643.476895-3-francesco.dolcini@toradex.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--y6gglve2xlbipk5d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 20, 2021 at 09:26:43PM +0200, Francesco Dolcini wrote:
> During console setup imx_uart_console_setup() enables clocks, but they
> are never disabled when the console is unregistered, this leads to
> clk_prepare_enable() being called multiple times without a matching
> clk_disable_unprepare() in case of console unregister.
>=20
> Ensure that clock enable/disable are balanced adding
> clk_disable_unprepare() in the console exit callback.
>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y6gglve2xlbipk5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFxJyoACgkQwfwUeK3K
7AkNJAf/euBdQ/R/DwFToMZ2PjKFK7cGNOE5MVbNtUd6GHCCTI4dsP0Wu+AzU3Mb
9YzfAsZCe1htDW03TyouJxEwHHmHen6T9Qz06iJEp2LGPo/MXBRx3EggHHdT3oan
am7iWS+1rbfhiSSpy4eiA8ZJG7QTaHnONEI13J5Jd4wyqWVTZ2gh0dkpYsl45Wqe
ShJD5/uoMx4M4m7IM9KX1rTnNSJ0hVhmUIyQbnA6hOVCDfwgNBDm+vykxwiVLcUf
0Jx75AvbJhBnJwqKzKOYlw7LGQD57BvQcvXeunt5jYI4vFiuWDgLcFrllhOcP/+T
LDf65T8HQryYc8ZvkVLdt9QquJ3eKA==
=KhiM
-----END PGP SIGNATURE-----

--y6gglve2xlbipk5d--
