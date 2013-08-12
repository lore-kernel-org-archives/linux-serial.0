From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] serial: sirf: make the driver also support USP-based UART
Date: Mon, 12 Aug 2013 18:15:35 +0800
Message-ID: <1376302535-18696-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:45472 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab3HLKQW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Aug 2013 06:16:22 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so6661716pbc.17
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2013 03:16:22 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

Universal Serial Ports (USP) can be used as PCM, UART, SPI,
I2S etc. this makes the USP work as UART. the basic work
flow is same with UART controller, the main difference will
be offset of registers and bits.

this patch makes the old sirfsoc uart driver support both
sirf UART and USP-based UART by making their differences
become private data.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 this patch depends on:
 Barry Song: [PATCH] serial: sirf: add support for Marco chip
 at: http://www.spinics.net/lists/linux-serial/msg10532.html

 drivers/tty/serial/sirfsoc_uart.c | 540 ++++++++++++++++++++++++--------------
 drivers/tty/serial/sirfsoc_uart.h | 413 +++++++++++++++++++++--------
 2 files changed, 655 insertions(+), 298 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 2c991d6..c4f8ffe 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -99,21 +99,23 @@ static inline struct sirfsoc_uart_port *to_sirfport(struct uart_port *port)
 static inline unsigned int sirfsoc_uart_tx_empty(struct uart_port *port)
 {
 	unsigned long reg;
-	reg = rd_regl(port, SIRFUART_TX_FIFO_STATUS);
-	if (reg & SIRFUART_FIFOEMPTY_MASK(port))
-		return TIOCSER_TEMT;
-	else
-		return 0;
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_fifo_status *ufifo_st = &sirfport->uart_reg->fifo_status;
+	reg = rd_regl(port, ureg->sirfsoc_tx_fifo_status);
+
+	return (reg & ufifo_st->ff_empty(port->line)) ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int sirfsoc_uart_get_mctrl(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	if (!(sirfport->ms_enabled)) {
 		goto cts_asserted;
 	} else if (sirfport->hw_flow_ctrl) {
-		if (!(rd_regl(port, SIRFUART_AFC_CTRL) &
-						SIRFUART_CTS_IN_STATUS))
+		if (!(rd_regl(port, ureg->sirfsoc_afc_ctrl) &
+						SIRFUART_AFC_CTS_STATUS))
 			goto cts_asserted;
 		else
 			goto cts_deasserted;
@@ -127,122 +129,145 @@ cts_asserted:
 static void sirfsoc_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	unsigned int assert = mctrl & TIOCM_RTS;
 	unsigned int val = assert ? SIRFUART_AFC_CTRL_RX_THD : 0x0;
 	unsigned int current_val;
 	if (sirfport->hw_flow_ctrl) {
-		current_val = rd_regl(port, SIRFUART_AFC_CTRL) & ~0xFF;
+		current_val = rd_regl(port, ureg->sirfsoc_afc_ctrl) & ~0xFF;
 		val |= current_val;
-		wr_regl(port, SIRFUART_AFC_CTRL, val);
+		wr_regl(port, ureg->sirfsoc_afc_ctrl, val);
 	}
 }
 
 static void sirfsoc_uart_stop_tx(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned int regv;
 
 	if (!sirfport->is_marco) {
-		regv = rd_regl(port, SIRFUART_INT_EN);
-		wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_TX_INT_EN);
-	} else {
-		wr_regl(port, SIRFUART_INT_EN_CLR, SIRFUART_TX_INT_EN);
-	}
+		regv = rd_regl(port, ureg->sirfsoc_int_en_reg);
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+			regv & ~uint_en->sirfsoc_txfifo_empty_en);
+	} else
+		wr_regl(port, SIRFUART_INT_EN_CLR,
+				uint_en->sirfsoc_txfifo_empty_en);
+
 }
 
 void sirfsoc_uart_start_tx(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long regv;
 
 	sirfsoc_uart_pio_tx_chars(sirfport, 1);
-	wr_regl(port, SIRFUART_TX_FIFO_OP, SIRFUART_TX_FIFO_START);
-
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
 	if (!sirfport->is_marco) {
-		regv = rd_regl(port, SIRFUART_INT_EN);
-		wr_regl(port, SIRFUART_INT_EN, regv | SIRFUART_TX_INT_EN);
-	} else {
-		wr_regl(port, SIRFUART_INT_EN, SIRFUART_TX_INT_EN);
-	}
+		regv = rd_regl(port, ureg->sirfsoc_int_en_reg);
+		wr_regl(port, ureg->sirfsoc_int_en_reg, regv |
+			uint_en->sirfsoc_txfifo_empty_en);
+	} else
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+				uint_en->sirfsoc_txfifo_empty_en);
 }
 
 static void sirfsoc_uart_stop_rx(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	unsigned long regv;
-
-	wr_regl(port, SIRFUART_RX_FIFO_OP, 0);
-
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
+	unsigned long reg;
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
 	if (!sirfport->is_marco) {
-		regv = rd_regl(port, SIRFUART_INT_EN);
-		wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_RX_IO_INT_EN);
-	} else {
-		wr_regl(port, SIRFUART_INT_EN_CLR, SIRFUART_RX_IO_INT_EN);
-	}
+		reg = rd_regl(port, ureg->sirfsoc_int_en_reg);
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+			reg & ~(SIRFUART_RX_IO_INT_EN(port, uint_en)));
+	} else
+		wr_regl(port, SIRFUART_INT_EN_CLR,
+				SIRFUART_RX_IO_INT_EN(port, uint_en));
 }
 
 static void sirfsoc_uart_disable_ms(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long reg;
 
 	sirfport->ms_enabled = 0;
 	if (!sirfport->hw_flow_ctrl)
 		return;
 
-	reg = rd_regl(port, SIRFUART_AFC_CTRL);
-	wr_regl(port, SIRFUART_AFC_CTRL, reg & ~0x3FF);
-
+	reg = rd_regl(port, ureg->sirfsoc_afc_ctrl);
+	wr_regl(port, ureg->sirfsoc_afc_ctrl, reg & ~0x3FF);
 	if (!sirfport->is_marco) {
-		reg = rd_regl(port, SIRFUART_INT_EN);
-		wr_regl(port, SIRFUART_INT_EN, reg & ~SIRFUART_CTS_INT_EN);
-	} else {
-		wr_regl(port, SIRFUART_INT_EN_CLR, SIRFUART_CTS_INT_EN);
-	}
+		reg = rd_regl(port, ureg->sirfsoc_int_en_reg);
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+			reg & ~uint_en->sirfsoc_cts_en);
+	} else
+		wr_regl(port, SIRFUART_INT_EN_CLR,
+				uint_en->sirfsoc_cts_en);
 }
 
 static void sirfsoc_uart_enable_ms(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long reg;
 	unsigned long flg;
 
 	if (!sirfport->hw_flow_ctrl)
 		return;
-	flg = SIRFUART_AFC_RX_EN | SIRFUART_AFC_TX_EN;
-	reg = rd_regl(port, SIRFUART_AFC_CTRL);
-	wr_regl(port, SIRFUART_AFC_CTRL, reg | flg);
-
+	flg = SIRFUART_AFC_TX_EN | SIRFUART_AFC_RX_EN;
+	reg = rd_regl(port, ureg->sirfsoc_afc_ctrl);
+	wr_regl(port, ureg->sirfsoc_afc_ctrl, reg | flg);
 	if (!sirfport->is_marco) {
-		reg = rd_regl(port, SIRFUART_INT_EN);
-		wr_regl(port, SIRFUART_INT_EN, reg | SIRFUART_CTS_INT_EN);
-	} else {
-		wr_regl(port, SIRFUART_INT_EN, SIRFUART_CTS_INT_EN);
-	}
-
+		reg = rd_regl(port, ureg->sirfsoc_int_en_reg);
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+				reg | uint_en->sirfsoc_cts_en);
+	} else
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+				uint_en->sirfsoc_cts_en);
 	uart_handle_cts_change(port,
-		!(rd_regl(port, SIRFUART_AFC_CTRL) & SIRFUART_CTS_IN_STATUS));
+		!(rd_regl(port, ureg->sirfsoc_afc_ctrl) &
+				SIRFUART_AFC_CTS_STATUS));
 	sirfport->ms_enabled = 1;
 }
 
 static void sirfsoc_uart_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long ulcon = rd_regl(port, SIRFUART_LINE_CTRL);
