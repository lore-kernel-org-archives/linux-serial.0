From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2 1/4] tty: serial: qcom_geni_serial: Remove use of *_relaxed() and mb()
Date: Mon,  7 Jan 2019 17:58:35 -0800
Message-ID: <20190108015838.166271-2-ryandcase@chromium.org>
References: <20190108015838.166271-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108015838.166271-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

A frequent side comment has been to remove the use of writel_relaxed,
readl_relaxed, and mb. This reduces driver complexity and the _relaxed
variants were not known to provide any noticeable performance benefit.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Expanded commit message
- Coalesced lines where possible

 drivers/tty/serial/qcom_geni_serial.c | 191 +++++++++++---------------
 1 file changed, 80 insertions(+), 111 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2b1e73193dad..e2cb3f7d1a7c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -230,7 +230,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 	if (uart_console(uport) || !uart_cts_enabled(uport)) {
 		mctrl |= TIOCM_CTS;
 	} else {
-		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
+		geni_ios = readl(uport->membase + SE_GENI_IOS);
 		if (!(geni_ios & IO2_DATA_IN))
 			mctrl |= TIOCM_CTS;
 	}
@@ -248,7 +248,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 
 	if (!(mctrl & TIOCM_RTS))
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
-	writel_relaxed(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
+	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
 }
 
 static const char *qcom_geni_serial_get_type(struct uart_port *uport)
@@ -277,9 +277,6 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	unsigned int fifo_bits;
 	unsigned long timeout_us = 20000;
 
