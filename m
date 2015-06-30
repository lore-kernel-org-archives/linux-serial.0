From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 4/4] tty/serial: at91: use 32bit writes into TX FIFO when DMA is enabled
Date: Tue, 30 Jun 2015 16:05:17 +0200
Message-ID: <e742dbf0268c5f191e73061e57a5fc4ca992fc8b.1435672649.git.cyrille.pitchen@atmel.com>
References: <cover.1435672649.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1435672649.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

For now this improvement is only used with TX DMA transfers. The data
width must be set properly when configuring the DMA controller. Also
the FIFO configuration must be set to match the DMA transfer data
width:
TXRDYM (Transmitter Ready Mode) and RXRDYM (Receiver Ready Mode) must
be set into the FIFO Mode Register. These values are used by the
USART to trigger the DMA controller. In single data mode they are not
used and should be reset to 0.
So the TXRDYM bits are changed to FOUR_DATA; then USART triggers the
DMA controller when at least 4 data can be written into the TX FIFO
througth the THR. On the other hand the RXRDYM bits are left unchanged
to ONE_DATA.

Atmel eXtended DMA controller allows us to set a different data width
for each part of a scatter-gather transfer. So when calling
dmaengine_slave_config() to configure the TX path, we just need to set
dst_addr_width to the maximum data width. Then DMA writes into THR are
split into up to two parts. The first part carries the first data to
be sent and has a length equal to the greatest multiple of 4 (bytes)
lower than or equal to the total length of the TX DMA transfer. The
second part carries the trailing data (up to 3 bytes). The first part
is written by the DMA into THR using 32 bit accesses, whereas 8bit
accesses are used for the second part.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/atmel_serial.c | 66 ++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e3082d912a52..06cbb68923a8 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -185,6 +185,7 @@ struct atmel_uart_port {
 	unsigned int		irq_status;
 	unsigned int		irq_status_prev;
 	unsigned int		status_change;
+	unsigned int		tx_len;
 
 	struct circ_buf		rx_ring;
 
@@ -752,10 +753,10 @@ static void atmel_complete_tx_dma(void *arg)
 
 	if (chan)
 		dmaengine_terminate_all(chan);
-	xmit->tail += sg_dma_len(&atmel_port->sg_tx);
+	xmit->tail += atmel_port->tx_len;
 	xmit->tail &= UART_XMIT_SIZE - 1;
 
-	port->icount.tx += sg_dma_len(&atmel_port->sg_tx);
+	port->icount.tx += atmel_port->tx_len;
 
 	spin_lock_irq(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
@@ -803,7 +804,9 @@ static void atmel_tx_dma(struct uart_port *port)
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_chan *chan = atmel_port->chan_tx;
 	struct dma_async_tx_descriptor *desc;
-	struct scatterlist *sg = &atmel_port->sg_tx;
+	struct scatterlist sgl[2], *sg, *sg_tx = &atmel_port->sg_tx;
+	unsigned int tx_len, part1_len, part2_len, sg_len;
+	dma_addr_t phys_addr;
 
 	/* Make sure we have an idle channel */
 	if (atmel_port->desc_tx != NULL)
@@ -819,18 +822,46 @@ static void atmel_tx_dma(struct uart_port *port)
 		 * Take the port lock to get a
 		 * consistent xmit buffer state.
 		 */
-		sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
-		sg_dma_address(sg) = (sg_dma_address(sg) &
-					~(UART_XMIT_SIZE - 1))
-					+ sg->offset;
-		sg_dma_len(sg) = CIRC_CNT_TO_END(xmit->head,
-						xmit->tail,
-						UART_XMIT_SIZE);
-		BUG_ON(!sg_dma_len(sg));
+		tx_len = CIRC_CNT_TO_END(xmit->head,
+					 xmit->tail,
+					 UART_XMIT_SIZE);
+
+		if (atmel_port->fifo_size) {
+			/* multi data mode */
+			part1_len = (tx_len & ~0x3); /* DWORD access */
+			part2_len = (tx_len & 0x3); /* BYTE access */
+		} else {
+			/* single data (legacy) mode */
+			part1_len = 0;
+			part2_len = tx_len; /* BYTE access only */
+		}
+
+		sg_init_table(sgl, 2);
+		sg_len = 0;
+		phys_addr = sg_dma_address(sg_tx) + xmit->tail;
+		if (part1_len) {
+			sg = &sgl[sg_len++];
+			sg_dma_address(sg) = phys_addr;
+			sg_dma_len(sg) = part1_len;
+
+			phys_addr += part1_len;
+		}
+
+		if (part2_len) {
+			sg = &sgl[sg_len++];
+			sg_dma_address(sg) = phys_addr;
+			sg_dma_len(sg) = part2_len;
+		}
+
+		/*
+		 * save tx_len so atmel_complete_tx_dma() will increase
+		 * xmit->tail correctly
+		 */
+		atmel_port->tx_len = tx_len;
 
 		desc = dmaengine_prep_slave_sg(chan,
-					       sg,
-					       1,
+					       sgl,
+					       sg_len,
 					       DMA_MEM_TO_DEV,
 					       DMA_PREP_INTERRUPT |
 					       DMA_CTRL_ACK);
@@ -839,7 +870,7 @@ static void atmel_tx_dma(struct uart_port *port)
 			return;
 		}
 
-		dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
+		dma_sync_sg_for_device(port->dev, sg_tx, 1, DMA_TO_DEVICE);
 
 		atmel_port->desc_tx = desc;
 		desc->callback = atmel_complete_tx_dma;
@@ -899,7 +930,9 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	/* Configure the slave DMA */
 	memset(&config, 0, sizeof(config));
 	config.direction = DMA_MEM_TO_DEV;
-	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.dst_addr_width = (atmel_port->fifo_size) ?
+				DMA_SLAVE_BUSWIDTH_4_BYTES :
+				DMA_SLAVE_BUSWIDTH_1_BYTE;
 	config.dst_addr = port->mapbase + ATMEL_US_THR;
 	config.dst_maxburst = 1;
 
@@ -1832,6 +1865,9 @@ static int atmel_startup(struct uart_port *port)
 			    ATMEL_US_RXFCLR |
 			    ATMEL_US_TXFLCLR);
 
+		if (atmel_use_dma_tx(port))
+			txrdym = ATMEL_US_FOUR_DATA;
+
 		fmr = ATMEL_US_TXRDYM(txrdym) | ATMEL_US_RXRDYM(rxrdym);
 		if (atmel_port->rts_high &&
 		    atmel_port->rts_low)
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
