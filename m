Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B838C43617
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0128613BB
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbhERB6r (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4722 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346159AbhERB6p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:45 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkfDk4Q6mzmhpn;
        Tue, 18 May 2021 09:53:58 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
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
Subject: [PATCH 10/11] tty: serial: dz: Use 'unsigned int' instead of 'unsigned'
Date:   Tue, 18 May 2021 09:57:17 +0800
Message-ID: <1621303038-12062-11-git-send-email-f.fangjian@huawei.com>
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

Fix 2 "WARNING: Prefer 'unsigned int' to bare use of 'unsigned'"
warnings reported by checkpatch.pl:

  WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
  #99: FILE: ./drivers/tty/serial/dz.c:99:
  +static u16 dz_in(struct dz_port *dport, unsigned offset)

  WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
  #106: FILE: ./drivers/tty/serial/dz.c:106:
  +static void dz_out(struct dz_port *dport, unsigned offset, u16 value)

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/dz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 4552742..5ba26d2 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -96,14 +96,14 @@ static inline struct dz_port *to_dport(struct uart_port *uport)
  * ------------------------------------------------------------
  */
 
-static u16 dz_in(struct dz_port *dport, unsigned offset)
+static u16 dz_in(struct dz_port *dport, unsigned int offset)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
 	return readw(addr);
 }
 
-static void dz_out(struct dz_port *dport, unsigned offset, u16 value)
+static void dz_out(struct dz_port *dport, unsigned int offset, u16 value)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
-- 
2.7.4

