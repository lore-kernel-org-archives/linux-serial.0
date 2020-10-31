Return-Path: <SRS0=Jo6V=EG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C7C4742C
	for <linux-serial@archiver.kernel.org>; Sat, 31 Oct 2020 01:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9085221EB
	for <linux-serial@archiver.kernel.org>; Sat, 31 Oct 2020 01:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgJaBNX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Oct 2020 21:13:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJaBNX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Oct 2020 21:13:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNLlj0BVDzhdJg;
        Sat, 31 Oct 2020 09:13:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 09:13:10 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] serial: txx9: add missing platform_driver_unregister() on error in serial_txx9_init
Date:   Sat, 31 Oct 2020 09:18:57 +0800
Message-ID: <20201031011857.137352-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the missing platform_driver_unregister() before return
from serial_txx9_init in the error handling case when failed
to register serial_txx9_pci_driver with macro ENABLE_SERIAL_TXX9_PCI
defined.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/tty/serial/serial_txx9.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index b4d89e317..3d883cd55 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1280,10 +1280,13 @@ static int __init serial_txx9_init(void)
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
 	ret = pci_register_driver(&serial_txx9_pci_driver);
+	if (ret)
+		goto unreg_platform_drv;
 #endif
-	if (ret == 0)
-		goto out;
+	return 0;
 
+ unreg_platform_drv:
+	platform_driver_unregister(&serial_txx9_plat_driver);
  del_dev:
 	platform_device_del(serial_txx9_plat_devs);
  put_dev:
-- 
2.23.0

