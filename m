From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] serial: sirf: add DMA support using dmaengine APIs
Date: Mon, 19 Aug 2013 11:47:53 +0800
Message-ID: <1376884073-22375-3-git-send-email-Baohua.Song@csr.com>
References: <1376884073-22375-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:52317 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3HSDsN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Aug 2013 23:48:13 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so4103623pab.12
        for <linux-serial@vger.kernel.org>; Sun, 18 Aug 2013 20:48:13 -0700 (PDT)
In-Reply-To: <1376884073-22375-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

if we get the valid dma channels from dts, move to use dmaengine to do
rx/tx. because the dma hardware requires dma address and length to be
4bytes aligned, in this driver, we will still use PIO for non-aligned
bytes, and use dma for aligned bytes.

for rx, to keep the dmaengine always active, we use double-buffer, so
we issue two dma_desc at first, and maintain the status of both
1. dma transfer done: update in rx dma finish callback
2. dma buffer is inserted into tty: update in rx dma finish tasklet and
   rx timeout tasklet
so we re-issue the dma_desc only if both 1&2 are finished.

for tx, as we know the actual length for every transfer, we don't need
the above double buffering.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 608 ++++++++++++++++++++++++++++++++++----
 drivers/tty/serial/sirfsoc_uart.h |  63 ++++
 2 files changed, 615 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index d37609d..b8d7eb3 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -21,6 +21,10 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of_gpio.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/sirfsoc_dma.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
@@ -32,6 +36,9 @@ static unsigned int
 sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int max_rx_count);
 static struct uart_driver sirfsoc_uart_drv;
 
+static void sirfsoc_uart_tx_dma_complete_callback(void *param);
+static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port);
+static void sirfsoc_uart_rx_dma_complete_callback(void *param);
 static const struct sirfsoc_baudrate_to_regv baudrate_to_regv[] = {
 	{4000000, 2359296},
 	{3500000, 1310721},
@@ -158,16 +165,115 @@ static void sirfsoc_uart_stop_tx(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	unsigned int regv;
 
-	if (!sirfport->is_marco) {
-		regv = rd_regl(port, ureg->sirfsoc_int_en_reg);
+	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no)) {
+		if (sirfport->tx_dma_state == TX_DMA_RUNNING) {
+			dmaengine_pause(sirfport->tx_dma_chan);
+			sirfport->tx_dma_state = TX_DMA_PAUSE;
+		} else {
+			if (!sirfport->is_marco)
+				wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) &
+				~uint_en->sirfsoc_txfifo_empty_en);
+			else
+				wr_regl(port, SIRFUART_INT_EN_CLR,
+				uint_en->sirfsoc_txfifo_empty_en);
+		}
+	} else {
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) &
+				~uint_en->sirfsoc_txfifo_empty_en);
+		else
+			wr_regl(port, SIRFUART_INT_EN_CLR,
+				uint_en->sirfsoc_txfifo_empty_en);
+	}
+}
+
+static void sirfsoc_uart_tx_with_dma(struct sirfsoc_uart_port *sirfport)
+{
+	struct uart_port *port = &sirfport->port;
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long tran_size;
+	unsigned long tran_start;
+	unsigned long pio_tx_size;
+
+	tran_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	tran_start = (unsigned long)(xmit->buf + xmit->tail);
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port) ||
+			!tran_size)
+		return;
+	if (sirfport->tx_dma_state == TX_DMA_PAUSE) {
+		dmaengine_resume(sirfport->tx_dma_chan);
+		return;
+	}
+	if (sirfport->tx_dma_state == TX_DMA_RUNNING)
+		return;
+	if (!sirfport->is_marco)
 		wr_regl(port, ureg->sirfsoc_int_en_reg,
-			regv & ~uint_en->sirfsoc_txfifo_empty_en);
-	} else
+				rd_regl(port, ureg->sirfsoc_int_en_reg)&
+				~(uint_en->sirfsoc_txfifo_empty_en));
+	else
 		wr_regl(port, SIRFUART_INT_EN_CLR,
 				uint_en->sirfsoc_txfifo_empty_en);
