Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE8C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 03:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC6061417
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 03:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhEMDDJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 23:03:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2577 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEMDDI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 23:03:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgbwP560YzsRQM;
        Thu, 13 May 2021 10:59:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 11:01:52 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 11/12] tty: serial: vr41xx_siu: include <linux/io.h> instead of <asm/io.h>
Date:   Thu, 13 May 2021 11:01:43 +0800
Message-ID: <1620874904-39285-12-git-send-email-f.fangjian@huawei.com>
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
 drivers/tty/serial/vr41xx_siu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index eeb4b65..647198b1 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -20,7 +20,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/vr41xx/siu.h>
 #include <asm/vr41xx/vr41xx.h>
 
-- 
2.7.4