-	/* Ensure polling is not re-ordered before the prior writes/reads */
-	mb();
-
 	if (uport->private_data) {
 		port = to_dev_port(uport, uport);
 		baud = port->baud;
@@ -299,7 +296,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	 */
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
-		reg = readl_relaxed(uport->membase + offset);
+		reg = readl(uport->membase + offset);
 		if ((bool)(reg & field) == set)
 			return true;
 		udelay(10);
@@ -312,7 +309,7 @@ static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 {
 	u32 m_cmd;
 
-	writel_relaxed(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
+	writel(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
 	m_cmd = UART_START_TX << M_OPCODE_SHFT;
 	writel(m_cmd, uport->membase + SE_GENI_M_CMD0);
 }
@@ -325,13 +322,13 @@ static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
 	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_DONE_EN, true);
 	if (!done) {
-		writel_relaxed(M_GENI_CMD_ABORT, uport->membase +
+		writel(M_GENI_CMD_ABORT, uport->membase +
 						SE_GENI_M_CMD_CTRL_REG);
 		irq_clear |= M_CMD_ABORT_EN;
 		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 							M_CMD_ABORT_EN, true);
 	}
-	writel_relaxed(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_abort_rx(struct uart_port *uport)
@@ -341,8 +338,8 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
 	writel(S_GENI_CMD_ABORT, uport->membase + SE_GENI_S_CMD_CTRL_REG);
 	qcom_geni_serial_poll_bit(uport, SE_GENI_S_CMD_CTRL_REG,
 					S_GENI_CMD_ABORT, false);
-	writel_relaxed(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
-	writel_relaxed(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
+	writel(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	writel(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -351,19 +348,13 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 	u32 rx_fifo;
 	u32 status;
 
-	status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
-	writel_relaxed(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
-
-	status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
-	writel_relaxed(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
+	writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 
-	/*
-	 * Ensure the writes to clear interrupts is not re-ordered after
-	 * reading the data.
-	 */
-	mb();
+	status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
 
-	status = readl_relaxed(uport->membase + SE_GENI_RX_FIFO_STATUS);
+	status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
 	if (!(status & RX_FIFO_WC_MSK))
 		return NO_POLL_CHAR;
 
@@ -376,13 +367,12 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	writel_relaxed(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, 1);
 	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_TX_FIFO_WATERMARK_EN, true));
-	writel_relaxed(c, uport->membase + SE_GENI_TX_FIFOn);
-	writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
-							SE_GENI_M_IRQ_CLEAR);
+	writel(c, uport->membase + SE_GENI_TX_FIFOn);
+	writel(M_TX_FIFO_WATERMARK_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_poll_tx_done(uport);
 }
 #endif
@@ -390,7 +380,7 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
 static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
 {
-	writel_relaxed(ch, uport->membase + SE_GENI_TX_FIFOn);
+	writel(ch, uport->membase + SE_GENI_TX_FIFOn);
 }
 
 static void
@@ -409,7 +399,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 			bytes_to_send++;
 	}
 
-	writel_relaxed(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, bytes_to_send);
 	for (i = 0; i < count; ) {
 		size_t chars_to_write = 0;
@@ -427,7 +417,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 		chars_to_write = min_t(size_t, count - i, avail / 2);
 		uart_console_write(uport, s + i, chars_to_write,
 						qcom_geni_serial_wr_char);
-		writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
+		writel(M_TX_FIFO_WATERMARK_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
 		i += chars_to_write;
 	}
@@ -456,7 +446,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	else
 		spin_lock_irqsave(&uport->lock, flags);
 
-	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	geni_status = readl(uport->membase + SE_GENI_STATUS);
 
 	/* Cancel the current write to log the fault */
 	if (!locked) {
@@ -466,11 +456,10 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 			geni_se_abort_m_cmd(&port->se);
 			qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 							M_CMD_ABORT_EN, true);
-			writel_relaxed(M_CMD_ABORT_EN, uport->membase +
+			writel(M_CMD_ABORT_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
 		}
-		writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
-							SE_GENI_M_IRQ_CLEAR);
+		writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
 		/*
 		 * It seems we can't interrupt existing transfers if all data
@@ -479,9 +468,8 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		qcom_geni_serial_poll_tx_done(uport);
 
 		if (uart_circ_chars_pending(&uport->state->xmit)) {
-			irq_en = readl_relaxed(uport->membase +
-					SE_GENI_M_IRQ_EN);
-			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+			irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
 					uport->membase + SE_GENI_M_IRQ_EN);
 		}
 	}
@@ -585,12 +573,12 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
 		if (!qcom_geni_serial_tx_empty(uport))
 			return;
 
-		irq_en = readl_relaxed(uport->membase +	SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 		irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-		writel_relaxed(port->tx_wm, uport->membase +
+		writel(port->tx_wm, uport->membase +
 						SE_GENI_TX_WATERMARK_REG);
-		writel_relaxed(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
+		writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 	}
 }
 
@@ -600,35 +588,28 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~M_CMD_DONE_EN;
 	if (port->xfer_mode == GENI_SE_FIFO) {
 		irq_en &= ~M_TX_FIFO_WATERMARK_EN;
-		writel_relaxed(0, uport->membase +
+		writel(0, uport->membase +
 				     SE_GENI_TX_WATERMARK_REG);
 	}
-	writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
 	if (!(status & M_GENI_CMD_ACTIVE))
 		return;
 
-	/*
-	 * Ensure cancel command write is not re-ordered before checking
-	 * the status of the Primary Sequencer.
-	 */
-	mb();
-
 	geni_se_cancel_m_cmd(&port->se);
 	if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_CANCEL_EN, true)) {
 		geni_se_abort_m_cmd(&port->se);
 		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_ABORT_EN, true);
-		writel_relaxed(M_CMD_ABORT_EN, uport->membase +
-							SE_GENI_M_IRQ_CLEAR);
+		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
-	writel_relaxed(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_start_rx(struct uart_port *uport)
@@ -637,26 +618,20 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	status = readl(uport->membase + SE_GENI_STATUS);
 	if (status & S_GENI_CMD_ACTIVE)
 		qcom_geni_serial_stop_rx(uport);
 
-	/*
-	 * Ensure setup command write is not re-ordered before checking
-	 * the status of the Secondary Sequencer.
-	 */
-	mb();
-
 	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
 
 	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_S_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
 		irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
-		writel_relaxed(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
-		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	}
 }
 
@@ -668,31 +643,25 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 	u32 irq_clear = S_CMD_DONE_EN;
 
 	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_S_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
 		irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
-		writel_relaxed(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
-		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop rx is called multiple times. */
 	if (!(status & S_GENI_CMD_ACTIVE))
 		return;
 
-	/*
-	 * Ensure cancel command write is not re-ordered before checking
-	 * the status of the Secondary Sequencer.
-	 */
-	mb();
-
 	geni_se_cancel_s_cmd(&port->se);
 	qcom_geni_serial_poll_bit(uport, SE_GENI_S_CMD_CTRL_REG,
 					S_GENI_CMD_CANCEL, false);
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
-	writel_relaxed(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	status = readl(uport->membase + SE_GENI_STATUS);
+	writel(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
 	if (status & S_GENI_CMD_ACTIVE)
 		qcom_geni_serial_abort_rx(uport);
 }
@@ -706,7 +675,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 	u32 total_bytes;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	status = readl_relaxed(uport->membase +	SE_GENI_RX_FIFO_STATUS);
+	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
 	word_cnt = status & RX_FIFO_WC_MSK;
 	last_word_partial = status & RX_LAST;
 	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
@@ -736,7 +705,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	unsigned int chunk;
 	int tail;
 
-	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
+	status = readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 
 	/* Complete the current tx command before taking newly added data */
 	if (active)
@@ -762,9 +731,9 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
 
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
-			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
@@ -797,14 +766,14 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	 * cleared it in qcom_geni_serial_isr it will have already reasserted
 	 * so we must clear it again here after our writes.
 	 */
-	writel_relaxed(M_TX_FIFO_WATERMARK_EN,
+	writel(M_TX_FIFO_WATERMARK_EN,
 			uport->membase + SE_GENI_M_IRQ_CLEAR);
 
 out_write_wakeup:
 	if (!port->tx_remaining) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		if (irq_en & M_TX_FIFO_WATERMARK_EN)
-			writel_relaxed(irq_en & ~M_TX_FIFO_WATERMARK_EN,
+			writel(irq_en & ~M_TX_FIFO_WATERMARK_EN,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
@@ -828,12 +797,12 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		return IRQ_NONE;
 
 	spin_lock_irqsave(&uport->lock, flags);
-	m_irq_status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
-	s_irq_status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
-	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
-	m_irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
-	writel_relaxed(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
-	writel_relaxed(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
+	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	geni_status = readl(uport->membase + SE_GENI_STATUS);
+	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
 
 	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
 		goto out_unlock;
@@ -931,7 +900,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	get_tx_fifo_size(port);
 
 	set_rfr_wm(port);
-	writel_relaxed(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
+	writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
 	/*
 	 * Make an unconditional cancel on the main sequencer to reset
 	 * it else we could end up in data loss scenarios.
@@ -1035,10 +1004,10 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
 	/* parity */
-	tx_trans_cfg = readl_relaxed(uport->membase + SE_UART_TX_TRANS_CFG);
-	tx_parity_cfg = readl_relaxed(uport->membase + SE_UART_TX_PARITY_CFG);
-	rx_trans_cfg = readl_relaxed(uport->membase + SE_UART_RX_TRANS_CFG);
-	rx_parity_cfg = readl_relaxed(uport->membase + SE_UART_RX_PARITY_CFG);
+	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
+	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
+	rx_trans_cfg = readl(uport->membase + SE_UART_RX_TRANS_CFG);
+	rx_parity_cfg = readl(uport->membase + SE_UART_RX_PARITY_CFG);
 	if (termios->c_cflag & PARENB) {
 		tx_trans_cfg |= UART_TX_PAR_EN;
 		rx_trans_cfg |= UART_RX_PAR_EN;
@@ -1094,17 +1063,17 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		uart_update_timeout(uport, termios->c_cflag, baud);
 
 	if (!uart_console(uport))
-		writel_relaxed(port->loopback,
+		writel(port->loopback,
 				uport->membase + SE_UART_LOOPBACK_CFG);
-	writel_relaxed(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
-	writel_relaxed(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
-	writel_relaxed(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
-	writel_relaxed(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
-	writel_relaxed(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
-	writel_relaxed(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
-	writel_relaxed(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
+	writel(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
+	writel(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
+	writel(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
+	writel(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
+	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
+	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
+	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+	writel(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
+	writel(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
 out_restart_rx:
 	qcom_geni_serial_start_rx(uport);
 }
@@ -1195,13 +1164,13 @@ static int __init qcom_geni_serial_earlycon_setup(struct earlycon_device *dev,
 	geni_se_init(&se, DEF_FIFO_DEPTH_WORDS / 2, DEF_FIFO_DEPTH_WORDS - 2);
 	geni_se_select_mode(&se, GENI_SE_FIFO);
 
-	writel_relaxed(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
-	writel_relaxed(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
-	writel_relaxed(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
-	writel_relaxed(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
-	writel_relaxed(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+	writel(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
+	writel(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
+	writel(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
+	writel(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
+	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
+	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
+	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
 
 	dev->con->write = qcom_geni_serial_earlycon_write;
 	dev->con->setup = NULL;
-- 
2.20.1.97.g81188d93c3-goog