-
+	/*
+	 * DMA requires buffer address and buffer length are both aligned with
+	 * 4 bytes, so we use PIO for
+	 * 1. if address is not aligned with 4bytes, use PIO for the first 1~3
+	 * bytes, and move to DMA for the left part aligned with 4bytes
+	 * 2. if buffer length is not aligned with 4bytes, use DMA for aligned
+	 * part first, move to PIO for the left 1~3 bytes
+	 */
+	if (tran_size < 4 || BYTES_TO_ALIGN(tran_start)) {
+		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_STOP);
+		wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl,
+			rd_regl(port, ureg->sirfsoc_tx_dma_io_ctrl)|
+			SIRFUART_IO_MODE);
+		if (BYTES_TO_ALIGN(tran_start)) {
+			pio_tx_size = sirfsoc_uart_pio_tx_chars(sirfport,
+				BYTES_TO_ALIGN(tran_start));
+			tran_size -= pio_tx_size;
+		}
+		if (tran_size < 4)
+			sirfsoc_uart_pio_tx_chars(sirfport, tran_size);
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg)|
+				uint_en->sirfsoc_txfifo_empty_en);
+		else
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				uint_en->sirfsoc_txfifo_empty_en);
+		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
+	} else {
+		/* tx transfer mode switch into dma mode */
+		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_STOP);
+		wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl,
+			rd_regl(port, ureg->sirfsoc_tx_dma_io_ctrl)&
+			~SIRFUART_IO_MODE);
+		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
+		tran_size &= ~(0x3);
+
+		sirfport->tx_dma_addr = dma_map_single(port->dev,
+			xmit->buf + xmit->tail,
+			tran_size, DMA_TO_DEVICE);
+		sirfport->tx_dma_desc = dmaengine_prep_slave_single(
+			sirfport->tx_dma_chan, sirfport->tx_dma_addr,
+			tran_size, DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
+		if (!sirfport->tx_dma_desc) {
+			dev_err(port->dev, "DMA prep slave single fail\n");
+			return;
+		}
+		sirfport->tx_dma_desc->callback =
+			sirfsoc_uart_tx_dma_complete_callback;
+		sirfport->tx_dma_desc->callback_param = (void *)sirfport;
+		sirfport->transfer_size = tran_size;
+
+		dmaengine_submit(sirfport->tx_dma_desc);
+		dma_async_issue_pending(sirfport->tx_dma_chan);
+		sirfport->tx_dma_state = TX_DMA_RUNNING;
+	}
 }
 
 static void sirfsoc_uart_start_tx(struct uart_port *port)
@@ -175,17 +281,19 @@ static void sirfsoc_uart_start_tx(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	unsigned long regv;
-
-	sirfsoc_uart_pio_tx_chars(sirfport, 1);
-	wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
-	if (!sirfport->is_marco) {
-		regv = rd_regl(port, ureg->sirfsoc_int_en_reg);
-		wr_regl(port, ureg->sirfsoc_int_en_reg, regv |
-			uint_en->sirfsoc_txfifo_empty_en);
-	} else
-		wr_regl(port, ureg->sirfsoc_int_en_reg,
-				uint_en->sirfsoc_txfifo_empty_en);
+	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no))
+		sirfsoc_uart_tx_with_dma(sirfport);
+	else {
+		sirfsoc_uart_pio_tx_chars(sirfport, 1);
+		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+					rd_regl(port, ureg->sirfsoc_int_en_reg)|
+					uint_en->sirfsoc_txfifo_empty_en);
+		else
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+					uint_en->sirfsoc_txfifo_empty_en);
+	}
 }
 
 static void sirfsoc_uart_stop_rx(struct uart_port *port)
@@ -193,15 +301,28 @@ static void sirfsoc_uart_stop_rx(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	unsigned long reg;
+
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
-	if (!sirfport->is_marco) {
-		reg = rd_regl(port, ureg->sirfsoc_int_en_reg);
-		wr_regl(port, ureg->sirfsoc_int_en_reg,
-			reg & ~(SIRFUART_RX_IO_INT_EN(port, uint_en)));
-	} else
-		wr_regl(port, SIRFUART_INT_EN_CLR,
-				SIRFUART_RX_IO_INT_EN(port, uint_en));
+	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no)) {
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) &
+				~(SIRFUART_RX_DMA_INT_EN(port, uint_en) |
+				uint_en->sirfsoc_rx_done_en));
+		else
+			wr_regl(port, SIRFUART_INT_EN_CLR,
+					SIRFUART_RX_DMA_INT_EN(port, uint_en)|
+					uint_en->sirfsoc_rx_done_en);
+		dmaengine_terminate_all(sirfport->rx_dma_chan);
+	} else {
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg)&
+				~(SIRFUART_RX_IO_INT_EN(port, uint_en)));
+		else
+			wr_regl(port, SIRFUART_INT_EN_CLR,
+					SIRFUART_RX_IO_INT_EN(port, uint_en));
+	}
 }
 
 static void sirfsoc_uart_disable_ms(struct uart_port *port)
@@ -298,6 +419,7 @@ sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int max_rx_count)
 			break;
 	}
 
+	sirfport->rx_io_count += rx_count;
 	port->icount.rx += rx_count;
 	tty_flip_buffer_push(&port->state->port);
 
