From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 19:42:29 +0100
Message-ID: <20141117184229.GM27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
 <546A29B9.5030104@elproma.com.pl>
 <546A2B69.4010409@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546A2B69.4010409@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Richard Genoud <richard.genoud@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Janusz,

On Mon, Nov 17, 2014 at 06:07:53PM +0100, Janusz U=C5=BCycki wrote:
> >It looks there could be one more helper useful.
> >Both atmel_serial.c and mxs-auart.c checks if the line is
> >supported by mctrl_gpio.
> >One time it is eg.:
> >(s->gpio_irq[UART_GPIO_DCD] > 0)
> >another time it is eg.:
> >IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS))
> >
> >The first one is no possible now. The second seems rude.
> >bool mctrl_gpio_is_gpio((struct mctrl_gpios *gpios, enum
> >mctrl_gpio_idx gidx);
> >The name is hard. Moreover the implementation could be very similar
> >to mctrl_gpio_to_gpiod(). Any ideas?
>=20
> The differences:
> - faster
> - not exported
> - used mainly in uart's interrupt
> - assumes that struct mctrl_gpios *gpios exists
I wonder why you need it at all?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
