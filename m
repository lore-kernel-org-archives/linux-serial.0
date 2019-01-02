From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH 3/4] tty: serial: qcom_geni_serial: Remove xfer_mode variable
Date: Wed,  2 Jan 2019 13:36:35 -0800
Message-ID: <20190102213636.40866-4-ryandcase@chromium.org>
References: <20190102213636.40866-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102213636.40866-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

The driver only supports FIFO mode so setting and checking this variable
is unnecessary. If DMA support is ever addedd then such checks can be
introduced.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 66 ++++++++++-----------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 5521ed4a0708..3103aa0adc86 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -105,7 +105,6 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_depth;
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
-	enum geni_se_xfer_mode xfer_mode;
 	bool setup;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
@@ -555,29 +554,20 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 static void qcom_geni_serial_start_tx(struct uart_port *uport)
 {
 	u32 irq_en;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	u32 status;
 
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		/*
-		 * readl ensures reading & writing of IRQ_EN register
-		 * is not re-ordered before checking the status of the
-		 * Serial Engine.
-		 */
-		status = readl(uport->membase + SE_GENI_STATUS);
-		if (status & M_GENI_CMD_ACTIVE)
-			return;
+	status = readl(uport->membase + SE_GENI_STATUS);
+	if (status & M_GENI_CMD_ACTIVE)
+		return;
 
-		if (!qcom_geni_serial_tx_empty(uport))
-			return;
+	if (!qcom_geni_serial_tx_empty(uport))
+		return;
 
-		irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
-		irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
+	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
+	irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-		writel(DEF_TX_WM, uport->membase +
-						SE_GENI_TX_WATERMARK_REG);
-		writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
-	}
+	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
 
 static void qcom_geni_serial_stop_tx(struct uart_port *uport)
@@ -588,11 +578,8 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~M_CMD_DONE_EN;
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en &= ~M_TX_FIFO_WATERMARK_EN;
-		writel(0, uport->membase +
-				     SE_GENI_TX_WATERMARK_REG);
-	}
+	irq_en &= ~M_TX_FIFO_WATERMARK_EN;
+	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
@@ -623,15 +610,13 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 
 	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
 
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
-		irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
-		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
+	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-		irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
-		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	}
+	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
+	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
 static void qcom_geni_serial_stop_rx(struct uart_port *uport)
@@ -641,15 +626,13 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	u32 irq_clear = S_CMD_DONE_EN;
 
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
-		irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
-		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
+	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-		irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
-		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	}
+	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
+	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 
 	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop rx is called multiple times. */
@@ -892,7 +875,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	 * Make an unconditional cancel on the main sequencer to reset
 	 * it else we could end up in data loss scenarios.
 	 */
-	port->xfer_mode = GENI_SE_FIFO;
 	if (uart_console(uport))
 		qcom_geni_serial_poll_tx_done(uport);
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->tx_bytes_pw,
@@ -900,7 +882,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->rx_bytes_pw,
 						false, false, true);
 	geni_se_init(&port->se, UART_CONSOLE_RX_WM, port->rx_fifo_depth - 2);
-	geni_se_select_mode(&port->se, port->xfer_mode);
+	geni_se_select_mode(&port->se, GENI_SE_FIFO);
 	if (!uart_console(uport)) {
 		port->rx_fifo = devm_kcalloc(uport->dev,
 			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
-- 
2.20.1.415.g653613c723-goog
