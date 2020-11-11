Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9699AC4742C
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 09:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434D020729
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 09:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKKJw7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgKKJw7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Nov 2020 04:52:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B668C0613D1
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2020 01:52:59 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcmoB-0004bD-RF; Wed, 11 Nov 2020 10:52:55 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcmoA-0007c5-TU; Wed, 11 Nov 2020 10:52:54 +0100
Date:   Wed, 11 Nov 2020 10:52:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fugang Duan <fugang.duan@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        lukas@wunner.de
Subject: Re: [PATCH v2 tty/serial 1/1] tty: serial: imx: keep console clocks
 always on
Message-ID: <20201111095253.f2vkapdwiqqjbz72@pengutronix.de>
References: <20201111025136.29818-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mpesgufqbgaob36x"
Content-Disposition: inline
In-Reply-To: <20201111025136.29818-1-fugang.duan@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--mpesgufqbgaob36x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 10:51:36AM +0800, Fugang Duan wrote:
> For below code, there has chance to cause deadlock in SMP system:
> Thread 1:
> clk_enable_lock();
> pr_info("debug message");
> clk_enable_unlock();
>=20
> Thread 2:
> imx_uart_console_write()
> 	clk_enable()
> 		clk_enable_lock();
>=20
> Thread 1:
> Acuired clk enable_lock -> printk -> console_trylock_spinning
> Thread 2:
> console_unlock() -> imx_uart_console_write -> clk_disable -> Acquite clk =
enable_lock
>=20
> So the patch is to keep console port clocks always on like
> other console drivers.
>=20
> Fixes: 1cf93e0d5488 ("serial: imx: remove the uart_console() check")
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Cc: stable@kernel.org

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mpesgufqbgaob36x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+rtHIACgkQwfwUeK3K
7Ak6mQf+Ogb1ua12zFTpaQEuE3BS/U0CBupiHgKdEdR5pj4UeJQAHBFIhsJJvGif
5frYtyvJA1s1DUXiswcs+2ORlx3/vyBeFsxHT2RtMhXVIb+avuftYiIB+67QTck7
dSymEG9J/uvoimQaVXO17DPFHvGhs6ihepX5IA1D9UfpbGfdVhhVWCJONAqTfFCG
rJZkqKDuJqltg1KKJ164dLiAk6N4qe/p9ejpgsunu2/57RLqDfnnLsbA+byelv1l
c/5bRidMHbYexWeOCAhh0jmus8l3YEywtXHgPpOKHh5oPZhefq/ObryZICqlu9n+
avtC/J2VMhvnxSwQFgqZainaudM/Hw==
=mL5h
-----END PGP SIGNATURE-----

--mpesgufqbgaob36x--
