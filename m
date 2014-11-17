From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 09:44:10 +0100
Message-ID: <20141117084410.GD27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
 <1416213534.761947189@f70.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416213534.761947189@f70.i.mail.ru>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: fabio.estevam@freescale.com, Alexandre Courbot <gnurou@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
List-Id: linux-serial@vger.kernel.org

Hello Alexander,

On Mon, Nov 17, 2014 at 11:38:54AM +0300, Alexander Shiyan wrote:
> Hello.
>=20
> ...
> > > struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned =
int
> > > idx, int *irqs)
> > What is idx about? I see it already in the mctrl_gpio API, but ther=
e is
> > no documentation about how it's used. Is it always 0?
>=20
> This could be used for drivers with several UARTs, which registered a=
t once.
Then what about:

	/**
	 * Document what idx is about here.
	 */
	struct mctrl_gpios *mctrl_gpio_init_index(struct uart_port *port, unsi=
gned int idx);
	static inline struct mctrl_gpios *mctrl_gpio_init(struct uart_port *po=
rt)
	{
		return mctrl_gpio_init_index(port, 0);
	}

? That matches how gpio and of functions use the indexed variants.

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
