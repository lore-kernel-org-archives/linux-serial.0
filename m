From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/6] serial: sirf: enable ATLAS7 USP serial support
Date: Thu, 14 May 2015 06:45:21 +0000
Message-ID: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

differentiate difference port types by re-defining the status MARCO
or putting HW differences into private data of the related ports.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 129 ++++++++++++++++++++++++++++----------
 drivers/tty/serial/sirfsoc_uart.h |  33 +++++-----
 2 files changed, 115 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 7214abe..1d0d47f 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -138,16 +138,19 @@ static void sirfsoc_uart_stop_tx(struct uart_port *port)
 				rd_regl(port, ureg->sirfsoc_int_en_reg) &
 				~uint_en->sirfsoc_txfifo_empty_en);
 			else
-				wr_regl(port, SIRFUART_INT_EN_CLR,
+				wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
 				uint_en->sirfsoc_txfifo_empty_en);
 		}
 	} else {
+		if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
+			wr_regl(port, ureg->sirfsoc_tx_rx_en, rd_regl(port,
+				ureg->sirfsoc_tx_rx_en) & ~SIRFUART_TX_EN);
 		if (!sirfport->is_atlas7)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
 				rd_regl(port, ureg->sirfsoc_int_en_reg) &
 				~uint_en->sirfsoc_txfifo_empty_en);
 		else
-			wr_regl(port, SIRFUART_INT_EN_CLR,
+			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
 				uint_en->sirfsoc_txfifo_empty_en);
 	}
 }
@@ -178,7 +181,7 @@ static void sirfsoc_uart_tx_with_dma(struct sirfsoc_uart_port *sirfport)
 				rd_regl(port, ureg->sirfsoc_int_en_reg)&
 				~(uint_en->sirfsoc_txfifo_empty_en));
 	else