@@ -327,6 +449,166 @@ sirfsoc_uart_pio_tx_chars(struct sirfsoc_uart_port *sirfport, int count)
 	return num_tx;
 }
 
+static void sirfsoc_uart_tx_dma_complete_callback(void *param)
+{
+	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
+	struct uart_port *port = &sirfport->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long flags;
+
+	xmit->tail = (xmit->tail + sirfport->transfer_size) &
+				(UART_XMIT_SIZE - 1);
+	port->icount.tx += sirfport->transfer_size;
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+	if (sirfport->tx_dma_addr)
+		dma_unmap_single(port->dev, sirfport->tx_dma_addr,
+				sirfport->transfer_size, DMA_TO_DEVICE);
+	spin_lock_irqsave(&sirfport->tx_lock, flags);
+	sirfport->tx_dma_state = TX_DMA_IDLE;
+	sirfsoc_uart_tx_with_dma(sirfport);
+	spin_unlock_irqrestore(&sirfport->tx_lock, flags);
+}
+
+static void sirfsoc_uart_insert_rx_buf_to_tty(
+		struct sirfsoc_uart_port *sirfport, int count)
+{
+	struct uart_port *port = &sirfport->port;
+	struct tty_port *tport = &port->state->port;
+	int inserted;
+
+	inserted = tty_insert_flip_string(tport,
+		sirfport->rx_dma_items[sirfport->rx_completed].xmit.buf, count);
+	port->icount.rx += inserted;
+	tty_flip_buffer_push(tport);
+}
+
+static void sirfsoc_rx_submit_one_dma_desc(struct uart_port *port, int index)
+{
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+
+	sirfport->rx_dma_items[index].xmit.tail =
+		sirfport->rx_dma_items[index].xmit.head = 0;
+	sirfport->rx_dma_items[index].desc =
+		dmaengine_prep_slave_single(sirfport->rx_dma_chan,
+		sirfport->rx_dma_items[index].dma_addr, SIRFSOC_RX_DMA_BUF_SIZE,
+		DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!sirfport->rx_dma_items[index].desc) {
+		dev_err(port->dev, "DMA slave single fail\n");
+		return;
+	}
+	sirfport->rx_dma_items[index].desc->callback =
+		sirfsoc_uart_rx_dma_complete_callback;
+	sirfport->rx_dma_items[index].desc->callback_param = sirfport;
+	sirfport->rx_dma_items[index].cookie =
+		dmaengine_submit(sirfport->rx_dma_items[index].desc);
+	dma_async_issue_pending(sirfport->rx_dma_chan);
+}
+
+static void sirfsoc_rx_tmo_process_tl(unsigned long param)
+{
+	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
+	struct uart_port *port = &sirfport->port;
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
+	struct sirfsoc_int_status *uint_st = &sirfport->uart_reg->uart_int_st;
+	unsigned int count;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sirfport->rx_lock, flags);
+	while (sirfport->rx_completed != sirfport->rx_issued) {
+		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
+					SIRFSOC_RX_DMA_BUF_SIZE);
+		sirfsoc_rx_submit_one_dma_desc(port, sirfport->rx_completed++);
+		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
+	}
+	count = CIRC_CNT(sirfport->rx_dma_items[sirfport->rx_issued].xmit.head,
+		sirfport->rx_dma_items[sirfport->rx_issued].xmit.tail,
+		SIRFSOC_RX_DMA_BUF_SIZE);
+	if (count > 0)
+		sirfsoc_uart_insert_rx_buf_to_tty(sirfport, count);
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
+			rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) |
+			SIRFUART_IO_MODE);
+	sirfsoc_uart_pio_rx_chars(port, 4 - sirfport->rx_io_count);
+	spin_unlock_irqrestore(&sirfport->rx_lock, flags);
+	if (sirfport->rx_io_count == 4) {
+		spin_lock_irqsave(&sirfport->rx_lock, flags);
+		sirfport->rx_io_count = 0;
+		wr_regl(port, ureg->sirfsoc_int_st_reg,
+				uint_st->sirfsoc_rx_done);
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) &
+				~(uint_en->sirfsoc_rx_done_en));
+		else
+			wr_regl(port, SIRFUART_INT_EN_CLR,
+					uint_en->sirfsoc_rx_done_en);
+		spin_unlock_irqrestore(&sirfport->rx_lock, flags);
+
+		sirfsoc_uart_start_next_rx_dma(port);
+	} else {
+		spin_lock_irqsave(&sirfport->rx_lock, flags);
+		wr_regl(port, ureg->sirfsoc_int_st_reg,
+				uint_st->sirfsoc_rx_done);
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) |
+				(uint_en->sirfsoc_rx_done_en));
+		else
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+					uint_en->sirfsoc_rx_done_en);
+		spin_unlock_irqrestore(&sirfport->rx_lock, flags);
+	}
+}
+
+static void sirfsoc_uart_handle_rx_tmo(struct sirfsoc_uart_port *sirfport)
+{
+	struct uart_port *port = &sirfport->port;
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
+	struct dma_tx_state tx_state;
+	spin_lock(&sirfport->rx_lock);
+
+	dmaengine_tx_status(sirfport->rx_dma_chan,
+		sirfport->rx_dma_items[sirfport->rx_issued].cookie, &tx_state);
+	dmaengine_terminate_all(sirfport->rx_dma_chan);
+	sirfport->rx_dma_items[sirfport->rx_issued].xmit.head =
+		SIRFSOC_RX_DMA_BUF_SIZE - tx_state.residue;
+	if (!sirfport->is_marco)
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+			rd_regl(port, ureg->sirfsoc_int_en_reg) &
+			~(uint_en->sirfsoc_rx_timeout_en));
+	else
+		wr_regl(port, SIRFUART_INT_EN_CLR,
+				uint_en->sirfsoc_rx_timeout_en);
+	spin_unlock(&sirfport->rx_lock);
+	tasklet_schedule(&sirfport->rx_tmo_process_tasklet);
+}
+
+static void sirfsoc_uart_handle_rx_done(struct sirfsoc_uart_port *sirfport)
+{
+	struct uart_port *port = &sirfport->port;
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
+	struct sirfsoc_int_status *uint_st = &sirfport->uart_reg->uart_int_st;
+
+	sirfsoc_uart_pio_rx_chars(port, 4 - sirfport->rx_io_count);
+	if (sirfport->rx_io_count == 4) {
+		sirfport->rx_io_count = 0;
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) &
+				~(uint_en->sirfsoc_rx_done_en));
+		else
+			wr_regl(port, SIRFUART_INT_EN_CLR,
+					uint_en->sirfsoc_rx_done_en);
+		wr_regl(port, ureg->sirfsoc_int_st_reg,
+				uint_st->sirfsoc_rx_timeout);
+		sirfsoc_uart_start_next_rx_dma(port);
+	}
+}
+
 static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 {
 	unsigned long intr_status;
@@ -343,6 +625,7 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 	spin_lock(&port->lock);
 	intr_status = rd_regl(port, ureg->sirfsoc_int_st_reg);
 	wr_regl(port, ureg->sirfsoc_int_st_reg, intr_status);
+	intr_status &= rd_regl(port, ureg->sirfsoc_int_en_reg);
 	if (unlikely(intr_status & (SIRFUART_ERR_INT_STAT(port, uint_st)))) {
 		if (intr_status & uint_st->sirfsoc_rxd_brk) {
 			port->icount.brk++;
@@ -367,7 +650,8 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 	}
 recv_char:
 	if ((sirfport->uart_reg->uart_type == SIRF_REAL_UART) &&
-			(intr_status & SIRFUART_CTS_INT_ST(uint_st))) {
+			(intr_status & SIRFUART_CTS_INT_ST(uint_st)) &&
+			!sirfport->tx_dma_state) {
 		cts_status = rd_regl(port, ureg->sirfsoc_afc_ctrl) &
 					SIRFUART_AFC_CTS_STATUS;
 		if (cts_status != 0)
@@ -377,41 +661,111 @@ recv_char:
 		uart_handle_cts_change(port, cts_status);
 		wake_up_interruptible(&state->port.delta_msr_wait);
 	}
-	if (intr_status & SIRFUART_RX_IO_INT_ST(uint_st))
-		sirfsoc_uart_pio_rx_chars(port, SIRFSOC_UART_IO_RX_MAX_CNT);
+	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no)) {
+		if (intr_status & uint_st->sirfsoc_rx_timeout)
+			sirfsoc_uart_handle_rx_tmo(sirfport);
+		if (intr_status & uint_st->sirfsoc_rx_done)
+			sirfsoc_uart_handle_rx_done(sirfport);
+	} else {
+		if (intr_status & SIRFUART_RX_IO_INT_ST(uint_st))
+			sirfsoc_uart_pio_rx_chars(port,
+					SIRFSOC_UART_IO_RX_MAX_CNT);
+	}
 	if (intr_status & uint_st->sirfsoc_txfifo_empty) {
-		if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-			spin_unlock(&port->lock);
-			return IRQ_HANDLED;
-		} else {
-			sirfsoc_uart_pio_tx_chars(sirfport,
+		if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no))
+			sirfsoc_uart_tx_with_dma(sirfport);
+		else {
+			if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+				spin_unlock(&port->lock);
+				return IRQ_HANDLED;
+			} else {
+				sirfsoc_uart_pio_tx_chars(sirfport,
 					SIRFSOC_UART_IO_TX_REASONABLE_CNT);
-			if ((uart_circ_empty(xmit)) &&
+				if ((uart_circ_empty(xmit)) &&
 				(rd_regl(port, ureg->sirfsoc_tx_fifo_status) &
-						ufifo_st->ff_empty(port->line)))
-				sirfsoc_uart_stop_tx(port);
+				ufifo_st->ff_empty(port->line)))
+					sirfsoc_uart_stop_tx(port);
+			}
 		}
 	}
 	spin_unlock(&port->lock);
 	return IRQ_HANDLED;
 }
 
