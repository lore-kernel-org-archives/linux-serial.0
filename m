Return-Path: <SRS0=2m+P=4R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF58C3F2CD
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144C124697
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 16:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eaxlabs.cz header.i=@eaxlabs.cz header.b="NkxIiuTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgB2QaI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:30:08 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:33614 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgB2QaI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Feb 2020 11:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Message-Id:Date:Subject:Cc:To:From; bh=Ckgfb+tZ4UayimR7ATmjnhS6EOieCUCK3o2mRGl5D0k=;
        b=NkxIiuTkB7rHeUHTFzQ7/Guyj4/QwnLwBusq91zKwUl1NgwFnwEKxYW/yZ7r7f17urT6PP6bkyrUgqGcFcEssp0wR0gN49vFfEDPV+SP1orpR+bsrCORGoOchWPOT/CQ/8LM59e90KbPeBXjhNzNJoLzRgZ0HZ36scpn5WpNERw=;
Received: from [82.99.129.6] (helo=localhost.localdomain)
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1j84cV-000150-TL; Sat, 29 Feb 2020 17:05:42 +0100
From:   Martin Devera <devik@eaxlabs.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     Martin Devera <devik@eaxlabs.cz>
Subject: [PATCH 1/2] tty/serial: Add st,swap OF option to stm32-usart
Date:   Sat, 29 Feb 2020 17:05:06 +0100
Message-Id: <20200229160507.31309-1-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

STM32 F7/H7 usarts supports RX & TX pin swapping.
Add option to turn it on.
Tested on STM32MP157.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
---
 drivers/tty/serial/stm32-usart.c | 3 ++-
 drivers/tty/serial/stm32-usart.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index fdcc2142aa79..8d25869a02eb 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -780,7 +780,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	cr1 = USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
-	cr2 = 0;
+	cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;
 
 	/* Tx and RX FIFO configuration */
 	cr3 = readl_relaxed(port->membase + ofs->cr3);
@@ -1097,6 +1097,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 
 	stm32_ports[id].hw_flow_control = of_property_read_bool(np,
 							"st,hw-flow-ctrl");
+	stm32_ports[id].swap = of_property_read_bool(np, "st,swap");
 	stm32_ports[id].port.line = id;
 	stm32_ports[id].cr1_irq = USART_CR1_RXNEIE;
 	stm32_ports[id].cr3_irq = 0;
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 2a68bc48652e..2503a91b890c 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -275,6 +275,7 @@ struct stm32_port {
 	enum dma_cb rx_dma_cb;	 /* dma rx callback status    */
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
+	bool swap;		 /* swap RX & TX pins */
 	bool fifoen;
 	int wakeirq;
 	struct pinctrl_state *console_pins;
-- 
2.11.0

