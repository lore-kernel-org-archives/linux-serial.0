Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A66C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 06:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiKGGYk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 01:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiKGGYi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 01:24:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25B10B5A;
        Sun,  6 Nov 2022 22:24:35 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5LmW53LHzRp42;
        Mon,  7 Nov 2022 14:24:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:24:33 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ben-linux@fluff.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.or>
Subject: [PATCH] tty: serial: samsung_tty: Fix clk resource leak issue
Date:   Mon, 7 Nov 2022 14:21:20 +0800
Message-ID: <20221107062120.20321-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In the s3c24xx_serial_get_options(), calling clk_get() without clk_put()
will cause clk resource leak issue, this patch fixes it.

Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/tty/serial/samsung_tty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 77d1363029f5..8a3bb9832172 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2529,9 +2529,10 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
 
 		clk = clk_get(port->dev, clk_name);
-		if (!IS_ERR(clk))
+		if (!IS_ERR(clk)) {
 			rate = clk_get_rate(clk);
-		else
+			clk_put(clk);
+		} else
 			rate = 1;
 
 		*baud = rate / (16 * (ubrdiv + 1));
-- 
2.17.1

