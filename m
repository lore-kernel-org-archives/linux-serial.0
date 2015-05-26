From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] serial: sirf: use hrtimer for data rx
Date: Tue, 26 May 2015 09:36:00 +0000
Message-ID: <1432632960-19748-3-git-send-email-21cnbao@gmail.com>
References: <1432632960-19748-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432632960-19748-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: Qipan Li <Qipan.Li@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-serial@vger.kernel.org

From: Qipan Li <Qipan.Li@csr.com>

when the serial works as a bluetooth sink, due to audio realtime
requirement, the driver should have something similar with ALSA:
1. one big DMA buffer to easy the schedule jitter
2. split this big DMA buffer to multiple small periods, for each
period, we get a DMA interrupt, then push the data to userspace.
the small periods will easy the audio latency.

so ALSA generally uses a cyclic chained DMA.

but for sirfsoc, the dma hardware has the limitation: we have
only two loops in the cyclic mode, so we can only support two
small periods to switch. if we make the DMA buffer too big, we
get long latency, if we make the DMA buffer too little, we get
miss in scheduling for audio realtime.

so this patch moves to use a hrtimer to simulate the cyclic
DMA, then we can have a big buffer, and also have a timely
data push to users as the hrtimer can generate in small period
then actual HW interrupts.

with this patch, we also delete a lot of complex codes to handle
loop buffers, and RX timeout interrupt since the RX work can be
completely handled from hrtimer interrupt.

tests show using this way will make our bad audio streaming be-
come smooth.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 341 ++++++++++++++------------------------
 drivers/tty/serial/sirfsoc_uart.h |  20 +--
 2 files changed, 135 insertions(+), 226 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 6b1c92c..b611641 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -36,8 +36,6 @@ sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int max_rx_count);
 static struct uart_driver sirfsoc_uart_drv;
 
 static void sirfsoc_uart_tx_dma_complete_callback(void *param);
