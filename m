From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2 6/9] tty: serial: fsl-lpuart: Use cyclic DMA for Rx
Date: Tue, 28 Jun 2016 11:02:32 +0530
Message-ID: <20160628053235.5114-7-bhuvanchandra.dv@toradex.com>
References: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Sender: linux-clk-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: stefan@agner.ch, shawnguo@kernel.org, kernel@pengutronix.de, mturquette@baylibre.com, sboyd@codeaurora.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

The initial approach of DMA implementatin for RX is inefficient due to switching
from PIO to DMA, this leads to overruns especially on instances with the smaller
FIFO. To address these issues this patch uses a cyclic DMA for receiver path.

Some part of the code is borrowed from atmel serial driver.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 483 +++++++++++++++++++++-------------------
 1 file changed, 258 insertions(+), 225 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 615f191..51d2b5a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -224,7 +224,8 @@
 #define UARTWATER_TXWATER_OFF	0
 #define UARTWATER_RXWATER_OFF	16
 
-#define FSL_UART_RX_DMA_BUFFER_SIZE	64
+/* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
+#define DMA_RX_TIMEOUT		(10)
 
 #define DRIVER_NAME	"fsl-lpuart"
 #define DEV_NAME	"ttyLP"
@@ -244,17 +245,17 @@ struct lpuart_port {
 	struct dma_async_tx_descriptor  *dma_tx_desc;
 	struct dma_async_tx_descriptor  *dma_rx_desc;
 	dma_addr_t		dma_tx_buf_bus;
-	dma_addr_t		dma_rx_buf_bus;
 	dma_cookie_t		dma_tx_cookie;
 	dma_cookie_t		dma_rx_cookie;
 	unsigned char		*dma_tx_buf_virt;
-	unsigned char		*dma_rx_buf_virt;
 	unsigned int		dma_tx_bytes;
 	unsigned int		dma_rx_bytes;
 	int			dma_tx_in_progress;
-	int			dma_rx_in_progress;
 	unsigned int		dma_rx_timeout;
 	struct timer_list	lpuart_timer;
+	struct scatterlist	rx_sgl;
+	struct circ_buf		rx_ring;
+	int			rx_dma_rng_buf_len;
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
@@ -270,7 +271,6 @@ MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
 
 /* Forward declare this for the dma callbacks*/
 static void lpuart_dma_tx_complete(void *arg);
-static void lpuart_dma_rx_complete(void *arg);
 
 static u32 lpuart32_read(void __iomem *addr)
 {
@@ -316,32 +316,6 @@ static void lpuart32_stop_rx(struct uart_port *port)
 	lpuart32_write(temp & ~UARTCTRL_RE, port->membase + UARTCTRL);
 }
 
