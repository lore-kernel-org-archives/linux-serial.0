Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95CEECAAA1
	for <linux-serial@archiver.kernel.org>; Sun, 11 Sep 2022 09:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIKJCd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 11 Sep 2022 05:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIKJCd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 11 Sep 2022 05:02:33 -0400
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CAF22BCE
        for <linux-serial@vger.kernel.org>; Sun, 11 Sep 2022 02:02:31 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 2E9E5101E6B69;
        Sun, 11 Sep 2022 11:02:30 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E0542603E021;
        Sun, 11 Sep 2022 11:02:29 +0200 (CEST)
X-Mailbox-Line: From 6059eab35dba394468335ef640df8b0050fd9dbd Mon Sep 17 00:00:00 2001
Message-Id: <6059eab35dba394468335ef640df8b0050fd9dbd.1662886616.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 11 Sep 2022 11:02:03 +0200
Subject: [PATCH] serial: stm32: Deassert Transmit Enable on ->rs485_config()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The STM32 USART can control RS-485 Transmit Enable in hardware.  Since
commit 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control"),
it can alternatively be controlled in software.  That was done to allow
RS-485 even if the RTS pin is unavailable because it's pinmuxed to a
different function.

However the commit neglected to deassert Transmit Enable upon invocation
of the ->rs485_config() callback.  Fix it.

Avoid forward declarations by moving stm32_usart_tx_empty(),
stm32_usart_rs485_rts_enable() and stm32_usart_rs485_rts_disable()
further up in the driver.

Fixes: 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.9+
Cc: Marek Vasut <marex@denx.de>
---
 drivers/tty/serial/stm32-usart.c | 100 ++++++++++++++++---------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0b18615b2ca4..c48f225eba86 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -131,6 +131,53 @@ static void stm32_usart_clr_bits(struct uart_port *port, u32 reg, u32 bits)
 	writel_relaxed(val, port->membase + reg);
 }
 
+static unsigned int stm32_usart_tx_empty(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	if (readl_relaxed(port->membase + ofs->isr) & USART_SR_TC)
+		return TIOCSER_TEMT;
+
+	return 0;
+}
+
+static void stm32_usart_rs485_rts_enable(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct serial_rs485 *rs485conf = &port->rs485;
+
+	if (stm32_port->hw_flow_control ||
+	    !(rs485conf->flags & SER_RS485_ENABLED))
+		return;
+
+	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+		mctrl_gpio_set(stm32_port->gpios,
+			       stm32_port->port.mctrl | TIOCM_RTS);
+	} else {
+		mctrl_gpio_set(stm32_port->gpios,
+			       stm32_port->port.mctrl & ~TIOCM_RTS);
+	}
+}
+
+static void stm32_usart_rs485_rts_disable(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct serial_rs485 *rs485conf = &port->rs485;
+
+	if (stm32_port->hw_flow_control ||
+	    !(rs485conf->flags & SER_RS485_ENABLED))
+		return;
+
+	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+		mctrl_gpio_set(stm32_port->gpios,
+			       stm32_port->port.mctrl & ~TIOCM_RTS);
+	} else {
+		mctrl_gpio_set(stm32_port->gpios,
+			       stm32_port->port.mctrl | TIOCM_RTS);
+	}
+}
+
 static void stm32_usart_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
 					 u32 delay_DDE, u32 baud)
 {
@@ -214,6 +261,12 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
 
 	stm32_usart_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 
+	/* Adjust RTS polarity in case it's driven in software */
+	if (stm32_usart_tx_empty(port))
+		stm32_usart_rs485_rts_disable(port);
+	else
+		stm32_usart_rs485_rts_enable(port);
+
 	return 0;
 }
 
@@ -529,42 +582,6 @@ static void stm32_usart_tc_interrupt_disable(struct uart_port *port)
 	stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_TCIE);
 }
 
-static void stm32_usart_rs485_rts_enable(struct uart_port *port)
-{
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct serial_rs485 *rs485conf = &port->rs485;
-
-	if (stm32_port->hw_flow_control ||
-	    !(rs485conf->flags & SER_RS485_ENABLED))
-		return;
-
-	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
-		mctrl_gpio_set(stm32_port->gpios,
-			       stm32_port->port.mctrl | TIOCM_RTS);
-	} else {
-		mctrl_gpio_set(stm32_port->gpios,
-			       stm32_port->port.mctrl & ~TIOCM_RTS);
-	}
-}
-
-static void stm32_usart_rs485_rts_disable(struct uart_port *port)
-{
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct serial_rs485 *rs485conf = &port->rs485;
-
-	if (stm32_port->hw_flow_control ||
-	    !(rs485conf->flags & SER_RS485_ENABLED))
-		return;
-
-	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
-		mctrl_gpio_set(stm32_port->gpios,
-			       stm32_port->port.mctrl & ~TIOCM_RTS);
-	} else {
-		mctrl_gpio_set(stm32_port->gpios,
-			       stm32_port->port.mctrl | TIOCM_RTS);
-	}
-}
-
 static void stm32_usart_transmit_chars_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -807,17 +824,6 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 	return IRQ_HANDLED;
 }
 
-static unsigned int stm32_usart_tx_empty(struct uart_port *port)
-{
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-
-	if (readl_relaxed(port->membase + ofs->isr) & USART_SR_TC)
-		return TIOCSER_TEMT;
-
-	return 0;
-}
-
 static void stm32_usart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-- 
2.36.1

