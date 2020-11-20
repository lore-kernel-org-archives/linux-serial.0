Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA4C388F9
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 01:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AB122256
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 01:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgKTB0f (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:26:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8004 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKTB0f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Nov 2020 20:26:35 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ccf5P0kYFzhbYS;
        Fri, 20 Nov 2020 09:26:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 09:26:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-unisoc@lists.infradead.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: serial: rad-uart: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Fri, 20 Nov 2020 09:26:53 +0800
Message-ID: <1605835613-28359-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/tty/serial/rda-uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 85366e0..d6705a0 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -406,10 +406,9 @@ static void rda_uart_receive_chars(struct uart_port *port)
 static irqreturn_t rda_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	unsigned long flags;
 	u32 val, irq_mask;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	/* Clear IRQ cause */
 	val = rda_uart_read(port, RDA_UART_IRQ_CAUSE);
@@ -426,7 +425,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 		rda_uart_send_chars(port);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock(&port->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

