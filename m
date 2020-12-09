Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439AC1B0D8
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 09:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6D23B6B
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 09:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgLIJS1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 04:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgLIJS0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 04:18:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C8C0617A7
        for <linux-serial@vger.kernel.org>; Wed,  9 Dec 2020 01:17:46 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <str@pengutronix.de>)
        id 1kmvbT-0005wi-Gg; Wed, 09 Dec 2020 10:17:43 +0100
Received: from str by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <str@pengutronix.de>)
        id 1kmvbT-0000cq-5q; Wed, 09 Dec 2020 10:17:43 +0100
From:   Steffen Trumtrar <s.trumtrar@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 1/2] tty: serial: 8250: always call tx_chars under spinlock
Date:   Wed,  9 Dec 2020 10:17:27 +0100
Message-Id: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: str@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In most cases serial8250_tx_chars is called with spinlock held.
Fix the remaining location, too.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b0af13074cd3..3310c2b70138 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1559,6 +1559,7 @@ static void serial8250_stop_tx(struct uart_port *port)
 static inline void __start_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
 
 	if (up->dma && !up->dma->tx_dma(up))
 		return;
@@ -1569,8 +1570,11 @@ static inline void __start_tx(struct uart_port *port)
 
 			lsr = serial_in(up, UART_LSR);
 			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-			if (lsr & UART_LSR_THRE)
+			if (lsr & UART_LSR_THRE) {
+				spin_lock_irqsave(&port->lock, flags);
 				serial8250_tx_chars(up);
+				spin_unlock_irqrestore(&port->lock, flags);
+			}
 		}
 	}
 
-- 
2.20.1

