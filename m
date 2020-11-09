Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16BC2D0A3
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAEF2074F
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 21:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKIV06 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIV06 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Nov 2020 16:26:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A54C0613CF
        for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2020 13:26:58 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcEgi-0000uo-4P; Mon, 09 Nov 2020 22:26:56 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcEgf-0001sJ-7q; Mon, 09 Nov 2020 22:26:53 +0100
Date:   Mon, 9 Nov 2020 22:26:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sam Nobs <samuel.nobs@taitradio.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        jun qian <hangdianqj@163.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] tty: serial: imx: fix potential deadlock
Message-ID: <20201109212651.kqoh2oelhwxycfvo@pengutronix.de>
References: <1604955006-9363-1-git-send-email-samuel.nobs@taitradio.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yyz33iplvjm52bts"
Content-Disposition: inline
In-Reply-To: <1604955006-9363-1-git-send-email-samuel.nobs@taitradio.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--yyz33iplvjm52bts
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2020 at 09:50:06AM +1300, Sam Nobs wrote:
> Enabling the lock dependency validator has revealed
> that the way spinlocks are used in the IMX serial
> port could result in a deadlock.
>=20
> Specifically, imx_uart_int() acquires a spinlock
> without disabling the interrupts, meaning that another
> interrupt could come along and try to acquire the same
> spinlock, potentially causing the two to wait for each
> other indefinitely.
>=20
> Use spin_lock_irqsave() instead to disable interrupts
> upon acquisition of the spinlock.
>=20
> Signed-off-by: Sam Nobs <samuel.nobs@taitradio.com>

Fixes: c974991d2620 ("tty:serial:imx: use spin_lock instead of spin_lock_ir=
qsave in isr")
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yyz33iplvjm52bts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+ptBgACgkQwfwUeK3K
7AmcGgf+I1S7XZ3OoUwFgXNZm9Bm8EX/ixCd5yIGaRMWHeGZ03TQpKrZPlYcHEGZ
3I0wB1SK0TqialF/OtUJu3kMeIjL76hqppI6e33siNECp7eDeYIGssb1XCBsSOS0
3QptRrpvgyyjaQ+p6I7Ueda5yW/v+VqE691EGzmcngyAM5lR2VDleWaSawyGWAd7
YkSgzVbBL/WQsNSX/TfPFrJwn9wsqQI9RmsqhwdzvURQ+ppUnOpUBh0xuH+N4sUR
tfcSuhuworhdiIR4OUzkuzZ6HwJLgJK957bMJw30UPaJb3EUegUU1T5oNt3dMG4g
kJk0gf+4ZsudambGkaHIaWSbepM6+g==
=EQ7E
-----END PGP SIGNATURE-----

--yyz33iplvjm52bts--
