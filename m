Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74373C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3481723D6C
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 13:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbgLJNAD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 08:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732802AbgLJNAB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 08:00:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1565C0613CF
        for <linux-serial@vger.kernel.org>; Thu, 10 Dec 2020 04:59:20 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knLXS-0006Dm-Ta; Thu, 10 Dec 2020 13:59:18 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knLXS-0004jg-Fg; Thu, 10 Dec 2020 13:59:18 +0100
Date:   Thu, 10 Dec 2020 13:59:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: imx: Move imx_uart_probe_dt() content into
 probe()
Message-ID: <20201210125918.vswuimfvqhtkq3wj@pengutronix.de>
References: <20201209214712.15247-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dbofy3z7ml53b3dc"
Content-Disposition: inline
In-Reply-To: <20201209214712.15247-1-festevam@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--dbofy3z7ml53b3dc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 06:47:12PM -0300, Fabio Estevam wrote:
> Now that the driver only probes via devicetree, we can move the
> content of imx_uart_probe_dt() directly into imx_uart_probe() to
> make the code simpler.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for picking up the suggestion,
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dbofy3z7ml53b3dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/SG6MACgkQwfwUeK3K
7Ak6ggf+PJg8aJuKbBEraNQHLUpKLv7G2clTDEZwRPtWnMLZlmrroipatCnUiNK5
lv0BbtlFlrMcnv3W1SXImR9MTPKKov5lxQcUnLFNlt590XKamYRhuMcRNgEsAWq/
brH5pZQvkU9xhCxSDQ6PbNptOnZGIJr/VCdw8T3W4ovwvReF5ZWguNnUyUFfIKvL
sYjS93yXciTk65SRjRZHZO+fbwfgQ4j32SpmyczLDj/8nCiFFqHrfBvjm7GeL+Uk
5ue3x3pIy8aUXJHKEcxSLEdskar//0Vgz2xFJ4IdadwNYzDul/67JzcDtmHVc894
9IKCWxO6gfEvAc7IEssgAwEYuhPimw==
=rKij
-----END PGP SIGNATURE-----

--dbofy3z7ml53b3dc--
