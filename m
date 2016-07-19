From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH RESEND v2 6/8] tty: serial: fsl_lpuart: Use scatter/gather DMA
 for Tx
Date: Tue, 19 Jul 2016 13:13:08 +0530
Message-ID: <20160719074310.16872-7-bhuvanchandra.dv@toradex.com>
References: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

Drop PIO to DMA switching and use scatter/gather DMA for Tx path to improve
performance.

Some part of the code is borrowed from imx serial driver.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 257 ++++++++++++++++++----------------------
 1 file changed, 113 insertions(+), 144 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 51d2b5a..27687d5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -244,18 +244,18 @@ struct lpuart_port {
 	struct dma_chan		*dma_rx_chan;
 	struct dma_async_tx_descriptor  *dma_tx_desc;
 	struct dma_async_tx_descriptor  *dma_rx_desc;
-	dma_addr_t		dma_tx_buf_bus;
 	dma_cookie_t		dma_tx_cookie;
 	dma_cookie_t		dma_rx_cookie;
-	unsigned char		*dma_tx_buf_virt;
 	unsigned int		dma_tx_bytes;
 	unsigned int		dma_rx_bytes;
-	int			dma_tx_in_progress;
+	bool			dma_tx_in_progress;
 	unsigned int		dma_rx_timeout;
 	struct timer_list	lpuart_timer;
-	struct scatterlist	rx_sgl;
+	struct scatterlist	rx_sgl, tx_sgl[2];
 	struct circ_buf		rx_ring;
 	int			rx_dma_rng_buf_len;
+	unsigned int		dma_tx_nents;
+	wait_queue_head_t	dma_wait;
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
@@ -316,103 +316,118 @@ static void lpuart32_stop_rx(struct uart_port *port)
 	lpuart32_write(temp & ~UARTCTRL_RE, port->membase + UARTCTRL);
 }
 
-static void lpuart_pio_tx(struct lpuart_port *sport)
+static void lpuart_dma_tx(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sport->port.lock, flags);
+	struct scatterlist *sgl = sport->tx_sgl;
+	struct device *dev = sport->port.dev;
+	int ret;
 
-	while (!uart_circ_empty(xmit) &&
-		readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size) {
-		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
-	}
+	if (sport->dma_tx_in_progress)
+		return;
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
+	sport->dma_tx_bytes = uart_circ_chars_pending(xmit);
 
-	if (uart_circ_empty(xmit))
-		writeb(readb(sport->port.membase + UARTCR5) | UARTCR5_TDMAS,
-			sport->port.membase + UARTCR5);
+	if (xmit->tail < xmit->head) {
+		sport->dma_tx_nents = 1;
+		sg_init_one(sgl, xmit->buf + xmit->tail, sport->dma_tx_bytes);
+	} else {
+		sport->dma_tx_nents = 2;
+		sg_init_table(sgl, 2);
+		sg_set_buf(sgl, xmit->buf + xmit->tail,
+				UART_XMIT_SIZE - xmit->tail);
+		sg_set_buf(sgl + 1, xmit->buf, xmit->head);
+	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-}
+	ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
+	if (!ret) {
+		dev_err(dev, "DMA mapping error for TX.\n");
+		return;
+	}
 