-static void sirfsoc_uart_start_rx(struct uart_port *port)
+static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
+{
+	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
+	struct uart_port *port = &sirfport->port;
+	unsigned long flags;
+	spin_lock_irqsave(&sirfport->rx_lock, flags);
+	while (sirfport->rx_completed != sirfport->rx_issued) {
+		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
+					SIRFSOC_RX_DMA_BUF_SIZE);
+		sirfsoc_rx_submit_one_dma_desc(port, sirfport->rx_completed++);
+		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
+	}
+	spin_unlock_irqrestore(&sirfport->rx_lock, flags);
+}
+
+static void sirfsoc_uart_rx_dma_complete_callback(void *param)
+{
+	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
+	spin_lock(&sirfport->rx_lock);
+	sirfport->rx_issued++;
+	sirfport->rx_issued %= SIRFSOC_RX_LOOP_BUF_CNT;
+	spin_unlock(&sirfport->rx_lock);
+	tasklet_schedule(&sirfport->rx_dma_complete_tasklet);
+}
+
+/* submit rx dma task into dmaengine */
+static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	unsigned long regv;
-	if (!sirfport->is_marco) {
-		regv = rd_regl(port, ureg->sirfsoc_int_en_reg);
-		wr_regl(port, ureg->sirfsoc_int_en_reg, regv |
-			SIRFUART_RX_IO_INT_EN(port, uint_en));
-	} else
+	unsigned long flags;
+	int i;
+	spin_lock_irqsave(&sirfport->rx_lock, flags);
+	sirfport->rx_io_count = 0;
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
+		rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) &
+		~SIRFUART_IO_MODE);
+	spin_unlock_irqrestore(&sirfport->rx_lock, flags);
+	for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++)
+		sirfsoc_rx_submit_one_dma_desc(port, i);
+	sirfport->rx_completed = sirfport->rx_issued = 0;
+	spin_lock_irqsave(&sirfport->rx_lock, flags);
+	if (!sirfport->is_marco)
 		wr_regl(port, ureg->sirfsoc_int_en_reg,
-				SIRFUART_RX_IO_INT_EN(port, uint_en));
+				rd_regl(port, ureg->sirfsoc_int_en_reg) |
+				SIRFUART_RX_DMA_INT_EN(port, uint_en));
+	else
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+			SIRFUART_RX_DMA_INT_EN(port, uint_en));
+	spin_unlock_irqrestore(&sirfport->rx_lock, flags);
+}
+
+static void sirfsoc_uart_start_rx(struct uart_port *port)
+{
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
+
+	sirfport->rx_io_count = 0;
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
+	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no))
+		sirfsoc_uart_start_next_rx_dma(port);
+	else {
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) |
+				SIRFUART_RX_IO_INT_EN(port, uint_en));
+		else
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				SIRFUART_RX_IO_INT_EN(port, uint_en));
+	}
 }
 
 static unsigned int