-static void lpuart_copy_rx_to_tty(struct lpuart_port *sport,
-		struct tty_port *tty, int count)
-{
-	int copied;
-
-	sport->port.icount.rx += count;
-
-	if (!tty) {
-		dev_err(sport->port.dev, "No tty port\n");
-		return;
-	}
-
-	dma_sync_single_for_cpu(sport->port.dev, sport->dma_rx_buf_bus,
-			FSL_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
-	copied = tty_insert_flip_string(tty,
-			((unsigned char *)(sport->dma_rx_buf_virt)), count);
-
-	if (copied != count) {
-		WARN_ON(1);
-		dev_err(sport->port.dev, "RxData copy to tty layer failed\n");
-	}
-
-	dma_sync_single_for_device(sport->port.dev, sport->dma_rx_buf_bus,
-			FSL_UART_RX_DMA_BUFFER_SIZE, DMA_TO_DEVICE);
-}
-
 static void lpuart_pio_tx(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
@@ -433,28 +407,6 @@ static void lpuart_dma_tx_complete(void *arg)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-static int lpuart_dma_rx(struct lpuart_port *sport)
-{
-	dma_sync_single_for_device(sport->port.dev, sport->dma_rx_buf_bus,
-			FSL_UART_RX_DMA_BUFFER_SIZE, DMA_TO_DEVICE);
-	sport->dma_rx_desc = dmaengine_prep_slave_single(sport->dma_rx_chan,
-			sport->dma_rx_buf_bus, FSL_UART_RX_DMA_BUFFER_SIZE,
-			DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
-
-	if (!sport->dma_rx_desc) {
-		dev_err(sport->port.dev, "Not able to get desc for rx\n");
-		return -EIO;
-	}
-
-	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
-	sport->dma_rx_desc->callback_param = sport;
-	sport->dma_rx_in_progress = 1;
-	sport->dma_rx_cookie = dmaengine_submit(sport->dma_rx_desc);
-	dma_async_issue_pending(sport->dma_rx_chan);
-
-	return 0;
-}
-
 static void lpuart_flush_buffer(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -464,73 +416,6 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 }
 
-static void lpuart_dma_rx_complete(void *arg)
-{
-	struct lpuart_port *sport = arg;
-	struct tty_port *port = &sport->port.state->port;
-	unsigned long flags;
-
-	async_tx_ack(sport->dma_rx_desc);
-	mod_timer(&sport->lpuart_timer, jiffies + sport->dma_rx_timeout);
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
-	sport->dma_rx_in_progress = 0;
-	lpuart_copy_rx_to_tty(sport, port, FSL_UART_RX_DMA_BUFFER_SIZE);
-	tty_flip_buffer_push(port);
-	lpuart_dma_rx(sport);
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-}
-
-static void lpuart_dma_rx_terminate(struct lpuart_port *sport)
-{
-	struct tty_port *port = &sport->port.state->port;
-	struct dma_tx_state state;
-	unsigned long flags;
-	unsigned char temp;
-	int count;
-
-	del_timer(&sport->lpuart_timer);
-	dmaengine_pause(sport->dma_rx_chan);
-	dmaengine_tx_status(sport->dma_rx_chan, sport->dma_rx_cookie, &state);
-	dmaengine_terminate_all(sport->dma_rx_chan);
-	count = FSL_UART_RX_DMA_BUFFER_SIZE - state.residue;
-	async_tx_ack(sport->dma_rx_desc);
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
-	sport->dma_rx_in_progress = 0;
-	lpuart_copy_rx_to_tty(sport, port, count);
-	tty_flip_buffer_push(port);
-	temp = readb(sport->port.membase + UARTCR5);
-	writeb(temp & ~UARTCR5_RDMAS, sport->port.membase + UARTCR5);
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-}
-
-static void lpuart_timer_func(unsigned long data)
-{
-	lpuart_dma_rx_terminate((struct lpuart_port *)data);
-}
-
-static inline void lpuart_prepare_rx(struct lpuart_port *sport)
-{
-	unsigned long flags;
-	unsigned char temp;
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
-	sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
-	add_timer(&sport->lpuart_timer);
-
-	lpuart_dma_rx(sport);
-	temp = readb(sport->port.membase + UARTCR5);
-	writeb(temp | UARTCR5_RDMAS, sport->port.membase + UARTCR5);
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-}
-
 static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
@@ -770,18 +655,14 @@ out:
 static irqreturn_t lpuart_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned char sts, crdma;
+	unsigned char sts;
 
 	sts = readb(sport->port.membase + UARTSR1);
-	crdma = readb(sport->port.membase + UARTCR5);
 
-	if (sts & UARTSR1_RDRF && !(crdma & UARTCR5_RDMAS)) {
-		if (sport->lpuart_dma_rx_use)
-			lpuart_prepare_rx(sport);
-		else
-			lpuart_rxint(irq, dev_id);
-	}
-	if (sts & UARTSR1_TDRE && !(crdma & UARTCR5_TDMAS)) {
+	if (sts & UARTSR1_RDRF)
+		lpuart_rxint(irq, dev_id);
+
+	if (sts & UARTSR1_TDRE) {
 		if (sport->lpuart_dma_tx_use)
 			lpuart_pio_tx(sport);
 		else
@@ -834,6 +715,209 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 		TIOCSER_TEMT : 0;
 }
 
+static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
+{
+	struct tty_port *port = &sport->port.state->port;
+	struct dma_tx_state state;
+	enum dma_status dmastat;
+	struct circ_buf *ring = &sport->rx_ring;
+	unsigned long flags;
+	int count = 0;
+	unsigned char sr;
+
+	sr = readb(sport->port.membase + UARTSR1);
+
+	if (sr & (UARTSR1_PE | UARTSR1_FE)) {
+		/* Read DR to clear the error flags */
+		readb(sport->port.membase + UARTDR);
+
+		if (sr & UARTSR1_PE)
+		    sport->port.icount.parity++;
+		else if (sr & UARTSR1_FE)
+		    sport->port.icount.frame++;
+	}
+
+	async_tx_ack(sport->dma_rx_desc);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	dmastat = dmaengine_tx_status(sport->dma_rx_chan,
+				sport->dma_rx_cookie,
+				&state);
+
+	if (dmastat == DMA_ERROR) {
+		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+		return;
+	}
+
+	/* CPU claims ownership of RX DMA buffer */
+	dma_sync_sg_for_cpu(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+
+	/*
+	 * ring->head points to the end of data already written by the DMA.
+	 * ring->tail points to the beginning of data to be read by the
+	 * framework.
+	 * The current transfer size should not be larger than the dma buffer
+	 * length.
+	 */
+	ring->head = sport->rx_sgl.length - state.residue;
+	BUG_ON(ring->head > sport->rx_sgl.length);
+	/*
+	 * At this point ring->head may point to the first byte right after the
+	 * last byte of the dma buffer:
+	 * 0 <= ring->head <= sport->rx_sgl.length
+	 *
+	 * However ring->tail must always points inside the dma buffer:
+	 * 0 <= ring->tail <= sport->rx_sgl.length - 1
+	 *
+	 * Since we use a ring buffer, we have to handle the case
+	 * where head is lower than tail. In such a case, we first read from
+	 * tail to the end of the buffer then reset tail.
+	 */
+	if (ring->head < ring->tail) {
+		count = sport->rx_sgl.length - ring->tail;
+
+		tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		ring->tail = 0;
+		sport->port.icount.rx += count;
+	}
+
+	/* Finally we read data from tail to head */
+	if (ring->tail < ring->head) {
+		count = ring->head - ring->tail;
+		tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		/* Wrap ring->head if needed */
+		if (ring->head >= sport->rx_sgl.length)
+			ring->head = 0;
+		ring->tail = ring->head;
+		sport->port.icount.rx += count;
+	}
+
+	dma_sync_sg_for_device(sport->port.dev, &sport->rx_sgl, 1,
+			       DMA_FROM_DEVICE);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	tty_flip_buffer_push(port);
+	mod_timer(&sport->lpuart_timer, jiffies + sport->dma_rx_timeout);
+}
+
+static void lpuart_dma_rx_complete(void *arg)
+{
+	struct lpuart_port *sport = arg;
+
+	lpuart_copy_rx_to_tty(sport);
+}
+
+static void lpuart_timer_func(unsigned long data)
+{
+	struct lpuart_port *sport = (struct lpuart_port *)data;
+
+	lpuart_copy_rx_to_tty(sport);
+}
+
+static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
+{
+	struct dma_slave_config dma_rx_sconfig = {};
+	struct circ_buf *ring = &sport->rx_ring;
+	int ret, nent;
+	int bits, baud;
+	struct tty_struct *tty = tty_port_tty_get(&sport->port.state->port);
+	struct ktermios *termios = &tty->termios;
+
+	baud = tty_get_baud_rate(tty);
+
+	bits = (termios->c_cflag & CSIZE) == CS7 ? 9 : 10;
+	if (termios->c_cflag & PARENB)
+		bits++;
+
+	/*
+	 * Calculate length of one DMA buffer size to keep latency below
+	 * 10ms at any baud rate.
+	 */
+	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
+	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	if (sport->rx_dma_rng_buf_len < 16)
+		sport->rx_dma_rng_buf_len = 16;
+
+	ring->buf = kmalloc(sport->rx_dma_rng_buf_len, GFP_KERNEL);
+	if (!ring->buf) {
+		dev_err(sport->port.dev, "Ring buf alloc failed\n");
+		return -ENOMEM;
+	}
+
+	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
+	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
+	nent = dma_map_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+
+	if (!nent) {
+		dev_err(sport->port.dev, "DMA Rx mapping error\n");
+		return -EINVAL;
+	}
+
+	dma_rx_sconfig.src_addr = sport->port.mapbase + UARTDR;
+	dma_rx_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_rx_sconfig.src_maxburst = 1;
+	dma_rx_sconfig.direction = DMA_DEV_TO_MEM;
+	ret = dmaengine_slave_config(sport->dma_rx_chan, &dma_rx_sconfig);
+
+	if (ret < 0) {
+		dev_err(sport->port.dev,
+				"DMA Rx slave config failed, err = %d\n", ret);
+		return ret;
+	}
+
+	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(sport->dma_rx_chan,
+				 sg_dma_address(&sport->rx_sgl),
+				 sport->rx_sgl.length,
+				 sport->rx_sgl.length / 2,
+				 DMA_DEV_TO_MEM,
+				 DMA_PREP_INTERRUPT);
+	if (!sport->dma_rx_desc) {
+		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
+		return -EFAULT;
+	}
+
+	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
+	sport->dma_rx_desc->callback_param = sport;
+	sport->dma_rx_cookie = dmaengine_submit(sport->dma_rx_desc);
+	dma_async_issue_pending(sport->dma_rx_chan);
+
+	writeb(readb(sport->port.membase + UARTCR5) | UARTCR5_RDMAS,
+				sport->port.membase + UARTCR5);
+
+	return 0;
+}
+
+static void lpuart_dma_tx_free(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+
+	dma_unmap_single(sport->port.dev, sport->dma_tx_buf_bus,
+			UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	sport->dma_tx_buf_bus = 0;
+	sport->dma_tx_buf_virt = NULL;
+}
+
+static void lpuart_dma_rx_free(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+
+	if (sport->dma_rx_chan)
+		dmaengine_terminate_all(sport->dma_rx_chan);
+
+	dma_unmap_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+	kfree(sport->rx_ring.buf);
+	sport->rx_ring.tail = 0;
+	sport->rx_ring.head = 0;
+	sport->dma_rx_desc = NULL;
+	sport->dma_rx_cookie = -EINVAL;
+}
+
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
 	unsigned int temp = 0;
@@ -1015,72 +1099,12 @@ static int lpuart_dma_tx_request(struct uart_port *port)
 	return 0;
 }
 
-static int lpuart_dma_rx_request(struct uart_port *port)
+static void rx_dma_timer_init(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = container_of(port,
-					struct lpuart_port, port);
-	struct dma_slave_config dma_rx_sconfig;
-	dma_addr_t dma_bus;
-	unsigned char *dma_buf;
-	int ret;
-
-	dma_buf = devm_kzalloc(sport->port.dev,
-				FSL_UART_RX_DMA_BUFFER_SIZE, GFP_KERNEL);
-
-	if (!dma_buf) {
-		dev_err(sport->port.dev, "Dma rx alloc failed\n");
-		return -ENOMEM;
-	}
-
-	dma_bus = dma_map_single(sport->dma_rx_chan->device->dev, dma_buf,
-				FSL_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
-
-	if (dma_mapping_error(sport->dma_rx_chan->device->dev, dma_bus)) {
-		dev_err(sport->port.dev, "dma_map_single rx failed\n");
-		return -ENOMEM;
-	}
-
-	dma_rx_sconfig.src_addr = sport->port.mapbase + UARTDR;
-	dma_rx_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	dma_rx_sconfig.src_maxburst = 1;
-	dma_rx_sconfig.direction = DMA_DEV_TO_MEM;
-	ret = dmaengine_slave_config(sport->dma_rx_chan, &dma_rx_sconfig);
-
-	if (ret < 0) {
-		dev_err(sport->port.dev,
-				"Dma slave config failed, err = %d\n", ret);
-		return ret;
-	}
-
-	sport->dma_rx_buf_virt = dma_buf;
-	sport->dma_rx_buf_bus = dma_bus;
-	sport->dma_rx_in_progress = 0;
-
-	return 0;
-}
-
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
-static void lpuart_dma_rx_free(struct uart_port *port)
-{
-	struct lpuart_port *sport = container_of(port,
-					struct lpuart_port, port);
-
-	dma_unmap_single(sport->port.dev, sport->dma_rx_buf_bus,
-			FSL_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
-
-	sport->dma_rx_buf_bus = 0;
-	sport->dma_rx_buf_virt = NULL;
+		setup_timer(&sport->lpuart_timer, lpuart_timer_func,
+				(unsigned long)sport);
+		sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
+		add_timer(&sport->lpuart_timer);
 }
 
 static int lpuart_startup(struct uart_port *port)
@@ -1101,22 +1125,6 @@ static int lpuart_startup(struct uart_port *port)
 	sport->rxfifo_size = 0x1 << (((temp >> UARTPFIFO_RXSIZE_OFF) &
 		UARTPFIFO_FIFOSIZE_MASK) + 1);
 
-	if (sport->dma_rx_chan && !lpuart_dma_rx_request(port)) {
-		sport->lpuart_dma_rx_use = true;
-		setup_timer(&sport->lpuart_timer, lpuart_timer_func,
-			    (unsigned long)sport);
-	} else
-		sport->lpuart_dma_rx_use = false;
-
-
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
-		sport->lpuart_dma_tx_use = true;
-		temp = readb(port->membase + UARTCR5);
-		temp &= ~UARTCR5_RDMAS;
-		writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
-	} else
-		sport->lpuart_dma_tx_use = false;
-
 	ret = devm_request_irq(port->dev, port->irq, lpuart_int, 0,
 				DRIVER_NAME, sport);
 	if (ret)
@@ -1130,7 +1138,28 @@ static int lpuart_startup(struct uart_port *port)
 	temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
 	writeb(temp, sport->port.membase + UARTCR2);
 
+	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
+		/* set Rx DMA timeout */
+		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
+		if (!sport->dma_rx_timeout)
+		     sport->dma_rx_timeout = 1;
+
+		sport->lpuart_dma_rx_use = true;
+		rx_dma_timer_init(sport);
+	} else {
+		sport->lpuart_dma_rx_use = false;
+	}
+
+	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
+		sport->lpuart_dma_tx_use = true;
+		temp = readb(port->membase + UARTCR5);
+		writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
+	} else {
+		sport->lpuart_dma_tx_use = false;
+	}
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+
 	return 0;
 }
 
@@ -1187,8 +1216,8 @@ static void lpuart_shutdown(struct uart_port *port)
 	devm_free_irq(port->dev, port->irq, sport);
 
 	if (sport->lpuart_dma_rx_use) {
-		lpuart_dma_rx_free(&sport->port);
 		del_timer_sync(&sport->lpuart_timer);
+		lpuart_dma_rx_free(&sport->port);
 	}
 
 	if (sport->lpuart_dma_tx_use)
@@ -1318,17 +1347,6 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	if (sport->lpuart_dma_rx_use) {
-		/* Calculate delay for 1.5 DMA buffers */
-		sport->dma_rx_timeout = (sport->port.timeout - HZ / 50) *
-					FSL_UART_RX_DMA_BUFFER_SIZE * 3 /
-					sport->rxfifo_size / 2;
-		dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
-			sport->dma_rx_timeout * 1000 / HZ, sport->port.timeout);
-		if (sport->dma_rx_timeout < msecs_to_jiffies(20))
-			sport->dma_rx_timeout = msecs_to_jiffies(20);
-	}
-
 	/* wait transmit engin complete */
 	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
 		barrier();
@@ -1353,6 +1371,24 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* restore control register */
 	writeb(old_cr2, sport->port.membase + UARTCR2);
 
+	/*
+	 * If new baud rate is set, we will also need to update the Ring buffer
+	 * length according to the selected baud rate and restart Rx DMA path.
+	 */
+	if (old) {
+		if (sport->lpuart_dma_rx_use) {
+			del_timer_sync(&sport->lpuart_timer);
+			lpuart_dma_rx_free(&sport->port);
+		}
+
+		if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
+			sport->lpuart_dma_rx_use = true;
+			rx_dma_timer_init(sport);
+		} else {
+			sport->lpuart_dma_rx_use = false;
+		}
+	}
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
@@ -1937,9 +1973,6 @@ static int lpuart_suspend(struct device *dev)
 		writeb(temp, sport->port.membase + UARTCR2);
 	}
 
-	if (sport->dma_rx_in_progress)
-		lpuart_dma_rx_terminate(sport);
-
 	uart_suspend_port(&lpuart_reg, &sport->port);
 	if (sport->port.suspended && !sport->port.irq_wake)
 		clk_disable_unprepare(sport->clk);
-- 
2.9.0

