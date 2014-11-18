From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] gpio: mxs: implement get_direction callback
Date: Tue, 18 Nov 2014 08:55:45 +0100
Message-ID: <20141118075545.GO27002@pengutronix.de>
References: <1416221256-11671-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39886 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaKRHzv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Nov 2014 02:55:51 -0500
Content-Disposition: inline
In-Reply-To: <1416221256-11671-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello,

On Mon, Nov 17, 2014 at 11:47:36AM +0100, Janusz Uzycki wrote:
> gpiolib's gpiod_get_direction() function returns the EINVAL error
> if .get_direction callback is not defined.
> The patch implements the callback for mxs chip what is useful
s/what/which/

> for debugging.
>=20
> Commit f9e42397d79b
> ("serial: mxs-auart: add interrupts for modem control lines")
> as based on commit ab5e4e4108ca
> ("tty/serial: at91: add interrupts for modem control lines")
> uses the gpiod_get_direction() function.
This paragraph is obsolete now that we agreed that .get_direction has
nothing to do with mctrl_gpio, right?
>=20
> Inspired from arch/arm/mach-at91/gpio.c
s/from/by/ I think

Other than that:
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
