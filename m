From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] serial: sirf: add a new uart type support
Date: Tue, 11 Nov 2014 20:44:58 +0800
Message-ID: <1415709898-2824-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:52998 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaKKMpV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Nov 2014 07:45:21 -0500
Received: by mail-pd0-f177.google.com with SMTP id v10so9952687pde.22
        for <linux-serial@vger.kernel.org>; Tue, 11 Nov 2014 04:45:20 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

in CSR A7DA SoC, uart6 located at BT module and it need multiple clock
sources, so for "sirf,marco-bt-uart" compatible uarts, drivers take 3
clock sources and enable them.

this patch also replaces clk_get by devm_clk_get function and fix DT
binding document in which we missed to fix when we added marco platform
in commit 909102db44f "serial: sirf: add support for Marco chip".

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 .../devicetree/bindings/serial/sirf-uart.txt       | 16 +++++++++-
 drivers/tty/serial/sirfsoc_uart.c                  | 34 +++++++++++++++++-----
 drivers/tty/serial/sirfsoc_uart.h                  |  4 +++
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/sirf-uart.txt b/Documentation/devicetree/bindings/serial/sirf-uart.txt
index a2dfc65..3acdd96 100644
--- a/Documentation/devicetree/bindings/serial/sirf-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sirf-uart.txt
@@ -1,7 +1,9 @@
 * CSR SiRFprimaII/atlasVI Universal Synchronous Asynchronous Receiver/Transmitter *
 
 Required properties:
-- compatible : Should be "sirf,prima2-uart" or "sirf, prima2-usp-uart"
+- compatible : Should be "sirf,prima2-uart", "sirf, prima2-usp-uart",
+		"sirf,marco-uart" or "sirf,marco-bt-uart" which means
+		uart located in BT module and used for BT.
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - fifosize : Should define hardware rx/tx fifo size
@@ -31,3 +33,15 @@ usp@b0090000 {
 	rts-gpios = <&gpio 15 0>;
 	cts-gpios = <&gpio 46 0>;
 };
+
+for uart use in BT module,
+uart6: uart@11000000 {
+	cell-index = <6>;
+	compatible = "sirf,marco-bt-uart", "sirf,marco-uart";
+	reg = <0x11000000 0x1000>;
+	interrupts = <0 100 0>;
+	clocks = <&clks 138>, <&clks 140>, <&clks 141>;
+	clock-names = "uart", "general", "noc";
+	fifosize = <128>;
+	status = "disabled";
+}
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 4102192..2f6c6b0 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1032,10 +1032,19 @@ static void sirfsoc_uart_pm(struct uart_port *port, unsigned int state,
 			      unsigned int oldstate)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	if (!state)
+	if (!state) {
+		if (sirfport->is_bt_uart) {
+			clk_prepare_enable(sirfport->clk_noc);
+			clk_prepare_enable(sirfport->clk_general);
+		}
 		clk_prepare_enable(sirfport->clk);
-	else
+	} else {
 		clk_disable_unprepare(sirfport->clk);
+		if (sirfport->is_bt_uart) {
+			clk_disable_unprepare(sirfport->clk_general);
+			clk_disable_unprepare(sirfport->clk_noc);
+		}
+	}
 }
 
 static int sirfsoc_uart_startup(struct uart_port *port)
@@ -1378,12 +1387,26 @@ usp_no_flow_control:
 	}
 	port->irq = res->start;
 
-	sirfport->clk = clk_get(&pdev->dev, NULL);
+	sirfport->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sirfport->clk)) {
 		ret = PTR_ERR(sirfport->clk);
 		goto err;
 	}
 	port->uartclk = clk_get_rate(sirfport->clk);
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,marco-bt-uart")) {
+		sirfport->clk_general = devm_clk_get(&pdev->dev, "general");
+		if (IS_ERR(sirfport->clk_general)) {
+			ret = PTR_ERR(sirfport->clk_general);
+			goto err;
+		}
+		sirfport->clk_noc = devm_clk_get(&pdev->dev, "noc");
+		if (IS_ERR(sirfport->clk_noc)) {
+			ret = PTR_ERR(sirfport->clk_noc);
+			goto err;
+		}
+		sirfport->is_bt_uart = true;
+	} else
+		sirfport->is_bt_uart = false;
 
 	port->ops = &sirfsoc_uart_ops;
 	spin_lock_init(&port->lock);
@@ -1392,7 +1415,7 @@ usp_no_flow_control:
 	ret = uart_add_one_port(&sirfsoc_uart_drv, port);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Cannot add UART port(%d).\n", pdev->id);
-		goto port_err;
+		goto err;
 	}
 
 	sirfport->rx_dma_chan = dma_request_slave_channel(port->dev, "rx");
@@ -1421,8 +1444,6 @@ alloc_coherent_err:
 				sirfport->rx_dma_items[j].xmit.buf,
 				sirfport->rx_dma_items[j].dma_addr);
 	dma_release_channel(sirfport->rx_dma_chan);
-port_err:
-	clk_put(sirfport->clk);
 err:
 	return ret;
 }
@@ -1431,7 +1452,6 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 {
 	struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
 	struct uart_port *port = &sirfport->port;
-	clk_put(sirfport->clk);
 	uart_remove_one_port(&sirfsoc_uart_drv, port);
 	if (sirfport->rx_dma_chan) {
 		int i;
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 6a7ebf7..275d038 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -417,6 +417,10 @@ struct sirfsoc_uart_port {
 
 	struct uart_port		port;
 	struct clk			*clk;
+	/* UART6 for BT usage in A7DA platform need multi-clock source */
+	bool				is_bt_uart;
+	struct clk			*clk_general;
+	struct clk			*clk_noc;
 	/* for SiRFmarco, there are SET/CLR for UART_INT_EN */
 	bool				is_marco;
 	struct sirfsoc_uart_register	*uart_reg;
-- 
2.1.1

