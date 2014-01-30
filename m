From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] serial: sirf: move to use generic dma dt-binding to get dma channels
Date: Thu, 30 Jan 2014 13:57:29 +0800
Message-ID: <1391061449-2266-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:60269 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaA3F5p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Jan 2014 00:57:45 -0500
Received: by mail-pd0-f171.google.com with SMTP id g10so2626321pdj.30
        for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2014 21:57:44 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

instead of using sirf specific dma channel property like "sirf,uart-dma-rx-channel"
and "sirf,uart-dma-tx-channel", here we move to use generic dma dt-binding to get
the channel like:
- sirf,uart-dma-rx-channel = <21>;
- sirf,uart-dma-tx-channel = <2>;
+ dmas = <&dmac1 5>, <&dmac0 2>;
+ dma-names = "rx", "tx";

and we move dma_request_channel() to dma_request_slave_channel(), we don't need to
call sirfsoc dma filter function sirfsoc_dma_filter_id() again.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi     |   17 ++--
 arch/arm/boot/dts/prima2.dtsi     |   20 ++--
 drivers/tty/serial/sirfsoc_uart.c |  195 ++++++++++++-------------------------
 drivers/tty/serial/sirfsoc_uart.h |    5 -
 4 files changed, 81 insertions(+), 156 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index f8674bc..0c81dc9 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -217,8 +217,8 @@
 				interrupts = <17>;
 				fifosize = <128>;
 				clocks = <&clks 13>;
-				sirf,uart-dma-rx-channel = <21>;
-				sirf,uart-dma-tx-channel = <2>;
+				dmas = <&dmac1 5>, <&dmac0 2>;
+				dma-names = "rx", "tx";
 			};
 
 			uart1: uart@b0060000 {
@@ -228,6 +228,7 @@
 				interrupts = <18>;
 				fifosize = <32>;
 				clocks = <&clks 14>;
+				dma-names = "no-rx", "no-tx";
 			};
 
 			uart2: uart@b0070000 {
@@ -237,8 +238,8 @@
 				interrupts = <19>;
 				fifosize = <128>;
 				clocks = <&clks 15>;
-				sirf,uart-dma-rx-channel = <6>;
-				sirf,uart-dma-tx-channel = <7>;
+				dmas = <&dmac0 6>, <&dmac0 7>;
+				dma-names = "rx", "tx";
 			};
 
 			usp0: usp@b0080000 {
@@ -248,8 +249,8 @@
 				interrupts = <20>;
 				fifosize = <128>;
 				clocks = <&clks 28>;
-				sirf,usp-dma-rx-channel = <17>;
-				sirf,usp-dma-tx-channel = <18>;
+				dmas = <&dmac1 1>, <&dmac1 2>;
+				dma-names = "rx", "tx";
 			};
 
 			usp1: usp@b0090000 {
@@ -259,8 +260,8 @@
 				interrupts = <21>;
 				fifosize = <128>;
 				clocks = <&clks 29>;
-				sirf,usp-dma-rx-channel = <14>;
-				sirf,usp-dma-tx-channel = <15>;
+				dmas = <&dmac0 14>, <&dmac0 15>;
+				dma-names = "rx", "tx";
 			};
 
 			dmac0: dma-controller@b00b0000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 0e21993..8582ae4 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -223,8 +223,8 @@
 				interrupts = <17>;
 				fifosize = <128>;
 				clocks = <&clks 13>;
