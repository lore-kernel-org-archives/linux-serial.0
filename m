From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] serial: sirf: fix the hardware-flow-ctrl for USP-based UART
Date: Tue, 13 Aug 2013 19:18:16 +0800
Message-ID: <1376392697-20664-2-git-send-email-Baohua.Song@csr.com>
References: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34913 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab3HMLSd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Aug 2013 07:18:33 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so3254296pab.41
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2013 04:18:33 -0700 (PDT)
In-Reply-To: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

for USP-based UART, we use two gpios as RTS and CST pins.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 161 ++++++++++++++++++++++++++++----------
 drivers/tty/serial/sirfsoc_uart.h |   6 +-
 2 files changed, 122 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 64d0192..caf26ec 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of_gpio.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
@@ -110,14 +111,19 @@ static unsigned int sirfsoc_uart_get_mctrl(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
-	if (!(sirfport->ms_enabled)) {
+	if (!sirfport->hw_flow_ctrl || !sirfport->ms_enabled)
 		goto cts_asserted;
-	} else if (sirfport->hw_flow_ctrl) {
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
 		if (!(rd_regl(port, ureg->sirfsoc_afc_ctrl) &
 						SIRFUART_AFC_CTS_STATUS))
 			goto cts_asserted;
 		else
 			goto cts_deasserted;
+	} else {
+		if (!gpio_get_value(sirfport->cts_gpio))
+			goto cts_asserted;
+		else
+			goto cts_deasserted;
 	}
 cts_deasserted:
 	return TIOCM_CAR | TIOCM_DSR;
@@ -132,10 +138,18 @@ static void sirfsoc_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	unsigned int assert = mctrl & TIOCM_RTS;
 	unsigned int val = assert ? SIRFUART_AFC_CTRL_RX_THD : 0x0;
 	unsigned int current_val;
-	if (sirfport->hw_flow_ctrl) {
+
+	if (!sirfport->hw_flow_ctrl || !sirfport->ms_enabled)
+		return;
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
 		current_val = rd_regl(port, ureg->sirfsoc_afc_ctrl) & ~0xFF;
 		val |= current_val;
 		wr_regl(port, ureg->sirfsoc_afc_ctrl, val);
+	} else {
+		if (!val)
+			gpio_set_value(sirfport->rts_gpio, 1);
+		else
+			gpio_set_value(sirfport->rts_gpio, 0);
 	}
 }
 
@@ -195,21 +209,32 @@ static void sirfsoc_uart_disable_ms(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	unsigned long reg;
 
-	sirfport->ms_enabled = 0;
 	if (!sirfport->hw_flow_ctrl)
 		return;
-
-	reg = rd_regl(port, ureg->sirfsoc_afc_ctrl);
-	wr_regl(port, ureg->sirfsoc_afc_ctrl, reg & ~0x3FF);
-	if (!sirfport->is_marco) {
-		reg = rd_regl(port, ureg->sirfsoc_int_en_reg);
-		wr_regl(port, ureg->sirfsoc_int_en_reg,
-			reg & ~uint_en->sirfsoc_cts_en);
+	sirfport->ms_enabled = false;
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
+		wr_regl(port, ureg->sirfsoc_afc_ctrl,
+				rd_regl(port, ureg->sirfsoc_afc_ctrl) & ~0x3FF);
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+					rd_regl(port, ureg->sirfsoc_int_en_reg)&
+					~uint_en->sirfsoc_cts_en);
+		else
+			wr_regl(port, SIRFUART_INT_EN_CLR,
+					uint_en->sirfsoc_cts_en);
 	} else
-		wr_regl(port, SIRFUART_INT_EN_CLR,
-				uint_en->sirfsoc_cts_en);
+		disable_irq(gpio_to_irq(sirfport->cts_gpio));
+}
+
+static irqreturn_t sirfsoc_uart_usp_cts_handler(int irq, void *dev_id)
+{
+	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)dev_id;
+	struct uart_port *port = &sirfport->port;
+	if (gpio_is_valid(sirfport->cts_gpio) && sirfport->ms_enabled)
+		uart_handle_cts_change(port,
+				!gpio_get_value(sirfport->cts_gpio));
+	return IRQ_HANDLED;
 }
 
 static void sirfsoc_uart_enable_ms(struct uart_port *port)
