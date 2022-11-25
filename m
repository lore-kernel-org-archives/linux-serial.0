Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA2C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 25 Nov 2022 09:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKYJlY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKYJlC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Nov 2022 04:41:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7F3D91C
        for <linux-serial@vger.kernel.org>; Fri, 25 Nov 2022 01:40:38 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJVFv3gYYzRpVR;
        Fri, 25 Nov 2022 17:40:03 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 25 Nov
 2022 17:40:36 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <alan@linux.intel.com>, <joshua.henderson@microchip.com>,
        <andrei.pistirica@microchip.com>, <ralf@linux-mips.org>,
        <linux-serial@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] serial: pic32: Add checks for devm_clk_get() in pic32_uart_probe()
Date:   Fri, 25 Nov 2022 09:38:32 +0000
Message-ID: <20221125093832.33386-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As the devm_clk_get() may return ERR_PTR, its return value needs to be
checked to avoid invalid poineter dereference.

Fixes: 157b9394709e ("serial: pic32_uart: Add PIC32 UART driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/tty/serial/pic32_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 2beada66c824..ad16c5d28a30 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -890,6 +890,8 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	sport->irq_rx		= irq_of_parse_and_map(np, 1);
 	sport->irq_tx		= irq_of_parse_and_map(np, 2);
 	sport->clk		= devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sport->clk))
+		return PTR_ERR(sport->clk);
 	sport->dev		= &pdev->dev;
 
 	/* Hardware flow control: gpios
-- 
2.17.1