-				sirf,uart-dma-rx-channel = <21>;
-				sirf,uart-dma-tx-channel = <2>;
+				dmas = <&dmac1 5>, <&dmac0 2>;
+				dma-names = "rx", "tx";
 			};
 
 			uart1: uart@b0060000 {
@@ -243,8 +243,8 @@
 				interrupts = <19>;
 				fifosize = <128>;
 				clocks = <&clks 15>;
-				sirf,uart-dma-rx-channel = <6>;
-				sirf,uart-dma-tx-channel = <7>;
+				dmas = <&dmac0 6>, <&dmac0 7>;
+				dma-names = "rx", "tx";
 			};
 
 			usp0: usp@b0080000 {
@@ -254,8 +254,8 @@
 				interrupts = <20>;
 				fifosize = <128>;
 				clocks = <&clks 28>;
-				sirf,usp-dma-rx-channel = <17>;
-				sirf,usp-dma-tx-channel = <18>;
+				dmas = <&dmac1 1>, <&dmac1 2>;
+				dma-names = "rx", "tx";
 			};
 
 			usp1: usp@b0090000 {
@@ -265,8 +265,8 @@
 				interrupts = <21>;
 				fifosize = <128>;
 				clocks = <&clks 29>;
-				sirf,usp-dma-rx-channel = <14>;
-				sirf,usp-dma-tx-channel = <15>;
+				dmas = <&dmac0 14>, <&dmac0 15>;
+				dma-names = "rx", "tx";
 			};
 
 			usp2: usp@b00a0000 {
@@ -276,8 +276,8 @@
 				interrupts = <22>;
 				fifosize = <128>;
 				clocks = <&clks 30>;
-				sirf,usp-dma-rx-channel = <10>;
-				sirf,usp-dma-tx-channel = <11>;
+				dmas = <&dmac0 10>, <&dmac0 11>;
+				dma-names = "rx", "tx";
 			};
 
 			dmac0: dma-controller@b00b0000 {
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index b7bfe24..68b0fd4 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -24,7 +24,6 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
-#include <linux/sirfsoc_dma.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
@@ -173,7 +172,7 @@ static void sirfsoc_uart_stop_tx(struct uart_port *port)
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 
-	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no)) {
+	if (sirfport->tx_dma_chan) {
 		if (sirfport->tx_dma_state == TX_DMA_RUNNING) {
 			dmaengine_pause(sirfport->tx_dma_chan);
 			sirfport->tx_dma_state = TX_DMA_PAUSE;
@@ -288,7 +287,7 @@ static void sirfsoc_uart_start_tx(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no))
+	if (sirfport->tx_dma_chan)
 		sirfsoc_uart_tx_with_dma(sirfport);
 	else {
 		sirfsoc_uart_pio_tx_chars(sirfport, 1);
@@ -310,7 +309,7 @@ static void sirfsoc_uart_stop_rx(struct uart_port *port)
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
-	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no)) {
+	if (sirfport->rx_dma_chan) {
 		if (!sirfport->is_marco)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
 				rd_regl(port, ureg->sirfsoc_int_en_reg) &
@@ -675,7 +674,7 @@ recv_char:
 		uart_handle_cts_change(port, cts_status);
 		wake_up_interruptible(&state->port.delta_msr_wait);
 	}
-	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no)) {
+	if (sirfport->rx_dma_chan) {
 		if (intr_status & uint_st->sirfsoc_rx_timeout)
 			sirfsoc_uart_handle_rx_tmo(sirfport);
 		if (intr_status & uint_st->sirfsoc_rx_done)
@@ -686,7 +685,7 @@ recv_char:
 					SIRFSOC_UART_IO_RX_MAX_CNT);
 	}
 	if (intr_status & uint_st->sirfsoc_txfifo_empty) {
-		if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no))
+		if (sirfport->tx_dma_chan)
 			sirfsoc_uart_tx_with_dma(sirfport);
 		else {
 			if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
@@ -778,7 +777,7 @@ static void sirfsoc_uart_start_rx(struct uart_port *port)
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
-	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no))
+	if (sirfport->rx_dma_chan)
 		sirfsoc_uart_start_next_rx_dma(port);
 	else {
 		if (!sirfport->is_marco)
@@ -1014,11 +1013,11 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 			(sample_div_reg & SIRFSOC_USP_ASYNC_DIV2_MASK) <<
 			SIRFSOC_USP_ASYNC_DIV2_OFFSET);
 	}
-	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no))
+	if (sirfport->tx_dma_chan)
 		wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, SIRFUART_DMA_MODE);
 	else
 		wr_regl(port, ureg->sirfsoc_tx_dma_io_ctrl, SIRFUART_IO_MODE);
