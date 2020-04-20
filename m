Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE905C38A30
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9E12145D
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587402153;
	bh=plMzlobQNccyl97bdN7R33bGIDUnUZmwwqOwhihDlNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgtWjJW+rZ3ZelBIqTLhyPqvR25vPmLJoO5YND0cZc5r53mmsEljVOHnw5TSSoDe8
	 OXXZXx9ZfZEsUP5qgnttv1zFrLGEoe51/jQb1oTPvvjd/1gOLNMwqm0XoFcgsdA+U6
	 V1viR/Ryrb175kIHKzlgSOb8cCZCBJ9DO7KLfj0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDTRCc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRCc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Apr 2020 13:02:32 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C5D221F4;
        Mon, 20 Apr 2020 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402151;
        bh=plMzlobQNccyl97bdN7R33bGIDUnUZmwwqOwhihDlNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQoDVIQpN/VZy7sDK1aZIiMW9C0CDN9KdUol7rsq1Ba1n7p0dX8xxuWNbXmLsRxwu
         huLrKf/jlWP46Vm1R0rOK539k1YpaL60iApYRnV8TgECCfppSF4vkCfNXZE0Fve6n6
         cXHum4o73j41QL2N0V73y4yGVM+3DqG6AqPsHBX8=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 2/2] tty: serial: Add modem control gpio support for STM32 UART
Date:   Mon, 20 Apr 2020 22:32:04 +0530
Message-Id: <20200420170204.24541-3-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420170204.24541-1-mani@kernel.org>
References: <20200420170204.24541-1-mani@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

STM32 UART controllers have the built in modem control support using
dedicated gpios which can be enabled using 'st,hw-flow-ctrl' flag in DT.
But there might be cases where the board design need to use different
gpios for modem control.

For supporting such cases, this commit adds modem control gpio support
to STM32 UART controller using mctrl_gpio driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/tty/serial/Kconfig       |  1 +
 drivers/tty/serial/stm32-usart.c | 53 ++++++++++++++++++++++++++++++--
 drivers/tty/serial/stm32-usart.h |  1 +
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0aea76cd67ff..e7a6f2130684 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1462,6 +1462,7 @@ config SERIAL_STM32
 	tristate "STMicroelectronics STM32 serial port support"
 	select SERIAL_CORE
 	depends on ARCH_STM32 || COMPILE_TEST
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  This driver is for the on-chip Serial Controller on
 	  STMicroelectronics STM32 MCUs.
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 5e93e8d40f59..17c2f3276888 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -31,6 +31,7 @@
 #include <linux/tty_flip.h>
 #include <linux/tty.h>
 
+#include "serial_mctrl_gpio.h"
 #include "stm32-usart.h"
 
 static void stm32_stop_tx(struct uart_port *port);
@@ -510,12 +511,29 @@ static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		stm32_set_bits(port, ofs->cr3, USART_CR3_RTSE);
 	else
 		stm32_clr_bits(port, ofs->cr3, USART_CR3_RTSE);
+
+	mctrl_gpio_set(stm32_port->gpios, mctrl);
 }
 
 static unsigned int stm32_get_mctrl(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	unsigned int ret;
+
 	/* This routine is used to get signals of: DCD, DSR, RI, and CTS */
-	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
+	ret = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
+
+	return mctrl_gpio_get(stm32_port->gpios, &ret);
+}
+
+static void stm32_enable_ms(struct uart_port *port)
+{
+	mctrl_gpio_enable_ms(to_stm32_port(port)->gpios);
+}
+
+static void stm32_disable_ms(struct uart_port *port)
+{
+	mctrl_gpio_disable_ms(to_stm32_port(port)->gpios);
 }
 
 /* Transmit stop */
@@ -626,6 +644,9 @@ static void stm32_shutdown(struct uart_port *port)
 	u32 val, isr;
 	int ret;
 
+	/* Disable modem control interrupts */
+	stm32_disable_ms(port);
+
 	val = USART_CR1_TXEIE | USART_CR1_TE;
 	val |= stm32_port->cr1_irq | USART_CR1_RE;
 	val |= BIT(cfg->uart_enable_bit);
@@ -764,6 +785,12 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 		cr3 |= USART_CR3_CTSE | USART_CR3_RTSE;
 	}
 
+	/* Handle modem control interrupts */
+	if (UART_ENABLE_MS(port, termios->c_cflag))
+		stm32_enable_ms(port);
+	else
+		stm32_disable_ms(port);
+
 	usartdiv = DIV_ROUND_CLOSEST(port->uartclk, baud);
 
 	/*
@@ -898,6 +925,7 @@ static const struct uart_ops stm32_uart_ops = {
 	.throttle	= stm32_throttle,
 	.unthrottle	= stm32_unthrottle,
 	.stop_rx	= stm32_stop_rx,
+	.enable_ms	= stm32_enable_ms,
 	.break_ctl	= stm32_break_ctl,
 	.startup	= stm32_startup,
 	.shutdown	= stm32_shutdown,
@@ -960,10 +988,31 @@ static int stm32_init_port(struct stm32_port *stm32port,
 
 	stm32port->port.uartclk = clk_get_rate(stm32port->clk);
 	if (!stm32port->port.uartclk) {
-		clk_disable_unprepare(stm32port->clk);
 		ret = -EINVAL;
+		goto err_clk;
+	}
+
+	stm32port->gpios = mctrl_gpio_init(&stm32port->port, 0);
+	if (IS_ERR(stm32port->gpios)) {
+		ret = PTR_ERR(stm32port->gpios);
+		goto err_clk;
 	}
 
+	/* Both CTS/RTS gpios and "st,hw-flow-ctrl" should not be specified */
+	if (stm32port->hw_flow_control) {
+		if (mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_CTS) ||
+		    mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_RTS)) {
+			dev_err(&pdev->dev, "Conflicting RTS/CTS config\n");
+			ret = -EINVAL;
+			goto err_clk;
+		}
+	}
+
+	return ret;
+
+err_clk:
+	clk_disable_unprepare(stm32port->clk);
+
 	return ret;
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index db8bf0d4982d..d4c916e78d40 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -274,6 +274,7 @@ struct stm32_port {
 	bool fifoen;
 	int wakeirq;
 	int rdr_mask;		/* receive data register mask */
+	struct mctrl_gpios *gpios; /* modem control gpios */
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
2.17.1

