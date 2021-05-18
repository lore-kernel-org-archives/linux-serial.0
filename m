Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B713C4360C
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3903A61361
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbhERB6q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3572 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkfFY6WM7zmV9n;
        Tue, 18 May 2021 09:54:41 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
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
Subject: [PATCH 09/11] tty: serial: digicolor: Use 'unsigned int' instead of 'unsigned'
Date:   Tue, 18 May 2021 09:57:16 +0800
Message-ID: <1621303038-12062-10-git-send-email-f.fangjian@huawei.com>
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

Fix the following checkpatch warnings:

  WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
  #393: FILE: ./drivers/tty/serial/digicolor-usart.c:393:
  +					 unsigned n)

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/digicolor-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 13ac36e..e26afd8 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -390,7 +390,7 @@ static void digicolor_uart_console_putchar(struct uart_port *port, int ch)
 }
 
 static void digicolor_uart_console_write(struct console *co, const char *c,
-					 unsigned n)
+					 unsigned int n)
 {
 	struct uart_port *port = digicolor_ports[co->index];
 	u8 status;
-- 
2.7.4