-	if (break_state)
-		ulcon |= SIRFUART_SET_BREAK;
-	else
-		ulcon &= ~SIRFUART_SET_BREAK;
-	wr_regl(port, SIRFUART_LINE_CTRL, ulcon);
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
+		unsigned long ulcon = rd_regl(port, ureg->sirfsoc_line_ctrl);
+		if (break_state)
+			ulcon |= SIRFUART_SET_BREAK;
+		else
+			ulcon &= ~SIRFUART_SET_BREAK;
+		wr_regl(port, ureg->sirfsoc_line_ctrl, ulcon);
+	}
 }
 
 static unsigned int
 sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int max_rx_count)
 {
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_fifo_status *ufifo_st = &sirfport->uart_reg->fifo_status;
 	unsigned int ch, rx_count = 0;
-
-	while (!(rd_regl(port, SIRFUART_RX_FIFO_STATUS) &
-					SIRFUART_FIFOEMPTY_MASK(port))) {
-		ch = rd_regl(port, SIRFUART_RX_FIFO_DATA) | SIRFUART_DUMMY_READ;
+	struct tty_struct *tty;
+	tty = tty_port_tty_get(&port->state->port);
+	if (!tty)
+		return -ENODEV;
+	while (!(rd_regl(port, ureg->sirfsoc_rx_fifo_status) &
+					ufifo_st->ff_empty(port->line))) {
+		ch = rd_regl(port, ureg->sirfsoc_rx_fifo_data) |
+			SIRFUART_DUMMY_READ;
 		if (unlikely(uart_handle_sysrq_char(port, ch)))
 			continue;
 		uart_insert_char(port, 0, 0, ch, TTY_NORMAL);
@@ -261,13 +286,16 @@ static unsigned int
 sirfsoc_uart_pio_tx_chars(struct sirfsoc_uart_port *sirfport, int count)
 {
 	struct uart_port *port = &sirfport->port;
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_fifo_status *ufifo_st = &sirfport->uart_reg->fifo_status;
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int num_tx = 0;
 	while (!uart_circ_empty(xmit) &&
-		!(rd_regl(port, SIRFUART_TX_FIFO_STATUS) &
-					SIRFUART_FIFOFULL_MASK(port)) &&
+		!(rd_regl(port, ureg->sirfsoc_tx_fifo_status) &
+					ufifo_st->ff_full(port->line)) &&
 		count--) {
-		wr_regl(port, SIRFUART_TX_FIFO_DATA, xmit->buf[xmit->tail]);
+		wr_regl(port, ureg->sirfsoc_tx_fifo_data,
+				xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		num_tx++;
@@ -284,50 +312,52 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 	unsigned long flag = TTY_NORMAL;
 	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)dev_id;
 	struct uart_port *port = &sirfport->port;
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_fifo_status *ufifo_st = &sirfport->uart_reg->fifo_status;
+	struct sirfsoc_int_status *uint_st = &sirfport->uart_reg->uart_int_st;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	struct uart_state *state = port->state;
 	struct circ_buf *xmit = &port->state->xmit;
 	spin_lock(&port->lock);
-	intr_status = rd_regl(port, SIRFUART_INT_STATUS);
-	wr_regl(port, SIRFUART_INT_STATUS, intr_status);
-	intr_status &= rd_regl(port, SIRFUART_INT_EN);
-	if (unlikely(intr_status & (SIRFUART_ERR_INT_STAT))) {
-		if (intr_status & SIRFUART_RXD_BREAK) {
+	intr_status = rd_regl(port, ureg->sirfsoc_int_st_reg);
+	wr_regl(port, ureg->sirfsoc_int_st_reg, intr_status);
+	if (unlikely(intr_status & (SIRFUART_ERR_INT_STAT(port, uint_st)))) {
+		if (intr_status & uint_st->sirfsoc_rxd_brk) {
+			port->icount.brk++;
 			if (uart_handle_break(port))
 				goto recv_char;
-			uart_insert_char(port, intr_status,
-					SIRFUART_RX_OFLOW, 0, TTY_BREAK);
-			spin_unlock(&port->lock);
-			return IRQ_HANDLED;
 		}
-		if (intr_status & SIRFUART_RX_OFLOW)
+		if (intr_status & uint_st->sirfsoc_rx_oflow)
 			port->icount.overrun++;
-		if (intr_status & SIRFUART_FRM_ERR) {
+		if (intr_status & uint_st->sirfsoc_frm_err) {
 			port->icount.frame++;
 			flag = TTY_FRAME;
 		}
-		if (intr_status & SIRFUART_PARITY_ERR)
+		if (intr_status & uint_st->sirfsoc_parity_err)
 			flag = TTY_PARITY;
-		wr_regl(port, SIRFUART_RX_FIFO_OP, SIRFUART_RX_FIFO_RESET);
-		wr_regl(port, SIRFUART_RX_FIFO_OP, 0);
-		wr_regl(port, SIRFUART_RX_FIFO_OP, SIRFUART_RX_FIFO_START);
+		wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
+		wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
+		wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
 		intr_status &= port->read_status_mask;
 		uart_insert_char(port, intr_status,
-					SIRFUART_RX_OFLOW_INT, 0, flag);
+					uint_en->sirfsoc_rx_oflow_en, 0, flag);
+		tty_flip_buffer_push(&state->port);
 	}
 recv_char:
-	if (intr_status & SIRFUART_CTS_INT_EN) {
-		cts_status = !(rd_regl(port, SIRFUART_AFC_CTRL) &
-							SIRFUART_CTS_IN_STATUS);
-		if (cts_status != 0) {
-			uart_handle_cts_change(port, 1);
-		} else {
-			uart_handle_cts_change(port, 0);
-			wake_up_interruptible(&state->port.delta_msr_wait);
-		}
+	if ((sirfport->uart_reg->uart_type == SIRF_REAL_UART) &&
+			(intr_status & SIRFUART_CTS_INT_ST(uint_st))) {
+		cts_status = rd_regl(port, ureg->sirfsoc_afc_ctrl) &
+					SIRFUART_AFC_CTS_STATUS;
+		if (cts_status != 0)
+			cts_status = 0;
+		else
+			cts_status = 1;
+		uart_handle_cts_change(port, cts_status);
+		wake_up_interruptible(&state->port.delta_msr_wait);
 	}
-	if (intr_status & SIRFUART_RX_IO_INT_EN)
+	if (intr_status & SIRFUART_RX_IO_INT_ST(uint_st))
 		sirfsoc_uart_pio_rx_chars(port, SIRFSOC_UART_IO_RX_MAX_CNT);
-	if (intr_status & SIRFUART_TX_INT_EN) {
+	if (intr_status & uint_st->sirfsoc_txfifo_empty) {
 		if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
 			spin_unlock(&port->lock);
 			return IRQ_HANDLED;
@@ -335,8 +365,8 @@ recv_char:
 			sirfsoc_uart_pio_tx_chars(sirfport,
 					SIRFSOC_UART_IO_TX_REASONABLE_CNT);
 			if ((uart_circ_empty(xmit)) &&
-				(rd_regl(port, SIRFUART_TX_FIFO_STATUS) &
-						SIRFUART_FIFOEMPTY_MASK(port)))
+				(rd_regl(port, ureg->sirfsoc_tx_fifo_status) &
+						ufifo_st->ff_empty(port->line)))
 				sirfsoc_uart_stop_tx(port);
 		}
 	}
@@ -347,23 +377,54 @@ recv_char:
 static void sirfsoc_uart_start_rx(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
+	unsigned long regv;
 	if (!sirfport->is_marco) {
-		unsigned long regv;
-		regv = rd_regl(port, SIRFUART_INT_EN);
-		wr_regl(port, SIRFUART_INT_EN, regv | SIRFUART_RX_IO_INT_EN);
-	} else {
-		wr_regl(port, SIRFUART_INT_EN, SIRFUART_RX_IO_INT_EN);
-	}
+		regv = rd_regl(port, ureg->sirfsoc_int_en_reg);
+		wr_regl(port, ureg->sirfsoc_int_en_reg, regv |
+			SIRFUART_RX_IO_INT_EN(port, uint_en));
+	} else
+		wr_regl(port, ureg->sirfsoc_int_en_reg,
+				SIRFUART_RX_IO_INT_EN(port, uint_en));
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
+}
+
+static unsigned int
+sirfsoc_usp_calc_sample_div(unsigned long set_rate,
+		unsigned long ioclk_rate, unsigned long *sample_reg)
+{
+	unsigned long min_delta = ~0UL;
+	unsigned short sample_div;
+	unsigned long ioclk_div = 0;
+	unsigned long temp_delta;
+
+	for (sample_div = SIRF_MIN_SAMPLE_DIV;
+			sample_div <= SIRF_MAX_SAMPLE_DIV; sample_div++) {
+		temp_delta = ioclk_rate -
+		(ioclk_rate + (set_rate * sample_div) / 2)
+		/ (set_rate * sample_div) * set_rate * sample_div;
 
-	wr_regl(port, SIRFUART_RX_FIFO_OP, SIRFUART_RX_FIFO_RESET);
-	wr_regl(port, SIRFUART_RX_FIFO_OP, 0);
-	wr_regl(port, SIRFUART_RX_FIFO_OP, SIRFUART_RX_FIFO_START);
+		temp_delta = (temp_delta > 0) ? temp_delta : -temp_delta;
+		if (temp_delta < min_delta) {
+			ioclk_div = (2 * ioclk_rate /
+				(set_rate * sample_div) + 1) / 2 - 1;
+			if (ioclk_div > SIRF_IOCLK_DIV_MAX)
+				continue;
+			min_delta = temp_delta;
+			*sample_reg = sample_div;
+			if (!temp_delta)
+				break;
+		}
+	}
+	return ioclk_div;
 }
 
 static unsigned int
-sirfsoc_calc_sample_div(unsigned long baud_rate,
-			unsigned long ioclk_rate, unsigned long *setted_baud)
+sirfsoc_uart_calc_sample_div(unsigned long baud_rate,
+			unsigned long ioclk_rate, unsigned long *set_baud)
 {
 	unsigned long min_delta = ~0UL;
 	unsigned short sample_div;
@@ -386,7 +447,7 @@ sirfsoc_calc_sample_div(unsigned long baud_rate,
 			regv = regv & (~SIRF_SAMPLE_DIV_MASK);
 			regv = regv | (sample_div << SIRF_SAMPLE_DIV_SHIFT);
 			min_delta = temp_delta;
-			*setted_baud = baud_tmp;
+			*set_baud = baud_tmp;
 		}
 	}
 	return regv;
@@ -397,63 +458,96 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 				       struct ktermios *old)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long	config_reg = 0;
 	unsigned long	baud_rate;
-	unsigned long	setted_baud;
+	unsigned long	set_baud;
 	unsigned long	flags;
 	unsigned long	ic;
 	unsigned int	clk_div_reg = 0;
-	unsigned long	temp_reg_val;
+	unsigned long	temp_reg_val, ioclk_rate;
 	unsigned long	rx_time_out;
 	int		threshold_div;
 	int		temp;
+	u32		data_bit_len, stop_bit_len, len_val;
+	unsigned long	sample_div_reg = 0xf;
+	ioclk_rate	= port->uartclk;
 
 	switch (termios->c_cflag & CSIZE) {
 	default:
 	case CS8:
+		data_bit_len = 8;
 		config_reg |= SIRFUART_DATA_BIT_LEN_8;
 		break;
 	case CS7:
+		data_bit_len = 7;
 		config_reg |= SIRFUART_DATA_BIT_LEN_7;
 		break;
 	case CS6:
+		data_bit_len = 6;
 		config_reg |= SIRFUART_DATA_BIT_LEN_6;
 		break;
 	case CS5:
+		data_bit_len = 5;
 		config_reg |= SIRFUART_DATA_BIT_LEN_5;
 		break;
 	}
-	if (termios->c_cflag & CSTOPB)
+	if (termios->c_cflag & CSTOPB) {
 		config_reg |= SIRFUART_STOP_BIT_LEN_2;
-	baud_rate = uart_get_baud_rate(port, termios, old, 0, 4000000);
+		stop_bit_len = 2;
+	} else
+		stop_bit_len = 1;
+
 	spin_lock_irqsave(&port->lock, flags);
-	port->read_status_mask = SIRFUART_RX_OFLOW_INT;
+	port->read_status_mask = uint_en->sirfsoc_rx_oflow_en;
 	port->ignore_status_mask = 0;
-	/* read flags */
-	if (termios->c_iflag & INPCK)
-		port->read_status_mask |=
-			SIRFUART_FRM_ERR_INT | SIRFUART_PARITY_ERR_INT;
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
+		if (termios->c_iflag & INPCK)
+			port->read_status_mask |= uint_en->sirfsoc_frm_err_en |
+				uint_en->sirfsoc_parity_err_en;
+	}
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+		if (termios->c_iflag & INPCK)
+			port->read_status_mask |= uint_en->sirfsoc_frm_err_en;
+	}
 	if (termios->c_iflag & (BRKINT | PARMRK))
-		port->read_status_mask |= SIRFUART_RXD_BREAK_INT;
-	/* ignore flags */
-	if (termios->c_iflag & IGNPAR)
+			port->read_status_mask |= uint_en->sirfsoc_rxd_brk_en;
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |=
+				uint_en->sirfsoc_frm_err_en |
+				uint_en->sirfsoc_parity_err_en;
+		if (termios->c_cflag & PARENB) {
+			if (termios->c_cflag & CMSPAR) {
+				if (termios->c_cflag & PARODD)
+					config_reg |= SIRFUART_STICK_BIT_MARK;
+				else
+					config_reg |= SIRFUART_STICK_BIT_SPACE;
+			} else if (termios->c_cflag & PARODD) {
+				config_reg |= SIRFUART_STICK_BIT_ODD;
+			} else {
+				config_reg |= SIRFUART_STICK_BIT_EVEN;
+			}
+		}
+	}
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |=
+				uint_en->sirfsoc_frm_err_en;
+		if (termios->c_cflag & PARENB)
+			dev_warn(port->dev,
+					"USP-UART not support parity err\n");
+	}
+	if (termios->c_iflag & IGNBRK) {
 		port->ignore_status_mask |=
-			SIRFUART_FRM_ERR_INT | SIRFUART_PARITY_ERR_INT;
+			uint_en->sirfsoc_rxd_brk_en;
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |=
+				uint_en->sirfsoc_rx_oflow_en;
+	}
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= SIRFUART_DUMMY_READ;
-	/* enable parity if PARENB is set*/
-	if (termios->c_cflag & PARENB) {
-		if (termios->c_cflag & CMSPAR) {
-			if (termios->c_cflag & PARODD)
-				config_reg |= SIRFUART_STICK_BIT_MARK;
-			else
-				config_reg |= SIRFUART_STICK_BIT_SPACE;
-		} else if (termios->c_cflag & PARODD) {
-			config_reg |= SIRFUART_STICK_BIT_ODD;
-		} else {
-			config_reg |= SIRFUART_STICK_BIT_EVEN;
-		}
-	}
 	/* Hardware Flow Control Settings */
 	if (UART_ENABLE_MS(port, termios->c_cflag)) {
 		if (!sirfport->ms_enabled)
@@ -462,70 +556,107 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 		if (sirfport->ms_enabled)
 			sirfsoc_uart_disable_ms(port);
 	}
-
-	if (port->uartclk == 150000000) {
-		/* common rate: fast calculation */
+	baud_rate = uart_get_baud_rate(port, termios, old, 0, 4000000);
+	if (ioclk_rate == 150000000) {
 		for (ic = 0; ic < SIRF_BAUD_RATE_SUPPORT_NR; ic++)
 			if (baud_rate == baudrate_to_regv[ic].baud_rate)
 				clk_div_reg = baudrate_to_regv[ic].reg_val;
 	}
+	set_baud = baud_rate;
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
+		if (unlikely(clk_div_reg == 0))
+			clk_div_reg = sirfsoc_uart_calc_sample_div(baud_rate,
+					ioclk_rate, &set_baud);
+		wr_regl(port, ureg->sirfsoc_divisor, clk_div_reg);
+	}
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+		clk_div_reg = sirfsoc_usp_calc_sample_div(baud_rate,
+				ioclk_rate, &sample_div_reg);
+		sample_div_reg--;
+		set_baud = ((ioclk_rate / (clk_div_reg+1) - 1) /
+				(sample_div_reg + 1));
+		/* setting usp mode 2 */
+		len_val = ((1 << 0) | (1 << 8));
+		len_val |= ((clk_div_reg & 0x3ff) << 21);
+		wr_regl(port, ureg->sirfsoc_mode2,
+				len_val);
 
-	setted_baud = baud_rate;
-	/* arbitary rate setting */
-	if (unlikely(clk_div_reg == 0))
-		clk_div_reg = sirfsoc_calc_sample_div(baud_rate, port->uartclk,
-								&setted_baud);
-	wr_regl(port, SIRFUART_DIVISOR, clk_div_reg);
-
+	}
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, setted_baud, setted_baud);
-
-	/* set receive timeout */
-	rx_time_out = SIRFSOC_UART_RX_TIMEOUT(baud_rate, 20000);
-	rx_time_out = (rx_time_out > 0xFFFF) ? 0xFFFF : rx_time_out;
-	config_reg |= SIRFUART_RECV_TIMEOUT(rx_time_out);
-	temp_reg_val = rd_regl(port, SIRFUART_TX_FIFO_OP);
-	wr_regl(port, SIRFUART_RX_FIFO_OP, 0);
-	wr_regl(port, SIRFUART_TX_FIFO_OP,
-				temp_reg_val & ~SIRFUART_TX_FIFO_START);
-	wr_regl(port, SIRFUART_TX_DMA_IO_CTRL, SIRFUART_TX_MODE_IO);
-	wr_regl(port, SIRFUART_RX_DMA_IO_CTRL, SIRFUART_RX_MODE_IO);
-	wr_regl(port, SIRFUART_LINE_CTRL, config_reg);
-
+		tty_termios_encode_baud_rate(termios, set_baud, set_baud);
+	/* set receive timeout && data bits len */
+	rx_time_out = SIRFSOC_UART_RX_TIMEOUT(set_baud, 20000);
+	rx_time_out = SIRFUART_RECV_TIMEOUT_VALUE(rx_time_out);
+	temp_reg_val = rd_regl(port, ureg->sirfsoc_tx_fifo_op);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op,
+			(temp_reg_val & ~SIRFUART_FIFO_START));
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
+		config_reg |= SIRFUART_RECV_TIMEOUT(port, rx_time_out);
+		wr_regl(port, ureg->sirfsoc_line_ctrl, config_reg);
+	}
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+		/*tx frame ctrl*/
+		len_val = (data_bit_len - 1) << 0;
+		len_val |= (data_bit_len + 1 + stop_bit_len - 1) << 16;
+		len_val |= ((data_bit_len - 1) << 24);
+		len_val |= (((clk_div_reg & 0xc00) >> 10) << 30);
+		wr_regl(port, ureg->sirfsoc_tx_frame_ctrl, len_val);
+		/*rx frame ctrl*/
+		len_val = (data_bit_len - 1) << 0;
+		len_val |= (data_bit_len + 1 + stop_bit_len - 1) << 8;
+		len_val |= (data_bit_len - 1) << 16;
+		len_val |= (((clk_div_reg & 0xf000) >> 12) << 24);
+		wr_regl(port, ureg->sirfsoc_rx_frame_ctrl, len_val);
+		/*async param*/
+		wr_regl(port, ureg->sirfsoc_async_param_reg,
+			(SIRFUART_RECV_TIMEOUT(port, rx_time_out)) |
+			(sample_div_reg & 0x3f) << 16);
+	}
+	wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, SIRFUART_IO_MODE);
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_IO_MODE);
 	/* Reset Rx/Tx FIFO Threshold level for proper baudrate */
