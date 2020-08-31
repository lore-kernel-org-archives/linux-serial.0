Return-Path: <SRS0=jZzm=CJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B479C433E6
	for <linux-serial@archiver.kernel.org>; Mon, 31 Aug 2020 17:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FEE20658
	for <linux-serial@archiver.kernel.org>; Mon, 31 Aug 2020 17:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHaRK4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:10:56 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58714 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgHaRKx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Aug 2020 13:10:53 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BgGtf2qmcz1rypb;
        Mon, 31 Aug 2020 19:10:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BgGtf24qbz1qyXG;
        Mon, 31 Aug 2020 19:10:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id y_WuuKnbA_w3; Mon, 31 Aug 2020 19:10:48 +0200 (CEST)
X-Auth-Info: N5VmMcsO1sNzmZ2knTBd7OtIBn0GOGbLgeUexseSoqQ=
Received: from desktop.lan (ip-86-49-101-166.net.upcbroadband.cz [86.49.101.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 31 Aug 2020 19:10:48 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V3] serial: stm32: Add RS485 RTS GPIO control again
Date:   Mon, 31 Aug 2020 19:10:45 +0200
Message-Id: <20200831171045.205691-1-marex@denx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

While the STM32 does support RS485 drive-enable control within the
UART IP itself, some systems have the drive-enable line connected
to a pin which cannot be pinmuxed as RTS. Add support for toggling
the RTS GPIO line using the modem control GPIOs to provide at least
some sort of emulation.

Fixes: 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-stm32@st-md-mailman.stormreply.com
---
V2: Use mctrl_gpio_set() instead of stm32_set_mctrl()
V3: - Actually toggle the RTS line before and after TX
    - Undo 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control")
      which was previous version of this patch ; I messed up.
---
 drivers/tty/serial/stm32-usart.c | 33 ++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 143300a80090..23f7453441ae 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -129,13 +129,9 @@ static int stm32_config_rs485(struct uart_port *port,
 		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
 			cr3 &= ~USART_CR3_DEP;
 			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl & ~TIOCM_RTS);
 		} else {
 			cr3 |= USART_CR3_DEP;
 			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl | TIOCM_RTS);
 		}
 
 		writel_relaxed(cr3, port->membase + ofs->cr3);
@@ -541,17 +537,42 @@ static void stm32_disable_ms(struct uart_port *port)
 /* Transmit stop */
 static void stm32_stop_tx(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct serial_rs485 *rs485conf = &port->rs485;
+
 	stm32_tx_interrupt_disable(port);
+
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl & ~TIOCM_RTS);
+		} else {
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl | TIOCM_RTS);
+		}
+	}
 }
 
 /* There are probably characters waiting to be transmitted. */
 static void stm32_start_tx(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct serial_rs485 *rs485conf = &port->rs485;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (uart_circ_empty(xmit))
 		return;
 
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl | TIOCM_RTS);
+		} else {
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl & ~TIOCM_RTS);
+		}
+	}
+
 	stm32_transmit_chars(port);
 }
 
@@ -851,13 +872,9 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
 			cr3 &= ~USART_CR3_DEP;
 			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl & ~TIOCM_RTS);
 		} else {
 			cr3 |= USART_CR3_DEP;
 			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
-			mctrl_gpio_set(stm32_port->gpios,
-					stm32_port->port.mctrl | TIOCM_RTS);
 		}
 
 	} else {
-- 
2.28.0

