From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v3] tty: serial: qcom_geni_serial: Fix softlock
Date: Thu, 29 Nov 2018 18:18:40 -0800
Message-ID: <20181130021840.75861-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

Transfers were being divided into device FIFO sized (64 byte max)
operations which would poll for completion within a spin_lock_irqsave /
spin_unlock_irqrestore block. This both made things slow by waiting for
the FIFO to completely drain before adding further data and would also
result in softlocks on large transmissions.

This patch allows larger transfers with continuous FIFO additions as
space becomes available and removes polling from the interrupt handler.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

Changes in v3:
- Reworded comment for clarity
- Fixed mips compiler warning

Changes in v2:
- Addressed nits raised by Stephen

 drivers/tty/serial/qcom_geni_serial.c | 56 +++++++++++++++++++--------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ded51081add..bbc7d7a5b8b6 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -117,6 +117,8 @@ struct qcom_geni_serial_port {
 	u32 *rx_fifo;
 	u32 loopback;
 	bool brk;
+
+	unsigned int tx_remaining;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -439,6 +441,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	struct qcom_geni_serial_port *port;
 	bool locked = true;
 	unsigned long flags;
+	u32 geni_status;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -452,6 +455,8 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	else
 		spin_lock_irqsave(&uport->lock, flags);
 
+	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+
 	/* Cancel the current write to log the fault */
 	if (!locked) {
 		geni_se_cancel_m_cmd(&port->se);
@@ -465,9 +470,19 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		}
 		writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
+	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
+		/*
+		 * It seems we can't interrupt existing transfers if all data
+		 * has been sent, in which case we need to look for done first.
+		 */
+		qcom_geni_serial_poll_tx_done(uport);
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);
+
+	if (port->tx_remaining)
+		qcom_geni_serial_setup_tx(uport, port->tx_remaining);
+
 	if (locked)
 		spin_unlock_irqrestore(&uport->lock, flags);
 }
@@ -701,40 +716,45 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 	port->handle_rx(uport, total_bytes, drop);
 }
 
-static void qcom_geni_serial_handle_tx(struct uart_port *uport)
+static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
+		bool active)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
 	size_t remaining;
+	size_t pending;
 	int i;
 	u32 status;
 	unsigned int chunk;
 	int tail;
-	u32 irq_en;
 
-	chunk = uart_circ_chars_pending(xmit);
 	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
-	/* Both FIFO and framework buffer are drained */
-	if (!chunk && !status) {
+
+	/* Complete the current tx command before taking newly added data */
+	if (active)
+		pending = port->tx_remaining;
+	else
+		pending = uart_circ_chars_pending(xmit);
+
+	/* All data has been transmitted and acknowledged as received */
+	if (!pending && !status && done) {
 		qcom_geni_serial_stop_tx(uport);
 		goto out_write_wakeup;
 	}
 
-	if (!uart_console(uport)) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
-		irq_en &= ~(M_TX_FIFO_WATERMARK_EN);
-		writel_relaxed(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
-		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	}
+	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
+	avail *= port->tx_bytes_pw;
 
-	avail = (port->tx_fifo_depth - port->tx_wm) * port->tx_bytes_pw;
 	tail = xmit->tail;
-	chunk = min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail), avail);
+	chunk = min3(avail, pending, (size_t)(UART_XMIT_SIZE - tail));
 	if (!chunk)
 		goto out_write_wakeup;
 
-	qcom_geni_serial_setup_tx(uport, chunk);
+	if (!port->tx_remaining) {
+		qcom_geni_serial_setup_tx(uport, pending);
+		port->tx_remaining = pending;
+	}
 
 	remaining = chunk;
 	for (i = 0; i < chunk; ) {
@@ -753,11 +773,10 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport)
 		tail += tx_bytes;
 		uport->icount.tx += tx_bytes;
 		remaining -= tx_bytes;
+		port->tx_remaining -= tx_bytes;
 	}
 
 	xmit->tail = tail & (UART_XMIT_SIZE - 1);
-	if (uart_console(uport))
-		qcom_geni_serial_poll_tx_done(uport);
 out_write_wakeup:
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(uport);
@@ -767,6 +786,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 {
 	unsigned int m_irq_status;
 	unsigned int s_irq_status;
+	unsigned int geni_status;
 	struct uart_port *uport = dev;
 	unsigned long flags;
 	unsigned int m_irq_en;
@@ -780,6 +800,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	spin_lock_irqsave(&uport->lock, flags);
 	m_irq_status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
 	s_irq_status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
+	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
 	m_irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
 	writel_relaxed(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	writel_relaxed(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
@@ -794,7 +815,8 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 
 	if (m_irq_status & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN) &&
 	    m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
-		qcom_geni_serial_handle_tx(uport);
+		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
+					geni_status & M_GENI_CMD_ACTIVE);
 
 	if (s_irq_status & S_GP_IRQ_0_EN || s_irq_status & S_GP_IRQ_1_EN) {
 		if (s_irq_status & S_GP_IRQ_0_EN)
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