-	if (baud_rate < 1000000)
+	if (set_baud < 1000000)
 		threshold_div = 1;
 	else
 		threshold_div = 2;
-	temp = port->line == 1 ? 16 : 64;
-	wr_regl(port, SIRFUART_TX_FIFO_CTRL, temp / threshold_div);
-	wr_regl(port, SIRFUART_RX_FIFO_CTRL, temp / threshold_div);
-	temp_reg_val |= SIRFUART_TX_FIFO_START;
-	wr_regl(port, SIRFUART_TX_FIFO_OP, temp_reg_val);
-	uart_update_timeout(port, termios->c_cflag, baud_rate);
+	temp = SIRFUART_FIFO_THD(port);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, temp / threshold_div);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl, temp / threshold_div);
+	temp_reg_val |= SIRFUART_FIFO_START;
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op, temp_reg_val);
+	uart_update_timeout(port, termios->c_cflag, set_baud);
 	sirfsoc_uart_start_rx(port);
-	wr_regl(port, SIRFUART_TX_RX_EN, SIRFUART_TX_EN | SIRFUART_RX_EN);
+	wr_regl(port, ureg->sirfsoc_tx_rx_en, SIRFUART_TX_EN | SIRFUART_RX_EN);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void startup_uart_controller(struct uart_port *port)
 {
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	unsigned long temp_regv;
 	int temp;
-	temp_regv = rd_regl(port, SIRFUART_TX_DMA_IO_CTRL);
-	wr_regl(port, SIRFUART_TX_DMA_IO_CTRL, temp_regv | SIRFUART_TX_MODE_IO);
-	temp_regv = rd_regl(port, SIRFUART_RX_DMA_IO_CTRL);
-	wr_regl(port, SIRFUART_RX_DMA_IO_CTRL, temp_regv | SIRFUART_RX_MODE_IO);
-	wr_regl(port, SIRFUART_TX_DMA_IO_LEN, 0);
-	wr_regl(port, SIRFUART_RX_DMA_IO_LEN, 0);
-	wr_regl(port, SIRFUART_TX_RX_EN, SIRFUART_RX_EN | SIRFUART_TX_EN);
-	wr_regl(port, SIRFUART_TX_FIFO_OP, SIRFUART_TX_FIFO_RESET);
-	wr_regl(port, SIRFUART_TX_FIFO_OP, 0);
-	wr_regl(port, SIRFUART_RX_FIFO_OP, SIRFUART_RX_FIFO_RESET);
-	wr_regl(port, SIRFUART_RX_FIFO_OP, 0);
-	temp = port->line == 1 ? 16 : 64;
-	wr_regl(port, SIRFUART_TX_FIFO_CTRL, temp);
-	wr_regl(port, SIRFUART_RX_FIFO_CTRL, temp);
+	temp_regv = rd_regl(port, ureg->sirfsoc_tx_dma_io_ctrl);
+	wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, temp_regv |
+					SIRFUART_IO_MODE);
+	temp_regv = rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl);
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, temp_regv |
+					SIRFUART_IO_MODE);
+	wr_regl(port, ureg->sirfsoc_tx_dma_io_len, 0);
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_len, 0);
+	wr_regl(port, ureg->sirfsoc_tx_rx_en, SIRFUART_RX_EN | SIRFUART_TX_EN);
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
+		wr_regl(port, ureg->sirfsoc_mode1,
+				SIRFSOC_USP_ENDIAN_CTRL_LSBF |
+				SIRFSOC_USP_EN);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_RESET);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op, 0);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
+	temp = SIRFUART_FIFO_THD(port);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, temp);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl, temp);
 }
 
 static int sirfsoc_uart_startup(struct uart_port *port)