@@ -217,25 +242,23 @@ static void sirfsoc_uart_enable_ms(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
-	unsigned long reg;
-	unsigned long flg;
 
 	if (!sirfport->hw_flow_ctrl)
 		return;
-	flg = SIRFUART_AFC_TX_EN | SIRFUART_AFC_RX_EN;
-	reg = rd_regl(port, ureg->sirfsoc_afc_ctrl);
-	wr_regl(port, ureg->sirfsoc_afc_ctrl, reg | flg);
-	if (!sirfport->is_marco) {
-		reg = rd_regl(port, ureg->sirfsoc_int_en_reg);
-		wr_regl(port, ureg->sirfsoc_int_en_reg,
-				reg | uint_en->sirfsoc_cts_en);
+	sirfport->ms_enabled = true;
+	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
+		wr_regl(port, ureg->sirfsoc_afc_ctrl,
+				rd_regl(port, ureg->sirfsoc_afc_ctrl) |
+				SIRFUART_AFC_TX_EN | SIRFUART_AFC_RX_EN);
+		if (!sirfport->is_marco)
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+					rd_regl(port, ureg->sirfsoc_int_en_reg)
+					| uint_en->sirfsoc_cts_en);
+		else
+			wr_regl(port, ureg->sirfsoc_int_en_reg,
+					uint_en->sirfsoc_cts_en);
 	} else
-		wr_regl(port, ureg->sirfsoc_int_en_reg,
-				uint_en->sirfsoc_cts_en);
-	uart_handle_cts_change(port,
-		!(rd_regl(port, ureg->sirfsoc_afc_ctrl) &
-				SIRFUART_AFC_CTS_STATUS));
-	sirfport->ms_enabled = 1;
+		enable_irq(gpio_to_irq(sirfport->cts_gpio));
 }
 
 static void sirfsoc_uart_break_ctl(struct uart_port *port, int break_state)
@@ -505,8 +528,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 		if (termios->c_iflag & INPCK)
 			port->read_status_mask |= uint_en->sirfsoc_frm_err_en |
 				uint_en->sirfsoc_parity_err_en;
-	}
-	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+	} else {
 		if (termios->c_iflag & INPCK)
 			port->read_status_mask |= uint_en->sirfsoc_frm_err_en;
 	}
@@ -529,8 +551,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 				config_reg |= SIRFUART_STICK_BIT_EVEN;
 			}
 		}
-	}
-	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+	} else {
 		if (termios->c_iflag & IGNPAR)
 			port->ignore_status_mask |=
 				uint_en->sirfsoc_frm_err_en;
@@ -567,8 +588,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 			clk_div_reg = sirfsoc_uart_calc_sample_div(baud_rate,
 					ioclk_rate, &set_baud);
 		wr_regl(port, ureg->sirfsoc_divisor, clk_div_reg);
-	}
-	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+	} else {
 		clk_div_reg = sirfsoc_usp_calc_sample_div(baud_rate,
 				ioclk_rate, &sample_div_reg);
 		sample_div_reg--;
@@ -593,8 +613,7 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
 		config_reg |= SIRFUART_RECV_TIMEOUT(port, rx_time_out);
 		wr_regl(port, ureg->sirfsoc_line_ctrl, config_reg);
-	}
-	if (sirfport->uart_reg->uart_type == SIRF_USP_UART) {
+	} else {
 		/*tx frame ctrl*/
 		len_val = (data_bit_len - 1) << 0;
 		len_val |= (data_bit_len + 1 + stop_bit_len - 1) << 16;
@@ -675,7 +694,25 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 		goto irq_err;
 	}
 	startup_uart_controller(port);
+
+	sirfport->ms_enabled = false;
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART &&
+		sirfport->hw_flow_ctrl) {
+		set_irq_flags(gpio_to_irq(sirfport->cts_gpio),
+			IRQF_VALID | IRQF_NOAUTOEN);
+		ret = request_irq(gpio_to_irq(sirfport->cts_gpio),
+			sirfsoc_uart_usp_cts_handler, IRQF_TRIGGER_FALLING |
+			IRQF_TRIGGER_RISING, "usp_cts_irq", sirfport);
+		if (ret != 0) {
+			dev_err(port->dev, "UART-USP:request gpio irq fail\n");
+			goto init_rx_err;
+		}
+	}
+
 	enable_irq(port->irq);
