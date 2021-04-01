Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2564C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 07:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA406108B
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 07:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhDAHtp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 03:49:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14663 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhDAHta (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 03:49:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9wHY48VHznX5d;
        Thu,  1 Apr 2021 15:46:49 +0800 (CST)
Received: from huawei.com (10.67.174.166) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 15:49:19 +0800
From:   Zucheng Zheng <zhengzucheng@huawei.com>
To:     <alcooperx@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>, <hucool.lihua@huawei.com>
Subject: [PATCH -next] serial: 8250: Make symbol 'brcmuart_debugfs_root' static
Date:   Thu, 1 Apr 2021 15:49:19 +0800
Message-ID: <20210401074919.56573-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.166]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

symbol 'brcmuart_debugfs_root' is not used outside of 8250_bcm7271.c,
so this commit marks it static.

Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 63883185fccd..ebba7f2e960c 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -239,7 +239,7 @@ struct brcmuart_priv {
 	u32		rx_abort;
 };
 
-struct dentry *brcmuart_debugfs_root;
+static struct dentry *brcmuart_debugfs_root;
 
 /*
  * Register access routines
-- 
2.17.1