-	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no))
+	if (sirfport->rx_dma_chan)
 		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_DMA_MODE);
 	else
 		wr_regl(port, ureg->sirfsoc_rx_dma_io_ctrl, SIRFUART_IO_MODE);
@@ -1049,93 +1048,6 @@ static void sirfsoc_uart_pm(struct uart_port *port, unsigned int state,
 		clk_disable_unprepare(sirfport->clk);
 }
 
-static unsigned int sirfsoc_uart_init_tx_dma(struct uart_port *port)
-{
-	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	dma_cap_mask_t dma_mask;
-	struct dma_slave_config tx_slv_cfg = {
-		.dst_maxburst = 2,
-	};
-
-	dma_cap_zero(dma_mask);
-	dma_cap_set(DMA_SLAVE, dma_mask);
-	sirfport->tx_dma_chan = dma_request_channel(dma_mask,
-		(dma_filter_fn)sirfsoc_dma_filter_id,
-		(void *)sirfport->tx_dma_no);
-	if (!sirfport->tx_dma_chan) {
-		dev_err(port->dev, "Uart Request Dma Channel Fail %d\n",
-					sirfport->tx_dma_no);
-		return  -EPROBE_DEFER;
-	}
-	dmaengine_slave_config(sirfport->tx_dma_chan, &tx_slv_cfg);
-
-	return 0;
-}
-
-static unsigned int sirfsoc_uart_init_rx_dma(struct uart_port *port)
-{
-	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	dma_cap_mask_t dma_mask;
-	int ret;
-	int i, j;
-	struct dma_slave_config slv_cfg = {
-		.src_maxburst = 2,
-	};
-
-	dma_cap_zero(dma_mask);
-	dma_cap_set(DMA_SLAVE, dma_mask);
-	sirfport->rx_dma_chan = dma_request_channel(dma_mask,
-					(dma_filter_fn)sirfsoc_dma_filter_id,
-					(void *)sirfport->rx_dma_no);
-	if (!sirfport->rx_dma_chan) {
-		dev_err(port->dev, "Uart Request Dma Channel Fail %d\n",
-				sirfport->rx_dma_no);
-		ret = -EPROBE_DEFER;
-		goto request_err;
-	}
-	for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++) {
-		sirfport->rx_dma_items[i].xmit.buf =
-			dma_alloc_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
-			&sirfport->rx_dma_items[i].dma_addr, GFP_KERNEL);
-		if (!sirfport->rx_dma_items[i].xmit.buf) {
-			dev_err(port->dev, "Uart alloc bufa failed\n");
-			ret = -ENOMEM;
-			goto alloc_coherent_err;
-		}
-		sirfport->rx_dma_items[i].xmit.head =
-			sirfport->rx_dma_items[i].xmit.tail = 0;
-	}
-	dmaengine_slave_config(sirfport->rx_dma_chan, &slv_cfg);
-
-	return 0;
-alloc_coherent_err:
-	for (j = 0; j < i; j++)
-		dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
-				sirfport->rx_dma_items[j].xmit.buf,
-				sirfport->rx_dma_items[j].dma_addr);
-	dma_release_channel(sirfport->rx_dma_chan);
-request_err:
-	return ret;
-}
-
-static void sirfsoc_uart_uninit_tx_dma(struct sirfsoc_uart_port *sirfport)
-{
-	dmaengine_terminate_all(sirfport->tx_dma_chan);
-	dma_release_channel(sirfport->tx_dma_chan);
-}
-
-static void sirfsoc_uart_uninit_rx_dma(struct sirfsoc_uart_port *sirfport)
-{
-	int i;
-	struct uart_port *port = &sirfport->port;
-	dmaengine_terminate_all(sirfport->rx_dma_chan);
-	dma_release_channel(sirfport->rx_dma_chan);
-	for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++)
-		dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
-				sirfport->rx_dma_items[i].xmit.buf,
-				sirfport->rx_dma_items[i].dma_addr);
-}
-
 static int sirfsoc_uart_startup(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport	= to_sirfport(port);
@@ -1174,18 +1086,12 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
 	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, SIRFUART_FIFO_THD(port));
 	wr_regl(port, ureg->sirfsoc_rx_fifo_ctrl, SIRFUART_FIFO_THD(port));
