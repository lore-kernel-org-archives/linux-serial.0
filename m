Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B0FC43461
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B2B613B9
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhERB6p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4720 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkfDj5zt4zmhDF;
        Tue, 18 May 2021 09:53:57 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:26 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:25 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 05/11] tty: serial: apbuart: Fix some coding sytle issues
Date:   Tue, 18 May 2021 09:57:12 +0800
Message-ID: <1621303038-12062-6-git-send-email-f.fangjian@huawei.com>
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

Fix 4 coding style warnings reported by checkpatch.pl.

There is 1 "labels should not be indented" warning, and the
remaining 3 warnings are "Missing a blank line after declarations".

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/apbuart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index d8c937b..196b571 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -113,7 +113,7 @@ static void apbuart_rx_chars(struct uart_port *port)
 		uart_insert_char(port, rsr, UART_STATUS_OE, ch, flag);
 
 
-	      ignore_char:
+ignore_char:
 		status = UART_GET_STATUS(port);
 	}
 
@@ -175,6 +175,7 @@ static irqreturn_t apbuart_int(int irq, void *dev_id)
 static unsigned int apbuart_tx_empty(struct uart_port *port)
 {
 	unsigned int status = UART_GET_STATUS(port);
+
 	return status & UART_STATUS_THE ? TIOCSER_TEMT : 0;
 }
 
@@ -311,6 +312,7 @@ static int apbuart_verify_port(struct uart_port *port,
 			       struct serial_struct *ser)
 {
 	int ret = 0;
+
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_APBUART)
 		ret = -EINVAL;
 	if (ser->irq < 0 || ser->irq >= NR_IRQS)
@@ -416,6 +418,7 @@ static void apbuart_flush_fifo(struct uart_port *port)
 static void apbuart_console_putchar(struct uart_port *port, int ch)
 {
 	unsigned int status;
+
 	do {
 		status = UART_GET_STATUS(port);
 	} while (!UART_TX_READY(status));
-- 
2.7.4

