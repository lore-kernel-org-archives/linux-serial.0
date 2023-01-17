Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E53C677F1
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 11:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbjAQLcd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 06:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjAQLcL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 06:32:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5E1E295
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 03:32:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHkCF-0006Dd-Nk; Tue, 17 Jan 2023 12:32:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHkCE-006f7x-Hy; Tue, 17 Jan 2023 12:32:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHkCD-00DaCb-Sg; Tue, 17 Jan 2023 12:32:05 +0100
Date:   Tue, 17 Jan 2023 12:32:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading
 loop
Message-ID: <20230117113205.l5byaz3srzpagzhz@pengutronix.de>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
 <20230113184334.287130-8-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="skdg3bsof64xq6qu"
Content-Disposition: inline
In-Reply-To: <20230113184334.287130-8-sorganov@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--skdg3bsof64xq6qu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 09:43:33PM +0300, Sergey Organov wrote:
> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
> we read registers that must not be cached.
>=20
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index be00362b8b67..f4236e8995fa 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *=
dev_id)
>  	struct imx_port *sport =3D dev_id;
>  	unsigned int rx, flg;
>  	struct tty_port *port =3D &sport->port.state->port;
> +	typeof(sport->port.membase) membase =3D sport->port.membase;
>  	u32 usr2;
> =20
>  	/* If we received something, check for 0xff flood */
> -	usr2 =3D imx_uart_readl(sport, USR2);
> +	usr2 =3D readl(membase + USR2);
>  	if (usr2 & USR2_RDR)
>  		imx_uart_check_flood(sport, usr2);
> =20
> -	while ((rx =3D imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
> +	while ((rx =3D readl(membase + URXD0)) & URXD_CHARRDY) {
>  		flg =3D TTY_NORMAL;
>  		sport->port.icount.rx++;

One of the motivations to introduce imx_uart_readl was to have a single
place to add a debug output to be able to inspect what the driver is
doing.

I wonder where your need for higher speed comes from and if the compiler
really generates more effective code with your change.

Please either drop the patch from your series or provide the differences
the compiler produces and a benchmark.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--skdg3bsof64xq6qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPGhzIACgkQwfwUeK3K
7AnNogf8CLwtWM8poQTxR0CtEJq3af4kVn4OVNWStDS+9WPMCIWuqbH9j5ZMo6PE
DF7JudpDzN2gPOHS/LSqbsVgBnvo2YwhYl8VzVdNwSeea3d0WEF0yCkmXZFXOVtV
S68YNOXDsd9iabqcVV6vu2xUBViqy6L3dOT7dkZ9yULebVZpN1avDx75hYbzWZXa
30Zq7u+x0x9z2LtpSYFiNsIqNp8QSDSDLBgBh/V3j+5M2mpxXTzgceQdJI92NJT+
z/Rjfit8LIBNaBBikfY7Rk3Q19340e+kzULF5iR805DkQ9Tlk2Q/LZ6X4iKReVMg
3oocZfSNbuhjXpRyY7hG5YEpld/c7A==
=CaSA
-----END PGP SIGNATURE-----

--skdg3bsof64xq6qu--
