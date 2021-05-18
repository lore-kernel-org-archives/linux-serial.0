Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896BC43603
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0DA613BE
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhERB6q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2956 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245659AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkfFX1dC6zCtHX;
        Tue, 18 May 2021 09:54:40 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
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
Subject: [PATCH 03/11] tty: serial: amba-pl011: Replace the unsuitable spaces with tabs
Date:   Tue, 18 May 2021 09:57:10 +0800
Message-ID: <1621303038-12062-4-git-send-email-f.fangjian@huawei.com>
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

Replace the unsuitable spaces at the start of a line reported by
checkpatch.pl with tabs:

  WARNING: please, no spaces at the start of a line
  #1813: FILE: ./drivers/tty/serial/amba-pl011.c:1813:
  +      unsigned long val;$

  WARNING: please, no spaces at the start of a line
  #1815: FILE: ./drivers/tty/serial/amba-pl011.c:1815:
  +      val = pl011_read(uap, lcrh);$

  WARNING: please, no spaces at the start of a line
  #1816: FILE: ./drivers/tty/serial/amba-pl011.c:1816:
  +      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);$

  WARNING: please, no spaces at the start of a line
  #1817: FILE: ./drivers/tty/serial/amba-pl011.c:1817:
  +      pl011_write(val, uap, lcrh);$

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/amba-pl011.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 78682c1..2a63e70 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1810,11 +1810,11 @@ static int sbsa_uart_startup(struct uart_port *port)
 static void pl011_shutdown_channel(struct uart_amba_port *uap,
 					unsigned int lcrh)
 {
-      unsigned long val;
+	unsigned long val;
 
-      val = pl011_read(uap, lcrh);
-      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
-      pl011_write(val, uap, lcrh);
+	val = pl011_read(uap, lcrh);
+	val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
+	pl011_write(val, uap, lcrh);
 }
 
 /*
-- 
2.7.4

