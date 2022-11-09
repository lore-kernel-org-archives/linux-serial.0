Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591FBC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 08:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKIIqb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKIIqa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 03:46:30 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F610E
        for <linux-serial@vger.kernel.org>; Wed,  9 Nov 2022 00:46:29 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6dqC2mDPz15MRV;
        Wed,  9 Nov 2022 16:46:15 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:46:27 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <andre.przywara@arm.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-serial@vger.kernel.org>
Subject: [PATCH] serial: pl011: Fix error handling in pl011_init()
Date:   Wed, 9 Nov 2022 16:46:26 +0800
Message-ID: <20221109084626.2032013-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When amba_driver_register failed, we need to unregister the platform
driver which have been registered, otherwise there maybe resource leak,
so we add error handlings in pl011_init() to fix it.

Fixes: 0dd1e247fd39 ("drivers: PL011: add support for the ARM SBSA generic UART")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6d8552506091..ef6d9941f972 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2982,11 +2982,23 @@ static struct amba_driver pl011_driver = {
 
 static int __init pl011_init(void)
 {
+	int ret;
+
 	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
 
-	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
+	ret = platform_driver_register(&arm_sbsa_uart_platform_driver);
+	if (unlikely(ret)) {
 		pr_warn("could not register SBSA UART platform driver\n");
-	return amba_driver_register(&pl011_driver);
+		return ret;
+	}
+
+	ret = amba_driver_register(&pl011_driver);
+	if (unlikely(ret)) {
+		platform_driver_unregister(&arm_sbsa_uart_platform_driver);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void __exit pl011_exit(void)
-- 
2.25.1

