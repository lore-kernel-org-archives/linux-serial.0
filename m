Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A084C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 24 Nov 2022 06:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKXGOo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Nov 2022 01:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKXGOn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Nov 2022 01:14:43 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3098664A09
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 22:14:39 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NHngY05nszJnsw;
        Thu, 24 Nov 2022 14:11:21 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 14:14:37 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <shc_work@mail.ru>, <arnd@arndb.de>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] serial: clps711x: Fix error handling in uart_clps711x_init()
Date:   Thu, 24 Nov 2022 06:12:36 +0000
Message-ID: <20221124061236.31050-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The uart_clps711x_init() returns the platform_driver_register() directly
without checking its return value, if platform_driver_register() failed,
the clps711x_uart is not unregistered.

Fix by unregister clps711x_uart when platform_driver_register() failed.

Fixes: bc00024502ed ("serial: clps711x: Driver refactor")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/tty/serial/clps711x.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 404b43a5ae33..d6284244da1d 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -546,7 +546,13 @@ static int __init uart_clps711x_init(void)
 	if (ret)
 		return ret;
 
-	return platform_driver_register(&clps711x_uart_platform);
+	ret = platform_driver_register(&clps711x_uart_platform);
+	if (ret) {
+		uart_unregister_driver(&clps711x_uart);
+		return ret;
+	}
+
+	return 0;
 }
 module_init(uart_clps711x_init);
 
-- 
2.17.1

