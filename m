Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A870AC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 25 May 2022 02:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiEYCBH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 May 2022 22:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiEYCBH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 May 2022 22:01:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629A129;
        Tue, 24 May 2022 19:01:05 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L7DmN6jJ2zjX44;
        Wed, 25 May 2022 10:00:20 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 10:01:03 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 10:01:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Subject: [PATCH -next] serial: pic32: fix missing clk_disable_unprepare() on error in pic32_uart_startup()
Date:   Wed, 25 May 2022 10:12:04 +0800
Message-ID: <20220525021204.2407631-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from pic32_uart_startup() in the error handling case.

Fixes: 157b9394709e ("serial: pic32_uart: Add PIC32 UART driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/serial/pic32_uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index b399aac530fe..f418f1de66b3 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -503,7 +503,7 @@ static int pic32_uart_startup(struct uart_port *port)
 	if (!sport->irq_fault_name) {
 		dev_err(port->dev, "%s: kasprintf err!", __func__);
 		ret = -ENOMEM;
-		goto out_done;
+		goto out_disable_clk;
 	}
 	irq_set_status_flags(sport->irq_fault, IRQ_NOAUTOEN);
 	ret = request_irq(sport->irq_fault, pic32_uart_fault_interrupt,
@@ -579,6 +579,8 @@ static int pic32_uart_startup(struct uart_port *port)
 out_f:
 	free_irq(sport->irq_fault, port);
 	kfree(sport->irq_fault_name);
+out_disable_clk:
+	clk_disable_unprepare(sport->clk);
 out_done:
 	return ret;
 }
-- 
2.25.1

