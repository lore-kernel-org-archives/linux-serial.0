From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/2] serial: sirf: use uart_port's fifosize for fifo related
 operation
Date: Wed, 29 Apr 2015 06:45:09 +0000
Message-ID: <1430289909-28396-2-git-send-email-21cnbao@gmail.com>
References: <1430289909-28396-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1430289909-28396-1-git-send-email-21cnbao@gmail.com>
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

In SiRF platform, there are different fifo size of uart and usp,
with the fifosize configuration changes in different chips, we
can not use port line to decide how to check FIFO full,empty and
level.

There is a direct mapping between FIFO HW register layout with
fifo size, so move to use fifosize as the input to check fifo
status.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 24 ++++++++----------
 drivers/tty/serial/sirfsoc_uart.h | 53 +++++++++++++++++----------------------
 2 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index e033b93..7214abe 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -73,8 +73,7 @@ static inline unsigned int sirfsoc_uart_tx_empty(struct uart_port *port)
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_fifo_status *ufifo_st = &sirfport->uart_reg->fifo_status;
 	reg = rd_regl(port, ureg->sirfsoc_tx_fifo_status);
-
-	return (reg & ufifo_st->ff_empty(port->line)) ? TIOCSER_TEMT : 0;
+	return (reg & ufifo_st->ff_empty(port)) ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int sirfsoc_uart_get_mctrl(struct uart_port *port)
@@ -247,8 +246,7 @@ static void sirfsoc_uart_start_tx(struct uart_port *port)
 	if (sirfport->tx_dma_chan)
 		sirfsoc_uart_tx_with_dma(sirfport);
 	else {
-		sirfsoc_uart_pio_tx_chars(sirfport,
-			SIRFSOC_UART_IO_TX_REASONABLE_CNT);
+		sirfsoc_uart_pio_tx_chars(sirfport, port->fifosize);
 		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
 		if (!sirfport->is_atlas7)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
@@ -374,7 +372,7 @@ sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int max_rx_count)
 	if (!tty)
 		return -ENODEV;
 	while (!(rd_regl(port, ureg->sirfsoc_rx_fifo_status) &
-					ufifo_st->ff_empty(port->line))) {
+					ufifo_st->ff_empty(port))) {
 		ch = rd_regl(port, ureg->sirfsoc_rx_fifo_data) |
 			SIRFUART_DUMMY_READ;
 		if (unlikely(uart_handle_sysrq_char(port, ch)))
@@ -401,7 +399,7 @@ sirfsoc_uart_pio_tx_chars(struct sirfsoc_uart_port *sirfport, int count)
 	unsigned int num_tx = 0;
 	while (!uart_circ_empty(xmit) &&
 		!(rd_regl(port, ureg->sirfsoc_tx_fifo_status) &
-					ufifo_st->ff_full(port->line)) &&
+					ufifo_st->ff_full(port)) &&
 		count--) {
 		wr_regl(port, ureg->sirfsoc_tx_fifo_data,
 				xmit->buf[xmit->tail]);
@@ -626,8 +624,7 @@ recv_char:
 			sirfsoc_uart_handle_rx_done(sirfport);
 	} else {
 		if (intr_status & SIRFUART_RX_IO_INT_ST(uint_st))
-			sirfsoc_uart_pio_rx_chars(port,
-					SIRFSOC_UART_IO_RX_MAX_CNT);
+			sirfsoc_uart_pio_rx_chars(port, port->fifosize);
 	}
 	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&state->port);
@@ -641,10 +638,10 @@ recv_char:
 				return IRQ_HANDLED;
 			} else {
 				sirfsoc_uart_pio_tx_chars(sirfport,
-					SIRFSOC_UART_IO_TX_REASONABLE_CNT);
+						port->fifosize);
 				if ((uart_circ_empty(xmit)) &&
 				(rd_regl(port, ureg->sirfsoc_tx_fifo_status) &
-				ufifo_st->ff_empty(port->line)))
+				ufifo_st->ff_empty(port)))
 					sirfsoc_uart_stop_tx(port);
 			}
 		}
@@ -746,7 +743,7 @@ sirfsoc_usp_calc_sample_div(unsigned long set_rate,
 	unsigned long ioclk_div = 0;
 	unsigned long temp_delta;
 
-	for (sample_div = SIRF_MIN_SAMPLE_DIV;
+	for (sample_div = SIRF_USP_MIN_SAMPLE_DIV;
 			sample_div <= SIRF_MAX_SAMPLE_DIV; sample_div++) {
 		temp_delta = ioclk_rate -
 		(ioclk_rate + (set_rate * sample_div) / 2)
@@ -1012,7 +1009,6 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 							index, port->irq);
 		goto irq_err;
 	}
-
 	/* initial hardware settings */
 	wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl,
 		rd_regl(port, ureg->sirfsoc_tx_dma_io_ctrl) |
@@ -1174,8 +1170,8 @@ static void sirfsoc_uart_console_putchar(struct uart_port *port, int ch)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_fifo_status *ufifo_st = &sirfport->uart_reg->fifo_status;
-	while (rd_regl(port,
-		ureg->sirfsoc_tx_fifo_status) & ufifo_st->ff_full(port->line))
+	while (rd_regl(port, ureg->sirfsoc_tx_fifo_status) &
+		ufifo_st->ff_full(port))
 		cpu_relax();
 	wr_regl(port, ureg->sirfsoc_tx_fifo_data, ch);
 }
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index cd30ba9..af2f187 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -6,6 +6,7 @@
  * Licensed under GPLv2 or later.
  */
 #include <linux/bitops.h>