@@ -488,10 +842,9 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	unsigned long	flags;
 	unsigned long	ic;
 	unsigned int	clk_div_reg = 0;
-	unsigned long	temp_reg_val, ioclk_rate;
+	unsigned long	txfifo_op_reg, ioclk_rate;
 	unsigned long	rx_time_out;
 	int		threshold_div;
-	int		temp;
 	u32		data_bit_len, stop_bit_len, len_val;
 	unsigned long	sample_div_reg = 0xf;
 	ioclk_rate	= port->uartclk;
@@ -606,10 +959,10 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	/* set receive timeout && data bits len */
 	rx_time_out = SIRFSOC_UART_RX_TIMEOUT(set_baud, 20000);
 	rx_time_out = SIRFUART_RECV_TIMEOUT_VALUE(rx_time_out);
-	temp_reg_val = rd_regl(port, ureg->sirfsoc_tx_fifo_op);
+	txfifo_op_reg = rd_regl(port, ureg->sirfsoc_tx_fifo_op);
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
 	wr_regl(port, ureg->sirfsoc_tx_fifo_op,
-			(temp_reg_val & ~SIRFUART_FIFO_START));
+			(txfifo_op_reg & ~SIRFUART_FIFO_START));
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
 		config_reg |= SIRFUART_RECV_TIMEOUT(port, rx_time_out);
 		wr_regl(port, ureg->sirfsoc_line_ctrl, config_reg);
