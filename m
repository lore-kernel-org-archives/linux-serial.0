From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] serial: sirf: add support for Marco chip
Date: Wed,  7 Aug 2013 13:35:38 +0800
Message-ID: <1375853738-2062-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:56047 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab3HGFgT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Aug 2013 01:36:19 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so1454705pbb.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2013 22:36:19 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

the marco and coming new CSR multiple SoCs have SET/CLR pair for
INTEN registers to avoid some read-modify-write.

this patch adds support for this and make the driver support current
up and coming mp SoCs.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |   76 ++++++++++++++++++++++++++++++-------
 drivers/tty/serial/sirfsoc_uart.h |    3 +
 2 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 1fd564b..2c991d6 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -139,40 +139,66 @@ static void sirfsoc_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void sirfsoc_uart_stop_tx(struct uart_port *port)
 {
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	unsigned int regv;
-	regv = rd_regl(port, SIRFUART_INT_EN);
-	wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_TX_INT_EN);
+
+	if (!sirfport->is_marco) {
+		regv = rd_regl(port, SIRFUART_INT_EN);
+		wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_TX_INT_EN);
+	} else {
+		wr_regl(port, SIRFUART_INT_EN_CLR, SIRFUART_TX_INT_EN);
+	}
 }
 
 void sirfsoc_uart_start_tx(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	unsigned long regv;
+
 	sirfsoc_uart_pio_tx_chars(sirfport, 1);
 	wr_regl(port, SIRFUART_TX_FIFO_OP, SIRFUART_TX_FIFO_START);
-	regv = rd_regl(port, SIRFUART_INT_EN);
-	wr_regl(port, SIRFUART_INT_EN, regv | SIRFUART_TX_INT_EN);
+
+	if (!sirfport->is_marco) {
+		regv = rd_regl(port, SIRFUART_INT_EN);
+		wr_regl(port, SIRFUART_INT_EN, regv | SIRFUART_TX_INT_EN);
+	} else {
+		wr_regl(port, SIRFUART_INT_EN, SIRFUART_TX_INT_EN);
+	}
 }
 
 static void sirfsoc_uart_stop_rx(struct uart_port *port)
 {
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	unsigned long regv;
+
 	wr_regl(port, SIRFUART_RX_FIFO_OP, 0);
-	regv = rd_regl(port, SIRFUART_INT_EN);
-	wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_RX_IO_INT_EN);
+
+	if (!sirfport->is_marco) {
+		regv = rd_regl(port, SIRFUART_INT_EN);
+		wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_RX_IO_INT_EN);
+	} else {
+		wr_regl(port, SIRFUART_INT_EN_CLR, SIRFUART_RX_IO_INT_EN);
+	}
 }
 
 static void sirfsoc_uart_disable_ms(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	unsigned long reg;
+
 	sirfport->ms_enabled = 0;
 	if (!sirfport->hw_flow_ctrl)
 		return;
+
 	reg = rd_regl(port, SIRFUART_AFC_CTRL);
 	wr_regl(port, SIRFUART_AFC_CTRL, reg & ~0x3FF);
-	reg = rd_regl(port, SIRFUART_INT_EN);
-	wr_regl(port, SIRFUART_INT_EN, reg & ~SIRFUART_CTS_INT_EN);
+
+	if (!sirfport->is_marco) {
+		reg = rd_regl(port, SIRFUART_INT_EN);
+		wr_regl(port, SIRFUART_INT_EN, reg & ~SIRFUART_CTS_INT_EN);
+	} else {
+		wr_regl(port, SIRFUART_INT_EN_CLR, SIRFUART_CTS_INT_EN);
+	}
 }
 
 static void sirfsoc_uart_enable_ms(struct uart_port *port)
