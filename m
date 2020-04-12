Return-Path: <SRS0=Ld9p=54=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1823CC2BB86
	for <linux-serial@archiver.kernel.org>; Sun, 12 Apr 2020 18:16:23 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB78206E9
	for <linux-serial@archiver.kernel.org>; Sun, 12 Apr 2020 18:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyBPTZnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB78206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgDLSPJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Apr 2020 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgDLSPG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Apr 2020 14:15:06 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653DAC008749;
        Sun, 12 Apr 2020 11:10:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [157.50.0.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77BF8206DA;
        Sun, 12 Apr 2020 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586715004;
        bh=A+Q5c8ZprAFrfX84bhRceoLh8P6URdK3TI6udATXaeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyBPTZnFOwIDwpsYtkOw7Qy+ac1zBbq9NVN381s6JiZJBtWE6ghCNgedOeQijthQi
         sVXQJBFdHR75itQlQoFAaNMoqlKkJvIL16yAE01TgViQcPVxKxDT0J5rb+S1oDh9Dw
         jM5oOyqjSUWE7WCoBYS81KvmYFw6NvPSzXKYF5nQ=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 2/2] tty: serial: Add software flow control support for STM32 USART
Date:   Sun, 12 Apr 2020 23:39:23 +0530
Message-Id: <20200412180923.30774-3-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412180923.30774-1-mani@kernel.org>
References: <20200412180923.30774-1-mani@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Add software flow control support for STM32 USART controller. This could
be useful when the hardware RTS/CTS pins are not available in the
design.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/tty/serial/stm32-usart.c | 143 +++++++++++++++++++++++++++++--
 drivers/tty/serial/stm32-usart.h |   4 +
 2 files changed, 141 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 5e93e8d40f59..f8adc108ae19 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -94,6 +95,20 @@ static void stm32_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
 	*cr1 |= rs485_deat_dedt;
 }
 
+static irqreturn_t stm32_cts_handler(int irq, void *dev_id)
+{
+	struct stm32_port *stm32port = (struct stm32_port *)dev_id;
+	struct uart_port *port = &stm32port->port;
+
+	spin_lock(&port->lock);
+	if (gpio_is_valid(stm32port->cts_gpio) && stm32port->ms_enabled)
+		uart_handle_cts_change(port,
+				!gpio_get_value(stm32port->cts_gpio));
+	spin_unlock(&port->lock);
+
+	return IRQ_HANDLED;
+}
+
 static int stm32_config_rs485(struct uart_port *port,
 			      struct serial_rs485 *rs485conf)
 {
@@ -506,16 +521,39 @@ static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
-	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
-		stm32_set_bits(port, ofs->cr3, USART_CR3_RTSE);
-	else
-		stm32_clr_bits(port, ofs->cr3, USART_CR3_RTSE);
+	if (stm32_port->hw_flow_control) {
+		if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
+			stm32_set_bits(port, ofs->cr3, USART_CR3_RTSE);
+		else
+			stm32_clr_bits(port, ofs->cr3, USART_CR3_RTSE);
+	} else if (stm32_port->sw_flow_control) {
+		if ((mctrl & TIOCM_RTS))
+			gpio_set_value(stm32_port->rts_gpio, 0);
+		else
+			gpio_set_value(stm32_port->rts_gpio, 1);
+	}
 }
 
+/* This routine is used to get signals of: DCD, DSR, RI, and CTS */
 static unsigned int stm32_get_mctrl(struct uart_port *port)
 {
-	/* This routine is used to get signals of: DCD, DSR, RI, and CTS */
+	struct stm32_port *stm32_port = to_stm32_port(port);
+
+	if (!stm32_port->ms_enabled)
+		goto cts_asserted;
+
+	if (stm32_port->sw_flow_control) {
+		if (!gpio_get_value(stm32_port->cts_gpio))
+			goto cts_asserted;
+		else
+			goto cts_deasserted;
+	}
+
+cts_asserted:
 	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
+
+cts_deasserted:
+	return TIOCM_CAR | TIOCM_DSR;
 }
 
 /* Transmit stop */
@@ -582,6 +620,28 @@ static void stm32_break_ctl(struct uart_port *port, int break_state)
 {
 }
 
+static void stm32_enable_ms(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+
+	if (!stm32_port->sw_flow_control)
+		return;
+
+	stm32_port->ms_enabled = true;
+	enable_irq(gpio_to_irq(stm32_port->cts_gpio));
+}
+
+static void stm32_disable_ms(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+
+	if (!stm32_port->sw_flow_control)
+		return;
+
+	stm32_port->ms_enabled = false;
+	disable_irq(gpio_to_irq(stm32_port->cts_gpio));
+}
+
 static int stm32_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -615,6 +675,19 @@ static int stm32_startup(struct uart_port *port)
 		val |= USART_CR1_FIFOEN;
 	stm32_set_bits(port, ofs->cr1, val);
 
