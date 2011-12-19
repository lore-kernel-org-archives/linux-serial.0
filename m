From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] imx: Add save/restore functions for UART control regs
Date: Mon, 19 Dec 2011 11:49:03 +0800
Message-ID: <20111219034902.GC4962@S2100-06.ap.freescale.net>
References: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:51857
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752079Ab1LSDfv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Dec 2011 22:35:51 -0500
Content-Disposition: inline
In-Reply-To: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Saleem Abdulrasool <compnerd@compnerd.org>

On Sun, Dec 18, 2011 at 06:34:14PM +0100, Dirk Behme wrote:
> Factor out the uart save/restore functionality instead of
> having the same code several times in the driver.
>=20
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> CC: Saleem Abdulrasool <compnerd@compnerd.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> CC: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/imx.c |   38 +++++++++++++++++++++++++++++++-----=
--
>  1 files changed, 31 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 163fc90..6a01c2a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -260,6 +260,31 @@ static inline int is_imx21_uart(struct imx_port =
*sport)
>  }
> =20
>  /*
> + * Save and restore functions for UCR1, UCR2 and UCR3 registers
> + */
> +static void imx_console_mode(struct uart_port *port,

=46unction name imx_console_mode seems not like a couple with
imx_console_restore.  And I guess something like
imx_port_ucrs_save[restore] would be better?

> +			     unsigned int *ucr1,
> +			     unsigned int *ucr2,
> +			     unsigned int *ucr3)

Can we define something like 'struct imx_port_ucrs' to contains these?

Regards,
Shawn

> +{
> +	/* save control registers */
> +	*ucr1 =3D readl(port->membase + UCR1);
> +	*ucr2 =3D readl(port->membase + UCR2);
> +	*ucr3 =3D readl(port->membase + UCR3);
> +}
> +
> +static void imx_console_restore(struct uart_port *port,
> +				unsigned int ucr1,
> +				unsigned int ucr2,
> +				unsigned int ucr3)
> +{
> +	/* restore control registers */
> +	writel(ucr1, port->membase + UCR1);
> +	writel(ucr2, port->membase + UCR2);
> +	writel(ucr3, port->membase + UCR3);
> +}
> +
> +/*
>   * Handle any change of modem status signal since we were last calle=
d.
>   */
>  static void imx_mctrl_check(struct imx_port *sport)
> @@ -1118,13 +1143,13 @@ static void
>  imx_console_write(struct console *co, const char *s, unsigned int co=
unt)
>  {
>  	struct imx_port *sport =3D imx_ports[co->index];
> -	unsigned int old_ucr1, old_ucr2, ucr1;
> +	unsigned int old_ucr1, old_ucr2, old_ucr3, ucr1;
> =20
>  	/*
> -	 *	First, save UCR1/2 and then disable interrupts
> +	 *	First, save UCR1/2/3 and then disable interrupts
>  	 */
> -	ucr1 =3D old_ucr1 =3D readl(sport->port.membase + UCR1);
> -	old_ucr2 =3D readl(sport->port.membase + UCR2);
> +	imx_console_mode(&sport->port, &old_ucr1, &old_ucr2, &old_ucr3);
> +	ucr1 =3D old_ucr1;
> =20
>  	if (is_imx1_uart(sport))
>  		ucr1 |=3D IMX1_UCR1_UARTCLKEN;
> @@ -1139,12 +1164,11 @@ imx_console_write(struct console *co, const c=
har *s, unsigned int count)
> =20
>  	/*
>  	 *	Finally, wait for transmitter to become empty
> -	 *	and restore UCR1/2
> +	 *	and restore UCR1/2/3
>  	 */
>  	while (!(readl(sport->port.membase + USR2) & USR2_TXDC));
> =20
> -	writel(old_ucr1, sport->port.membase + UCR1);
> -	writel(old_ucr2, sport->port.membase + UCR2);
> +	imx_console_restore(&sport->port, old_ucr1, old_ucr2, old_ucr3);
>  }
> =20
>  /*
> --=20
> 1.7.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