-
-	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no)) {
-		ret = sirfsoc_uart_init_rx_dma(port);
-		if (ret)
-			goto init_rx_err;
+	if (sirfport->rx_dma_chan)
 		wr_regl(port, ureg->sirfsoc_rx_fifo_level_chk,
-				SIRFUART_RX_FIFO_CHK_SC(port->line, 0x4) |
-				SIRFUART_RX_FIFO_CHK_LC(port->line, 0xe) |
-				SIRFUART_RX_FIFO_CHK_HC(port->line, 0x1b));
-	}
-	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no)) {
-		sirfsoc_uart_init_tx_dma(port);
+			SIRFUART_RX_FIFO_CHK_SC(port->line, 0x4) |
+			SIRFUART_RX_FIFO_CHK_LC(port->line, 0xe) |
+			SIRFUART_RX_FIFO_CHK_HC(port->line, 0x1b));
+	if (sirfport->tx_dma_chan) {
 		sirfport->tx_dma_state = TX_DMA_IDLE;
 		wr_regl(port, ureg->sirfsoc_tx_fifo_level_chk,
 				SIRFUART_TX_FIFO_CHK_SC(port->line, 0x1b) |
@@ -1232,12 +1138,8 @@ static void sirfsoc_uart_shutdown(struct uart_port *port)
 		gpio_set_value(sirfport->rts_gpio, 1);
 		free_irq(gpio_to_irq(sirfport->cts_gpio), sirfport);
 	}
-	if (IS_DMA_CHAN_VALID(sirfport->rx_dma_no))
-		sirfsoc_uart_uninit_rx_dma(sirfport);
-	if (IS_DMA_CHAN_VALID(sirfport->tx_dma_no)) {
-		sirfsoc_uart_uninit_tx_dma(sirfport);
+	if (sirfport->tx_dma_chan)
 		sirfport->tx_dma_state = TX_DMA_IDLE;
-	}
 }
 
 static const char *sirfsoc_uart_type(struct uart_port *port)
@@ -1313,8 +1215,8 @@ sirfsoc_uart_console_setup(struct console *co, char *options)
 	port->cons = co;
 
 	/* default console tx/rx transfer using io mode */
-	sirfport->rx_dma_no = UNVALID_DMA_CHAN;
-	sirfport->tx_dma_no = UNVALID_DMA_CHAN;
+	sirfport->rx_dma_chan = NULL;
+	sirfport->tx_dma_chan = NULL;
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
@@ -1382,6 +1284,13 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	struct uart_port *port;
 	struct resource *res;
 	int ret;
+	int i, j;
+	struct dma_slave_config slv_cfg = {
+		.src_maxburst = 2,
+	};
+	struct dma_slave_config tx_slv_cfg = {
+		.dst_maxburst = 2,
+	};
 	const struct of_device_id *match;
 
 	match = of_match_node(sirfsoc_uart_ids, pdev->dev.of_node);
@@ -1402,27 +1311,10 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 
 	sirfport->hw_flow_ctrl = of_property_read_bool(pdev->dev.of_node,
 		"sirf,uart-has-rtscts");
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart")) {
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-		if (of_property_read_u32(pdev->dev.of_node,
-				"sirf,uart-dma-rx-channel",
-				&sirfport->rx_dma_no))
-			sirfport->rx_dma_no = UNVALID_DMA_CHAN;
-		if (of_property_read_u32(pdev->dev.of_node,
-				"sirf,uart-dma-tx-channel",
-				&sirfport->tx_dma_no))
-			sirfport->tx_dma_no = UNVALID_DMA_CHAN;
-	}
 	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart")) {
 		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
