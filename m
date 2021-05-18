Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A5C43611
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB4B613BA
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbhERB6q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3012 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346153AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkfG72mLlzlfdF;
        Tue, 18 May 2021 09:55:11 +0800 (CST)
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
Subject: [PATCH 08/11] tty: serial: clps711x: Fix some coding style issuses
Date:   Tue, 18 May 2021 09:57:15 +0800
Message-ID: <1621303038-12062-9-git-send-email-f.fangjian@huawei.com>
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
  #365: FILE: ./drivers/tty/serial/clps711x.c:365:
  +					unsigned n)

  WARNING: suspect code indent for conditional statements (8, 12)
  #486: FILE: ./drivers/tty/serial/clps711x.c:486:
  +	if (IS_ERR(s->gpios))
  +	    return PTR_ERR(s->gpios);

  WARNING: Statements should start on a tabstop
  #487: FILE: ./drivers/tty/serial/clps711x.c:487:
  +	    return PTR_ERR(s->gpios);

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/clps711x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 95abc6f..3a7a76c 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -362,7 +362,7 @@ static void uart_clps711x_console_putchar(struct uart_port *port, int ch)
 }
 
 static void uart_clps711x_console_write(struct console *co, const char *c,
-					unsigned n)
+					unsigned int n)
 {
 	struct uart_port *port = clps711x_uart.state[co->index].uart_port;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
@@ -484,7 +484,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 
 	s->gpios = mctrl_gpio_init_noauto(&pdev->dev, 0);
 	if (IS_ERR(s->gpios))
-	    return PTR_ERR(s->gpios);
+		return PTR_ERR(s->gpios);
 
 	ret = uart_add_one_port(&clps711x_uart, &s->port);
 	if (ret)
-- 
2.7.4