@@ -631,24 +984,118 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 			(SIRFUART_RECV_TIMEOUT(port, rx_time_out)) |
 			(sample_div_reg & 0x3f) << 16);
 	}
-	wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, SIRFUART_IO_MODE);
-	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_IO_MODE);
+	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no))
+		wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, SIRFUART_DMA_MODE);
+	else
+		wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, SIRFUART_IO_MODE);
+	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no))
+		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_DMA_MODE);
+	else
+		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_IO_MODE);
 	/* Reset Rx/Tx FIFO Threshold level for proper baudrate */
 	if (set_baud < 1000000)
 		threshold_div = 1;
 	else
 		threshold_div = 2;
-	temp = SIRFUART_FIFO_THD(port);
-	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, temp / threshold_div);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl, temp / threshold_div);
-	temp_reg_val |= SIRFUART_FIFO_START;
-	wr_regl(port, ureg->sirfsoc_tx_fifo_op, temp_reg_val);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl,
+				SIRFUART_FIFO_THD(port) / threshold_div);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl,
+				SIRFUART_FIFO_THD(port) / threshold_div);
+	txfifo_op_reg |= SIRFUART_FIFO_START;
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op, txfifo_op_reg);
 	uart_update_timeout(port, termios->c_cflag, set_baud);
 	sirfsoc_uart_start_rx(port);
 	wr_regl(port, ureg->sirfsoc_tx_rx_en, SIRFUART_TX_EN | SIRFUART_RX_EN);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static unsigned int sirfsoc_uart_init_tx_dma(struct uart_port *port)
+{
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	dma_cap_mask_t dma_mask;
+	struct dma_slave_config tx_slv_cfg = {
+		.dst_maxburst = 2,
+	};
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+	sirfport->tx_dma_chan = dma_request_channel(dma_mask,
+		(dma_filter_fn)sirfsoc_dma_filter_id,
+		(void *)sirfport->tx_dma_no);
+	if (!sirfport->tx_dma_chan) {
+		dev_err(port->dev, "Uart Request Dma Channel Fail %d\n",
+					sirfport->tx_dma_no);
+		return  -EPROBE_DEFER;
+	}
+	dmaengine_slave_config(sirfport->tx_dma_chan, &tx_slv_cfg);
+
+	return 0;
+}
+
+static unsigned int sirfsoc_uart_init_rx_dma(struct uart_port *port)
+{
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	dma_cap_mask_t dma_mask;
+	int ret;
+	int i, j;
+	struct dma_slave_config slv_cfg = {
+		.src_maxburst = 2,
+	};
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+	sirfport->rx_dma_chan = dma_request_channel(dma_mask,
+					(dma_filter_fn)sirfsoc_dma_filter_id,
+					(void *)sirfport->rx_dma_no);
+	if (!sirfport->rx_dma_chan) {
+		dev_err(port->dev, "Uart Request Dma Channel Fail %d\n",
+				sirfport->rx_dma_no);
+		ret = -EPROBE_DEFER;
+		goto request_err;
+	}
+	for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++) {
+		sirfport->rx_dma_items[i].xmit.buf =
+			dma_alloc_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+			&sirfport->rx_dma_items[i].dma_addr, GFP_KERNEL);
+		if (!sirfport->rx_dma_items[i].xmit.buf) {
+			dev_err(port->dev, "Uart alloc bufa failed\n");
+			ret = -ENOMEM;
+			goto alloc_coherent_err;
+		}
+		sirfport->rx_dma_items[i].xmit.head =
+			sirfport->rx_dma_items[i].xmit.tail = 0;
+	}
+	dmaengine_slave_config(sirfport->rx_dma_chan, &slv_cfg);
+
+	return 0;
+alloc_coherent_err:
+	for (j = 0; j < i; j++)
+		dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+				sirfport->rx_dma_items[j].xmit.buf,
+				sirfport->rx_dma_items[j].dma_addr);
+	dma_release_channel(sirfport->rx_dma_chan);
+request_err:
+	return ret;
+}
+
+static void sirfsoc_uart_uninit_tx_dma(struct sirfsoc_uart_port *sirfport)
+{
+	dmaengine_terminate_all(sirfport->tx_dma_chan);
+	dma_release_channel(sirfport->tx_dma_chan);
+}
+
+static void sirfsoc_uart_uninit_rx_dma(struct sirfsoc_uart_port *sirfport)
+{
+	int i;
+	struct uart_port *port = &sirfport->port;
+	dmaengine_terminate_all(sirfport->rx_dma_chan);
+	dma_release_channel(sirfport->rx_dma_chan);
+	for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++)
+		dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+				sirfport->rx_dma_items[i].xmit.buf,
+				sirfport->rx_dma_items[i].dma_addr);
+}
+
 static int sirfsoc_uart_startup(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport	= to_sirfport(port);
@@ -688,6 +1135,23 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, SIRFUART_FIFO_THD(port));
 	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl, SIRFUART_FIFO_THD(port));
 