+#include <linux/log2.h>
 struct sirfsoc_uart_param {
 	const char *uart_name;
 	const char *port_name;
@@ -43,8 +44,8 @@ struct sirfsoc_register {
 	u32 sirfsoc_async_param_reg;
 };
 
-typedef u32 (*fifo_full_mask)(int line);
-typedef u32 (*fifo_empty_mask)(int line);
+typedef u32 (*fifo_full_mask)(struct uart_port *port);
+typedef u32 (*fifo_empty_mask)(struct uart_port *port);
 
 struct sirfsoc_fifo_status {
 	fifo_full_mask ff_full;
@@ -103,21 +104,20 @@ struct sirfsoc_uart_register {
 	enum sirfsoc_uart_type uart_type;
 };
 
-u32 usp_ff_full(int line)
+u32 uart_usp_ff_full_mask(struct uart_port *port)
 {
-	return 0x80;
-}
-u32 usp_ff_empty(int line)
-{
-	return 0x100;
-}
-u32 uart_ff_full(int line)
-{
-	return (line == 1) ? (0x20) : (0x80);
+	u32 full_bit;
+
+	full_bit = ilog2(port->fifosize);
+	return (1 << full_bit);
 }
-u32 uart_ff_empty(int line)
+
+u32 uart_usp_ff_empty_mask(struct uart_port *port)
 {
-	return (line == 1) ? (0x40) : (0x100);
+	u32 empty_bit;
+
+	empty_bit = ilog2(port->fifosize);
+	return (1 << empty_bit);
 }
 struct sirfsoc_uart_register sirfsoc_usp = {
 	.uart_reg = {
@@ -175,8 +175,8 @@ struct sirfsoc_uart_register sirfsoc_usp = {
 		.sirfsoc_rxd_brk	= BIT(15),
 	},
 	.fifo_status = {
-		.ff_full		= usp_ff_full,
-		.ff_empty		= usp_ff_empty,
+		.ff_full		= uart_usp_ff_full_mask,
+		.ff_empty		= uart_usp_ff_empty_mask,
 	},
 	.uart_param = {
 		.uart_name = "ttySiRF",
@@ -245,8 +245,8 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 		.sirfsoc_rts		= BIT(15),
 	},
 	.fifo_status = {
-		.ff_full		= uart_ff_full,
-		.ff_empty		= uart_ff_empty,
+		.ff_full		= uart_usp_ff_full_mask,
+		.ff_empty		= uart_usp_ff_empty_mask,
 	},
 	.uart_param = {
 		.uart_name = "ttySiRF",
@@ -294,6 +294,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 /* Macro Specific*/
 #define SIRFUART_INT_EN_CLR                    0x0060
 /* Baud Rate Calculation */
+#define SIRF_USP_MIN_SAMPLE_DIV			0x1
 #define SIRF_MIN_SAMPLE_DIV			0xf
 #define SIRF_MAX_SAMPLE_DIV			0x3f
 #define SIRF_IOCLK_DIV_MAX			0xffff
@@ -328,7 +329,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFUART_RECV_TIMEOUT(port, x)	\
 		(((port)->line > 2) ? (x & 0xFFFF) : ((x) & 0xFFFF) << 16)
 
-#define SIRFUART_FIFO_THD(port)		((port->line) == 1 ? 16 : 64)
+#define SIRFUART_FIFO_THD(port)		(port->fifosize >> 1)
 #define SIRFUART_ERR_INT_STAT(port, unit_st)			\
 				(uint_st->sirfsoc_rx_oflow |		\
 				uint_st->sirfsoc_frm_err |		\
@@ -365,10 +366,6 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 /* Uart Common Use Macro*/
 #define SIRFSOC_RX_DMA_BUF_SIZE	256
 #define BYTES_TO_ALIGN(dma_addr)	((unsigned long)(dma_addr) & 0x3)
-#define LOOP_DMA_BUFA_FILL	1
-#define LOOP_DMA_BUFB_FILL	2
-#define TX_TRAN_PIO		1
-#define TX_TRAN_DMA		2
 /* Uart Fifo Level Chk */
 #define SIRFUART_TX_FIFO_SC_OFFSET	0
 #define SIRFUART_TX_FIFO_LC_OFFSET	10
@@ -437,10 +434,6 @@ struct sirfsoc_uart_port {
 #define wr_regl(port, reg, val)		__raw_writel(val, portaddr(port, reg))
 
 /* UART Port Mask */
-#define SIRFUART_FIFOLEVEL_MASK(port)	((port->line == 1) ? (0x1f) : (0x7f))
-#define SIRFUART_FIFOFULL_MASK(port)	((port->line == 1) ? (0x20) : (0x80))
-#define SIRFUART_FIFOEMPTY_MASK(port)	((port->line == 1) ? (0x40) : (0x100))
-
-/* I/O Mode */
-#define SIRFSOC_UART_IO_RX_MAX_CNT		256
-#define SIRFSOC_UART_IO_TX_REASONABLE_CNT	256
+#define SIRFUART_FIFOLEVEL_MASK(port)	((port->fifosize - 1) & 0xFFF)
+#define SIRFUART_FIFOFULL_MASK(port)	(port->fifosize & 0xFFF)
+#define SIRFUART_FIFOEMPTY_MASK(port)	((port->fifosize & 0xFFF) << 1)
-- 
2.3.5
