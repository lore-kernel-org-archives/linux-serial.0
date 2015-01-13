From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH v2 2/4] serial: mxs-auart: Use helpers for gpio irqs
Date: Tue, 13 Jan 2015 10:35:24 +0100
Message-ID: <20150113093524.GI22880@pengutronix.de>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
 <1420900366-9169-2-git-send-email-j.uzycki@elproma.com.pl>
 <20150113080817.GG22880@pengutronix.de>
 <54B4E588.5010602@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54B4E588.5010602@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Tue, Jan 13, 2015 at 10:29:44AM +0100, Janusz U=C5=BCycki wrote:
>=20
> W dniu 2015-01-13 o 09:08, Uwe Kleine-K=C3=B6nig pisze:
> >Hello,
> >
> >On Sat, Jan 10, 2015 at 03:32:44PM +0100, Janusz Uzycki wrote:
> >>The patch updates mxs-auart driver to use new mctrl_gpio helpers fo=
r
> >>gpio irqs. The code is much simpler now.
> >>
> >>Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> >>---
> >>
> >>There is no changes since v1 (rebased only).
> >>
> >>---
> >>  drivers/tty/serial/mxs-auart.c | 133 ++++------------------------=
-------------
> >>  1 file changed, 13 insertions(+), 120 deletions(-)
> >Very nice!
> >
> >>diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mx=
s-auart.c
> >>index ec553f8..2ddba69 100644
> >>--- a/drivers/tty/serial/mxs-auart.c
> >>+++ b/drivers/tty/serial/mxs-auart.c
> >>[...]
> >>@@ -483,18 +458,9 @@ static void mxs_auart_enable_ms(struct uart_po=
rt *port)
> >>  	s->ms_irq_enabled =3D true;
> >>-	if (s->gpio_irq[UART_GPIO_CTS] >=3D 0)
> >>-		enable_irq(s->gpio_irq[UART_GPIO_CTS]);
> >>-	/* TODO: enable AUART_INTR_CTSMIEN otherwise */
> >>-
> >>-	if (s->gpio_irq[UART_GPIO_DSR] >=3D 0)
> >>-		enable_irq(s->gpio_irq[UART_GPIO_DSR]);
> >>-
> >>-	if (s->gpio_irq[UART_GPIO_RI] >=3D 0)
> >>-		enable_irq(s->gpio_irq[UART_GPIO_RI]);
> >>-
> >>-	if (s->gpio_irq[UART_GPIO_DCD] >=3D 0)
> >>-		enable_irq(s->gpio_irq[UART_GPIO_DCD]);
> >>+	mctrl_gpio_enable_ms(s->gpios);
> >>+	/* TODO: enable AUART_INTR_CTSMIEN
> >>+	 * if s->gpios->irq[UART_GPIO_CTS] =3D=3D 0 */
> >What is the problem here? For the other lines nothing needs to be do=
ne?
> >This comment doesn't match the coding style.
>=20
> Right, the comment should be rather:
> /* TODO: enable AUART_INTR_CTSMIEN
>  * if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_CTS)) */
I'd say:

	/*
	 * TODO: enable AUART_INTR_CTSMIEN if CTS isn't handled by
	 * mctrl_gpio.
	 */

> In this place I marked that CTSMIEN should be switched on
> enable/disable_ms if CTS
> is not a gpio. The driver enables CTSMIEN forever what is wrong but
> I can't test it
> and I don't need it so I've just marked the fact in the comment.
That's what I thought. You're not affected because CTS is a gpio for
you (or not?)?  What would be the effect otherwise?

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