+	stm32_port->ms_enabled = false;
+	if (stm32_port->sw_flow_control) {
+		irq_modify_status(gpio_to_irq(stm32_port->cts_gpio),
+				  IRQ_NOREQUEST, IRQ_NOAUTOEN);
+		ret = request_irq(gpio_to_irq(stm32_port->cts_gpio),
+			stm32_cts_handler, IRQF_TRIGGER_FALLING |
+			IRQF_TRIGGER_RISING, "stm32_cts_irq", stm32_port);
+		if (ret != 0) {
+			dev_err(port->dev, "request gpio irq fail\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -642,6 +715,14 @@ static void stm32_shutdown(struct uart_port *port)
 	stm32_clr_bits(port, ofs->cr1, val);
 
 	free_irq(port->irq, port);
+
+	if (stm32_port->ms_enabled)
+		stm32_disable_ms(port);
+
+	if (stm32_port->sw_flow_control) {
+		gpio_set_value(stm32_port->rts_gpio, 1);
+		free_irq(gpio_to_irq(stm32_port->cts_gpio), stm32_port);
+	}
 }
 
 static unsigned int stm32_get_databits(struct ktermios *termios)
@@ -812,6 +893,14 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= USART_SR_DUMMY_RX;
 
+	if (UART_ENABLE_MS(port, termios->c_cflag)) {
+		if (!stm32_port->ms_enabled)
+			stm32_enable_ms(port);
+	} else {
+		if (stm32_port->ms_enabled)
+			stm32_disable_ms(port);
+	}
+
 	if (stm32_port->rx_ch)
 		cr3 |= USART_CR3_DMAR;
 
@@ -898,6 +987,7 @@ static const struct uart_ops stm32_uart_ops = {
 	.throttle	= stm32_throttle,
 	.unthrottle	= stm32_unthrottle,
 	.stop_rx	= stm32_stop_rx,
+	.enable_ms	= stm32_enable_ms,
 	.break_ctl	= stm32_break_ctl,
 	.startup	= stm32_startup,
 	.shutdown	= stm32_shutdown,
@@ -970,7 +1060,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int id;
+	int id, ret;
 
 	if (!np)
 		return NULL;
@@ -990,6 +1080,47 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	stm32_ports[id].cr1_irq = USART_CR1_RXNEIE;
 	stm32_ports[id].cr3_irq = 0;
 	stm32_ports[id].last_res = RX_BUF_L;
+
+	stm32_ports[id].sw_flow_control = of_property_read_bool(np,
+							"st,sw-flow-ctrl");
+	if (stm32_ports[id].sw_flow_control) {
+		if (of_find_property(np, "cts-gpios", NULL))
+			stm32_ports[id].cts_gpio =
+				of_get_named_gpio(np, "cts-gpios", 0);
+		else
+			stm32_ports[id].cts_gpio = -1;
+
+		if (of_find_property(np, "rts-gpios", NULL))
+			stm32_ports[id].rts_gpio =
+				of_get_named_gpio(np, "rts-gpios", 0);
+		else
+			stm32_ports[id].rts_gpio = -1;
+
+		if ((!gpio_is_valid(stm32_ports[id].cts_gpio)) ||
+			(!gpio_is_valid(stm32_ports[id].rts_gpio))) {
+				dev_err(&pdev->dev,
+					"SW flow control must have cts and rts gpio");
+				return NULL;
+		}
+
+		ret = devm_gpio_request(&pdev->dev, stm32_ports[id].cts_gpio,
+				"st-cts-gpio");
+		if (ret) {
+			dev_err(&pdev->dev, "Unable request cts gpio");
+			return NULL;
+		}
+
+		gpio_direction_input(stm32_ports[id].cts_gpio);
+		ret = devm_gpio_request(&pdev->dev, stm32_ports[id].rts_gpio,
+				"st-rts-gpio");
+		if (ret) {
+			dev_err(&pdev->dev, "Unable request rts gpio");
+			return NULL;
+		}
+
+		gpio_direction_output(stm32_ports[id].rts_gpio, 1);
+	}
+
 	return &stm32_ports[id];
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index a175c1094dc8..87b30f514e15 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -274,6 +274,10 @@ struct stm32_port {
 	bool fifoen;
 	int wakeirq;
 	int rdr_mask;		/* receive data register mask */
+	bool sw_flow_control;
+	unsigned int cts_gpio;
+	unsigned int rts_gpio;
+	bool ms_enabled;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
2.17.1

