From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 09:39:39 +0100
Message-ID: <20141117083939.GC27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
 <CACQ1gAjjQuiThoTP9D3igmrZyCDpyH7iWCnP5T29K4b-n4FXVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACQ1gAjjQuiThoTP9D3igmrZyCDpyH7iWCnP5T29K4b-n4FXVg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Richard,

On Mon, Nov 17, 2014 at 09:31:21AM +0100, Richard Genoud wrote:
> 2014-11-16 22:42 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pen=
gutronix.de>:
> > On Sat, Nov 15, 2014 at 08:29:04PM +0100, Janusz U=C5=BCycki wrote:
> >> The commit f9e42397d79b6e810437ba1130b0b4b594f5e56c
> >> ("serial: mxs-auart: add interrupts for modem control lines")
> >> is based on Richard's commit ab5e4e4108ca5d8326cb6b4b3a21b096a002f=
68f
> >> ("tty/serial: at91: add interrupts for modem control lines").
> >> Both patches use the condition:
> >> "if (gpiod && (gpiod_get_direction(gpiod) =3D=3D GPIOF_DIR_IN))"
> > This is broken. Actually you want to loop only over the functions i=
n
> > mctrl_gpios_desc that are inputs (i.e. CTS, DSR, DCD and RNG) and d=
on't
> > depend on the hardware state and/or a working gpiod_get_direction.
> Yes, it seemed a convenient test to locate inputs in atmel_serial's
> probe function.
> But you're right, looping on a
> enum mctrl_gpio_idx [] =3D {
>         UART_GPIO_CTS, UART_GPIO_DSR,
>         UART_GPIO_DCD, UART_GPIO_RNG, UART_GPIO_RI
> };
> Would better describe what is done, without using gpiod_get_direction=
().
Note that UART_GPIO_RNG =3D=3D UART_GPIO_RI. And this is also something=
 that
could be handled be generic code, so the respective mctrl_gpio function
can just loop over mctrl_gpios_desc and skip the entries with
dir_out=3Dtrue.

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
