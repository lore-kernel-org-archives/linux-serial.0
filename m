Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453BC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 11 May 2022 07:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiEKHBh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 May 2022 03:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiEKHBd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 May 2022 03:01:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356648E40;
        Wed, 11 May 2022 00:01:32 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kym3475jfzGpcY;
        Wed, 11 May 2022 14:58:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 15:01:28 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] tty: serial: max3100: Add missing uart_unregister_driver in max3100_probe
Date:   Wed, 11 May 2022 15:15:23 +0800
Message-ID: <20220511071523.3128725-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

max3100_probe misses a call uart_unregister_driver in error path,
this patch fixes that.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/tty/serial/max3100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 0b5f21fbb53d..6d34ca2a3f7b 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -752,6 +752,7 @@ static int max3100_probe(struct spi_device *spi)
 		if (!max3100s[i])
 			break;
 	if (i == MAX_MAX3100) {
+		uart_unregister_driver(&max3100_uart_driver);
 		dev_warn(&spi->dev, "too many MAX3100 chips\n");
 		mutex_unlock(&max3100s_lock);
 		return -ENOMEM;
@@ -759,6 +760,7 @@ static int max3100_probe(struct spi_device *spi)

 	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
 	if (!max3100s[i]) {
+		uart_unregister_driver(&max3100_uart_driver);
 		dev_warn(&spi->dev,
 			 "kmalloc for max3100 structure %d failed!\n", i);
 		mutex_unlock(&max3100s_lock);
--
2.31.1

