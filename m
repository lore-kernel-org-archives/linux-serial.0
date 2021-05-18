Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788DFC433B4
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507C0613B9
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbhERB6o (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3002 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhERB6n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:43 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkfDh4rMQzQpBY;
        Tue, 18 May 2021 09:53:56 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
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
Subject: [PATCH 01/11] tty: serial: 21285: Fix some coding sytle issues
Date:   Tue, 18 May 2021 09:57:08 +0800
Message-ID: <1621303038-12062-2-git-send-email-f.fangjian@huawei.com>
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

Fix the following coding style issues reported by checkpatch.pl:

  ERROR: trailing whitespace
  #265: FILE: ./drivers/tty/serial/21285.c:265:
  +^Ibaud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); $

  ERROR: that open brace { should be on the previous line
  #483: FILE: ./drivers/tty/serial/21285.c:483:
  +static struct console serial21285_console =
  +{

  ERROR: Macros with complex values should be enclosed in parentheses
  #501: FILE: ./drivers/tty/serial/21285.c:501:
  +#define SERIAL_21285_CONSOLE	&serial21285_console

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/21285.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 09baef4..bb323a7 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -262,7 +262,7 @@ serial21285_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
 	quot = uart_get_divisor(port, baud);
 	b = port->uartclk / (16 * quot);
 	tty_termios_encode_baud_rate(termios, b, b);
@@ -479,8 +479,7 @@ static int __init serial21285_console_setup(struct console *co, char *options)
 
 static struct uart_driver serial21285_reg;
 
-static struct console serial21285_console =
-{
+static struct console serial21285_console = {
 	.name		= SERIAL_21285_NAME,
 	.write		= serial21285_console_write,
 	.device		= uart_console_device,
@@ -498,7 +497,7 @@ static int __init rs285_console_init(void)
 }
 console_initcall(rs285_console_init);
 
-#define SERIAL_21285_CONSOLE	&serial21285_console
+#define SERIAL_21285_CONSOLE	(&serial21285_console)
 #else
 #define SERIAL_21285_CONSOLE	NULL
 #endif
-- 
2.7.4