+	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no)) {
+		ret = sirfsoc_uart_init_rx_dma(port);
+		if (ret)
+			goto init_rx_err;
+		wr_regl(port, ureg->sirfsoc_rx_fifo_level_chk,
+				SIRFUART_RX_FIFO_CHK_SC(port->line, 0x4) |
+				SIRFUART_RX_FIFO_CHK_LC(port->line, 0xe) |
+				SIRFUART_RX_FIFO_CHK_HC(port->line, 0x1b));
+	}
+	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no)) {
+		sirfsoc_uart_init_tx_dma(port);
+		sirfport->tx_dma_state = TX_DMA_IDLE;
+		wr_regl(port, ureg->sirfsoc_tx_fifo_level_chk,
+				SIRFUART_TX_FIFO_CHK_SC(port->line, 0x1b) |
+				SIRFUART_TX_FIFO_CHK_LC(port->line, 0xe) |
+				SIRFUART_TX_FIFO_CHK_HC(port->line, 0x4));
+	}
 	sirfport->ms_enabled = false;
 	if (sirfport->uart_reg->uart_type == SIRF_USP_UART &&
 		sirfport->hw_flow_ctrl) {
@@ -728,6 +1192,12 @@ static void sirfsoc_uart_shutdown(struct uart_port *port)
 		gpio_set_value(sirfport->rts_gpio, 1);
 		free_irq(gpio_to_irq(sirfport->cts_gpio), sirfport);
 	}
+	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no))
+		sirfsoc_uart_uninit_rx_dma(sirfport);
+	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no)) {
+		sirfsoc_uart_uninit_tx_dma(sirfport);
+		sirfport->tx_dma_state = TX_DMA_IDLE;
+	}
 }
 
 static const char *sirfsoc_uart_type(struct uart_port *port)
@@ -801,6 +1271,9 @@ sirfsoc_uart_console_setup(struct console *co, char *options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	port->cons = co;
 
+	/* default console tx/rx transfer using io mode */
+	sirfport->rx_dma_no = UNVALID_DMA_CHAN;
+	sirfport->tx_dma_no = UNVALID_DMA_CHAN;
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
@@ -888,10 +1361,27 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 
 	sirfport->hw_flow_ctrl = of_property_read_bool(pdev->dev.of_node,
 		"sirf,uart-has-rtscts");
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart"))
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart")) {
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
+		if (of_property_read_u32(pdev->dev.of_node,
+				"sirf,uart-dma-rx-channel",
+				&sirfport->rx_dma_no))
+			sirfport->rx_dma_no = UNVALID_DMA_CHAN;
+		if (of_property_read_u32(pdev->dev.of_node,
+				"sirf,uart-dma-tx-channel",
+				&sirfport->tx_dma_no))
+			sirfport->tx_dma_no = UNVALID_DMA_CHAN;
+	}
 	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart")) {
 		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
+		if (of_property_read_u32(pdev->dev.of_node,
+				"sirf,usp-dma-rx-channel",
+				&sirfport->rx_dma_no))
+			sirfport->rx_dma_no = UNVALID_DMA_CHAN;
+		if (of_property_read_u32(pdev->dev.of_node,
+				"sirf,usp-dma-tx-channel",
+				&sirfport->tx_dma_no))
+			sirfport->tx_dma_no = UNVALID_DMA_CHAN;
 		if (!sirfport->hw_flow_ctrl)
 			goto usp_no_flow_control;
 		if (of_find_property(pdev->dev.of_node, "cts-gpios", NULL))
@@ -946,6 +1436,12 @@ usp_no_flow_control:
 		ret = -EFAULT;
 		goto err;
 	}
+	spin_lock_init(&sirfport->rx_lock);
+	spin_lock_init(&sirfport->tx_lock);
+	tasklet_init(&sirfport->rx_dma_complete_tasklet,
+			sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);
+	tasklet_init(&sirfport->rx_tmo_process_tasklet,
+			sirfsoc_rx_tmo_process_tl, (unsigned long)sirfport);
 	port->mapbase = res->start;
 	port->membase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!port->membase) {
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index e87035a..173e00f 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -338,6 +338,12 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 				 uint_st->sirfsoc_rxfifo_thd |\
 				 uint_st->sirfsoc_rxfifo_full)
 #define SIRFUART_CTS_INT_ST(uint_st)	(uint_st->sirfsoc_cts)
