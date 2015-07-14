From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/2] serial: sirf: let uart's receive start in right place
Date: Tue, 14 Jul 2015 00:52:23 +0000
Message-ID: <1436835143-6697-2-git-send-email-21cnbao@gmail.com>
References: <1436835143-6697-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1436835143-6697-1-git-send-email-21cnbao@gmail.com>
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

While UART work in DMA mode, function start_rx will request descriptor
from DMA engine, if there is no left descriptor UART, driver will give
err logs "DMA slave single fail".

currently start_rx is called in set_termios function, so everytime, port
setting will call start_rx once.

Now put start_rx in startup, it will be called once while open the port.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 46 ++++++++++++++-------------------------
 drivers/tty/serial/sirfsoc_uart.h |  1 -
 2 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 8cac7ac..c6657de 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -413,7 +413,6 @@ sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int max_rx_count)
 			break;
 	}
 
-	sirfport->rx_io_count += rx_count;
 	port->icount.rx += rx_count;
 
 	return rx_count;
@@ -600,7 +599,6 @@ static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	sirfport->rx_io_count = 0;
 	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
 		rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) &
 		~SIRFUART_IO_MODE);
@@ -632,31 +630,6 @@ static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
 				sirfport->uart_reg->uart_type));
 }
 
-static void sirfsoc_uart_start_rx(struct uart_port *port)
-{
-	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
-	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-
-	sirfport->rx_io_count = 0;
-	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
-	if (sirfport->rx_dma_chan)
-		sirfsoc_uart_start_next_rx_dma(port);
-	else {
-		if (!sirfport->is_atlas7)
-			wr_regl(port, ureg->sirfsoc_int_en_reg,
-				rd_regl(port, ureg->sirfsoc_int_en_reg) |
-				SIRFUART_RX_IO_INT_EN(uint_en,
-					sirfport->uart_reg->uart_type));
-		else
-			wr_regl(port, ureg->sirfsoc_int_en_reg,
-				SIRFUART_RX_IO_INT_EN(uint_en,
-					sirfport->uart_reg->uart_type));
-	}
-}
-
 static unsigned int
 sirfsoc_usp_calc_sample_div(unsigned long set_rate,
 		unsigned long ioclk_rate, unsigned long *sample_reg)
@@ -850,7 +823,6 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	rx_time_out = SIRFSOC_UART_RX_TIMEOUT(set_baud, 20000);
 	rx_time_out = SIRFUART_RECV_TIMEOUT_VALUE(rx_time_out);
 	txfifo_op_reg = rd_regl(port, ureg->sirfsoc_tx_fifo_op);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_STOP);
 	wr_regl(port, ureg->sirfsoc_tx_fifo_op,
 			(txfifo_op_reg & ~SIRFUART_FIFO_START));
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
@@ -906,7 +878,6 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	txfifo_op_reg |= SIRFUART_FIFO_START;
 	wr_regl(port, ureg->sirfsoc_tx_fifo_op, txfifo_op_reg);
 	uart_update_timeout(port, termios->c_cflag, set_baud);
-	sirfsoc_uart_start_rx(port);
 	wr_regl(port, ureg->sirfsoc_tx_rx_en, SIRFUART_TX_EN | SIRFUART_RX_EN);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -925,6 +896,7 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport	= to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned int index			= port->line;
 	int ret;
 	irq_modify_status(port->irq, IRQ_NOREQUEST, IRQ_NOAUTOEN);
@@ -994,7 +966,6 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
 			rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) |
 			SIRFSOC_USP_FRADDR_CLR_EN);
-	enable_irq(port->irq);
 	if (sirfport->rx_dma_chan && !sirfport->is_hrt_enabled) {
 		sirfport->is_hrt_enabled = true;
 		sirfport->rx_period_time = 20000000;
@@ -1006,6 +977,21 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 			ns_to_ktime(sirfport->rx_period_time),
 			HRTIMER_MODE_REL);
 	}
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
+	if (sirfport->rx_dma_chan)
+		sirfsoc_uart_start_next_rx_dma(port);
+	else {
+		if (!sirfport->is_atlas7)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg) |
+				SIRFUART_RX_IO_INT_EN(uint_en,
+					sirfport->uart_reg->uart_type));
+		else
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+				SIRFUART_RX_IO_INT_EN(uint_en,
+					sirfport->uart_reg->uart_type));
+	}
+	enable_irq(port->irq);
 
 	return 0;
 init_rx_err:
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 671a08d..c3a885b 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -423,7 +423,6 @@ struct sirfsoc_uart_port {
 	struct dma_chan			*tx_dma_chan;
 	dma_addr_t			tx_dma_addr;
 	struct dma_async_tx_descriptor	*tx_dma_desc;
-	unsigned int			rx_io_count;
 	unsigned long			transfer_size;
 	enum sirfsoc_tx_state		tx_dma_state;
 	unsigned int			cts_gpio;
-- 
2.3.5
