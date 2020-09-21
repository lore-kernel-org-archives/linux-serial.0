Return-Path: <SRS0=VEyX=C6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0742C43468
	for <linux-serial@archiver.kernel.org>; Mon, 21 Sep 2020 13:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06D82076E
	for <linux-serial@archiver.kernel.org>; Mon, 21 Sep 2020 13:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgIUNLH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:11:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbgIUNLC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Sep 2020 09:11:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 46D57CD31CBB9DC7C72E;
        Mon, 21 Sep 2020 21:10:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:41 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] serial: mvebu-uart: simplify the return expression of mvebu_uart_probe()
Date:   Mon, 21 Sep 2020 21:11:05 +0800
Message-ID: <20200921131105.93177-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/tty/serial/mvebu-uart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 4e9a59071..7443c0506 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -912,10 +912,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	udelay(1);
 	writel(0, port->membase + UART_CTRL(port));
 
-	ret = uart_add_one_port(&mvebu_uart_driver, port);
-	if (ret)
-		return ret;
-	return 0;
+	return uart_add_one_port(&mvebu_uart_driver, port);
 }
 
 static struct mvebu_uart_driver_data uart_std_driver_data = {
-- 
2.23.0