-static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port);
-static void sirfsoc_uart_rx_dma_complete_callback(void *param);
 static const struct sirfsoc_baudrate_to_regv baudrate_to_regv[] = {
 	{4000000, 2359296},
 	{3500000, 1310721},
@@ -465,144 +463,6 @@ static void sirfsoc_uart_tx_dma_complete_callback(void *param)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void sirfsoc_uart_insert_rx_buf_to_tty(
-		struct sirfsoc_uart_port *sirfport, int count)
-{
-	struct uart_port *port = &sirfport->port;
-	struct tty_port *tport = &port->state->port;
-	int inserted;
-
-	inserted = tty_insert_flip_string(tport,
-		sirfport->rx_dma_items[sirfport->rx_completed].xmit.buf, count);
-	port->icount.rx += inserted;
-}
-
-static void sirfsoc_rx_submit_one_dma_desc(struct uart_port *port, int index)
-{
-	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-
-	sirfport->rx_dma_items[index].xmit.tail =
-		sirfport->rx_dma_items[index].xmit.head = 0;
-	sirfport->rx_dma_items[index].desc =
-		dmaengine_prep_slave_single(sirfport->rx_dma_chan,
-		sirfport->rx_dma_items[index].dma_addr, SIRFSOC_RX_DMA_BUF_SIZE,
-		DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
-	if (IS_ERR_OR_NULL(sirfport->rx_dma_items[index].desc)) {
-		dev_err(port->dev, "DMA slave single fail\n");
-		return;
-	}
-	sirfport->rx_dma_items[index].desc->callback =
-		sirfsoc_uart_rx_dma_complete_callback;
-	sirfport->rx_dma_items[index].desc->callback_param = sirfport;
-	sirfport->rx_dma_items[index].cookie =
-		dmaengine_submit(sirfport->rx_dma_items[index].desc);
-	dma_async_issue_pending(sirfport->rx_dma_chan);
-}
-
-static void sirfsoc_rx_tmo_process_tl(unsigned long param)
-{
-	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
-	struct uart_port *port = &sirfport->port;
-	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
-	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	struct sirfsoc_int_status *uint_st = &sirfport->uart_reg->uart_int_st;
-	unsigned int count;
-	struct dma_tx_state tx_state;
-	unsigned long flags;
-	int i = 0;
-
-	spin_lock_irqsave(&port->lock, flags);
-	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
-		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
-		&tx_state)) {
-		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
-					SIRFSOC_RX_DMA_BUF_SIZE);
-		sirfport->rx_completed++;
-		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
-		i++;
-		if (i > SIRFSOC_RX_LOOP_BUF_CNT)
-			break;
-	}
-	count = CIRC_CNT(sirfport->rx_dma_items[sirfport->rx_issued].xmit.head,
-		sirfport->rx_dma_items[sirfport->rx_issued].xmit.tail,
-		SIRFSOC_RX_DMA_BUF_SIZE);
-	if (count > 0)
-		sirfsoc_uart_insert_rx_buf_to_tty(sirfport, count);
-	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
-			rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) |
-			SIRFUART_IO_MODE);
-	sirfsoc_uart_pio_rx_chars(port, 4 - sirfport->rx_io_count);
-	if (sirfport->rx_io_count == 4) {
-		sirfport->rx_io_count = 0;
-		wr_regl(port, ureg->sirfsoc_int_st_reg,
-				uint_st->sirfsoc_rx_done);
-		if (!sirfport->is_atlas7)
-			wr_regl(port, ureg->sirfsoc_int_en_reg,
-				rd_regl(port, ureg->sirfsoc_int_en_reg) &
-				~(uint_en->sirfsoc_rx_done_en));
-		else
-			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
-					uint_en->sirfsoc_rx_done_en);
-		sirfsoc_uart_start_next_rx_dma(port);
-	} else {
-		wr_regl(port, ureg->sirfsoc_int_st_reg,
-				uint_st->sirfsoc_rx_done);
-		if (!sirfport->is_atlas7)
-			wr_regl(port, ureg->sirfsoc_int_en_reg,
-				rd_regl(port, ureg->sirfsoc_int_en_reg) |
-				(uint_en->sirfsoc_rx_done_en));
-		else
-			wr_regl(port, ureg->sirfsoc_int_en_reg,
-					uint_en->sirfsoc_rx_done_en);
-	}
-	spin_unlock_irqrestore(&port->lock, flags);
-	tty_flip_buffer_push(&port->state->port);
-}
-
-static void sirfsoc_uart_handle_rx_tmo(struct sirfsoc_uart_port *sirfport)
-{
-	struct uart_port *port = &sirfport->port;
-	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
-	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	struct dma_tx_state tx_state;
-	dmaengine_tx_status(sirfport->rx_dma_chan,
-		sirfport->rx_dma_items[sirfport->rx_issued].cookie, &tx_state);
-	dmaengine_terminate_all(sirfport->rx_dma_chan);
-	sirfport->rx_dma_items[sirfport->rx_issued].xmit.head =
-		SIRFSOC_RX_DMA_BUF_SIZE - tx_state.residue;
-	if (!sirfport->is_atlas7)
-		wr_regl(port, ureg->sirfsoc_int_en_reg,
-			rd_regl(port, ureg->sirfsoc_int_en_reg) &
-			~(uint_en->sirfsoc_rx_timeout_en));
-	else
-		wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
-				uint_en->sirfsoc_rx_timeout_en);
-	tasklet_schedule(&sirfport->rx_tmo_process_tasklet);
-}
-
-static void sirfsoc_uart_handle_rx_done(struct sirfsoc_uart_port *sirfport)
-{
-	struct uart_port *port = &sirfport->port;
-	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
-	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	struct sirfsoc_int_status *uint_st = &sirfport->uart_reg->uart_int_st;
-
-	sirfsoc_uart_pio_rx_chars(port, 4 - sirfport->rx_io_count);
-	if (sirfport->rx_io_count == 4) {
-		sirfport->rx_io_count = 0;
-		if (!sirfport->is_atlas7)
-			wr_regl(port, ureg->sirfsoc_int_en_reg,
-				rd_regl(port, ureg->sirfsoc_int_en_reg) &
-				~(uint_en->sirfsoc_rx_done_en));
-		else
-			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
-					uint_en->sirfsoc_rx_done_en);
-		wr_regl(port, ureg->sirfsoc_int_st_reg,
-				uint_st->sirfsoc_rx_timeout);
-		sirfsoc_uart_start_next_rx_dma(port);
-	}
-}
-
 static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 {
 	unsigned long intr_status;
@@ -659,12 +519,8 @@ recv_char:
 		uart_handle_cts_change(port, cts_status);
 		wake_up_interruptible(&state->port.delta_msr_wait);
 	}
