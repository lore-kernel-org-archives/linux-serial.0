Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4109C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 07:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiCAHms (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiCAHmr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 02:42:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E417CDD5;
        Mon, 28 Feb 2022 23:42:06 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K78Kq67k8zBrRV;
        Tue,  1 Mar 2022 15:40:15 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 15:42:03 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] serial: mvebu-uart: fix return value check in mvebu_uart_clock_probe()
Date:   Tue, 1 Mar 2022 07:58:06 +0000
Message-ID: <20220301075806.3950108-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Fixes: b7e2b5360f9b ("serial: mvebu-uart: implement UART clock driver for configuring UART base clock")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/serial/mvebu-uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 2e9263888ddc..45976e2140d4 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -1382,8 +1382,8 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 	 */
 	uart_clock_base->reg1 = devm_ioremap(dev, res->start,
 					     resource_size(res));
-	if (IS_ERR(uart_clock_base->reg1))
-		return PTR_ERR(uart_clock_base->reg1);
+	if (!uart_clock_base->reg1)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res) {
@@ -1401,8 +1401,8 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 	 */
 	uart_clock_base->reg2 = devm_ioremap(dev, res->start,
 					     resource_size(res));
-	if (IS_ERR(uart_clock_base->reg2))
-		return PTR_ERR(uart_clock_base->reg2);
+	if (!uart_clock_base->reg2)
+		return -ENOMEM;
 
 	hw_clk_data = devm_kzalloc(dev,
 				   struct_size(hw_clk_data, hws,

