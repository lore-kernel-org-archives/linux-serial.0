Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E3C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 30 Apr 2022 16:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383050AbiD3QcS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 30 Apr 2022 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiD3QcQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 30 Apr 2022 12:32:16 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5416A050
        for <linux-serial@vger.kernel.org>; Sat, 30 Apr 2022 09:28:54 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.net.upcbroadband.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E8B28818A3;
        Sat, 30 Apr 2022 18:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651336132;
        bh=rvfDjyFjOBd+WPPBrIAUo142QMIenhiSTqBD2/hl6rk=;
        h=From:To:Cc:Subject:Date:From;
        b=oULBikiEicXc/K386OqLwD17VzSeF/oqmuolYuLpZFfyHVzdzj7UF0eoGV0Rq504Z
         bz3kzJ2lCRQ35lh7sf/l/4xAUKCzsCpVZxjPFc1ITMxOo0K5P0rkXDDNxqJgky0r6Q
         b/xcjCUDcvyFUqOafb013/6Ww1RU+CqWHTts69xjR0zlWH5Un5xT42UxAw5AbZy55Y
         PJkUZiUUX7MESFEpA5/FtZfjgh68i9O28viMi4l+SEPofQCLoAc3XbC6mGAGKhD/Ta
         MA79M57+8ck1OJ+EAEH8S9xpt7G1bNmJZeKfzDRvg8XMUdJdXJX0eQ/HI2UNDYSJZO
         3wG1UH9c394ag==
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] serial: stm32: Factor out GPIO RTS toggling into separate function
Date:   Sat, 30 Apr 2022 18:28:44 +0200
Message-Id: <20220430162845.244655-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Pull out the GPIO RTS enable and disable handling into separate function.
Limit the scope of GPIO RTS toggling only to GPIO emulated RS485 too.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Erwan Le Ray <erwan.leray@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jean Philippe Romain <jean-philippe.romain@foss.st.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-serial@vger.kernel.org
---
 drivers/tty/serial/stm32-usart.c | 59 ++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index f75691e727295..224f359c6051e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -442,6 +442,42 @@ static void stm32_usart_tx_interrupt_disable(struct uart_port *port)
 		stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
 }
 
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
 static void stm32_usart_transmit_chars_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -713,43 +749,24 @@ static void stm32_usart_disable_ms(struct uart_port *port)
 static void stm32_usart_stop_tx(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct serial_rs485 *rs485conf = &port->rs485;
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	stm32_usart_tx_interrupt_disable(port);
 	if (stm32_usart_tx_dma_started(stm32_port) && stm32_usart_tx_dma_enabled(stm32_port))
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 
-	if (rs485conf->flags & SER_RS485_ENABLED) {
-		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl & ~TIOCM_RTS);
-		} else {
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl | TIOCM_RTS);
-		}
-	}
+	stm32_usart_rs485_rts_disable(port);
 }
 
 /* There are probably characters waiting to be transmitted. */
 static void stm32_usart_start_tx(struct uart_port *port)
 {
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct serial_rs485 *rs485conf = &port->rs485;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (uart_circ_empty(xmit) && !port->x_char)
 		return;
 
-	if (rs485conf->flags & SER_RS485_ENABLED) {
-		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl | TIOCM_RTS);
-		} else {
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl & ~TIOCM_RTS);
-		}
-	}
+	stm32_usart_rs485_rts_enable(port);
 
 	stm32_usart_transmit_chars(port);
 }
-- 
2.35.1