-	if (sirfport->rx_dma_chan) {
-		if (intr_status & uint_st->sirfsoc_rx_timeout)
-			sirfsoc_uart_handle_rx_tmo(sirfport);
-		if (intr_status & uint_st->sirfsoc_rx_done)
-			sirfsoc_uart_handle_rx_done(sirfport);
-	} else if (intr_status & SIRFUART_RX_IO_INT_ST(uint_st)) {
+	if (!sirfport->rx_dma_chan &&
+		(intr_status & SIRFUART_RX_IO_INT_ST(uint_st))) {
 		/*
 		 * chip will trigger continuous RX_TIMEOUT interrupt
 		 * in RXFIFO empty and not trigger if RXFIFO recevice
@@ -734,47 +590,8 @@ recv_char:
 	return IRQ_HANDLED;
 }
 
-static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
-{
-	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
-	struct uart_port *port = &sirfport->port;
-	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
-	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	struct dma_tx_state tx_state;
-	unsigned long flags;
-	int i = 0;
-
-	spin_lock_irqsave(&port->lock, flags);
-	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
-		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
-		&tx_state)) {
-		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
-					SIRFSOC_RX_DMA_BUF_SIZE);
-		if (rd_regl(port, ureg->sirfsoc_int_en_reg) &
-				uint_en->sirfsoc_rx_timeout_en)
-			sirfsoc_rx_submit_one_dma_desc(port,
-					sirfport->rx_completed++);
-		else
-			sirfport->rx_completed++;
-		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
-		i++;
-		if (i > SIRFSOC_RX_LOOP_BUF_CNT)
-			break;
-	}
-	spin_unlock_irqrestore(&port->lock, flags);
-	tty_flip_buffer_push(&port->state->port);
-}
-
 static void sirfsoc_uart_rx_dma_complete_callback(void *param)
 {
-	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sirfport->port.lock, flags);
-	sirfport->rx_issued++;
-	sirfport->rx_issued %= SIRFSOC_RX_LOOP_BUF_CNT;
-	tasklet_schedule(&sirfport->rx_dma_complete_tasklet);
-	spin_unlock_irqrestore(&sirfport->port.lock, flags);
 }
 
 /* submit rx dma task into dmaengine */
@@ -783,14 +600,27 @@ static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	int i;
 	sirfport->rx_io_count = 0;
 	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
 		rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) &
 		~SIRFUART_IO_MODE);
-	for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++)
-		sirfsoc_rx_submit_one_dma_desc(port, i);
-	sirfport->rx_completed = sirfport->rx_issued = 0;
+	sirfport->rx_dma_items.xmit.tail =
+		sirfport->rx_dma_items.xmit.head = 0;
+	sirfport->rx_dma_items.desc =
+		dmaengine_prep_dma_cyclic(sirfport->rx_dma_chan,
+		sirfport->rx_dma_items.dma_addr, SIRFSOC_RX_DMA_BUF_SIZE,
+		SIRFSOC_RX_DMA_BUF_SIZE / 2,
+		DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (IS_ERR_OR_NULL(sirfport->rx_dma_items.desc)) {
+		dev_err(port->dev, "DMA slave single fail\n");
+		return;
+	}
+	sirfport->rx_dma_items.desc->callback =
+		sirfsoc_uart_rx_dma_complete_callback;
+	sirfport->rx_dma_items.desc->callback_param = sirfport;
+	sirfport->rx_dma_items.cookie =
+		dmaengine_submit(sirfport->rx_dma_items.desc);
+	dma_async_issue_pending(sirfport->rx_dma_chan);
 	if (!sirfport->is_atlas7)
 		wr_regl(port, ureg->sirfsoc_int_en_reg,
 				rd_regl(port, ureg->sirfsoc_int_en_reg) |
@@ -1059,6 +889,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_DMA_MODE);
 	else
 		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_IO_MODE);
+	sirfport->rx_period_time = 20000000;
 	/* Reset Rx/Tx FIFO Threshold level for proper baudrate */
 	if (set_baud < 1000000)
 		threshold_div = 1;
