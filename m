Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749CBC433E9
	for <linux-serial@archiver.kernel.org>; Wed, 23 Dec 2020 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BB423343
	for <linux-serial@archiver.kernel.org>; Wed, 23 Dec 2020 14:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgLWOO5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:14:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9918 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgLWOO5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Dec 2020 09:14:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D1FYQ2XDfz7K8j;
        Wed, 23 Dec 2020 22:13:30 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:14:05 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tty: serial: Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 23 Dec 2020 22:14:38 +0800
Message-ID: <20201223141438.889-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/tty/serial/icom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 94c8281ddb5f..9a872750581c 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -118,7 +118,7 @@ MODULE_DEVICE_TABLE(pci, icom_pci_table);
 static LIST_HEAD(icom_adapter_head);
 
 /* spinlock for adapter initialization and changing adapter operations */
-static spinlock_t icom_lock;
+static DEFINE_SPINLOCK(icom_lock);
 
 #ifdef ICOM_TRACE
 static inline void trace(struct icom_port *icom_port, char *trace_pt,
@@ -1616,8 +1616,6 @@ static int __init icom_init(void)
 {
 	int ret;
 
-	spin_lock_init(&icom_lock);
-
 	ret = uart_register_driver(&icom_uart_driver);
 	if (ret)
 		return ret;
-- 
2.22.0