-static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count)
-{
-	struct circ_buf *xmit = &sport->port.state->xmit;
-	dma_addr_t tx_bus_addr;
-
-	dma_sync_single_for_device(sport->port.dev, sport->dma_tx_buf_bus,
-				UART_XMIT_SIZE, DMA_TO_DEVICE);
-	sport->dma_tx_bytes = count & ~(sport->txfifo_size - 1);
-	tx_bus_addr = sport->dma_tx_buf_bus + xmit->tail;
-	sport->dma_tx_desc = dmaengine_prep_slave_single(sport->dma_tx_chan,
-					tx_bus_addr, sport->dma_tx_bytes,
+	sport->dma_tx_desc = dmaengine_prep_slave_sg(sport->dma_tx_chan, sgl,
+					sport->dma_tx_nents,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
-
 	if (!sport->dma_tx_desc) {
-		dev_err(sport->port.dev, "Not able to get desc for tx\n");
-		return -EIO;
+		dma_unmap_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
+		dev_err(dev, "Cannot prepare TX slave DMA!\n");
+		return;
 	}
 
 	sport->dma_tx_desc->callback = lpuart_dma_tx_complete;
 	sport->dma_tx_desc->callback_param = sport;
-	sport->dma_tx_in_progress = 1;
+	sport->dma_tx_in_progress = true;
 	sport->dma_tx_cookie = dmaengine_submit(sport->dma_tx_desc);
 	dma_async_issue_pending(sport->dma_tx_chan);
 
-	return 0;
-}
-
-static void lpuart_prepare_tx(struct lpuart_port *sport)
-{
-	struct circ_buf *xmit = &sport->port.state->xmit;
-	unsigned long count =  CIRC_CNT_TO_END(xmit->head,
-					xmit->tail, UART_XMIT_SIZE);
-
-	if (!count)
-		return;
-
-	if (count < sport->txfifo_size)
-		writeb(readb(sport->port.membase + UARTCR5) & ~UARTCR5_TDMAS,
-				sport->port.membase + UARTCR5);
-	else {
-		writeb(readb(sport->port.membase + UARTCR5) | UARTCR5_TDMAS,
-				sport->port.membase + UARTCR5);
-		lpuart_dma_tx(sport, count);
-	}
 }
 
 static void lpuart_dma_tx_complete(void *arg)
 {
 	struct lpuart_port *sport = arg;
+	struct scatterlist *sgl = &sport->tx_sgl[0];
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
-	async_tx_ack(sport->dma_tx_desc);
-
 	spin_lock_irqsave(&sport->port.lock, flags);
 
+	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
+
 	xmit->tail = (xmit->tail + sport->dma_tx_bytes) & (UART_XMIT_SIZE - 1);
-	sport->dma_tx_in_progress = 0;
+
+	sport->port.icount.tx += sport->dma_tx_bytes;
+	sport->dma_tx_in_progress = false;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&sport->port);
 
-	lpuart_prepare_tx(sport);
+	if (waitqueue_active(&sport->dma_wait)) {
+		wake_up(&sport->dma_wait);
+		return;
+	}
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
+		lpuart_dma_tx(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
+static int lpuart_dma_tx_request(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+	struct dma_slave_config dma_tx_sconfig = {};
+	int ret;
+
+	dma_tx_sconfig.dst_addr = sport->port.mapbase + UARTDR;
+	dma_tx_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_tx_sconfig.dst_maxburst = 1;
+	dma_tx_sconfig.direction = DMA_MEM_TO_DEV;
+	ret = dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
+
+	if (ret) {
+		dev_err(sport->port.dev,
+				"DMA slave config failed, err = %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void lpuart_flush_buffer(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
+
 	if (sport->lpuart_dma_tx_use) {
+		if (sport->dma_tx_in_progress) {
+			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
+				sport->dma_tx_nents, DMA_TO_DEVICE);
+			sport->dma_tx_in_progress = false;
+		}
 		dmaengine_terminate_all(sport->dma_tx_chan);
-		sport->dma_tx_in_progress = 0;
 	}
 }
 
@@ -469,8 +484,8 @@ static void lpuart_start_tx(struct uart_port *port)
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!uart_circ_empty(xmit) && !sport->dma_tx_in_progress)
-			lpuart_prepare_tx(sport);
+		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+			lpuart_dma_tx(sport);
 	} else {
 		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
 			lpuart_transmit_buffer(sport);
@@ -489,6 +504,29 @@ static void lpuart32_start_tx(struct uart_port *port)
 		lpuart32_transmit_buffer(sport);
 }
 
+/* return TIOCSER_TEMT when transmitter is not busy */
+static unsigned int lpuart_tx_empty(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+			struct lpuart_port, port);
+	unsigned char sr1 = readb(port->membase + UARTSR1);
+	unsigned char sfifo = readb(port->membase + UARTSFIFO);
+
+	if (sport->dma_tx_in_progress)
+		return 0;
+
+	if (sr1 & UARTSR1_TC && sfifo & UARTSFIFO_TXEMPT)
+		return TIOCSER_TEMT;
+
+	return 0;
+}
+
+static unsigned int lpuart32_tx_empty(struct uart_port *port)
+{
+	return (lpuart32_read(port->membase + UARTSTAT) & UARTSTAT_TC) ?
+		TIOCSER_TEMT : 0;
+}
+
 static irqreturn_t lpuart_txint(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
@@ -662,12 +700,8 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 	if (sts & UARTSR1_RDRF)
 		lpuart_rxint(irq, dev_id);
 
-	if (sts & UARTSR1_TDRE) {
-		if (sport->lpuart_dma_tx_use)
-			lpuart_pio_tx(sport);
-		else
-			lpuart_txint(irq, dev_id);
-	}
+	if (sts & UARTSR1_TDRE)
+		lpuart_txint(irq, dev_id);
 
 	return IRQ_HANDLED;
 }
@@ -692,29 +726,6 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* return TIOCSER_TEMT when transmitter is not busy */
-static unsigned int lpuart_tx_empty(struct uart_port *port)
-{
-	struct lpuart_port *sport = container_of(port,
-			struct lpuart_port, port);
-	unsigned char sr1 = readb(port->membase + UARTSR1);
-	unsigned char sfifo = readb(port->membase + UARTSFIFO);
-
-	if (sport->dma_tx_in_progress)
-		return 0;
-
-	if (sr1 & UARTSR1_TC && sfifo & UARTSFIFO_TXEMPT)
-		return TIOCSER_TEMT;
-
-	return 0;
-}
-
-static unsigned int lpuart32_tx_empty(struct uart_port *port)
-{
-	return (lpuart32_read(port->membase + UARTSTAT) & UARTSTAT_TC) ?
-		TIOCSER_TEMT : 0;
-}
-
 static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 {
 	struct tty_port *port = &sport->port.state->port;
@@ -890,18 +901,6 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	return 0;
 }
 
-static void lpuart_dma_tx_free(struct uart_port *port)
-{
-	struct lpuart_port *sport = container_of(port,
-					struct lpuart_port, port);
-
-	dma_unmap_single(sport->port.dev, sport->dma_tx_buf_bus,
-			UART_XMIT_SIZE, DMA_TO_DEVICE);
-
-	sport->dma_tx_buf_bus = 0;
-	sport->dma_tx_buf_virt = NULL;
-}
-
 static void lpuart_dma_rx_free(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
@@ -1061,44 +1060,6 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(ctrl_saved, sport->port.membase + UARTCTRL);
 }
 
-static int lpuart_dma_tx_request(struct uart_port *port)
-{
-	struct lpuart_port *sport = container_of(port,
-					struct lpuart_port, port);
-	struct dma_slave_config dma_tx_sconfig;
-	dma_addr_t dma_bus;
-	unsigned char *dma_buf;
-	int ret;
-
-	dma_bus = dma_map_single(sport->dma_tx_chan->device->dev,
-				sport->port.state->xmit.buf,
-				UART_XMIT_SIZE, DMA_TO_DEVICE);
-
-	if (dma_mapping_error(sport->dma_tx_chan->device->dev, dma_bus)) {
-		dev_err(sport->port.dev, "dma_map_single tx failed\n");
-		return -ENOMEM;
-	}
-
-	dma_buf = sport->port.state->xmit.buf;
-	dma_tx_sconfig.dst_addr = sport->port.mapbase + UARTDR;
-	dma_tx_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	dma_tx_sconfig.dst_maxburst = sport->txfifo_size;
-	dma_tx_sconfig.direction = DMA_MEM_TO_DEV;
-	ret = dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
-
-	if (ret < 0) {
-		dev_err(sport->port.dev,
-				"Dma slave config failed, err = %d\n", ret);
-		return ret;
-	}
-
-	sport->dma_tx_buf_virt = dma_buf;
-	sport->dma_tx_buf_bus = dma_bus;
-	sport->dma_tx_in_progress = 0;
-
-	return 0;
-}
-
 static void rx_dma_timer_init(struct lpuart_port *sport)
 {
 		setup_timer(&sport->lpuart_timer, lpuart_timer_func,
@@ -1151,6 +1112,7 @@ static int lpuart_startup(struct uart_port *port)
 	}
 
 	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
+		init_waitqueue_head(&sport->dma_wait);
 		sport->lpuart_dma_tx_use = true;
 		temp = readb(port->membase + UARTCR5);
 		writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
@@ -1220,8 +1182,15 @@ static void lpuart_shutdown(struct uart_port *port)
 		lpuart_dma_rx_free(&sport->port);
 	}
 
-	if (sport->lpuart_dma_tx_use)
-		lpuart_dma_tx_free(&sport->port);
+	if (sport->lpuart_dma_tx_use) {
+		if (wait_event_interruptible(sport->dma_wait,
+			!sport->dma_tx_in_progress) != false) {
+			sport->dma_tx_in_progress = false;
+			dmaengine_terminate_all(sport->dma_tx_chan);
+		}
+
+		lpuart_stop_tx(port);
+	}
 }
 
 static void lpuart32_shutdown(struct uart_port *port)
-- 
2.9.0
