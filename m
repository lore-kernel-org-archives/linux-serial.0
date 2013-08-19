From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] serial: sirf: fix the namespace of startup_uart entry
Date: Mon, 19 Aug 2013 11:47:52 +0800
Message-ID: <1376884073-22375-2-git-send-email-Baohua.Song@csr.com>
References: <1376884073-22375-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61452 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3HSDsK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Aug 2013 23:48:10 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so4486846pbb.10
        for <linux-serial@vger.kernel.org>; Sun, 18 Aug 2013 20:48:09 -0700 (PDT)
In-Reply-To: <1376884073-22375-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

startup_uart_controller() loses namespace, this patch
drops the function directly and move the content into
sirfsoc_uart_startup().

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 52 +++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 10718c0..d37609d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -649,37 +649,10 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void startup_uart_controller(struct uart_port *port)
-{
-	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
-	unsigned long temp_regv;
-	int temp;
-	temp_regv = rd_regl(port, ureg->sirfsoc_tx_dma_io_ctrl);
-	wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, temp_regv |
-					SIRFUART_IO_MODE);
-	temp_regv = rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl);
-	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, temp_regv |
-					SIRFUART_IO_MODE);
-	wr_regl(port, ureg->sirfsoc_tx_dma_io_len, 0);
-	wr_regl(port, ureg->sirfsoc_rx_dma_io_len, 0);
-	wr_regl(port, ureg->sirfsoc_tx_rx_en, SIRFUART_RX_EN | SIRFUART_TX_EN);
-	if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
-		wr_regl(port, ureg->sirfsoc_mode1,
-				SIRFSOC_USP_ENDIAN_CTRL_LSBF |
-				SIRFSOC_USP_EN);
-	wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_RESET);
-	wr_regl(port, ureg->sirfsoc_tx_fifo_op, 0);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
-	temp = SIRFUART_FIFO_THD(port);
-	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, temp);
-	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl, temp);
-}
-
 static int sirfsoc_uart_startup(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport	= to_sirfport(port);
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	unsigned int index			= port->line;
 	int ret;
 	set_irq_flags(port->irq, IRQF_VALID | IRQF_NOAUTOEN);
@@ -693,7 +666,27 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 							index, port->irq);
 		goto irq_err;
 	}
-	startup_uart_controller(port);
+
+	/* initial hardware settings */
+	wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl,
+		rd_regl(port, ureg->sirfsoc_tx_dma_io_ctrl) |
+		SIRFUART_IO_MODE);
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl,
+		rd_regl(port, ureg->sirfsoc_rx_dma_io_ctrl) |
+		SIRFUART_IO_MODE);
+	wr_regl(port, ureg->sirfsoc_tx_dma_io_len, 0);
+	wr_regl(port, ureg->sirfsoc_rx_dma_io_len, 0);
+	wr_regl(port, ureg->sirfsoc_tx_rx_en, SIRFUART_RX_EN | SIRFUART_TX_EN);
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
+		wr_regl(port, ureg->sirfsoc_mode1,
+			SIRFSOC_USP_ENDIAN_CTRL_LSBF |
+			SIRFSOC_USP_EN);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_RESET);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_op, 0);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
+	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, SIRFUART_FIFO_THD(port));
+	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl, SIRFUART_FIFO_THD(port));
 
 	sirfport->ms_enabled = false;
 	if (sirfport->uart_reg->uart_type == SIRF_USP_UART &&
@@ -711,6 +704,7 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 
 	enable_irq(port->irq);
 
+	return 0;
 init_rx_err:
 	free_irq(port->irq, sirfport);
 irq_err:
-- 
1.8.2.3

