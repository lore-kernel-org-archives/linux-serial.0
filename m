Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C070DC43462
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 03:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892D261405
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 03:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhEMDDJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 23:03:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2578 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhEMDDI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 23:03:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgbwP4xRRzsRQL;
        Thu, 13 May 2021 10:59:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 11:01:49 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 04/12] tty: serial: ip22zilog: include <linux/io.h> instead of <asm/io.h>
Date:   Thu, 13 May 2021 11:01:36 +0800
Message-ID: <1620874904-39285-5-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620874904-39285-1-git-send-email-f.fangjian@huawei.com>
References: <1620874904-39285-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Zihao Tang <tangzihao1@hisilicon.com>

Include the more general linux/io.h instead of asm/io.h
as checkpatch suggests.

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/ip22zilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 86fff69..f4dc5fe 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -31,7 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/irq.h>
 #include <asm/sgialib.h>
 #include <asm/sgi/ioc.h>
-- 
2.7.4