@@ -1110,6 +941,9 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
 		rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) |
 		SIRFUART_IO_MODE);
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
+		rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) &
+		~SIRFUART_RX_DMA_FLUSH);
 	wr_regl(port, ureg->sirfsoc_tx_dma_io_len, 0);
 	wr_regl(port, ureg->sirfsoc_rx_dma_io_len, 0);
 	wr_regl(port, ureg->sirfsoc_tx_rx_en, SIRFUART_RX_EN | SIRFUART_TX_EN);
@@ -1147,8 +981,16 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 			goto init_rx_err;
 		}
 	}
-
 	enable_irq(port->irq);
+	if (sirfport->rx_dma_chan && !sirfport->is_hrt_enabled) {
+		sirfport->is_hrt_enabled = true;
+		sirfport->rx_period_time = 20000000;
+		sirfport->rx_dma_items.xmit.tail =
+			sirfport->rx_dma_items.xmit.head = 0;
+		hrtimer_start(&sirfport->hrt,
+			ns_to_ktime(sirfport->rx_period_time),
+			HRTIMER_MODE_REL);
+	}
 
 	return 0;
 init_rx_err:
@@ -1176,6 +1018,13 @@ static void sirfsoc_uart_shutdown(struct uart_port *port)
 	}
 	if (sirfport->tx_dma_chan)
 		sirfport->tx_dma_state = TX_DMA_IDLE;
+	if (sirfport->rx_dma_chan && sirfport->is_hrt_enabled) {
+		while ((rd_regl(port, ureg->sirfsoc_rx_fifo_status) &
+			SIRFUART_RX_FIFO_MASK) > 0)
+			;
+		sirfport->is_hrt_enabled = false;
+		hrtimer_cancel(&sirfport->hrt);
+	}
 }
 
 static const char *sirfsoc_uart_type(struct uart_port *port)
@@ -1310,6 +1159,70 @@ static struct uart_driver sirfsoc_uart_drv = {
 #endif
 };
 
+static enum hrtimer_restart
+	sirfsoc_uart_rx_dma_hrtimer_callback(struct hrtimer *hrt)
+{
+	struct sirfsoc_uart_port *sirfport;
+	struct uart_port *port;
+	int count, inserted;
+	struct dma_tx_state tx_state;
+	struct tty_struct *tty;
+	struct sirfsoc_register *ureg;
+	struct circ_buf *xmit;
+
+	sirfport = container_of(hrt, struct sirfsoc_uart_port, hrt);
+	port = &sirfport->port;
+	inserted = 0;
+	tty = port->state->port.tty;
+	ureg = &sirfport->uart_reg->uart_reg;
+	xmit = &sirfport->rx_dma_items.xmit;
+	dmaengine_tx_status(sirfport->rx_dma_chan,
+		sirfport->rx_dma_items.cookie, &tx_state);
+	xmit->head = SIRFSOC_RX_DMA_BUF_SIZE - tx_state.residue;
+	count = CIRC_CNT_TO_END(xmit->head, xmit->tail,
+			SIRFSOC_RX_DMA_BUF_SIZE);
+	while (count > 0) {
+		inserted = tty_insert_flip_string(tty->port,
+			(const unsigned char *)&xmit->buf[xmit->tail], count);
+		if (!inserted)
+			goto next_hrt;
+		port->icount.rx += inserted;
+		xmit->tail = (xmit->tail + inserted) &
+				(SIRFSOC_RX_DMA_BUF_SIZE - 1);
+		count = CIRC_CNT_TO_END(xmit->head, xmit->tail,
+				SIRFSOC_RX_DMA_BUF_SIZE);
+		tty_flip_buffer_push(tty->port);
+	}
+	/*
+	 * if RX DMA buffer data have all push into tty buffer, and there is
+	 * only little data(less than a dma transfer unit) left in rxfifo,
+	 * fetch it out in pio mode and switch back to dma immediately
+	 */
+	if (!inserted && !count &&
+		((rd_regl(port, ureg->sirfsoc_rx_fifo_status) &
+		SIRFUART_RX_FIFO_MASK) > 0)) {
+		/* switch to pio mode */
+		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
+			rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) |
+			SIRFUART_IO_MODE);
+		while ((rd_regl(port, ureg->sirfsoc_rx_fifo_status) &
+			SIRFUART_RX_FIFO_MASK) > 0) {
+			if (sirfsoc_uart_pio_rx_chars(port, 16) > 0)
+				tty_flip_buffer_push(tty->port);
+		}
+		wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
+		wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
+		wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
+		/* switch back to dma mode */
+		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
+			rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) &
+			~SIRFUART_IO_MODE);
+	}
+next_hrt:
+	hrtimer_forward_now(hrt, ns_to_ktime(sirfport->rx_period_time));
+	return HRTIMER_RESTART;
+}
+
 static struct of_device_id sirfsoc_uart_ids[] = {
 	{ .compatible = "sirf,prima2-uart", .data = &sirfsoc_uart,},
 	{ .compatible = "sirf,atlas7-uart", .data = &sirfsoc_uart},
@@ -1325,7 +1238,6 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	struct uart_port *port;
 	struct resource *res;
 	int ret;
-	int i, j;
 	struct dma_slave_config slv_cfg = {
 		.src_maxburst = 2,
 	};
@@ -1413,12 +1325,9 @@ usp_no_flow_control:
 		ret = -EFAULT;
 		goto err;
 	}
