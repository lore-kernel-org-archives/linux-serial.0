From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2] serial: sirf: define macro for some magic numbers of USP
Date: Sun, 25 Aug 2013 20:18:40 +0800
Message-ID: <1377433121-11411-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33593 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab3HYMTA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Aug 2013 08:19:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2378799pbb.19
        for <linux-serial@vger.kernel.org>; Sun, 25 Aug 2013 05:19:00 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

this patch clears some magic numbers for offset and bitshift
of USP registers.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 37 ++++++++++++++++++++++---------------
 drivers/tty/serial/sirfsoc_uart.h | 15 +++++++++++++++
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index b8d7eb3..37aa0dd 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -948,11 +948,11 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 		set_baud = ((ioclk_rate / (clk_div_reg+1) - 1) /
 				(sample_div_reg + 1));
 		/* setting usp mode 2 */
-		len_val = ((1 << 0) | (1 << 8));
-		len_val |= ((clk_div_reg & 0x3ff) << 21);
-		wr_regl(port, ureg->sirfsoc_mode2,
-				len_val);
-
+		len_val = ((1 << SIRFSOC_USP_MODE2_RXD_DELAY_OFFSET) |
+				(1 << SIRFSOC_USP_MODE2_TXD_DELAY_OFFSET));
+		len_val |= ((clk_div_reg & SIRFSOC_USP_MODE2_CLK_DIVISOR_MASK)
+				<< SIRFSOC_USP_MODE2_CLK_DIVISOR_OFFSET);
+		wr_regl(port, ureg->sirfsoc_mode2, len_val);
 	}
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, set_baud, set_baud);
@@ -960,7 +960,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	rx_time_out = SIRFSOC_UART_RX_TIMEOUT(set_baud, 20000);
 	rx_time_out = SIRFUART_RECV_TIMEOUT_VALUE(rx_time_out);
 	txfifo_op_reg = rd_regl(port, ureg->sirfsoc_tx_fifo_op);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_STOP);
 	wr_regl(port, ureg->sirfsoc_tx_fifo_op,
 			(txfifo_op_reg & ~SIRFUART_FIFO_START));
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
@@ -968,21 +968,28 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 		wr_regl(port, ureg->sirfsoc_line_ctrl, config_reg);
 	} else {
 		/*tx frame ctrl*/
-		len_val = (data_bit_len - 1) << 0;
-		len_val |= (data_bit_len + 1 + stop_bit_len - 1) << 16;
-		len_val |= ((data_bit_len - 1) << 24);
-		len_val |= (((clk_div_reg & 0xc00) >> 10) << 30);
+		len_val = (data_bit_len - 1) << SIRFSOC_USP_TX_DATA_LEN_OFFSET;
+		len_val |= (data_bit_len + 1 + stop_bit_len - 1) <<
+				SIRFSOC_USP_TX_FRAME_LEN_OFFSET;
+		len_val |= ((data_bit_len - 1) <<
+				SIRFSOC_USP_TX_SHIFTER_LEN_OFFSET);
+		len_val |= (((clk_div_reg & 0xc00) >> 10) <<
+				SIRFSOC_USP_TX_CLK_DIVISOR_OFFSET);
 		wr_regl(port, ureg->sirfsoc_tx_frame_ctrl, len_val);
 		/*rx frame ctrl*/
-		len_val = (data_bit_len - 1) << 0;
-		len_val |= (data_bit_len + 1 + stop_bit_len - 1) << 8;
-		len_val |= (data_bit_len - 1) << 16;
-		len_val |= (((clk_div_reg & 0xf000) >> 12) << 24);
+		len_val = (data_bit_len - 1) << SIRFSOC_USP_RX_DATA_LEN_OFFSET;
+		len_val |= (data_bit_len + 1 + stop_bit_len - 1) <<
+				SIRFSOC_USP_RX_FRAME_LEN_OFFSET;
+		len_val |= (data_bit_len - 1) <<
+				SIRFSOC_USP_RX_SHIFTER_LEN_OFFSET;
+		len_val |= (((clk_div_reg & 0xf000) >> 12) <<
+				SIRFSOC_USP_RX_CLK_DIVISOR_OFFSET);
 		wr_regl(port, ureg->sirfsoc_rx_frame_ctrl, len_val);
 		/*async param*/
 		wr_regl(port, ureg->sirfsoc_async_param_reg,
 			(SIRFUART_RECV_TIMEOUT(port, rx_time_out)) |
-			(sample_div_reg & 0x3f) << 16);
+			(sample_div_reg & SIRFSOC_USP_ASYNC_DIV2_MASK) <<
+			SIRFSOC_USP_ASYNC_DIV2_OFFSET);
 	}
 	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no))
 		wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, SIRFUART_DMA_MODE);
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 173e00f..c43333d 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -311,6 +311,21 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 /* USP SPEC */
 #define SIRFSOC_USP_ENDIAN_CTRL_LSBF		BIT(4)
 #define SIRFSOC_USP_EN				BIT(5)
+#define SIRFSOC_USP_MODE2_RXD_DELAY_OFFSET	0
+#define SIRFSOC_USP_MODE2_TXD_DELAY_OFFSET	8
+#define SIRFSOC_USP_MODE2_CLK_DIVISOR_MASK	0x3ff
+#define SIRFSOC_USP_MODE2_CLK_DIVISOR_OFFSET	21
+#define SIRFSOC_USP_TX_DATA_LEN_OFFSET		0
+#define SIRFSOC_USP_TX_SYNC_LEN_OFFSET		8
+#define SIRFSOC_USP_TX_FRAME_LEN_OFFSET		16
+#define SIRFSOC_USP_TX_SHIFTER_LEN_OFFSET	24
+#define SIRFSOC_USP_TX_CLK_DIVISOR_OFFSET	30
+#define SIRFSOC_USP_RX_DATA_LEN_OFFSET		0
+#define SIRFSOC_USP_RX_FRAME_LEN_OFFSET		8
+#define SIRFSOC_USP_RX_SHIFTER_LEN_OFFSET	16
+#define SIRFSOC_USP_RX_CLK_DIVISOR_OFFSET	24
+#define SIRFSOC_USP_ASYNC_DIV2_MASK		0x3f
+#define SIRFSOC_USP_ASYNC_DIV2_OFFSET		16
 
 /* USP-UART Common */
 #define SIRFSOC_UART_RX_TIMEOUT(br, to)	(((br) * (((to) + 999) / 1000)) / 1000)
-- 
1.8.2.3