-		wr_regl(port, SIRFUART_INT_EN_CLR,
+		wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
 				uint_en->sirfsoc_txfifo_empty_en);
 	/*
 	 * DMA requires buffer address and buffer length are both aligned with
@@ -246,6 +249,9 @@ static void sirfsoc_uart_start_tx(struct uart_port *port)
 	if (sirfport->tx_dma_chan)
 		sirfsoc_uart_tx_with_dma(sirfport);
 	else {
+		if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
+			wr_regl(port, ureg->sirfsoc_tx_rx_en, rd_regl(port,
+				ureg->sirfsoc_tx_rx_en) | SIRFUART_TX_EN);
 		sirfsoc_uart_pio_tx_chars(sirfport, port->fifosize);
 		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
 		if (!sirfport->is_atlas7)
@@ -269,21 +275,25 @@ static void sirfsoc_uart_stop_rx(struct uart_port *port)
 		if (!sirfport->is_atlas7)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
 				rd_regl(port, ureg->sirfsoc_int_en_reg) &
-				~(SIRFUART_RX_DMA_INT_EN(port, uint_en) |
+				~(SIRFUART_RX_DMA_INT_EN(uint_en,
+				sirfport->uart_reg->uart_type) |
 				uint_en->sirfsoc_rx_done_en));
 		else
-			wr_regl(port, SIRFUART_INT_EN_CLR,
-					SIRFUART_RX_DMA_INT_EN(port, uint_en)|
-					uint_en->sirfsoc_rx_done_en);
+			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
+				SIRFUART_RX_DMA_INT_EN(uint_en,
+				sirfport->uart_reg->uart_type)|
+				uint_en->sirfsoc_rx_done_en);
 		dmaengine_terminate_all(sirfport->rx_dma_chan);
 	} else {
 		if (!sirfport->is_atlas7)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
 				rd_regl(port, ureg->sirfsoc_int_en_reg)&
-				~(SIRFUART_RX_IO_INT_EN(port, uint_en)));
+				~(SIRFUART_RX_IO_INT_EN(uint_en,
+				sirfport->uart_reg->uart_type)));
 		else
-			wr_regl(port, SIRFUART_INT_EN_CLR,
-					SIRFUART_RX_IO_INT_EN(port, uint_en));
+			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
+				SIRFUART_RX_IO_INT_EN(uint_en,
+				sirfport->uart_reg->uart_type));
 	}
 }
 
@@ -304,7 +314,7 @@ static void sirfsoc_uart_disable_ms(struct uart_port *port)
 					rd_regl(port, ureg->sirfsoc_int_en_reg)&
 					~uint_en->sirfsoc_cts_en);
 		else
-			wr_regl(port, SIRFUART_INT_EN_CLR,
+			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
 					uint_en->sirfsoc_cts_en);
 	} else
 		disable_irq(gpio_to_irq(sirfport->cts_gpio));
@@ -455,7 +465,7 @@ static void sirfsoc_rx_submit_one_dma_desc(struct uart_port *port, int index)
 		dmaengine_prep_slave_single(sirfport->rx_dma_chan,
 		sirfport->rx_dma_items[index].dma_addr, SIRFSOC_RX_DMA_BUF_SIZE,
 		DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
-	if (!sirfport->rx_dma_items[index].desc) {
+	if (IS_ERR_OR_NULL(sirfport->rx_dma_items[index].desc)) {
 		dev_err(port->dev, "DMA slave single fail\n");
 		return;
 	}
@@ -475,12 +485,13 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	struct sirfsoc_int_status *uint_st = &sirfport->uart_reg->uart_int_st;
 	unsigned int count;
-	unsigned long flags;
 	struct dma_tx_state tx_state;
+	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
-		sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
+		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
+		&tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
 		sirfport->rx_completed++;
@@ -504,7 +515,7 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
 				rd_regl(port, ureg->sirfsoc_int_en_reg) &
 				~(uint_en->sirfsoc_rx_done_en));
 		else
-			wr_regl(port, SIRFUART_INT_EN_CLR,
+			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
 					uint_en->sirfsoc_rx_done_en);
 		sirfsoc_uart_start_next_rx_dma(port);
 	} else {
@@ -538,7 +549,7 @@ static void sirfsoc_uart_handle_rx_tmo(struct sirfsoc_uart_port *sirfport)
 			rd_regl(port, ureg->sirfsoc_int_en_reg) &
 			~(uint_en->sirfsoc_rx_timeout_en));
 	else
-		wr_regl(port, SIRFUART_INT_EN_CLR,
+		wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
 				uint_en->sirfsoc_rx_timeout_en);
 	tasklet_schedule(&sirfport->rx_tmo_process_tasklet);
 }
@@ -558,7 +569,7 @@ static void sirfsoc_uart_handle_rx_done(struct sirfsoc_uart_port *sirfport)
 				rd_regl(port, ureg->sirfsoc_int_en_reg) &
 				~(uint_en->sirfsoc_rx_done_en));
 		else
-			wr_regl(port, SIRFUART_INT_EN_CLR,
+			wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
 					uint_en->sirfsoc_rx_done_en);
 		wr_regl(port, ureg->sirfsoc_int_st_reg,
 				uint_st->sirfsoc_rx_timeout);
@@ -583,7 +594,8 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 	intr_status = rd_regl(port, ureg->sirfsoc_int_st_reg);
 	wr_regl(port, ureg->sirfsoc_int_st_reg, intr_status);
 	intr_status &= rd_regl(port, ureg->sirfsoc_int_en_reg);
-	if (unlikely(intr_status & (SIRFUART_ERR_INT_STAT(port, uint_st)))) {
+	if (unlikely(intr_status & (SIRFUART_ERR_INT_STAT(uint_st,
+				sirfport->uart_reg->uart_type)))) {
 		if (intr_status & uint_st->sirfsoc_rxd_brk) {
 			port->icount.brk++;
 			if (uart_handle_break(port))
@@ -622,9 +634,50 @@ recv_char:
 			sirfsoc_uart_handle_rx_tmo(sirfport);
 		if (intr_status & uint_st->sirfsoc_rx_done)
 			sirfsoc_uart_handle_rx_done(sirfport);
-	} else {
-		if (intr_status & SIRFUART_RX_IO_INT_ST(uint_st))
+	} else if (intr_status & SIRFUART_RX_IO_INT_ST(uint_st)) {
+		/*
+		 * chip will trigger continuous RX_TIMEOUT interrupt
+		 * in RXFIFO empty and not trigger if RXFIFO recevice
+		 * data in limit time, original method use RX_TIMEOUT
+		 * will trigger lots of useless interrupt in RXFIFO
+		 * empty.RXFIFO received one byte will trigger RX_DONE
+		 * interrupt.use RX_DONE to wait for data received
+		 * into RXFIFO, use RX_THD/RX_FULL for lots data receive
+		 * and use RX_TIMEOUT for the last left data.
+		 */
+		if (intr_status & uint_st->sirfsoc_rx_done) {
+			if (!sirfport->is_atlas7) {
+				wr_regl(port, ureg->sirfsoc_int_en_reg,
+					rd_regl(port, ureg->sirfsoc_int_en_reg)
+					& ~(uint_en->sirfsoc_rx_done_en));
+				wr_regl(port, ureg->sirfsoc_int_en_reg,
+				rd_regl(port, ureg->sirfsoc_int_en_reg)
+				| (uint_en->sirfsoc_rx_timeout_en));
+			} else {
+				wr_regl(port, ureg->sirfsoc_int_en_clr_reg,
+					uint_en->sirfsoc_rx_done_en);
+				wr_regl(port, ureg->sirfsoc_int_en_reg,
+					uint_en->sirfsoc_rx_timeout_en);
+			}
+		} else {
+			if (intr_status & uint_st->sirfsoc_rx_timeout) {
+				if (!sirfport->is_atlas7) {
+					wr_regl(port, ureg->sirfsoc_int_en_reg,
+					rd_regl(port, ureg->sirfsoc_int_en_reg)
+					& ~(uint_en->sirfsoc_rx_timeout_en));
+					wr_regl(port, ureg->sirfsoc_int_en_reg,
+					rd_regl(port, ureg->sirfsoc_int_en_reg)
+					| (uint_en->sirfsoc_rx_done_en));
+				} else {
+					wr_regl(port,
+						ureg->sirfsoc_int_en_clr_reg,
+						uint_en->sirfsoc_rx_timeout_en);
+					wr_regl(port, ureg->sirfsoc_int_en_reg,
+						uint_en->sirfsoc_rx_done_en);
+				}
+			}
 			sirfsoc_uart_pio_rx_chars(port, port->fifosize);
+		}
 	}
 	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&state->port);
