Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E42DC77B73
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjEaGuq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaGuo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 02:50:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983199
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 23:50:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4FfM-0001l3-6R; Wed, 31 May 2023 08:50:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4FfK-0042xh-US; Wed, 31 May 2023 08:50:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4FfJ-009jVf-R9; Wed, 31 May 2023 08:50:37 +0200
Date:   Wed, 31 May 2023 08:50:37 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: omap: mark uart_write() as maybe unused
Message-ID: <20230531065037.bszirwfv533rxlxl@pengutronix.de>
References: <20230531064608.2401946-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xqj75rgvfjroow2b"
Content-Disposition: inline
In-Reply-To: <20230531064608.2401946-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--xqj75rgvfjroow2b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 08:46:08AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> uart_write() was introduced as a helper function that is for now only
> used in omap8250_soft_reset(). The latter function is only defined if
> CONFIG_PM is enabled. So add __maybe_unused to the defintion of the
> former function to fix
>=20
> 	drivers/tty/serial/8250/8250_omap.c:169:13: error: =E2=80=98uart_write=
=E2=80=99 defined but not used [-Werror=3Dunused-function]
>=20
> for CONFIG_PM=3Dn builds.
>=20
> Fixes: 398cecc24846 ("serial: 8250: omap: Fix imprecise external abort fo=
r omap_8250_pm()")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> the offending commit is in tty-next.

Ah, there is already a fix in tty-testing, i.e. 458ab5b47d9c ("serial:
8250: omap: Move uart_write() inside PM section")

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xqj75rgvfjroow2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR27jwACgkQj4D7WH0S
/k48Wwf/a0aAvWGTVIHLYdnrQXv2IjI5g8gEU/3nS8HL+1cTfNJZmFTOK8XFIUgH
AzgP4r8UPUAzpkC+fkn5aXncgqCQVw7T7o1c1s3WylGB537zqip93e8/5FrFMt8a
cdW/0d1D+kdgk9F3BWv8abgH72XjUXmIBcL3oQPWSZEU5nLJQgq/J5X/8Mx6oCJS
4DRGJ8P9Dj050EEpPaBmJJpKXBH8UlkL692bW3LfVLVtx2CWAoFc9pFT49Y6DMY7
6CDTo3jI8WnNrv7Cc8ziNpiaWlYRor7dwwf8LXgECHsikVsUvZ8pw5M4mga6bYUU
kQqQ0JBnQhvtb9i8Fs3PU0EAnLdBMg==
=7aoH
-----END PGP SIGNATURE-----

--xqj75rgvfjroow2b--