@@ -180,13 +206,20 @@ static void sirfsoc_uart_enable_ms(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	unsigned long reg;
 	unsigned long flg;
+
 	if (!sirfport->hw_flow_ctrl)
 		return;
 	flg = SIRFUART_AFC_RX_EN | SIRFUART_AFC_TX_EN;
 	reg = rd_regl(port, SIRFUART_AFC_CTRL);
 	wr_regl(port, SIRFUART_AFC_CTRL, reg | flg);
-	reg = rd_regl(port, SIRFUART_INT_EN);
-	wr_regl(port, SIRFUART_INT_EN, reg | SIRFUART_CTS_INT_EN);
+
+	if (!sirfport->is_marco) {
+		reg = rd_regl(port, SIRFUART_INT_EN);
+		wr_regl(port, SIRFUART_INT_EN, reg | SIRFUART_CTS_INT_EN);
+	} else {
+		wr_regl(port, SIRFUART_INT_EN, SIRFUART_CTS_INT_EN);
+	}
+
 	uart_handle_cts_change(port,
 		!(rd_regl(port, SIRFUART_AFC_CTRL) & SIRFUART_CTS_IN_STATUS));
 	sirfport->ms_enabled = 1;
@@ -313,9 +346,16 @@ recv_char:
 
 static void sirfsoc_uart_start_rx(struct uart_port *port)
 {
-	unsigned long regv;
-	regv = rd_regl(port, SIRFUART_INT_EN);
-	wr_regl(port, SIRFUART_INT_EN, regv | SIRFUART_RX_IO_INT_EN);
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+
+	if (!sirfport->is_marco) {
+		unsigned long regv;
+		regv = rd_regl(port, SIRFUART_INT_EN);
+		wr_regl(port, SIRFUART_INT_EN, regv | SIRFUART_RX_IO_INT_EN);
+	} else {
+		wr_regl(port, SIRFUART_INT_EN, SIRFUART_RX_IO_INT_EN);
+	}
+
 	wr_regl(port, SIRFUART_RX_FIFO_OP, SIRFUART_RX_FIFO_RESET);
 	wr_regl(port, SIRFUART_RX_FIFO_OP, 0);
 	wr_regl(port, SIRFUART_RX_FIFO_OP, SIRFUART_RX_FIFO_START);
@@ -513,7 +553,12 @@ irq_err:
 static void sirfsoc_uart_shutdown(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	wr_regl(port, SIRFUART_INT_EN, 0);
+
+	if (!sirfport->is_marco)
+		wr_regl(port, SIRFUART_INT_EN, 0);
+	else
+		wr_regl(port, SIRFUART_INT_EN_CLR, ~0UL);
+
 	free_irq(port->irq, sirfport);
 	if (sirfport->ms_enabled) {
 		sirfsoc_uart_disable_ms(port);
@@ -652,6 +697,9 @@ int sirfsoc_uart_probe(struct platform_device *pdev)
 	port->dev = &pdev->dev;
 	port->private_data = sirfport;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,marco-uart"))
+		sirfport->is_marco = true;
+
 	if (of_find_property(pdev->dev.of_node, "hw_flow_ctrl", NULL))
 		sirfport->hw_flow_ctrl = 1;
 
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 85328ba..6216660 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -13,6 +13,7 @@
 #define SIRFUART_DIVISOR			0x0050
 #define SIRFUART_INT_EN				0x0054
 #define SIRFUART_INT_STATUS			0x0058
+#define SIRFUART_INT_EN_CLR			0x0060
 #define SIRFUART_TX_DMA_IO_CTRL			0x0100
 #define SIRFUART_TX_DMA_IO_LEN			0x0104
 #define SIRFUART_TX_FIFO_CTRL			0x0108
@@ -164,6 +165,8 @@ struct sirfsoc_uart_port {
 	struct uart_port		port;
 	struct pinctrl			*p;
 	struct clk			*clk;
+	/* for SiRFmarco, there are SET/CLR for UART_INT_EN */
+	bool				is_marco;
 };
 
 /* Hardware Flow Control */
-- 
1.7.5.4

