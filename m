Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F0C2D0E4
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 09:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFBC24698
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 09:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgKSJBJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:01:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7952 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKSJBI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Nov 2020 04:01:08 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CcDDQ26RbzhcQj;
        Thu, 19 Nov 2020 17:00:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 17:01:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <afaerber@suse.de>, <manivannan.sadhasivam@linaro.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Thu, 19 Nov 2020 17:01:29 +0800
Message-ID: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/tty/serial/owl-uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index c149f8c3..472fdaf 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -251,10 +251,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
 static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	unsigned long flags;
 	u32 stat;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	stat = owl_uart_read(port, OWL_UART_STAT);
 
@@ -268,7 +267,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
 	owl_uart_write(port, stat, OWL_UART_STAT);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock(&port->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

