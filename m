Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669A3C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B8060FE8
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbhESJrT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346150AbhESJrS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 05:47:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756CC06175F
        for <linux-serial@vger.kernel.org>; Wed, 19 May 2021 02:45:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ljIm3-0002sd-C5; Wed, 19 May 2021 11:45:55 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ljIm2-0006gD-W3; Wed, 19 May 2021 11:45:54 +0200
Date:   Wed, 19 May 2021 11:45:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: drop irq-flags initialisations
Message-ID: <20210519094554.57yqutclknjnt4zi@pengutronix.de>
References: <20210519092541.10137-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7laz2anpypw64hiq"
Content-Disposition: inline
In-Reply-To: <20210519092541.10137-1-johan@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7laz2anpypw64hiq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 11:25:41AM +0200, Johan Hovold wrote:
> There's no need to initialise irq-flags variables before saving the
> interrupt state.
>=20
> Drop the redundant initialisations from drivers that got this wrong.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/amba-pl011.c    |  2 +-
>  drivers/tty/serial/imx.c           |  2 +-
>  drivers/tty/serial/omap-serial.c   | 10 +++++-----
>  drivers/tty/serial/serial_core.c   |  4 ++--
>  drivers/tty/serial/st-asc.c        |  2 +-
>  drivers/tty/serial/stm32-usart.c   |  2 +-
>  drivers/tty/serial/xilinx_uartps.c |  8 ++++----
>  7 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 78682c12156a..e14f3378b8a0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1062,7 +1062,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
>  	struct tty_port *port =3D &uap->port.state->port;
>  	struct pl011_dmarx_data *dmarx =3D &uap->dmarx;
>  	struct dma_chan *rxchan =3D uap->dmarx.chan;
> -	unsigned long flags =3D 0;
> +	unsigned long flags;
>  	unsigned int dmataken =3D 0;
>  	unsigned int size =3D 0;
>  	struct pl011_sgbuf *sgbuf;
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 7d5a8dfa3e91..4b838601cdce 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1975,8 +1975,8 @@ imx_uart_console_write(struct console *co, const ch=
ar *s, unsigned int count)
>  {
>  	struct imx_port *sport =3D imx_uart_ports[co->index];
>  	struct imx_port_ucrs old_ucr;
> +	unsigned long flags;
>  	unsigned int ucr1;
> -	unsigned long flags =3D 0;
>  	int locked =3D 1;
> =20
>  	if (sport->port.sysrq)

Apart from changing the order here being unnecessary, the patch looks
right. Ditto for serial_core.c and xilinx_uartps.c.
I don't care much though, so

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7laz2anpypw64hiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCk3k8ACgkQwfwUeK3K
7AlgpAf+LO2ZLVnnSaSfYiY0XG0C7UkYZKBl9jjl62z9SFUCraOqMIusAWYwCDrh
gQqfhtga0XHdWLTim3K1GVZDRo50hVpK/gOTZvYY9ISD7OvtufGvWZbI4u7SweJl
AfZVxIJc7SR4vhUERMfHqRrgZsEdacUULDF6CPDo57JA13GMEYV7QzeygEodMmmE
X/ivcQHkq1ieu01hqPzNm/sNFXN0t/flNrcuGzVDoRSftYBK+lRvvIFQnyv9Ad05
UUr1uJOU3S6w4LiAUj7g4y+Lx4GS0TKbdYcFqNxFogYskvETPHbJB/HiEjseiFk1
le4g757IBwmARsUzJT35gwJuzEtDFg==
=b8qQ
-----END PGP SIGNATURE-----

--7laz2anpypw64hiq--
