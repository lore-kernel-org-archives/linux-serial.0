Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C933C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 07:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E10A615E5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 07:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbhI3HFP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhI3HFP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 03:05:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB0C06161C
        for <linux-serial@vger.kernel.org>; Thu, 30 Sep 2021 00:03:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVq6M-0003Te-Ak; Thu, 30 Sep 2021 09:03:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVq6K-0006tY-V9; Thu, 30 Sep 2021 09:03:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVq6K-00054z-UB; Thu, 30 Sep 2021 09:03:28 +0200
Date:   Thu, 30 Sep 2021 09:02:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@denx.de>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, johan@kernel.org, marex@denx.de
Subject: Re: [PATCH v2] serial: imx: Fix sysrq deadlock
Message-ID: <20210930070253.awmmknmuemaaqv3n@pengutronix.de>
References: <20210929214324.44910-1-festevam@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="22jpyq3dhlxeco7w"
Content-Disposition: inline
In-Reply-To: <20210929214324.44910-1-festevam@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--22jpyq3dhlxeco7w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabio,

On Wed, Sep 29, 2021 at 06:43:24PM -0300, Fabio Estevam wrote:
> The following sysrq command causes the following deadlock:
>=20
>  # echo t > /proc/sysrq-trigger
>  ....
> [   20.325246] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   20.325252] WARNING: possible circular locking dependency detected
> [   20.325260] 5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163
> Not tainted
> [   20.325273] ------------------------------------------------------
> [   20.325279] sh/236 is trying to acquire lock:
> [   20.325293] c1618614 (console_owner){-...}-{0:0}, at:
> console_unlock+0x180/0x5bc
> [   20.325361]
> [   20.325361] but task is already holding lock:
> [   20.325368] eefccc90 (&pool->lock){-.-.}-{2:2}, at:
> show_workqueue_state+0x104/0x3c8
> [   20.325432]
> [   20.325432] which lock already depends on the new lock.
>=20
> ...
>=20
> [   20.325657] -> #2 (&pool->lock/1){-.-.}-{2:2}:
> [   20.325690]        __queue_work+0x114/0x810
> [   20.325710]        queue_work_on+0x54/0x94
> [   20.325727]        __imx_uart_rxint.constprop.0+0x1b4/0x2e0
> [   20.325760]        imx_uart_int+0x270/0x310
>=20
> This problem happens because uart_handle_sysrq_char() is called
> with the lock held.
>=20
> Fix this by using the same approach done in commit 5697df7322fe ("serial:
> fsl_lpuart: split sysrq handling"), which calls=20
> uart_unlock_and_check_sysrq() to drop the lock prior to=20
> uart_handle_sysrq_char().
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - I noticed that when sending break + t via the terminal, the characters
> were sometimes lost. Do the minimal changes to fix the deadlock without
> missing the sysrq input.
>=20
>  drivers/tty/serial/imx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b121cd869e9..1c768dd3896d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -788,6 +788,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *de=
v_id)
>  	unsigned int rx, flg, ignored =3D 0;
>  	struct tty_port *port =3D &sport->port.state->port;
> =20
> +	uart_unlock_and_check_sysrq(&sport->port);
>  	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
>  		u32 usr2;
> =20
> @@ -846,6 +847,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *de=
v_id)
>  out:
>  	tty_flip_buffer_push(port);
> =20
> +	spin_lock(&sport->port.lock);
>  	return IRQ_HANDLED;

Hmm, this releases the port lock. Are you sure it's correct to e.g.
modify sport->port.icount and various registers and call serial core
functions without holding it?
Also consider imx1 where we have a different irq for tx, rx and
handshaking, so unlocking port.lock might result in a call to
imx_uart_txint or imx_uart_rtsint.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--22jpyq3dhlxeco7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFVYRQACgkQwfwUeK3K
7Alk6gf/Wne2AVy8zGTjGoj38Ho7BJsAHzdOCF3MF7r7ZuoHOD5RgsOrpmzSQXZe
8SvCLZbplCFJSX9sO1r9k9tP8XKwMAA/4vcelVkVZbDLcLJniN/WsHDmqDOlb5Pq
NeHo1EzaH1c3WuyQoLoxCZ+6cEsH5uPrCushdgxyWp9m42tQxGpkipnQayZTaGLC
MP07LQ8nxrG4CKTEnXCBWwlmMl9PrcsuAOxr8YnrNeRYVY1FKI5QCWqGwQ+2OXB+
3oEZoT6vNRV8xk7AygE0Ype0qb4MLdtasbwvmTULDvkliI6IAIVYvXlhcO5HyUdQ
MGZtazZ5l18s3SEeyyWnOGf/gOW01Q==
=WNuf
-----END PGP SIGNATURE-----

--22jpyq3dhlxeco7w--