@@ -553,9 +684,9 @@ irq_err:
 static void sirfsoc_uart_shutdown(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	if (!sirfport->is_marco)
-		wr_regl(port, SIRFUART_INT_EN, 0);
+		wr_regl(port, ureg->sirfsoc_int_en_reg, 0);
 	else
 		wr_regl(port, SIRFUART_INT_EN_CLR, ~0UL);
 
@@ -573,9 +704,11 @@ static const char *sirfsoc_uart_type(struct uart_port *port)
 
 static int sirfsoc_uart_request_port(struct uart_port *port)
 {
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_uart_param *uart_param = &sirfport->uart_reg->uart_param;
 	void *ret;
 	ret = request_mem_region(port->mapbase,
-				SIRFUART_MAP_SIZE, SIRFUART_PORT_NAME);
+		SIRFUART_MAP_SIZE, uart_param->port_name);
 	return ret ? 0 : -EBUSY;
 }
 
@@ -611,32 +744,42 @@ static struct uart_ops sirfsoc_uart_ops = {
 };
 
 #ifdef CONFIG_SERIAL_SIRFSOC_CONSOLE
-static int __init sirfsoc_uart_console_setup(struct console *co, char *options)
+static int __init
+sirfsoc_uart_console_setup(struct console *co, char *options)
 {
 	unsigned int baud = 115200;
 	unsigned int bits = 8;
 	unsigned int parity = 'n';
 	unsigned int flow = 'n';
 	struct uart_port *port = &sirfsoc_uart_ports[co->index].port;
-
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	if (co->index < 0 || co->index >= SIRFSOC_UART_NR)
 		return -EINVAL;
 
 	if (!port->mapbase)
 		return -ENODEV;
 
+	/* enable usp in mode1 register */
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
+		wr_regl(port, ureg->sirfsoc_mode1, SIRFSOC_USP_EN |
+				SIRFSOC_USP_ENDIAN_CTRL_LSBF);
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	port->cons = co;
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
 static void sirfsoc_uart_console_putchar(struct uart_port *port, int ch)
 {
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_fifo_status *ufifo_st = &sirfport->uart_reg->fifo_status;
 	while (rd_regl(port,
-		SIRFUART_TX_FIFO_STATUS) & SIRFUART_FIFOFULL_MASK(port))
+		ureg->sirfsoc_tx_fifo_status) & ufifo_st->ff_full(port->line))
 		cpu_relax();
