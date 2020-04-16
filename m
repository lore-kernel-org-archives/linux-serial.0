Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA5FC2BB55
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0072206B9
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587059911;
	bh=1RrAUoUNggxa9GfCCTH+HfaKDyL/+0j2ab5DCtyFe+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxoYCtq3YQS8TKOBj3vwvLgT6pxoisXzWTgoDBNlxdpY1fRPHkjpc7DiFhFPXzMED
	 xUv8yHHAtGv+huTXaSIMnMQwBotDsIIOx1bpzu8F+qCQ8yoKQFwpGy9Pdr2JMTU3rg
	 WghzOrmfhhjcjtsyB1Konr70AnVMBYKo8eMqS/Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbgDPR62 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgDPR61 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 13:58:27 -0400
Received: from localhost.localdomain (unknown [157.50.106.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC7D221EB;
        Thu, 16 Apr 2020 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587059906;
        bh=1RrAUoUNggxa9GfCCTH+HfaKDyL/+0j2ab5DCtyFe+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfrIJdmjWHjFODLKeI9+YaknavJzKrn9muaHwW4JGvVW1mcruZrwZPnzAAqmOBtld
         hJvlNz3kQRjS2UldMkVlrWfcTjHwGPdpAHnSoR+yg9gDyVuFDSzYquuY5BqDds0Xz5
         JDWp39XK3g0myUet9HF7kkVbm/iejns806TWqdgI=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 1/2] tty: serial: Add modem control gpio support for STM32 UART
Date:   Thu, 16 Apr 2020 23:27:28 +0530
Message-Id: <20200416175729.5550-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416175729.5550-1-mani@kernel.org>
References: <20200416175729.5550-1-mani@kernel.org>
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

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/tty/serial/Kconfig       |  1 +
 drivers/tty/serial/stm32-usart.c | 43 +++++++++++++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

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
index 5e93e8d40f59..026982259714 100644
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
+	int ret;
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
@@ -964,6 +992,19 @@ static int stm32_init_port(struct stm32_port *stm32port,
 		ret = -EINVAL;
 	}
 
+	stm32port->gpios = mctrl_gpio_init(&stm32port->port, 0);
+	if (IS_ERR(stm32port->gpios))
+		return PTR_ERR(stm32port->gpios);
+
+	/* Both CTS/RTS gpios and "st,hw-flow-ctrl" should not be specified */
+	if (stm32port->hw_flow_control) {
+		if (mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_CTS) ||
+		    mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_RTS)) {
+			dev_err(&pdev->dev, "Conflicting RTS/CTS config\n");
+			return -EINVAL;
+		}
+	}
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