@@ -657,11 +710,12 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 	struct uart_port *port = &sirfport->port;
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	unsigned long flags;
 	struct dma_tx_state tx_state;
+	unsigned long flags;
 	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
-			sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
+		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
+		&tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
 		if (rd_regl(port, ureg->sirfsoc_int_en_reg) &
@@ -705,10 +759,12 @@ static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
 	if (!sirfport->is_atlas7)
 		wr_regl(port, ureg->sirfsoc_int_en_reg,
 				rd_regl(port, ureg->sirfsoc_int_en_reg) |
-				SIRFUART_RX_DMA_INT_EN(port, uint_en));
+				SIRFUART_RX_DMA_INT_EN(uint_en,
+				sirfport->uart_reg->uart_type));
 	else
 		wr_regl(port, ureg->sirfsoc_int_en_reg,
-			SIRFUART_RX_DMA_INT_EN(port, uint_en));
+				SIRFUART_RX_DMA_INT_EN(uint_en,
+				sirfport->uart_reg->uart_type));
 }
 
 static void sirfsoc_uart_start_rx(struct uart_port *port)
@@ -727,10 +783,12 @@ static void sirfsoc_uart_start_rx(struct uart_port *port)
 		if (!sirfport->is_atlas7)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
 				rd_regl(port, ureg->sirfsoc_int_en_reg) |
-				SIRFUART_RX_IO_INT_EN(port, uint_en));
+				SIRFUART_RX_IO_INT_EN(uint_en,
+					sirfport->uart_reg->uart_type));
 		else
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
-				SIRFUART_RX_IO_INT_EN(port, uint_en));
+				SIRFUART_RX_IO_INT_EN(uint_en,
+					sirfport->uart_reg->uart_type));
 	}
 }
 
