From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] serial: mxs-auart: set the FIFO size to DMA
 buffer size
Date: Wed, 2 Oct 2013 14:25:36 +0200
Message-ID: <20131002122536.GR2548@pengutronix.de>
References: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
 <1380715364-8025-2-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51553 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab3JBMZh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 08:25:37 -0400
Content-Disposition: inline
In-Reply-To: <1380715364-8025-2-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, b32955@freescale.com, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

Hallo Hector,

On Wed, Oct 02, 2013 at 02:02:43PM +0200, Hector Palacios wrote:
> When DMA is enabled (with hardware flow control enabled) the FIFO siz=
e
> must be set to the size of the DMA buffer, as this is the size the tt=
y
> subsystem can use.
>=20
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index f85b8e6..9f046177 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -40,6 +40,7 @@
>  #include <asm/cacheflush.h>
> =20
>  #define MXS_AUART_PORTS 5
> +#define MXS_AUART_FIFO_SIZE		16
> =20
>  #define AUART_CTRL0			0x00000000
>  #define AUART_CTRL0_SET			0x00000004
> @@ -549,6 +550,9 @@ static int mxs_auart_dma_init(struct mxs_auart_po=
rt *s)
>  	s->flags |=3D MXS_AUART_DMA_ENABLED;
>  	dev_dbg(s->dev, "enabled the DMA support.");
> =20
> +	/* The DMA buffer is now the FIFO the TTY subsystem can use */
> +	s->port.fifosize =3D UART_XMIT_SIZE;
> +
>  	return 0;
> =20
>  err_out:
> @@ -741,6 +745,9 @@ static int mxs_auart_startup(struct uart_port *u)
>  	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
>  			u->membase + AUART_INTR);
> =20
> +	/* Reset FIFO size (it could have changed if DMA was enabled) */
> +	u->fifosize =3D MXS_AUART_FIFO_SIZE;
> +
>  	/*
>  	 * Enable fifo so all four bytes of a DMA word are written to
>  	 * output (otherwise, only the LSB is written, ie. 1 in 4 bytes)
> @@ -1062,7 +1069,7 @@ static int mxs_auart_probe(struct platform_devi=
ce *pdev)
>  	s->port.membase =3D ioremap(r->start, resource_size(r));
>  	s->port.ops =3D &mxs_auart_ops;
>  	s->port.iotype =3D UPIO_MEM;
> -	s->port.fifosize =3D 16;
> +	s->port.fifosize =3D MXS_AUART_FIFO_SIZE;
>  	s->port.uartclk =3D clk_get_rate(s->clk);
>  	s->port.type =3D PORT_IMX;
>  	s->port.dev =3D s->dev =3D &pdev->dev;
I don't know if something is surprised when fifosize is changed by
set_termios, but that's how it is. So:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

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
