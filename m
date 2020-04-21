Return-Path: <SRS0=t3pX=6F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C329C54FC9
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 12:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D18F2075E
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 12:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgDUMZj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:25:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728576AbgDUMZj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Apr 2020 08:25:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A1180CA88C4FE8DFBF7B;
        Tue, 21 Apr 2020 20:25:36 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 20:25:26 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <f.fainelli@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] tty: serial: bcm63xx: fix missing clk_put() in bcm63xx_uart
Date:   Tue, 21 Apr 2020 20:31:46 +0800
Message-ID: <1587472306-105155-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch fixes below error reported by coccicheck

drivers/tty/serial/bcm63xx_uart.c:848:2-8: ERROR: missing clk_put;
clk_get on line 842 and execution via conditional on line 846

Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 5674da2..ed0aa5c 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -843,8 +843,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(clk) && pdev->dev.of_node)
 		clk = of_clk_get(pdev->dev.of_node, 0);
 
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		clk_put(clk);
 		return -ENODEV;
+	}
 
 	port->iotype = UPIO_MEM;
 	port->irq = res_irq->start;
-- 
2.6.2

