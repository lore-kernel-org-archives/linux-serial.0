Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E6C28E88
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B783C64E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbhCCCRZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836270AbhCBHAC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 02:00:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26110C061756
        for <linux-serial@vger.kernel.org>; Mon,  1 Mar 2021 22:59:22 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGz03-0006AE-MD; Tue, 02 Mar 2021 07:59:19 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGz02-0007lr-Pm; Tue, 02 Mar 2021 07:59:18 +0100
Date:   Tue, 2 Mar 2021 07:59:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, Fabio Estevam <festevam@gmail.com>,
        linux-serial@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 10/44] tty: imx, use ms_to_ktime
Message-ID: <20210302065918.cbxwen6vz2pz4msn@pengutronix.de>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-10-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liehcxyzb5az342c"
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-10-jslaby@suse.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--liehcxyzb5az342c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jiri,

On Tue, Mar 02, 2021 at 07:21:40AM +0100, Jiri Slaby wrote:
> This really eliminates multiplications from the assembly. I would have
> thought they are optimized by inlining ktime_set, but not on x86_64 with
> gcc 10.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8257597d034d..3f69356937ef 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -394,11 +394,7 @@ static void imx_uart_rts_inactive(struct imx_port *s=
port, u32 *ucr2)
> =20
>  static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>  {
> -       long sec =3D msec / MSEC_PER_SEC;
> -       long nsec =3D (msec % MSEC_PER_SEC) * 1000000;
> -       ktime_t t =3D ktime_set(sec, nsec);
> -
> -       hrtimer_start(hrt, t, HRTIMER_MODE_REL);
> +       hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
>  }

What about:


diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8257597d034d..8731d4f82cb8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -392,15 +392,6 @@ static void imx_uart_rts_inactive(struct imx_port *spo=
rt, u32 *ucr2)
 	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
 }
=20
-static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
-{
-       long sec =3D msec / MSEC_PER_SEC;
-       long nsec =3D (msec % MSEC_PER_SEC) * 1000000;
-       ktime_t t =3D ktime_set(sec, nsec);
-
-       hrtimer_start(hrt, t, HRTIMER_MODE_REL);
-}
-
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -457,8 +448,9 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		if (sport->tx_state =3D=3D SEND) {
 			sport->tx_state =3D WAIT_AFTER_SEND;
-			start_hrtimer_ms(&sport->trigger_stop_tx,
-					 port->rs485.delay_rts_after_send);
+			hrtimer_start(&sport->trigger_stop_tx,
+				      ms_to_ktime(port->rs485.delay_rts_after_send),
+				      HRTIMER_MODE_REL);
 			return;
 		}
=20
@@ -697,8 +689,9 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_stop_rx(port);
=20
 			sport->tx_state =3D WAIT_AFTER_RTS;
-			start_hrtimer_ms(&sport->trigger_start_tx,
-					 port->rs485.delay_rts_before_send);
+			hrtimer_start(&sport->trigger_start_tx,
+				      ms_to_ktime(port->rs485.delay_rts_before_send),
+				      HRTIMER_MODE_REL);
 			return;
 		}
=20
instead?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--liehcxyzb5az342c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA94kMACgkQwfwUeK3K
7Ak5yAf/elCUD1wY43QrLTTiAo8JYngSwH5rR2S7DKZ79hEmWcd7BAXbSkpS4lVJ
aloUGw7g2WqlzQ1fa7UQrm7e/Xdrp5oraHkO0RStDuCDW8dVRoAuixl5CSLEKBJq
+JSGIVQ0O0qwOQnZH9XOhBuR1C+f1SiBdXIk+hMIS/CyTuFxBB4NVlo9OUH6R07a
KrsOk7+nbGy5B5XcTEwFSVVyeO6h603nVBSmRnURwbKO5boea1SmcDO2povuDcYm
QJYG7qYDXDO9+VIlH0Zs1tWsm9+nY/uJ2wRd2H5kHcobEXiFeo9KV3XAeAIjyT99
gE+Iyd47vsFR0loi7gjIBMx6SqemoA==
=cAGD
-----END PGP SIGNATURE-----

--liehcxyzb5az342c--
