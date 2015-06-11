From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH linux-next v2 4/4] tty/serial: at91: use 32bit writes into TX FIFO when DMA is enabled
Date: Thu, 11 Jun 2015 18:20:17 +0200
Message-ID: <918ce0089cc01d241959c9e00b77c4fb4751d6a3.1434038494.git.cyrille.pitchen@atmel.com>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434038494.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, alexandre.belloni@free-electrons.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
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

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 66 ++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 6767570..270bb28 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -176,6 +176,7 @@ struct atmel_uart_port {
 	unsigned int		irq_status;
 	unsigned int		irq_status_prev;
 	unsigned int		status_change;
+	unsigned int		tx_len;
 
 	struct circ_buf		rx_ring;
 
@@ -743,10 +744,10 @@ static void atmel_complete_tx_dma(void *arg)
 
 	if (chan)
 		dmaengine_terminate_all(chan);
-	xmit->tail += sg_dma_len(&atmel_port->sg_tx);
+	xmit->tail += atmel_port->tx_len;
 	xmit->tail &= UART_XMIT_SIZE - 1;
 
-	port->icount.tx += sg_dma_len(&atmel_port->sg_tx);
+	port->icount.tx += atmel_port->tx_len;
 
 	spin_lock_irq(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
@@ -794,7 +795,9 @@ static void atmel_tx_dma(struct uart_port *port)
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_chan *chan = atmel_port->chan_tx;
 	struct dma_async_tx_descriptor *desc;
-	struct scatterlist *sg = &atmel_port->sg_tx;
+	struct scatterlist sgl[2], *sg, *sg_tx = &atmel_port->sg_tx;
+	unsigned int tx_len, part1_len, part2_len, sg_len;
+	dma_addr_t phys_addr;
 
 	/* Make sure we have an idle channel */
 	if (atmel_port->desc_tx != NULL)
@@ -810,18 +813,46 @@ static void atmel_tx_dma(struct uart_port *port)
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
@@ -830,7 +861,7 @@ static void atmel_tx_dma(struct uart_port *port)
 			return;
 		}
 
-		dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
+		dma_sync_sg_for_device(port->dev, sg_tx, 1, DMA_TO_DEVICE);
 
 		atmel_port->desc_tx = desc;
 		desc->callback = atmel_complete_tx_dma;
@@ -890,7 +921,9 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	/* Configure the slave DMA */
 	memset(&config, 0, sizeof(config));
 	config.direction = DMA_MEM_TO_DEV;
-	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.dst_addr_width = (atmel_port->fifo_size) ?
+				DMA_SLAVE_BUSWIDTH_4_BYTES :
+				DMA_SLAVE_BUSWIDTH_1_BYTE;
 	config.dst_addr = port->mapbase + ATMEL_US_THR;
 	config.dst_maxburst = 1;
 
@@ -1823,6 +1856,9 @@ static int atmel_startup(struct uart_port *port)
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
