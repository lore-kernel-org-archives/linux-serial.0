From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH linux-next v2 4/4] tty/serial: at91: use 32bit writes
 into TX FIFO when DMA is enabled
Date: Mon, 29 Jun 2015 15:28:42 +0200
Message-ID: <5591480A.3090804@atmel.com>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com> <918ce0089cc01d241959c9e00b77c4fb4751d6a3.1434038494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <918ce0089cc01d241959c9e00b77c4fb4751d6a3.1434038494.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, alexandre.belloni@free-electrons.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: linux-serial@vger.kernel.org

Le 11/06/2015 18:20, Cyrille Pitchen a =E9crit :
> For now this improvement is only used with TX DMA transfers. The data
> width must be set properly when configuring the DMA controller. Also
> the FIFO configuration must be set to match the DMA transfer data
> width:
> TXRDYM (Transmitter Ready Mode) and RXRDYM (Receiver Ready Mode) must
> be set into the FIFO Mode Register. These values are used by the
> USART to trigger the DMA controller. In single data mode they are not
> used and should be reset to 0.
> So the TXRDYM bits are changed to FOUR_DATA; then USART triggers the
> DMA controller when at least 4 data can be written into the TX FIFO
> througth the THR. On the other hand the RXRDYM bits are left unchange=
d
> to ONE_DATA.
>=20
> Atmel eXtended DMA controller allows us to set a different data width
> for each part of a scatter-gather transfer. So when calling
> dmaengine_slave_config() to configure the TX path, we just need to se=
t
> dst_addr_width to the maximum data width. Then DMA writes into THR ar=
e
> split into up to two parts. The first part carries the first data to
> be sent and has a length equal to the greatest multiple of 4 (bytes)
> lower than or equal to the total length of the TX DMA transfer. The
> second part carries the trailing data (up to 3 bytes). The first part
> is written by the DMA into THR using 32 bit accesses, whereas 8bit
> accesses are used for the second part.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 66 +++++++++++++++++++++++++++++=
+---------
>  1 file changed, 51 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 6767570..270bb28 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -176,6 +176,7 @@ struct atmel_uart_port {
>  	unsigned int		irq_status;
>  	unsigned int		irq_status_prev;
>  	unsigned int		status_change;
> +	unsigned int		tx_len;
> =20
>  	struct circ_buf		rx_ring;
> =20
> @@ -743,10 +744,10 @@ static void atmel_complete_tx_dma(void *arg)
> =20
>  	if (chan)
>  		dmaengine_terminate_all(chan);
> -	xmit->tail +=3D sg_dma_len(&atmel_port->sg_tx);
> +	xmit->tail +=3D atmel_port->tx_len;
>  	xmit->tail &=3D UART_XMIT_SIZE - 1;
> =20
> -	port->icount.tx +=3D sg_dma_len(&atmel_port->sg_tx);
> +	port->icount.tx +=3D atmel_port->tx_len;
> =20
>  	spin_lock_irq(&atmel_port->lock_tx);
>  	async_tx_ack(atmel_port->desc_tx);
> @@ -794,7 +795,9 @@ static void atmel_tx_dma(struct uart_port *port)
>  	struct circ_buf *xmit =3D &port->state->xmit;
>  	struct dma_chan *chan =3D atmel_port->chan_tx;
>  	struct dma_async_tx_descriptor *desc;
> -	struct scatterlist *sg =3D &atmel_port->sg_tx;
> +	struct scatterlist sgl[2], *sg, *sg_tx =3D &atmel_port->sg_tx;
> +	unsigned int tx_len, part1_len, part2_len, sg_len;
> +	dma_addr_t phys_addr;
> =20
>  	/* Make sure we have an idle channel */
>  	if (atmel_port->desc_tx !=3D NULL)
> @@ -810,18 +813,46 @@ static void atmel_tx_dma(struct uart_port *port=
)
>  		 * Take the port lock to get a
>  		 * consistent xmit buffer state.
>  		 */
> -		sg->offset =3D xmit->tail & (UART_XMIT_SIZE - 1);
> -		sg_dma_address(sg) =3D (sg_dma_address(sg) &
> -					~(UART_XMIT_SIZE - 1))
> -					+ sg->offset;
> -		sg_dma_len(sg) =3D CIRC_CNT_TO_END(xmit->head,
> -						xmit->tail,
> -						UART_XMIT_SIZE);
> -		BUG_ON(!sg_dma_len(sg));
> +		tx_len =3D CIRC_CNT_TO_END(xmit->head,
> +					 xmit->tail,
> +					 UART_XMIT_SIZE);
> +
> +		if (atmel_port->fifo_size) {
> +			/* multi data mode */
> +			part1_len =3D (tx_len & ~0x3); /* DWORD access */
> +			part2_len =3D (tx_len & 0x3); /* BYTE access */
> +		} else {
> +			/* single data (legacy) mode */
> +			part1_len =3D 0;
> +			part2_len =3D tx_len; /* BYTE access only */
> +		}
> +
> +		sg_init_table(sgl, 2);
> +		sg_len =3D 0;
> +		phys_addr =3D sg_dma_address(sg_tx) + xmit->tail;
> +		if (part1_len) {
> +			sg =3D &sgl[sg_len++];
> +			sg_dma_address(sg) =3D phys_addr;
> +			sg_dma_len(sg) =3D part1_len;
> +
> +			phys_addr +=3D part1_len;
> +		}
> +
> +		if (part2_len) {
> +			sg =3D &sgl[sg_len++];
> +			sg_dma_address(sg) =3D phys_addr;
> +			sg_dma_len(sg) =3D part2_len;
> +		}
> +
> +		/*
> +		 * save tx_len so atmel_complete_tx_dma() will increase
> +		 * xmit->tail correctly
> +		 */
> +		atmel_port->tx_len =3D tx_len;
> =20
>  		desc =3D dmaengine_prep_slave_sg(chan,
> -					       sg,
> -					       1,
> +					       sgl,
> +					       sg_len,
>  					       DMA_MEM_TO_DEV,
>  					       DMA_PREP_INTERRUPT |
>  					       DMA_CTRL_ACK);
> @@ -830,7 +861,7 @@ static void atmel_tx_dma(struct uart_port *port)
>  			return;
>  		}
> =20
> -		dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
> +		dma_sync_sg_for_device(port->dev, sg_tx, 1, DMA_TO_DEVICE);
> =20
>  		atmel_port->desc_tx =3D desc;
>  		desc->callback =3D atmel_complete_tx_dma;
> @@ -890,7 +921,9 @@ static int atmel_prepare_tx_dma(struct uart_port =
*port)
>  	/* Configure the slave DMA */
>  	memset(&config, 0, sizeof(config));
>  	config.direction =3D DMA_MEM_TO_DEV;
> -	config.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	config.dst_addr_width =3D (atmel_port->fifo_size) ?
> +				DMA_SLAVE_BUSWIDTH_4_BYTES :
> +				DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	config.dst_addr =3D port->mapbase + ATMEL_US_THR;
>  	config.dst_maxburst =3D 1;
> =20
> @@ -1823,6 +1856,9 @@ static int atmel_startup(struct uart_port *port=
)
>  			    ATMEL_US_RXFCLR |
>  			    ATMEL_US_TXFLCLR);
> =20
> +		if (atmel_use_dma_tx(port))
> +			txrdym =3D ATMEL_US_FOUR_DATA;
> +

Ok, I see now why you used a variable for txrdym: no problem to keep it
like you did then.

>  		fmr =3D ATMEL_US_TXRDYM(txrdym) | ATMEL_US_RXRDYM(rxrdym);
>  		if (atmel_port->rts_high &&
>  		    atmel_port->rts_low)
>=20

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks!
--=20
Nicolas Ferre
