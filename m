From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Remove interrupt storm
Date: Tue, 11 Dec 2018 16:35:22 -0800
Message-ID: <20181212003522.239189-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

Disable M_TX_FIFO_WATERMARK_EN after we've sent all data for a given
transaction so we don't continue to receive a flurry of free space
interrupts while waiting for the M_CMD_DONE notification. Re-enable the
watermark when establishing the next transaction.

Also clear the watermark interrupt after filling the FIFO so we do not
receive notification again prior to actually having free space.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6e38498362ef..965aefa54114 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -724,10 +724,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	size_t pending;
 	int i;
 	u32 status;
+	u32 irq_en;
 	unsigned int chunk;
 	int tail;
 
 	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
+	irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
 
 	/* Complete the current tx command before taking newly added data */
 	if (active)
@@ -752,6 +754,9 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	if (!port->tx_remaining) {
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
+
+		irq_en |= M_TX_FIFO_WATERMARK_EN;
+		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
 	remaining = chunk;
@@ -775,7 +780,15 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	}
 
 	xmit->tail = tail & (UART_XMIT_SIZE - 1);
+	writel_relaxed(M_TX_FIFO_WATERMARK_EN,
+			uport->membase + SE_GENI_M_IRQ_CLEAR);
+
 out_write_wakeup:
+	if (!port->tx_remaining) {
+		irq_en &= ~M_TX_FIFO_WATERMARK_EN;
+		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+	}
+
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(uport);
 }
@@ -811,8 +824,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
 	}
 
-	if (m_irq_status & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN) &&
-	    m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
+	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
 		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
 					geni_status & M_GENI_CMD_ACTIVE);
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog
