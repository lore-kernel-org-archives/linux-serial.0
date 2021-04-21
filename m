Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DDBC433B4
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA58B6144E
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 10:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhDUKrj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhDUKrh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 06:47:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25626C06138A
        for <linux-serial@vger.kernel.org>; Wed, 21 Apr 2021 03:47:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZANo-0000YS-FS; Wed, 21 Apr 2021 12:47:00 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZANl-0006gJ-F7; Wed, 21 Apr 2021 12:46:57 +0200
Date:   Wed, 21 Apr 2021 12:46:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] serial: imx: fix TX stop function not setting state
 to OFF
Message-ID: <20210421104657.kqvsnmsyfvejzzay@pengutronix.de>
References: <25c1a28dfb7f892a5c214ba7d8489879d7c0e4be.camel@digi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hhaf72dmo7adsjbw"
Content-Disposition: inline
In-Reply-To: <25c1a28dfb7f892a5c214ba7d8489879d7c0e4be.camel@digi.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--hhaf72dmo7adsjbw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 07:02:33PM +0000, Hodaszi, Robert wrote:
> If the mode had been changed to RS-485 after at least one character had
> been sent in RS-232 mode, the RS-485 transmission was not working.
>=20
> Commit cb1a609236096c278ecbfb7be678a693a70283f1 ("serial: imx: implement
> rts delaying for rs485") added a TX state variable to keep track, when
> it needs to enable / disable the RS-485 transmitter.
>=20
> In RS-232 mode, the start TX function just sets the state to SEND, and
> the stop function supposed to set it to OFF.
>=20
> In RS-485 mode, the start TX function expects the state to be either
> OFF, WAIT_AFTER_SEND, or WAIT_AFTER RTS. It cannot do anything if the
> state is set to SEND, expects a stop first.
>=20
> But stop TX function in RS-232 mode usually didn't set the state to OFF,
> as it first checked if the shifter is empty, and if not, it just
> returned, waiting for a TransmitComplete interrupt, which is only
> enabled in RS-485 mode. So the stop function was never called again.
>=20
> That check, and the subsequent code part is not needed for RS-232, it
> just have to set the TX state to OFF.
>=20
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
> ---
>=20
> Changes in v2:
>  - Fixed incorrect tabs
>=20
>  drivers/tty/serial/imx.c | 46 +++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8257597d034d..511badce3edd 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -443,6 +443,12 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  	ucr1 =3D imx_uart_readl(sport, UCR1);
>  	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
> =20
> +	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
> +		/* Set the TX state in non-RS485 mode, nothing else to do */
> +		sport->tx_state =3D OFF;
> +		return;
> +	}
> +
>  	usr2 =3D imx_uart_readl(sport, USR2);
>  	if (!(usr2 & USR2_TXDC)) {
>  		/* The shifter is still busy, so retry once TC triggers */

What this hunk essentially does is to skip clearing UCR4_TCEN. Doesn't
this result in an irq storm until there is new data to send or the
device is closed? At least if DMA isn't used for the port this is the
only place that disables the TC irq (apart from .shutdown).

I wonder if a better fix would be to only switch between RS485 and RS232
if the transmitter is empty.

> @@ -453,33 +459,29 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  	ucr4 &=3D ~UCR4_TCEN;
>  	imx_uart_writel(sport, ucr4, UCR4);
> =20
> -	/* in rs485 mode disable transmitter */
> -	if (port->rs485.flags & SER_RS485_ENABLED) {
> -		if (sport->tx_state =3D=3D SEND) {
> -			sport->tx_state =3D WAIT_AFTER_SEND;
> -			start_hrtimer_ms(&sport->trigger_stop_tx,
> -					 port->rs485.delay_rts_after_send);
> -			return;
> -		}
> +	if (sport->tx_state =3D=3D SEND) {
> +		sport->tx_state =3D WAIT_AFTER_SEND;
> +		start_hrtimer_ms(&sport->trigger_stop_tx,
> +					port->rs485.delay_rts_after_send);
> +		return;
> +	}
> =20
> -		if (sport->tx_state =3D=3D WAIT_AFTER_RTS ||
> -		    sport->tx_state =3D=3D WAIT_AFTER_SEND) {
> -			u32 ucr2;
> +	if (sport->tx_state =3D=3D WAIT_AFTER_RTS ||
> +		sport->tx_state =3D=3D WAIT_AFTER_SEND) {
> +		/* in rs485 mode disable transmitter */
> +		u32 ucr2;
> =20
> -			hrtimer_try_to_cancel(&sport->trigger_start_tx);
> +		hrtimer_try_to_cancel(&sport->trigger_start_tx);
> =20
> -			ucr2 =3D imx_uart_readl(sport, UCR2);
> -			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> -				imx_uart_rts_active(sport, &ucr2);
> -			else
> -				imx_uart_rts_inactive(sport, &ucr2);
> -			imx_uart_writel(sport, ucr2, UCR2);
> +		ucr2 =3D imx_uart_readl(sport, UCR2);
> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +			imx_uart_rts_active(sport, &ucr2);
> +		else
> +			imx_uart_rts_inactive(sport, &ucr2);
> +		imx_uart_writel(sport, ucr2, UCR2);
> =20
> -			imx_uart_start_rx(port);
> +		imx_uart_start_rx(port);
> =20
> -			sport->tx_state =3D OFF;
> -		}
> -	} else {
>  		sport->tx_state =3D OFF;
>  	}
>  }

This hunk is only removing the if check and reindenting the body, right?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hhaf72dmo7adsjbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCAAp4ACgkQwfwUeK3K
7Aml2Qf/TKv4UahdackfenHDGk7bdMm79/CM6pMsHGMuoGvEG8br93Ifopo4zlqS
LY/jAAukAXIbkhcfhy+53pB5KCNatZbMjTGnfX76coBu6SA96NYIg8dqMEb4HYPw
i/0LEe7XWZ+lAIwSH+k0iSlcLsbTvgr342N4/UzNcHPDe0Nz5fPB9jRNW51IYOeM
sTR7sD9LXAI1i+7RzReAHdJ70vQR7BYOoDITH2fo/VDGGmL37t1N3t61F3lNDL5j
afiL3QlPhd2CaUj1GD1npwYbsEhrVy/Wi4lAWnHtr0EhHAQUoB59EiSERY0nDFDS
cbqc1tVGFybq5n6kvj90UIyXvVBVfw==
=V/vA
-----END PGP SIGNATURE-----

--hhaf72dmo7adsjbw--