-	tasklet_init(&sirfport->rx_dma_complete_tasklet,
-			sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);
-	tasklet_init(&sirfport->rx_tmo_process_tasklet,
-			sirfsoc_rx_tmo_process_tl, (unsigned long)sirfport);
 	port->mapbase = res->start;
-	port->membase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	port->membase = devm_ioremap(&pdev->dev,
+			res->start, resource_size(res));
 	if (!port->membase) {
 		dev_err(&pdev->dev, "Cannot remap resource.\n");
 		ret = -ENOMEM;
@@ -1450,30 +1359,32 @@ usp_no_flow_control:
 	}
 
 	sirfport->rx_dma_chan = dma_request_slave_channel(port->dev, "rx");
-	for (i = 0; sirfport->rx_dma_chan && i < SIRFSOC_RX_LOOP_BUF_CNT; i++) {
-		sirfport->rx_dma_items[i].xmit.buf =
-			dma_alloc_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
-			&sirfport->rx_dma_items[i].dma_addr, GFP_KERNEL);
-		if (!sirfport->rx_dma_items[i].xmit.buf) {
-			dev_err(port->dev, "Uart alloc bufa failed\n");
-			ret = -ENOMEM;
-			goto alloc_coherent_err;
-		}
-		sirfport->rx_dma_items[i].xmit.head =
-			sirfport->rx_dma_items[i].xmit.tail = 0;
+	sirfport->rx_dma_items.xmit.buf =
+		dma_alloc_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+		&sirfport->rx_dma_items.dma_addr, GFP_KERNEL);
+	if (!sirfport->rx_dma_items.xmit.buf) {
+		dev_err(port->dev, "Uart alloc bufa failed\n");
+		ret = -ENOMEM;
+		goto alloc_coherent_err;
 	}
+	sirfport->rx_dma_items.xmit.head =
+		sirfport->rx_dma_items.xmit.tail = 0;
 	if (sirfport->rx_dma_chan)
 		dmaengine_slave_config(sirfport->rx_dma_chan, &slv_cfg);
 	sirfport->tx_dma_chan = dma_request_slave_channel(port->dev, "tx");
 	if (sirfport->tx_dma_chan)
 		dmaengine_slave_config(sirfport->tx_dma_chan, &tx_slv_cfg);
+	if (sirfport->rx_dma_chan) {
+		hrtimer_init(&sirfport->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		sirfport->hrt.function = sirfsoc_uart_rx_dma_hrtimer_callback;
+		sirfport->is_hrt_enabled = false;
+	}
 
 	return 0;
 alloc_coherent_err:
-	for (j = 0; j < i; j++)
-		dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
-				sirfport->rx_dma_items[j].xmit.buf,
-				sirfport->rx_dma_items[j].dma_addr);
+	dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+			sirfport->rx_dma_items.xmit.buf,
+			sirfport->rx_dma_items.dma_addr);
 	dma_release_channel(sirfport->rx_dma_chan);
 err:
 	return ret;
