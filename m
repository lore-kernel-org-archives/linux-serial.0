Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEAFC678D4
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 16:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCBQGo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 11:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCBQGo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 11:06:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A1515DE
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 08:06:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXlS5-0006yR-1r; Thu, 02 Mar 2023 17:06:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXlS2-001Mwa-62; Thu, 02 Mar 2023 17:06:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXlS1-001b5j-Ef; Thu, 02 Mar 2023 17:06:37 +0100
Date:   Thu, 2 Mar 2023 17:06:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: imx: Drop a few unneeded casts
Message-ID: <20230302160637.etw3a4qk4jb7oktf@pengutronix.de>
References: <20230302115417.1860210-1-u.kleine-koenig@pengutronix.de>
 <6e66bc69-52b7-bea5-1e2c-ad5ed819a6@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nktxwwdpuecj56n7"
Content-Disposition: inline
In-Reply-To: <6e66bc69-52b7-bea5-1e2c-ad5ed819a6@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--nktxwwdpuecj56n7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ilpo,

On Thu, Mar 02, 2023 at 05:35:17PM +0200, Ilpo J=E4rvinen wrote:
> On Thu, 2 Mar 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > There is no point in casting a struct uart_port to a struct imx_port
> > just to access the first member of the latter (a struct uart_port).
> >=20
> > This introduces code changes.
>=20
> I don't know what this sentence is supposed to mean (did you forgot to=20
> add a negation into it)?
>=20
> The code changes :-) are okay though:

Yes, I intended to write:

	This introduces no changes to the generated binary.

> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks.

Greg isn't in patch collecting mood currently anyhow, so I will wait a
bit before sending out a fixed patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nktxwwdpuecj56n7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQAyYoACgkQwfwUeK3K
7AnvJwgAh2eZyhCMHwWqQ0ysoqZitKh48s1+5xTGd/J1pgNYrOJe48OP8cZpu8yW
D+VEKzJ8cd5D2ddEqkei/55X+KdblKxOuTkXED0Gabl7u00eG9BnxPf3mdeIPIj4
wWQRHDQTQqZwUc1M71fi/Bi6QgbyADYexX5bbTofiZoDfgdS9JmZpZ3/weCsVtK+
zmg5ddDL/eTJo16SKZfUWLtOu2YrpffxzfewftI+eVmQ98akpbB2Sw3xU1jB2oXw
sRr12sJLFYg2MIdeMhsPE9wq9ai3z9BqO2jT2GMY81LKN9R1x7y3wpWZIFFZhk0e
5cD2389zV8RWty+UzpDtWaRSKZJ2Wg==
=kOdx
-----END PGP SIGNATURE-----

--nktxwwdpuecj56n7--