@@ -930,7 +988,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	wr_regl(port, ureg->sirfsoc_tx_fifo_op,
 			(txfifo_op_reg & ~SIRFUART_FIFO_START));
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
-		config_reg |= SIRFUART_RECV_TIMEOUT(port, rx_time_out);
+		config_reg |= SIRFUART_UART_RECV_TIMEOUT(rx_time_out);
 		wr_regl(port, ureg->sirfsoc_line_ctrl, config_reg);
 	} else {
 		/*tx frame ctrl*/
@@ -953,7 +1011,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 		wr_regl(port, ureg->sirfsoc_rx_frame_ctrl, len_val);
 		/*async param*/
 		wr_regl(port, ureg->sirfsoc_async_param_reg,
-			(SIRFUART_RECV_TIMEOUT(port, rx_time_out)) |
+			(SIRFUART_USP_RECV_TIMEOUT(rx_time_out)) |
 			(sample_div_reg & SIRFSOC_USP_ASYNC_DIV2_MASK) <<
 			SIRFSOC_USP_ASYNC_DIV2_OFFSET);
 	}
@@ -1071,7 +1129,7 @@ static void sirfsoc_uart_shutdown(struct uart_port *port)
 	if (!sirfport->is_atlas7)
 		wr_regl(port, ureg->sirfsoc_int_en_reg, 0);
 	else
-		wr_regl(port, SIRFUART_INT_EN_CLR, ~0UL);
+		wr_regl(port, ureg->sirfsoc_int_en_clr_reg, ~0UL);
 
 	free_irq(port->irq, sirfport);
 	if (sirfport->ms_enabled)
@@ -1217,10 +1275,11 @@ static struct uart_driver sirfsoc_uart_drv = {
 #endif
 };
 