-		if (of_property_read_u32(pdev->dev.of_node,
-				"sirf,usp-dma-rx-channel",
-				&sirfport->rx_dma_no))
-			sirfport->rx_dma_no = UNVALID_DMA_CHAN;
-		if (of_property_read_u32(pdev->dev.of_node,
-				"sirf,usp-dma-tx-channel",
-				&sirfport->tx_dma_no))
-			sirfport->tx_dma_no = UNVALID_DMA_CHAN;
 		if (!sirfport->hw_flow_ctrl)
 			goto usp_no_flow_control;
 		if (of_find_property(pdev->dev.of_node, "cts-gpios", NULL))
@@ -1515,8 +1407,32 @@ usp_no_flow_control:
 		goto port_err;
 	}
 
-	return 0;
+	sirfport->rx_dma_chan = dma_request_slave_channel(port->dev, "rx");
+	for (i = 0; sirfport->rx_dma_chan && i < SIRFSOC_RX_LOOP_BUF_CNT; i++) {
+		sirfport->rx_dma_items[i].xmit.buf =
+			dma_alloc_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+			&sirfport->rx_dma_items[i].dma_addr, GFP_KERNEL);
+		if (!sirfport->rx_dma_items[i].xmit.buf) {
+			dev_err(port->dev, "Uart alloc bufa failed\n");
+			ret = -ENOMEM;
+			goto alloc_coherent_err;
+		}
+		sirfport->rx_dma_items[i].xmit.head =
+			sirfport->rx_dma_items[i].xmit.tail = 0;
+	}
+	if (sirfport->rx_dma_chan)
+		dmaengine_slave_config(sirfport->rx_dma_chan, &slv_cfg);
+	sirfport->tx_dma_chan = dma_request_slave_channel(port->dev, "tx");
+	if (sirfport->tx_dma_chan)
+		dmaengine_slave_config(sirfport->tx_dma_chan, &tx_slv_cfg);
 
+	return 0;
+alloc_coherent_err:
+	for (j = 0; j < i; j++)
+		dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+				sirfport->rx_dma_items[j].xmit.buf,
+				sirfport->rx_dma_items[j].dma_addr);
+	dma_release_channel(sirfport->rx_dma_chan);
 port_err:
 	clk_put(sirfport->clk);
 err:
@@ -1529,6 +1445,19 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 	struct uart_port *port = &sirfport->port;
 	clk_put(sirfport->clk);
 	uart_remove_one_port(&sirfsoc_uart_drv, port);
+	if (sirfport->rx_dma_chan) {
+		int i;
+		dmaengine_terminate_all(sirfport->rx_dma_chan);
+		dma_release_channel(sirfport->rx_dma_chan);
+		for (i = 0; i < SIRFSOC_RX_LOOP_BUF_CNT; i++)
+			dma_free_coherent(port->dev, SIRFSOC_RX_DMA_BUF_SIZE,
+					sirfport->rx_dma_items[i].xmit.buf,
+					sirfport->rx_dma_items[i].dma_addr);
+	}
+	if (sirfport->tx_dma_chan) {
+		dmaengine_terminate_all(sirfport->tx_dma_chan);
+		dma_release_channel(sirfport->tx_dma_chan);
+	}
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index b7d679c..8a6edda 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -392,9 +392,6 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 /* Indicate how many buffers used */
 #define SIRFSOC_RX_LOOP_BUF_CNT		2
 
-/* Indicate if DMA channel valid */
-#define IS_DMA_CHAN_VALID(x)	((x) != -1)
-#define UNVALID_DMA_CHAN	-1
 /* For Fast Baud Rate Calculation */
 struct sirfsoc_baudrate_to_regv {
 	unsigned int baud_rate;
@@ -423,8 +420,6 @@ struct sirfsoc_uart_port {
 	/* for SiRFmarco, there are SET/CLR for UART_INT_EN */
 	bool				is_marco;
 	struct sirfsoc_uart_register	*uart_reg;
-	int				rx_dma_no;
-	int				tx_dma_no;
 	struct dma_chan			*rx_dma_chan;
 	struct dma_chan			*tx_dma_chan;
 	dma_addr_t			tx_dma_addr;
-- 
1.7.5.4

