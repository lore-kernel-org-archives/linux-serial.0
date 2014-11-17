From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 23:21:27 +0100
Message-ID: <20141117222127.GN27002@pengutronix.de>
References: <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
 <546A29B9.5030104@elproma.com.pl>
 <546A2B69.4010409@elproma.com.pl>
 <20141117184229.GM27002@pengutronix.de>
 <546A465E.5080904@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45312 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbaKQWVe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 17:21:34 -0500
Content-Disposition: inline
In-Reply-To: <546A465E.5080904@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Richard Genoud <richard.genoud@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello Janusz,

On Mon, Nov 17, 2014 at 08:02:54PM +0100, Janusz U=C5=BCycki wrote:
> W dniu 2014-11-17 o 19:42, Uwe Kleine-K=C3=B6nig pisze:
> >On Mon, Nov 17, 2014 at 06:07:53PM +0100, Janusz U=C5=BCycki wrote:
> >>>It looks there could be one more helper useful.
> >>>Both atmel_serial.c and mxs-auart.c checks if the line is
> >>>supported by mctrl_gpio.
> >>>One time it is eg.:
> >>>(s->gpio_irq[UART_GPIO_DCD] > 0)
> >>>another time it is eg.:
> >>>IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS))
> >>>
> >>>The first one is no possible now. The second seems rude.
> >>>bool mctrl_gpio_is_gpio((struct mctrl_gpios *gpios, enum
> >>>mctrl_gpio_idx gidx);
> >>>The name is hard. Moreover the implementation could be very simila=
r
> >>>to mctrl_gpio_to_gpiod(). Any ideas?
> >>The differences:
> >>- faster
> >>- not exported
> >>- used mainly in uart's interrupt
> >>- assumes that struct mctrl_gpios *gpios exists
> >I wonder why you need it at all?!
>=20
> If the line is not supported by gpio it could be supported by native
> uart's hardware
> if possible. There are different configurations. One port has the
> lines, other
> which uses the same driver doesn't have.
> Let's look at disable/enable_ms() in atmet_serial.c.
> In mxs-auart DMA is not used if CTS or RTS is gpio line (timming).
=46or the atmel driver I would expect that it doesn't hurt to set
ATMEL_US_CTSIC if CTS is realized using a gpio. But maybe I'm too
optimistic here. So atmel_enable_ms could look as follows:

	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);

	/*
	 * Interrupt should not be enabled twice
	 * ukl: is this check really needed?
	 */
	if (atmel_port->ms_irq_enabled)
		return;

	atmel_port->ms_irq_enabled =3D true;

	mctrl_gpio_enable_ms(...);
	UART_PUT_IER(port, ATMEL_US_CTSIC | ATMEL_US_DSRIC | ATMEL_US_RIIC | A=
TMEL_US_DCDIC);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