+#define SIRFUART_RX_DMA_INT_EN(port, uint_en)				\
+				(uint_en->sirfsoc_rx_timeout_en |\
+				 uint_en->sirfsoc_frm_err_en |\
+				 uint_en->sirfsoc_rx_oflow_en |\
+				 uint_en->sirfsoc_rxd_brk_en |\
+		((port->line > 2) ? 0 : uint_en->sirfsoc_parity_err_en))
 /* Generic Definitions */
 #define SIRFSOC_UART_NAME			"ttySiRF"
 #define SIRFSOC_UART_MAJOR			0
@@ -356,12 +362,52 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRF_SAMPLE_DIV_MASK			0x3f0000
 #define SIRF_BAUD_RATE_SUPPORT_NR		18
 
+/* Uart Common Use Macro*/
+#define SIRFSOC_RX_DMA_BUF_SIZE	256
+#define BYTES_TO_ALIGN(dma_addr)	((unsigned long)(dma_addr) & 0x3)
+#define LOOP_DMA_BUFA_FILL	1
+#define LOOP_DMA_BUFB_FILL	2
+#define TX_TRAN_PIO		1
+#define TX_TRAN_DMA		2
+/* Uart Fifo Level Chk */
+#define SIRFUART_TX_FIFO_SC_OFFSET	0
+#define SIRFUART_TX_FIFO_LC_OFFSET	10
+#define SIRFUART_TX_FIFO_HC_OFFSET	20
+#define SIRFUART_TX_FIFO_CHK_SC(line, value) ((((line) == 1) ? (value & 0x3) :\
+				(value & 0x1f)) << SIRFUART_TX_FIFO_SC_OFFSET)
+#define SIRFUART_TX_FIFO_CHK_LC(line, value) ((((line) == 1) ? (value & 0x3) :\
+				(value & 0x1f)) << SIRFUART_TX_FIFO_LC_OFFSET)
+#define SIRFUART_TX_FIFO_CHK_HC(line, value) ((((line) == 1) ? (value & 0x3) :\
+				(value & 0x1f)) << SIRFUART_TX_FIFO_HC_OFFSET)
+
+#define SIRFUART_RX_FIFO_CHK_SC SIRFUART_TX_FIFO_CHK_SC
+#define	SIRFUART_RX_FIFO_CHK_LC SIRFUART_TX_FIFO_CHK_LC
+#define SIRFUART_RX_FIFO_CHK_HC SIRFUART_TX_FIFO_CHK_HC
+/* Indicate how many buffers used */
+#define SIRFSOC_RX_LOOP_BUF_CNT		2
+
+/* Indicate if DMA channel valid */
+#define IS_DMA_CHAN_VALID(x)	((x) != -1)
+#define UNVALID_DMA_CHAN	-1
 /* For Fast Baud Rate Calculation */
 struct sirfsoc_baudrate_to_regv {
 	unsigned int baud_rate;
 	unsigned int reg_val;
 };
 
+enum sirfsoc_tx_state {
+	TX_DMA_IDLE,
+	TX_DMA_RUNNING,
+	TX_DMA_PAUSE,
+};
+
+struct sirfsoc_loop_buffer {
+	struct circ_buf			xmit;
+	dma_cookie_t			cookie;
+	struct dma_async_tx_descriptor	*desc;
+	dma_addr_t			dma_addr;
+};
+
 struct sirfsoc_uart_port {
 	bool				hw_flow_ctrl;
 	bool				ms_enabled;
@@ -371,8 +417,25 @@ struct sirfsoc_uart_port {
 	/* for SiRFmarco, there are SET/CLR for UART_INT_EN */
 	bool				is_marco;
 	struct sirfsoc_uart_register	*uart_reg;
+	int				rx_dma_no;
+	int				tx_dma_no;
+	struct dma_chan			*rx_dma_chan;
+	struct dma_chan			*tx_dma_chan;
+	dma_addr_t			tx_dma_addr;
+	struct dma_async_tx_descriptor	*tx_dma_desc;
+	spinlock_t			rx_lock;
+	spinlock_t			tx_lock;
+	struct tasklet_struct		rx_dma_complete_tasklet;
+	struct tasklet_struct		rx_tmo_process_tasklet;
+	unsigned int			rx_io_count;
+	unsigned long			transfer_size;
+	enum sirfsoc_tx_state		tx_dma_state;
 	unsigned int			cts_gpio;
 	unsigned int			rts_gpio;
+
+	struct sirfsoc_loop_buffer	rx_dma_items[SIRFSOC_RX_LOOP_BUF_CNT];
+	int				rx_completed;
+	int				rx_issued;
 };
 
 /* Hardware Flow Control */
-- 
1.8.2.3

