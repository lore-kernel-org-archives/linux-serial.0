From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 5/5] tty/serial: at91: fix typo and indentation
Date: Fri, 9 Jan 2015 16:41:26 +0100
Message-ID: <54AFF6A6.4060204@atmel.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com> <faa94cfe2de1047de096b51c780f6e408aced2fb.1418131298.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <faa94cfe2de1047de096b51c780f6e408aced2fb.1418131298.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, voice.shen@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Le 09/12/2014 14:31, Cyrille Pitchen a =E9crit :
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

thanks Cyrille. Bye.

> ---
>  drivers/tty/serial/atmel_serial.c | 40 +++++++++++++++++++++--------=
----------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 9e0c636..846552b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -738,7 +738,11 @@ static void atmel_complete_tx_dma(void *arg)
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
> =20
> -	/* Do we really need this? */
> +	/*
> +	 * xmit is a circular buffer so, if we have just send data from
> +	 * xmit->tail to the end of xmit->buf, now we have to transmit the
> +	 * remaining data from the beginning of xmit->buf to xmit->head.
> +	 */
>  	if (!uart_circ_empty(xmit))
>  		tasklet_schedule(&atmel_port->tasklet);
> =20
> @@ -797,11 +801,11 @@ static void atmel_tx_dma(struct uart_port *port=
)
>  		BUG_ON(!sg_dma_len(sg));
> =20
>  		desc =3D dmaengine_prep_slave_sg(chan,
> -						sg,
> -						1,
> -						DMA_MEM_TO_DEV,
> -						DMA_PREP_INTERRUPT |
> -						DMA_CTRL_ACK);
> +					       sg,
> +					       1,
> +					       DMA_MEM_TO_DEV,
> +					       DMA_PREP_INTERRUPT |
> +					       DMA_CTRL_ACK);
>  		if (!desc) {
>  			dev_err(port->dev, "Failed to send via dma!\n");
>  			return;
> @@ -1025,13 +1029,13 @@ static int atmel_prepare_rx_dma(struct uart_p=
ort *port)
>  	/* UART circular rx buffer is an aligned page. */
>  	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
>  	sg_set_page(&atmel_port->sg_rx,
> -			virt_to_page(ring->buf),
> -			ATMEL_SERIAL_RINGSIZE,
> -			(int)ring->buf & ~PAGE_MASK);
> -			nent =3D dma_map_sg(port->dev,
> -					&atmel_port->sg_rx,
> -					1,
> -					DMA_FROM_DEVICE);
> +		    virt_to_page(ring->buf),
> +		    ATMEL_SERIAL_RINGSIZE,
> +		    (int)ring->buf & ~PAGE_MASK);
> +	nent =3D dma_map_sg(port->dev,
> +			  &atmel_port->sg_rx,
> +			  1,
> +			  DMA_FROM_DEVICE);
> =20
>  	if (!nent) {
>  		dev_dbg(port->dev, "need to release resource of dma\n");
> @@ -1060,11 +1064,11 @@ static int atmel_prepare_rx_dma(struct uart_p=
ort *port)
>  	 * each one is half ring buffer size
>  	 */
>  	desc =3D dmaengine_prep_dma_cyclic(atmel_port->chan_rx,
> -				sg_dma_address(&atmel_port->sg_rx),
> -				sg_dma_len(&atmel_port->sg_rx),
> -				sg_dma_len(&atmel_port->sg_rx)/2,
> -				DMA_DEV_TO_MEM,
> -				DMA_PREP_INTERRUPT);
> +					 sg_dma_address(&atmel_port->sg_rx),
> +					 sg_dma_len(&atmel_port->sg_rx),
> +					 sg_dma_len(&atmel_port->sg_rx)/2,
> +					 DMA_DEV_TO_MEM,
> +					 DMA_PREP_INTERRUPT);
>  	desc->callback =3D atmel_complete_rx_dma;
>  	desc->callback_param =3D port;
>  	atmel_port->desc_rx =3D desc;
>=20


--=20
Nicolas Ferre