-	wr_regb(port, SIRFUART_TX_FIFO_DATA, ch);
+	wr_regb(port, ureg->sirfsoc_tx_fifo_data, ch);
 }
 
 static void sirfsoc_uart_console_write(struct console *co, const char *s,
@@ -678,25 +821,42 @@ static struct uart_driver sirfsoc_uart_drv = {
 #endif
 };
 
+static struct of_device_id sirfsoc_uart_ids[] = {
+	{ .compatible = "sirf,prima2-uart", .data = &sirfsoc_uart,},
+	{ .compatible = "sirf,marco-uart", .data = &sirfsoc_uart},
+	{ .compatible = "sirf,prima2-usp-uart", .data = &sirfsoc_usp},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirfsoc_uart_ids);
+
 int sirfsoc_uart_probe(struct platform_device *pdev)
 {
 	struct sirfsoc_uart_port *sirfport;
 	struct uart_port *port;
 	struct resource *res;
 	int ret;
+	const struct of_device_id *match;
 
+	match = of_match_node(sirfsoc_uart_ids, pdev->dev.of_node);
 	if (of_property_read_u32(pdev->dev.of_node, "cell-index", &pdev->id)) {
 		dev_err(&pdev->dev,
 			"Unable to find cell-index in uart node.\n");
 		ret = -EFAULT;
 		goto err;
 	}
-
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart"))
+		pdev->id += ((struct sirfsoc_uart_register *)
+				match->data)->uart_param.register_uart_nr;
 	sirfport = &sirfsoc_uart_ports[pdev->id];
 	port = &sirfport->port;
 	port->dev = &pdev->dev;
 	port->private_data = sirfport;
+	sirfport->uart_reg = (struct sirfsoc_uart_register *)match->data;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart"))
+		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart"))
+		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
 	if (of_device_is_compatible(pdev->dev.of_node, "sirf,marco-uart"))
 		sirfport->is_marco = true;
 
@@ -735,10 +895,9 @@ int sirfsoc_uart_probe(struct platform_device *pdev)
 
 	if (sirfport->hw_flow_ctrl) {
 		sirfport->p = pinctrl_get_select_default(&pdev->dev);
-		if (IS_ERR(sirfport->p)) {
-			ret = PTR_ERR(sirfport->p);
+		ret = IS_ERR(sirfport->p);
+		if (ret)
 			goto err;
-		}
 	}
 
 	sirfport->clk = clk_get(&pdev->dev, NULL);
@@ -802,13 +961,6 @@ static int sirfsoc_uart_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id sirfsoc_uart_ids[] = {
-	{ .compatible = "sirf,prima2-uart", },
-	{ .compatible = "sirf,marco-uart", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, sirfsoc_uart_ids);
-
 static struct platform_driver sirfsoc_uart_driver = {
 	.probe		= sirfsoc_uart_probe,
 	.remove		= sirfsoc_uart_remove,
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 6216660..6f6d275 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -6,32 +6,260 @@
  * Licensed under GPLv2 or later.
  */
 #include <linux/bitops.h>
+struct sirfsoc_uart_param {
+	const char *uart_name;
+	const char *port_name;
+	u32 uart_nr;
+	u32 register_uart_nr;
+};
+
+struct sirfsoc_register {
+	/* hardware uart specific */
+	u32 sirfsoc_line_ctrl;
+	u32 sirfsoc_divisor;
+	/* uart - usp common */
+	u32 sirfsoc_tx_rx_en;
+	u32 sirfsoc_int_en_reg;
+	u32 sirfsoc_int_st_reg;
+	u32 sirfsoc_tx_dma_io_ctrl;
+	u32 sirfsoc_tx_dma_io_len;
+	u32 sirfsoc_tx_fifo_ctrl;
+	u32 sirfsoc_tx_fifo_level_chk;
+	u32 sirfsoc_tx_fifo_op;
+	u32 sirfsoc_tx_fifo_status;
+	u32 sirfsoc_tx_fifo_data;
+	u32 sirfsoc_rx_dma_io_ctrl;
+	u32 sirfsoc_rx_dma_io_len;
+	u32 sirfsoc_rx_fifo_ctrl;
+	u32 sirfsoc_rx_fifo_level_chk;
+	u32 sirfsoc_rx_fifo_op;
+	u32 sirfsoc_rx_fifo_status;
+	u32 sirfsoc_rx_fifo_data;
+	u32 sirfsoc_afc_ctrl;
+	u32 sirfsoc_swh_dma_io;
+	/* hardware usp specific */
+	u32 sirfsoc_mode1;
+	u32 sirfsoc_mode2;
+	u32 sirfsoc_tx_frame_ctrl;
+	u32 sirfsoc_rx_frame_ctrl;
+	u32 sirfsoc_async_param_reg;
+};
+
+typedef u32 (*fifo_full_mask)(int line);
+typedef u32 (*fifo_empty_mask)(int line);
+
+struct sirfsoc_fifo_status {
+	fifo_full_mask ff_full;
+	fifo_empty_mask ff_empty;
+};
+
+struct sirfsoc_int_en {
+	u32 sirfsoc_rx_done_en;
+	u32 sirfsoc_tx_done_en;
+	u32 sirfsoc_rx_oflow_en;
+	u32 sirfsoc_tx_allout_en;
+	u32 sirfsoc_rx_io_dma_en;
+	u32 sirfsoc_tx_io_dma_en;
+	u32 sirfsoc_rxfifo_full_en;
+	u32 sirfsoc_txfifo_empty_en;
+	u32 sirfsoc_rxfifo_thd_en;
+	u32 sirfsoc_txfifo_thd_en;
+	u32 sirfsoc_frm_err_en;
+	u32 sirfsoc_rxd_brk_en;
+	u32 sirfsoc_rx_timeout_en;
+	u32 sirfsoc_parity_err_en;
+	u32 sirfsoc_cts_en;
+	u32 sirfsoc_rts_en;
+};
+
+struct sirfsoc_int_status {
+	u32 sirfsoc_rx_done;
+	u32 sirfsoc_tx_done;
+	u32 sirfsoc_rx_oflow;
+	u32 sirfsoc_tx_allout;
+	u32 sirfsoc_rx_io_dma;
+	u32 sirfsoc_tx_io_dma;
+	u32 sirfsoc_rxfifo_full;
+	u32 sirfsoc_txfifo_empty;
+	u32 sirfsoc_rxfifo_thd;
+	u32 sirfsoc_txfifo_thd;
+	u32 sirfsoc_frm_err;
+	u32 sirfsoc_rxd_brk;
+	u32 sirfsoc_rx_timeout;
+	u32 sirfsoc_parity_err;
+	u32 sirfsoc_cts;
+	u32 sirfsoc_rts;
+};
+
+enum sirfsoc_uart_type {
+	SIRF_REAL_UART,
+	SIRF_USP_UART,
+};
+
+struct sirfsoc_uart_register {
+	struct sirfsoc_register uart_reg;
+	struct sirfsoc_int_en uart_int_en;
+	struct sirfsoc_int_status uart_int_st;
+	struct sirfsoc_fifo_status fifo_status;
+	struct sirfsoc_uart_param uart_param;
+	enum sirfsoc_uart_type uart_type;
+};
 
-/* UART Register Offset Define */
-#define SIRFUART_LINE_CTRL			0x0040
-#define SIRFUART_TX_RX_EN			0x004c
-#define SIRFUART_DIVISOR			0x0050
-#define SIRFUART_INT_EN				0x0054
-#define SIRFUART_INT_STATUS			0x0058
-#define SIRFUART_INT_EN_CLR			0x0060
-#define SIRFUART_TX_DMA_IO_CTRL			0x0100
-#define SIRFUART_TX_DMA_IO_LEN			0x0104
-#define SIRFUART_TX_FIFO_CTRL			0x0108
-#define SIRFUART_TX_FIFO_LEVEL_CHK		0x010C
-#define SIRFUART_TX_FIFO_OP			0x0110
-#define SIRFUART_TX_FIFO_STATUS			0x0114
-#define SIRFUART_TX_FIFO_DATA			0x0118
-#define SIRFUART_RX_DMA_IO_CTRL			0x0120
-#define SIRFUART_RX_DMA_IO_LEN			0x0124
-#define SIRFUART_RX_FIFO_CTRL			0x0128
-#define SIRFUART_RX_FIFO_LEVEL_CHK		0x012C
-#define SIRFUART_RX_FIFO_OP			0x0130
-#define SIRFUART_RX_FIFO_STATUS			0x0134
-#define SIRFUART_RX_FIFO_DATA			0x0138
-#define SIRFUART_AFC_CTRL			0x0140
-#define SIRFUART_SWH_DMA_IO			0x0148
-
-/* UART Line Control Register */
+u32 usp_ff_full(int line)
+{
+	return 0x80;
+}
+u32 usp_ff_empty(int line)
+{
+	return 0x100;
+}
+u32 uart_ff_full(int line)
+{
+	return (line == 1) ? (0x20) : (0x80);
+}
+u32 uart_ff_empty(int line)
+{
+	return (line == 1) ? (0x40) : (0x100);
+}
+struct sirfsoc_uart_register sirfsoc_usp = {
+	.uart_reg = {
+		.sirfsoc_mode1		= 0x0000,
+		.sirfsoc_mode2		= 0x0004,
+		.sirfsoc_tx_frame_ctrl	= 0x0008,
+		.sirfsoc_rx_frame_ctrl	= 0x000c,
+		.sirfsoc_tx_rx_en	= 0x0010,
+		.sirfsoc_int_en_reg	= 0x0014,
+		.sirfsoc_int_st_reg	= 0x0018,
+		.sirfsoc_async_param_reg = 0x0024,
+		.sirfsoc_tx_dma_io_ctrl	= 0x0100,
+		.sirfsoc_tx_dma_io_len	= 0x0104,
+		.sirfsoc_tx_fifo_ctrl	= 0x0108,
+		.sirfsoc_tx_fifo_level_chk = 0x010c,
+		.sirfsoc_tx_fifo_op	= 0x0110,
+		.sirfsoc_tx_fifo_status	= 0x0114,
+		.sirfsoc_tx_fifo_data	= 0x0118,
+		.sirfsoc_rx_dma_io_ctrl	= 0x0120,
+		.sirfsoc_rx_dma_io_len	= 0x0124,
+		.sirfsoc_rx_fifo_ctrl	= 0x0128,
+		.sirfsoc_rx_fifo_level_chk = 0x012c,
+		.sirfsoc_rx_fifo_op	= 0x0130,
+		.sirfsoc_rx_fifo_status	= 0x0134,
+		.sirfsoc_rx_fifo_data	= 0x0138,
+	},
+	.uart_int_en = {
+		.sirfsoc_rx_done_en	= BIT(0),
+		.sirfsoc_tx_done_en	= BIT(1),
+		.sirfsoc_rx_oflow_en	= BIT(2),
+		.sirfsoc_tx_allout_en	= BIT(3),
+		.sirfsoc_rx_io_dma_en	= BIT(4),
+		.sirfsoc_tx_io_dma_en	= BIT(5),
+		.sirfsoc_rxfifo_full_en	= BIT(6),
+		.sirfsoc_txfifo_empty_en = BIT(7),
+		.sirfsoc_rxfifo_thd_en	= BIT(8),
+		.sirfsoc_txfifo_thd_en	= BIT(9),
+		.sirfsoc_frm_err_en	= BIT(10),
+		.sirfsoc_rx_timeout_en	= BIT(11),
+		.sirfsoc_rxd_brk_en	= BIT(15),
+	},
+	.uart_int_st = {
+		.sirfsoc_rx_done	= BIT(0),
+		.sirfsoc_tx_done	= BIT(1),
+		.sirfsoc_rx_oflow	= BIT(2),
+		.sirfsoc_tx_allout	= BIT(3),
+		.sirfsoc_rx_io_dma	= BIT(4),
+		.sirfsoc_tx_io_dma	= BIT(5),
+		.sirfsoc_rxfifo_full	= BIT(6),
+		.sirfsoc_txfifo_empty	= BIT(7),
+		.sirfsoc_rxfifo_thd	= BIT(8),
+		.sirfsoc_txfifo_thd	= BIT(9),
+		.sirfsoc_frm_err	= BIT(10),
+		.sirfsoc_rx_timeout	= BIT(11),
+		.sirfsoc_rxd_brk	= BIT(15),
+	},
+	.fifo_status = {
+		.ff_full		= usp_ff_full,
+		.ff_empty		= usp_ff_empty,
+	},
+	.uart_param = {
+		.uart_name = "ttySiRF",
+		.port_name = "sirfsoc-uart",
+		.uart_nr = 2,
+		.register_uart_nr = 3,
+	},
+};
+
+struct sirfsoc_uart_register sirfsoc_uart = {
+	.uart_reg = {
+		.sirfsoc_line_ctrl	= 0x0040,
+		.sirfsoc_tx_rx_en	= 0x004c,
+		.sirfsoc_divisor	= 0x0050,
+		.sirfsoc_int_en_reg	= 0x0054,
+		.sirfsoc_int_st_reg	= 0x0058,
+		.sirfsoc_tx_dma_io_ctrl	= 0x0100,
+		.sirfsoc_tx_dma_io_len	= 0x0104,
+		.sirfsoc_tx_fifo_ctrl	= 0x0108,
+		.sirfsoc_tx_fifo_level_chk = 0x010c,
+		.sirfsoc_tx_fifo_op	= 0x0110,
+		.sirfsoc_tx_fifo_status	= 0x0114,
+		.sirfsoc_tx_fifo_data	= 0x0118,
+		.sirfsoc_rx_dma_io_ctrl	= 0x0120,
+		.sirfsoc_rx_dma_io_len	= 0x0124,
+		.sirfsoc_rx_fifo_ctrl	= 0x0128,
+		.sirfsoc_rx_fifo_level_chk = 0x012c,
+		.sirfsoc_rx_fifo_op	= 0x0130,
+		.sirfsoc_rx_fifo_status	= 0x0134,
+		.sirfsoc_rx_fifo_data	= 0x0138,
+		.sirfsoc_afc_ctrl	= 0x0140,
+		.sirfsoc_swh_dma_io	= 0x0148,
+	},
+	.uart_int_en = {
+		.sirfsoc_rx_done_en	= BIT(0),
+		.sirfsoc_tx_done_en	= BIT(1),
+		.sirfsoc_rx_oflow_en	= BIT(2),
+		.sirfsoc_tx_allout_en	= BIT(3),
+		.sirfsoc_rx_io_dma_en	= BIT(4),
+		.sirfsoc_tx_io_dma_en	= BIT(5),
+		.sirfsoc_rxfifo_full_en	= BIT(6),
+		.sirfsoc_txfifo_empty_en = BIT(7),
+		.sirfsoc_rxfifo_thd_en	= BIT(8),
+		.sirfsoc_txfifo_thd_en	= BIT(9),
+		.sirfsoc_frm_err_en	= BIT(10),
+		.sirfsoc_rxd_brk_en	= BIT(11),
+		.sirfsoc_rx_timeout_en	= BIT(12),
+		.sirfsoc_parity_err_en	= BIT(13),
+		.sirfsoc_cts_en		= BIT(14),
+		.sirfsoc_rts_en		= BIT(15),
+	},
+	.uart_int_st = {
+		.sirfsoc_rx_done	= BIT(0),
+		.sirfsoc_tx_done	= BIT(1),
+		.sirfsoc_rx_oflow	= BIT(2),
+		.sirfsoc_tx_allout	= BIT(3),
+		.sirfsoc_rx_io_dma	= BIT(4),
+		.sirfsoc_tx_io_dma	= BIT(5),
+		.sirfsoc_rxfifo_full	= BIT(6),
+		.sirfsoc_txfifo_empty	= BIT(7),
+		.sirfsoc_rxfifo_thd	= BIT(8),
+		.sirfsoc_txfifo_thd	= BIT(9),
+		.sirfsoc_frm_err	= BIT(10),
+		.sirfsoc_rxd_brk	= BIT(11),
+		.sirfsoc_rx_timeout	= BIT(12),
+		.sirfsoc_parity_err	= BIT(13),
+		.sirfsoc_cts		= BIT(14),
+		.sirfsoc_rts		= BIT(15),
+	},
+	.fifo_status = {
+		.ff_full		= uart_ff_full,
+		.ff_empty		= uart_ff_empty,
+	},
+	.uart_param = {
+		.uart_name = "ttySiRF",
+		.port_name = "sirfsoc_uart",
+		.uart_nr = 3,
+		.register_uart_nr = 0,
+	},
+};
+/* uart io ctrl */
 #define SIRFUART_DATA_BIT_LEN_MASK		0x3
 #define SIRFUART_DATA_BIT_LEN_5			BIT(0)
 #define SIRFUART_DATA_BIT_LEN_6			1
@@ -51,89 +279,65 @@
 #define SIRFUART_LOOP_BACK			BIT(7)
 #define SIRFUART_PARITY_MASK			(7 << 3)
 #define SIRFUART_DUMMY_READ			BIT(16)
-
-#define SIRFSOC_UART_RX_TIMEOUT(br, to)	(((br) * (((to) + 999) / 1000)) / 1000)
-#define SIRFUART_RECV_TIMEOUT_MASK	(0xFFFF << 16)
-#define SIRFUART_RECV_TIMEOUT(x)	(((x) & 0xFFFF) << 16)
-
-/* UART Auto Flow Control */
-#define SIRFUART_AFC_RX_THD_MASK		0x000000FF
+#define SIRFUART_AFC_CTRL_RX_THD		0x70
 #define SIRFUART_AFC_RX_EN			BIT(8)
 #define SIRFUART_AFC_TX_EN			BIT(9)
-#define SIRFUART_CTS_CTRL			BIT(10)
-#define SIRFUART_RTS_CTRL			BIT(11)
-#define SIRFUART_CTS_IN_STATUS			BIT(12)
-#define SIRFUART_RTS_OUT_STATUS			BIT(13)
-
-/* UART Interrupt Enable Register */
-#define SIRFUART_RX_DONE_INT			BIT(0)
-#define SIRFUART_TX_DONE_INT			BIT(1)
-#define SIRFUART_RX_OFLOW_INT			BIT(2)
-#define SIRFUART_TX_ALLOUT_INT			BIT(3)
-#define SIRFUART_RX_IO_DMA_INT			BIT(4)
-#define SIRFUART_TX_IO_DMA_INT			BIT(5)
-#define SIRFUART_RXFIFO_FULL_INT		BIT(6)
-#define SIRFUART_TXFIFO_EMPTY_INT		BIT(7)
-#define SIRFUART_RXFIFO_THD_INT			BIT(8)
-#define SIRFUART_TXFIFO_THD_INT			BIT(9)
-#define SIRFUART_FRM_ERR_INT			BIT(10)
-#define SIRFUART_RXD_BREAK_INT			BIT(11)
-#define SIRFUART_RX_TIMEOUT_INT			BIT(12)
-#define SIRFUART_PARITY_ERR_INT			BIT(13)
-#define SIRFUART_CTS_INT_EN			BIT(14)
-#define SIRFUART_RTS_INT_EN			BIT(15)
-
-/* UART Interrupt Status Register */
-#define SIRFUART_RX_DONE			BIT(0)
-#define SIRFUART_TX_DONE			BIT(1)
-#define SIRFUART_RX_OFLOW			BIT(2)
-#define SIRFUART_TX_ALL_EMPTY			BIT(3)
-#define SIRFUART_DMA_IO_RX_DONE			BIT(4)
-#define SIRFUART_DMA_IO_TX_DONE			BIT(5)
-#define SIRFUART_RXFIFO_FULL			BIT(6)
-#define SIRFUART_TXFIFO_EMPTY			BIT(7)
-#define SIRFUART_RXFIFO_THD_REACH		BIT(8)
-#define SIRFUART_TXFIFO_THD_REACH		BIT(9)
-#define SIRFUART_FRM_ERR			BIT(10)
-#define SIRFUART_RXD_BREAK			BIT(11)
-#define SIRFUART_RX_TIMEOUT			BIT(12)
-#define SIRFUART_PARITY_ERR			BIT(13)
-#define SIRFUART_CTS_CHANGE			BIT(14)
-#define SIRFUART_RTS_CHANGE			BIT(15)
-#define SIRFUART_PLUG_IN			BIT(16)
-
-#define SIRFUART_ERR_INT_STAT					\
-				(SIRFUART_RX_OFLOW |		\
-				SIRFUART_FRM_ERR |		\
-				SIRFUART_RXD_BREAK |		\
-				SIRFUART_PARITY_ERR)
-#define SIRFUART_ERR_INT_EN					\
-				(SIRFUART_RX_OFLOW_INT |	\
-				SIRFUART_FRM_ERR_INT |		\
-				SIRFUART_RXD_BREAK_INT |	\
-				SIRFUART_PARITY_ERR_INT)
-#define SIRFUART_TX_INT_EN	SIRFUART_TXFIFO_EMPTY_INT
-#define SIRFUART_RX_IO_INT_EN					\
-				(SIRFUART_RX_TIMEOUT_INT |	\
-				SIRFUART_RXFIFO_THD_INT |	\
-				SIRFUART_RXFIFO_FULL_INT |	\
-				SIRFUART_ERR_INT_EN)
-
+#define SIRFUART_AFC_CTS_CTRL			BIT(10)
+#define SIRFUART_AFC_RTS_CTRL			BIT(11)
+#define	SIRFUART_AFC_CTS_STATUS			BIT(12)
+#define	SIRFUART_AFC_RTS_STATUS			BIT(13)
 /* UART FIFO Register */
-#define SIRFUART_TX_FIFO_STOP			0x0
-#define SIRFUART_TX_FIFO_RESET			0x1
-#define SIRFUART_TX_FIFO_START			0x2
-#define SIRFUART_RX_FIFO_STOP			0x0
-#define SIRFUART_RX_FIFO_RESET			0x1
-#define SIRFUART_RX_FIFO_START			0x2
-#define SIRFUART_TX_MODE_DMA			0
-#define SIRFUART_TX_MODE_IO			1
-#define SIRFUART_RX_MODE_DMA			0
-#define SIRFUART_RX_MODE_IO			1
-
-#define SIRFUART_RX_EN				0x1
-#define SIRFUART_TX_EN				0x2
+#define SIRFUART_FIFO_STOP			0x0
+#define SIRFUART_FIFO_RESET			BIT(0)
+#define SIRFUART_FIFO_START			BIT(1)
+
+#define SIRFUART_RX_EN				BIT(0)
+#define SIRFUART_TX_EN				BIT(1)
+
+#define SIRFUART_IO_MODE			BIT(0)
+#define SIRFUART_DMA_MODE			0x0
+
+/* Macro Specific*/
+#define SIRFUART_INT_EN_CLR                    0x0060
+/* Baud Rate Calculation */
+#define SIRF_MIN_SAMPLE_DIV			0xf
+#define SIRF_MAX_SAMPLE_DIV			0x3f
+#define SIRF_IOCLK_DIV_MAX			0xffff
+#define SIRF_SAMPLE_DIV_SHIFT			16
+#define SIRF_IOCLK_DIV_MASK			0xffff
+#define SIRF_SAMPLE_DIV_MASK			0x3f0000
+#define SIRF_BAUD_RATE_SUPPORT_NR		18
+
+/* USP SPEC */
+#define SIRFSOC_USP_ENDIAN_CTRL_LSBF		BIT(4)
+#define SIRFSOC_USP_EN				BIT(5)
+
+/* USP-UART Common */
+#define SIRFSOC_UART_RX_TIMEOUT(br, to)	(((br) * (((to) + 999) / 1000)) / 1000)
+#define SIRFUART_RECV_TIMEOUT_VALUE(x)	\
+				(((x) > 0xFFFF) ? 0xFFFF : ((x) & 0xFFFF))
+#define SIRFUART_RECV_TIMEOUT(port, x)	\
+		(((port)->line > 2) ? (x & 0xFFFF) : ((x) & 0xFFFF) << 16)
 
+#define SIRFUART_FIFO_THD(port)		((port->line) == 1 ? 16 : 64)
+#define SIRFUART_ERR_INT_STAT(port, unit_st)			\
+				(uint_st->sirfsoc_rx_oflow |		\
+				uint_st->sirfsoc_frm_err |		\
+				uint_st->sirfsoc_rxd_brk |		\
+		((port->line > 2) ? 0 : uint_st->sirfsoc_parity_err))
+#define SIRFUART_RX_IO_INT_EN(port, uint_en)				\
+				(uint_en->sirfsoc_rx_timeout_en |\
+				 uint_en->sirfsoc_rxfifo_thd_en |\
+				 uint_en->sirfsoc_rxfifo_full_en |\
+				 uint_en->sirfsoc_frm_err_en |\
+				 uint_en->sirfsoc_rx_oflow_en |\
+				 uint_en->sirfsoc_rxd_brk_en |\
+		((port->line > 2) ? 0 : uint_en->sirfsoc_parity_err_en))
+#define SIRFUART_RX_IO_INT_ST(uint_st)				\
+				(uint_st->sirfsoc_rx_timeout |\
+				 uint_st->sirfsoc_rxfifo_thd |\
+				 uint_st->sirfsoc_rxfifo_full)
+#define SIRFUART_CTS_INT_ST(uint_st)	(uint_st->sirfsoc_cts)
 /* Generic Definitions */
 #define SIRFSOC_UART_NAME			"ttySiRF"
 #define SIRFSOC_UART_MAJOR			0
@@ -167,6 +371,7 @@ struct sirfsoc_uart_port {
 	struct clk			*clk;
 	/* for SiRFmarco, there are SET/CLR for UART_INT_EN */
 	bool				is_marco;
+	struct sirfsoc_uart_register	*uart_reg;
 };
 
 /* Hardware Flow Control */
-- 
1.8.2.3

