Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07693C433ED
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC332613B9
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhERB6p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4652 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkfFX4f10z16Q6w;
        Tue, 18 May 2021 09:54:40 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:25 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:25 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 02/11] tty: serial: amba-pl010: Fix 2 coding style issues
Date:   Tue, 18 May 2021 09:57:09 +0800
Message-ID: <1621303038-12062-3-git-send-email-f.fangjian@huawei.com>
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

Fix the following 2 coding style issues reported by checkpatch.pl:

  ERROR: trailing whitespace
  #387: FILE: ./drivers/tty/serial/amba-pl010.c:387

  ERROR: Macros with complex values should be enclosed in parentheses
  #676: FILE: ./drivers/tty/serial/amba-pl010.c:676

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/amba-pl010.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index e744b95..b12ad58 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -384,7 +384,7 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, uap->port.uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, uap->port.uartclk/16);
 	quot = uart_get_divisor(port, baud);
 
 	switch (termios->c_cflag & CSIZE) {
@@ -673,7 +673,7 @@ static struct console amba_console = {
 	.data		= &amba_reg,
 };
 
-#define AMBA_CONSOLE	&amba_console
+#define AMBA_CONSOLE	(&amba_console)
 #else
 #define AMBA_CONSOLE	NULL
 #endif
-- 
2.7.4

