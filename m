Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE75C43217
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 07:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKIHWt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKIHWs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 02:22:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86E1DF0F
        for <linux-serial@vger.kernel.org>; Tue,  8 Nov 2022 23:22:46 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6btc1cR1zpVt4;
        Wed,  9 Nov 2022 15:19:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 15:22:44 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <alcooperx@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] serial: 8250_bcm7271: Fix error handling in brcmuart_init()
Date:   Wed, 9 Nov 2022 07:21:10 +0000
Message-ID: <20221109072110.117291-2-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109072110.117291-1-yuancan@huawei.com>
References: <20221109072110.117291-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A problem about 8250_bcm7271 create debugfs failed is triggered with the
following log given:

 [  324.516635] debugfs: Directory 'bcm7271-uart' with parent '/' already present!

The reason is that brcmuart_init() returns platform_driver_register()
directly without checking its return value, if platform_driver_register()
failed, it returns without destroy the newly created debugfs, resulting
the debugfs of 8250_bcm7271 can never be created later.

 brcmuart_init()
   debugfs_create_dir() # create debugfs directory
   platform_driver_register()
     driver_register()
       bus_add_driver()
         priv = kzalloc(...) # OOM happened
   # return without destroy debugfs directory

Fix by removing debugfs when platform_driver_register() returns error.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index fa8ccf204d86..89bfcefbea84 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1212,9 +1212,17 @@ static struct platform_driver brcmuart_platform_driver = {
 
 static int __init brcmuart_init(void)
 {
+	int ret;
+
 	brcmuart_debugfs_root = debugfs_create_dir(
 		brcmuart_platform_driver.driver.name, NULL);
-	return platform_driver_register(&brcmuart_platform_driver);
+	ret = platform_driver_register(&brcmuart_platform_driver);
+	if (ret) {
+		debugfs_remove_recursive(brcmuart_debugfs_root);
+		return ret;
+	}
+
+	return 0;
 }
 module_init(brcmuart_init);
 
-- 
2.17.1