+
+init_rx_err:
+	free_irq(port->irq, sirfport);
 irq_err:
 	return ret;
 }
@@ -690,9 +727,12 @@ static void sirfsoc_uart_shutdown(struct uart_port *port)
 		wr_regl(port, SIRFUART_INT_EN_CLR, ~0UL);
 
 	free_irq(port->irq, sirfport);
-	if (sirfport->ms_enabled) {
+	if (sirfport->ms_enabled)
 		sirfsoc_uart_disable_ms(port);
-		sirfport->ms_enabled = 0;
+	if (sirfport->uart_reg->uart_type == SIRF_USP_UART &&
+			sirfport->hw_flow_ctrl) {
+		gpio_set_value(sirfport->rts_gpio, 1);
+		free_irq(gpio_to_irq(sirfport->cts_gpio), sirfport);
 	}
 }
 
@@ -852,16 +892,51 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	port->private_data = sirfport;
 	sirfport->uart_reg = (struct sirfsoc_uart_register *)match->data;
 
+	sirfport->hw_flow_ctrl = of_property_read_bool(pdev->dev.of_node,
+		"sirf,uart-has-rtscts");
 	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart"))
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart")) {
 		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
+		if (!sirfport->hw_flow_ctrl)
+			goto usp_no_flow_control;
+		if (of_find_property(pdev->dev.of_node, "cts-gpios", NULL))
+			sirfport->cts_gpio = of_get_named_gpio(
+					pdev->dev.of_node, "cts-gpios", 0);
+		else
+			sirfport->cts_gpio = -1;
+		if (of_find_property(pdev->dev.of_node, "rts-gpios", NULL))
+			sirfport->rts_gpio = of_get_named_gpio(
+					pdev->dev.of_node, "rts-gpios", 0);
+		else
+			sirfport->rts_gpio = -1;
+
+		if ((!gpio_is_valid(sirfport->cts_gpio) ||
+			 !gpio_is_valid(sirfport->rts_gpio))) {
+			ret = -EINVAL;
+			dev_err(&pdev->dev,
+				"Usp flow control must have rfs and tfs gpio");
+			goto err;
+		}
+		ret = devm_gpio_request(&pdev->dev, sirfport->cts_gpio,
+				"usp-rfs-gpio");
+		if (ret) {
+			dev_err(&pdev->dev, "Unable request rfs gpio");
+			goto err;
+		}
+		gpio_direction_input(sirfport->cts_gpio);
+		ret = devm_gpio_request(&pdev->dev, sirfport->rts_gpio,
+				"usp-tfs-gpio");
+		if (ret) {
+			dev_err(&pdev->dev, "Unable request tfs gpio");
+			goto err;
+		}
+		gpio_direction_output(sirfport->rts_gpio, 1);
+	}
+usp_no_flow_control:
 	if (of_device_is_compatible(pdev->dev.of_node, "sirf,marco-uart"))
 		sirfport->is_marco = true;
 
-	if (of_find_property(pdev->dev.of_node, "hw_flow_ctrl", NULL))
-		sirfport->hw_flow_ctrl = 1;
-
 	if (of_property_read_u32(pdev->dev.of_node,
 			"fifosize",
 			&port->fifosize)) {
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 2b41b06..e87035a 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -363,14 +363,16 @@ struct sirfsoc_baudrate_to_regv {
 };
 
 struct sirfsoc_uart_port {
-	unsigned char			hw_flow_ctrl;
-	unsigned char			ms_enabled;
+	bool				hw_flow_ctrl;
+	bool				ms_enabled;
 
 	struct uart_port		port;
 	struct clk			*clk;
 	/* for SiRFmarco, there are SET/CLR for UART_INT_EN */
 	bool				is_marco;
 	struct sirfsoc_uart_register	*uart_reg;
+	unsigned int			cts_gpio;
+	unsigned int			rts_gpio;
 };
 
 /* Hardware Flow Control */
-- 
1.8.2.3

