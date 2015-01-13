From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH v2 2/4] serial: mxs-auart: Use helpers for gpio irqs
Date: Tue, 13 Jan 2015 09:08:17 +0100
Message-ID: <20150113080817.GG22880@pengutronix.de>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
 <1420900366-9169-2-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420900366-9169-2-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Sat, Jan 10, 2015 at 03:32:44PM +0100, Janusz Uzycki wrote:
> The patch updates mxs-auart driver to use new mctrl_gpio helpers for
> gpio irqs. The code is much simpler now.
>=20
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> ---
>=20
> There is no changes since v1 (rebased only).
>=20
> ---
>  drivers/tty/serial/mxs-auart.c | 133 ++++---------------------------=
----------
>  1 file changed, 13 insertions(+), 120 deletions(-)
Very nice!

> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index ec553f8..2ddba69 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> [...]
> @@ -483,18 +458,9 @@ static void mxs_auart_enable_ms(struct uart_port=
 *port)
> =20
>  	s->ms_irq_enabled =3D true;
> =20
> -	if (s->gpio_irq[UART_GPIO_CTS] >=3D 0)
> -		enable_irq(s->gpio_irq[UART_GPIO_CTS]);
> -	/* TODO: enable AUART_INTR_CTSMIEN otherwise */
> -
> -	if (s->gpio_irq[UART_GPIO_DSR] >=3D 0)
> -		enable_irq(s->gpio_irq[UART_GPIO_DSR]);
> -
> -	if (s->gpio_irq[UART_GPIO_RI] >=3D 0)
> -		enable_irq(s->gpio_irq[UART_GPIO_RI]);
> -
> -	if (s->gpio_irq[UART_GPIO_DCD] >=3D 0)
> -		enable_irq(s->gpio_irq[UART_GPIO_DCD]);
> +	mctrl_gpio_enable_ms(s->gpios);
> +	/* TODO: enable AUART_INTR_CTSMIEN
> +	 * if s->gpios->irq[UART_GPIO_CTS] =3D=3D 0 */
What is the problem here? For the other lines nothing needs to be done?
This comment doesn't match the coding style.

Other than that, this patch looks good.

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