-static const struct of_device_id sirfsoc_uart_ids[] = {
+static struct of_device_id sirfsoc_uart_ids[] = {
 	{ .compatible = "sirf,prima2-uart", .data = &sirfsoc_uart,},
 	{ .compatible = "sirf,atlas7-uart", .data = &sirfsoc_uart},
 	{ .compatible = "sirf,prima2-usp-uart", .data = &sirfsoc_usp},
+	{ .compatible = "sirf,atlas7-usp-uart", .data = &sirfsoc_usp},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sirfsoc_uart_ids);
@@ -1257,9 +1316,12 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 
 	sirfport->hw_flow_ctrl = of_property_read_bool(pdev->dev.of_node,
 		"sirf,uart-has-rtscts");
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart"))
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart") ||
+		of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart")) {
+	if (of_device_is_compatible(pdev->dev.of_node,
+		"sirf,prima2-usp-uart") || of_device_is_compatible(
+		pdev->dev.of_node, "sirf,atlas7-usp-uart")) {
 		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
 		if (!sirfport->hw_flow_ctrl)
 			goto usp_no_flow_control;
@@ -1297,7 +1359,8 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		gpio_direction_output(sirfport->rts_gpio, 1);
 	}
 usp_no_flow_control:
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-uart"))
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-uart") ||
+	    of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-usp-uart"))
 		sirfport->is_atlas7 = true;
 
 	if (of_property_read_u32(pdev->dev.of_node,
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index af2f187..b49c23a 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -20,6 +20,7 @@ struct sirfsoc_register {
 	u32 sirfsoc_tx_rx_en;
 	u32 sirfsoc_int_en_reg;
 	u32 sirfsoc_int_st_reg;
+	u32 sirfsoc_int_en_clr_reg;
 	u32 sirfsoc_tx_dma_io_ctrl;
 	u32 sirfsoc_tx_dma_io_len;
 	u32 sirfsoc_tx_fifo_ctrl;
@@ -143,6 +144,7 @@ struct sirfsoc_uart_register sirfsoc_usp = {
 		.sirfsoc_rx_fifo_op	= 0x0130,
 		.sirfsoc_rx_fifo_status	= 0x0134,
 		.sirfsoc_rx_fifo_data	= 0x0138,
+		.sirfsoc_int_en_clr_reg = 0x140,
 	},
 	.uart_int_en = {
 		.sirfsoc_rx_done_en	= BIT(0),
@@ -191,6 +193,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 		.sirfsoc_divisor	= 0x0050,
 		.sirfsoc_int_en_reg	= 0x0054,
 		.sirfsoc_int_st_reg	= 0x0058,
+		.sirfsoc_int_en_clr_reg	= 0x0060,
 		.sirfsoc_tx_dma_io_ctrl	= 0x0100,
 		.sirfsoc_tx_dma_io_len	= 0x0104,
 		.sirfsoc_tx_fifo_ctrl	= 0x0108,
@@ -291,8 +294,6 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFUART_IO_MODE			BIT(0)
 #define SIRFUART_DMA_MODE			0x0
 
-/* Macro Specific*/
-#define SIRFUART_INT_EN_CLR                    0x0060
 /* Baud Rate Calculation */
 #define SIRF_USP_MIN_SAMPLE_DIV			0x1
 #define SIRF_MIN_SAMPLE_DIV			0xf
@@ -326,34 +327,38 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFSOC_UART_RX_TIMEOUT(br, to)	(((br) * (((to) + 999) / 1000)) / 1000)
 #define SIRFUART_RECV_TIMEOUT_VALUE(x)	\
 				(((x) > 0xFFFF) ? 0xFFFF : ((x) & 0xFFFF))
-#define SIRFUART_RECV_TIMEOUT(port, x)	\
-		(((port)->line > 2) ? (x & 0xFFFF) : ((x) & 0xFFFF) << 16)
+#define SIRFUART_USP_RECV_TIMEOUT(x)	(x & 0xFFFF)
+#define SIRFUART_UART_RECV_TIMEOUT(x)	((x & 0xFFFF) << 16)
 
 #define SIRFUART_FIFO_THD(port)		(port->fifosize >> 1)
-#define SIRFUART_ERR_INT_STAT(port, unit_st)			\
+#define SIRFUART_ERR_INT_STAT(unit_st, uart_type)			\
 				(uint_st->sirfsoc_rx_oflow |		\
 				uint_st->sirfsoc_frm_err |		\
 				uint_st->sirfsoc_rxd_brk |		\
-		((port->line > 2) ? 0 : uint_st->sirfsoc_parity_err))
-#define SIRFUART_RX_IO_INT_EN(port, uint_en)				\
-				(uint_en->sirfsoc_rx_timeout_en |\
+				((uart_type != SIRF_REAL_UART) ? \
+				 0 : uint_st->sirfsoc_parity_err))
+#define SIRFUART_RX_IO_INT_EN(uint_en, uart_type)			\
+				(uint_en->sirfsoc_rx_done_en |\
 				 uint_en->sirfsoc_rxfifo_thd_en |\
 				 uint_en->sirfsoc_rxfifo_full_en |\
 				 uint_en->sirfsoc_frm_err_en |\
 				 uint_en->sirfsoc_rx_oflow_en |\
 				 uint_en->sirfsoc_rxd_brk_en |\
-		((port->line > 2) ? 0 : uint_en->sirfsoc_parity_err_en))
+				((uart_type != SIRF_REAL_UART) ? \
+				 0 : uint_en->sirfsoc_parity_err_en))
 #define SIRFUART_RX_IO_INT_ST(uint_st)				\
-				(uint_st->sirfsoc_rx_timeout |\
-				 uint_st->sirfsoc_rxfifo_thd |\
-				 uint_st->sirfsoc_rxfifo_full)
+				(uint_st->sirfsoc_rxfifo_thd |\
+				 uint_st->sirfsoc_rxfifo_full|\
+				 uint_st->sirfsoc_rx_done |\
+				 uint_st->sirfsoc_rx_timeout)
 #define SIRFUART_CTS_INT_ST(uint_st)	(uint_st->sirfsoc_cts)
-#define SIRFUART_RX_DMA_INT_EN(port, uint_en)				\
+#define SIRFUART_RX_DMA_INT_EN(uint_en, uart_type)		\
 				(uint_en->sirfsoc_rx_timeout_en |\
 				 uint_en->sirfsoc_frm_err_en |\
 				 uint_en->sirfsoc_rx_oflow_en |\
 				 uint_en->sirfsoc_rxd_brk_en |\
-		((port->line > 2) ? 0 : uint_en->sirfsoc_parity_err_en))
+				((uart_type != SIRF_REAL_UART) ? \
+				 0 : uint_en->sirfsoc_parity_err_en))
 /* Generic Definitions */
 #define SIRFSOC_UART_NAME			"ttySiRF"
 #define SIRFSOC_UART_MAJOR			0
-- 
2.3.5
