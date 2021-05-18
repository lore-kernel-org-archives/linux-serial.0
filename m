Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA406C43600
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC706613AC
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbhERB6q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4653 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344630AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkfFY3Yc2z16QCr;
        Tue, 18 May 2021 09:54:41 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:26 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:26 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 07/11] tty: serial: bcm63xx_uart: Fix some coding style issues
Date:   Tue, 18 May 2021 09:57:14 +0800
Message-ID: <1621303038-12062-8-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
References: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Zihao Tang <tangzihao1@hisilicon.com>

Fix 5 coding style warings reported by checkpatch.pl.

Fix 4 "WARNING: Block comments use a trailing */ on a separate line".
Fix 1 "WARNING: Prefer 'unsigned int' to bare use of 'unsigned'".

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 5fb0e84..76e2ab6 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -231,21 +231,24 @@ static void bcm_uart_do_rx(struct uart_port *port)
 
 	/* limit number of char read in interrupt, should not be
 	 * higher than fifo size anyway since we're much faster than
-	 * serial port */
+	 * serial port
+	 */
 	max_count = 32;
 	do {
 		unsigned int iestat, c, cstat;
 		char flag;
 
 		/* get overrun/fifo empty information from ier
-		 * register */
+		 * register
+		 */
 		iestat = bcm_uart_readl(port, UART_IR_REG);
 
 		if (unlikely(iestat & UART_IR_STAT(UART_IR_RXOVER))) {
 			unsigned int val;
 
 			/* fifo reset is required to clear
-			 * interrupt */
+			 * interrupt
+			 */
 			val = bcm_uart_readl(port, UART_CTL_REG);
 			val |= UART_CTL_RSTRXFIFO_MASK;
 			bcm_uart_writel(port, val, UART_CTL_REG);
@@ -424,7 +427,8 @@ static void bcm_uart_flush(struct uart_port *port)
 	bcm_uart_writel(port, val, UART_CTL_REG);
 
 	/* read any pending char to make sure all irq status are
-	 * cleared */
+	 * cleared
+	 */
 	(void)bcm_uart_readl(port, UART_FIFO_REG);
 }
 
@@ -764,7 +768,7 @@ static int __init bcm63xx_console_init(void)
 
 console_initcall(bcm63xx_console_init);
 
-static void bcm_early_write(struct console *con, const char *s, unsigned n)
+static void bcm_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
-- 
2.7.4

