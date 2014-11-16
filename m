From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Sun, 16 Nov 2014 22:48:38 +0100
Message-ID: <20141116214838.GY27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141116214239.GX27002@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Genoud <richard.genoud@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello again,

On Sun, Nov 16, 2014 at 10:42:39PM +0100, Uwe Kleine-K=F6nig wrote:
> Also note that the atmel_get_lines_status function can be simplified =
to
> just:
>=20
> 	status =3D UART_GET_CSR(port);
> 	return mctrl_gpio_get(atmel_port->gpios, &status);
thinking again, this is wrong because it uses the Atmel specific
register bits for the different flags, but with the generic solution
outlined in the previous mail this function wouldn't need to handle the
gpio parts at all.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
