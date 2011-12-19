From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 2/2 v2] imx: add polled io uart methods
Date: Mon, 19 Dec 2011 11:52:09 +0800
Message-ID: <20111219035208.GD4962@S2100-06.ap.freescale.net>
References: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
 <1324229655-5538-2-git-send-email-dirk.behme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:22496 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab1LSDiy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Dec 2011 22:38:54 -0500
Content-Disposition: inline
In-Reply-To: <1324229655-5538-2-git-send-email-dirk.behme@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Saleem Abdulrasool <compnerd@compnerd.org>

On Sun, Dec 18, 2011 at 06:34:15PM +0100, Dirk Behme wrote:
> From: Saleem Abdulrasool <compnerd@compnerd.org>
>=20
> These methods are invoked if the iMX uart is used in conjuction with =
kgdb during
> early boot.  In order to access the UART without the interrupts, the =
kernel uses
> the basic polling methods for IO with the device.  With these methods
> implemented, it is now possible to enable kgdb during early boot over=
 serial.
>=20
> Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> CC: linux-serial@vger.kernel.org
> ---
> Note: Changes in the v2 compared to Saleem's original version:
>        * Remove volatile form status variable
>        * Remove blank line
>        * Factor out imx_console_mode/restore()
>=20
>  drivers/tty/serial/imx.c |   66 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 66 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 6a01c2a..cd81ac0 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -102,6 +102,7 @@
>  #define  UCR2_STPB       (1<<6)	 /* Stop */
>  #define  UCR2_WS         (1<<5)	 /* Word size */
>  #define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable=
 */
> +#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
>  #define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
>  #define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
>  #define  UCR2_SRST 	 (1<<0)	 /* SW reset */
> @@ -1104,6 +1105,66 @@ imx_verify_port(struct uart_port *port, struct=
 serial_struct *ser)
>  	return ret;
>  }
> =20
> +#if defined(CONFIG_CONSOLE_POLL)
> +static int imx_poll_get_char(struct uart_port *port)
> +{
> +	unsigned int status, cr1, cr2, cr3;
> +	unsigned char c;
> +
> +	/* save control registers */
> +	imx_console_mode(port, &cr1, &cr2, &cr3);
> +
> +	/* disable interrupts */
> +	writel(UCR1_UARTEN, port->membase + UCR1);
> +	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
> +	       port->membase + UCR2);
> +	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UC=
R3);
> +
> +	/* poll */
> +	do {
> +		status =3D readl(port->membase + USR2);
> +	} while (~status & USR2_RDR);
> +
> +	/* read */
> +	c =3D readl(port->membase + URXD0);
> +
> +	/* restore control registers */
> +	imx_console_restore(port, cr1, cr2, cr3);
> +
> +	return c & 0xff;

The 'c' is defined an 'unsigned char'.  Do we still need '& 0xff'?

> +}
> +
> +static void imx_poll_put_char(struct uart_port *port, unsigned char =
c)
> +{
> +	unsigned int status, cr1, cr2, cr3;
> +
> +	/* save control registers */
> +	imx_console_mode(port, &cr1, &cr2, &cr3);
> +
> +	/* disable interrupts */
> +	writel(UCR1_UARTEN, port->membase + UCR1);
> +	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
> +	       port->membase + UCR2);
> +	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UC=
R3);
> +
> +	/* drain */
> +	do {
> +		status =3D readl(port->membase + USR1);
> +	} while (~status & USR1_TRDY);
> +
> +	/* write */
> +	writel(c, port->membase + URTX0);
> +
> +	/* flush */
> +	do {
> +		status =3D readl(port->membase + USR2);
> +	} while (~status & USR2_TXDC);
> +
> +	/* restore control registers */
> +	imx_console_restore(port, cr1, cr2, cr3);
> +}
> +#endif
> +
>  static struct uart_ops imx_pops =3D {
>  	.tx_empty	=3D imx_tx_empty,
>  	.set_mctrl	=3D imx_set_mctrl,
> @@ -1121,6 +1182,11 @@ static struct uart_ops imx_pops =3D {
>  	.request_port	=3D imx_request_port,
>  	.config_port	=3D imx_config_port,
>  	.verify_port	=3D imx_verify_port,
> +

Unnecessary blank line?

Regards,
Shawn

> +#if defined(CONFIG_CONSOLE_POLL)
> +	.poll_get_char  =3D imx_poll_get_char,
> +	.poll_put_char  =3D imx_poll_put_char,
> +#endif
>  };
> =20
>  static struct imx_port *imx_ports[UART_NR];
> --=20
> 1.7.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