@@ -1485,13 +1396,11 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 	struct uart_port *port = &sirfport->port;
 	uart_remove_one_port(&sirfsoc_uart_drv, port);
 	if (sirfport->rx_dma_chan) {
-		int i;
 		dmaengine_terminate_all(sirfport->rx_dma_chan);
 		dma_release_channel(sirfport->rx_dma_chan);
-		for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++)
-			dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
-					sirfport->rx_dma_items[i].xmit.buf,
-					sirfport->rx_dma_items[i].dma_addr);
+		dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+				sirfport->rx_dma_items.xmit.buf,
+				sirfport->rx_dma_items.dma_addr);
 	}
 	if (sirfport->tx_dma_chan) {
 		dmaengine_terminate_all(sirfport->tx_dma_chan);
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 644f865..eb162b0 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -7,6 +7,7 @@
  */
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/hrtimer.h>
 struct sirfsoc_uart_param {
 	const char *uart_name;
 	const char *port_name;
@@ -293,6 +294,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 
 #define SIRFUART_IO_MODE			BIT(0)
 #define SIRFUART_DMA_MODE			0x0
+#define SIRFUART_RX_DMA_FLUSH			0x4
 
 /* Baud Rate Calculation */
 #define SIRF_USP_MIN_SAMPLE_DIV			0x1
@@ -353,8 +355,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 				 uint_st->sirfsoc_rx_timeout)
 #define SIRFUART_CTS_INT_ST(uint_st)	(uint_st->sirfsoc_cts)
 #define SIRFUART_RX_DMA_INT_EN(uint_en, uart_type)		\
-				(uint_en->sirfsoc_rx_timeout_en |\
-				 uint_en->sirfsoc_frm_err_en |\
+				(uint_en->sirfsoc_frm_err_en |\
 				 uint_en->sirfsoc_rx_oflow_en |\
 				 uint_en->sirfsoc_rxd_brk_en |\
 				((uart_type != SIRF_REAL_UART) ? \
@@ -369,7 +370,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFSOC_PORT_TYPE			0xa5
 
 /* Uart Common Use Macro*/
-#define SIRFSOC_RX_DMA_BUF_SIZE	256
+#define SIRFSOC_RX_DMA_BUF_SIZE		(1024 * 32)
 #define BYTES_TO_ALIGN(dma_addr)	((unsigned long)(dma_addr) & 0x3)
 /* Uart Fifo Level Chk */
 #define SIRFUART_TX_FIFO_SC_OFFSET	0
@@ -385,8 +386,8 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFUART_RX_FIFO_CHK_SC SIRFUART_TX_FIFO_CHK_SC
 #define	SIRFUART_RX_FIFO_CHK_LC SIRFUART_TX_FIFO_CHK_LC
 #define SIRFUART_RX_FIFO_CHK_HC SIRFUART_TX_FIFO_CHK_HC
+#define SIRFUART_RX_FIFO_MASK 0x7f
 /* Indicate how many buffers used */
-#define SIRFSOC_RX_LOOP_BUF_CNT		2
 
 /* For Fast Baud Rate Calculation */
 struct sirfsoc_baudrate_to_regv {
@@ -400,7 +401,7 @@ enum sirfsoc_tx_state {
 	TX_DMA_PAUSE,
 };
 
-struct sirfsoc_loop_buffer {
+struct sirfsoc_rx_buffer {
 	struct circ_buf			xmit;
 	dma_cookie_t			cookie;
 	struct dma_async_tx_descriptor	*desc;
@@ -420,17 +421,16 @@ struct sirfsoc_uart_port {
 	struct dma_chan			*tx_dma_chan;
 	dma_addr_t			tx_dma_addr;
 	struct dma_async_tx_descriptor	*tx_dma_desc;
-	struct tasklet_struct		rx_dma_complete_tasklet;
-	struct tasklet_struct		rx_tmo_process_tasklet;
 	unsigned int			rx_io_count;
 	unsigned long			transfer_size;
 	enum sirfsoc_tx_state		tx_dma_state;
 	unsigned int			cts_gpio;
 	unsigned int			rts_gpio;
 
-	struct sirfsoc_loop_buffer	rx_dma_items[SIRFSOC_RX_LOOP_BUF_CNT];
-	int				rx_completed;
-	int				rx_issued;
+	struct sirfsoc_rx_buffer	rx_dma_items;
+	struct hrtimer			hrt;
+	bool				is_hrt_enabled;
+	unsigned long			rx_period_time;
 };
 
 /* Register Access Control */
-- 
2.3.5
