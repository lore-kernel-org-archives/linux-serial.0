Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9DC388F7
	for <linux-serial@archiver.kernel.org>; Tue, 10 Nov 2020 20:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18D92065E
	for <linux-serial@archiver.kernel.org>; Tue, 10 Nov 2020 20:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgKJUbL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJUbL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Nov 2020 15:31:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3CC0613D1
        for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2020 12:31:11 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcaIH-0002RR-2K; Tue, 10 Nov 2020 21:31:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcaIF-0007Ig-CH; Tue, 10 Nov 2020 21:31:07 +0100
Date:   Tue, 10 Nov 2020 21:31:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fugang Duan <fugang.duan@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        lukas@wunner.de
Subject: Re: [PATCH tty/serial 1/1] tty: serial: imx: keep console clocks
 always on
Message-ID: <20201110203105.psro267now4cgctg@pengutronix.de>
References: <20201109091403.12515-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hcps3huw4jqtwmu"
Content-Disposition: inline
In-Reply-To: <20201109091403.12515-1-fugang.duan@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--3hcps3huw4jqtwmu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 05:14:03PM +0800, Fugang Duan wrote:
> For below code, there has chance to cause deadlock in SMP system:
> Thread 1:
> clk_enable_lock();
> pr_info("debug message");
> clk_enable_unlock(flags);

flags?

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
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Depending on how old this problem is, identifying the commit that
introduces the problem (and noting it in a Fixes: line) would be good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3hcps3huw4jqtwmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+q+IUACgkQwfwUeK3K
7AnR3Qf/UIxui9seNojVcvsf7u9QpKxNS0p86XgD628lthnSzr2VFXDWvrzvdR0+
lJkgnYVQVnJMno9+/Bs1rvj2x2hJFzBD4WSV7OQGWtcEuEjZJhJAC/2uAdhf6FZX
BfhP4wsnUjSncTpV0acUd3TsEiVKsAGOCQz1fjLiPfazuietW6iuOVxP4DcCsYj8
ysjf7uGEg5REyjbwo8a4PldOBXu25Er3da17jgNjVjspe6suFjXwc9x9gIUJXjov
ZybogDrwNA2Io0iSF3snI/sZNK6aX724JzAFraVPGuGH4A2jkjJpCnW8axNqkbto
kmUdj21cKKUKCwXHL6umTNqsWxYIkQ==
=6s5B
-----END PGP SIGNATURE-----

--3hcps3huw4jqtwmu--
