Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA33C43334
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jun 2022 03:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379748AbiFQDET (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jun 2022 23:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379503AbiFQDES (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jun 2022 23:04:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B466226;
        Thu, 16 Jun 2022 20:04:18 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPP1h3ztSzSgxV;
        Fri, 17 Jun 2022 11:00:56 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 11:04:09 +0800
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 11:04:08 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <nsaenz@kernel.org>, <athierry@redhat.com>,
        <linux-serial@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH -next] drivers/tty/serial: Add missing clk_disable_unprepare()
Date:   Fri, 17 Jun 2022 10:58:27 +0800
Message-ID: <20220617025827.130497-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add missing clk_disable_unprepare() when get clk rate fails.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 2a1226a78a0c..21939bb44613 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -166,8 +166,10 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	uartclk = clk_get_rate(data->clk);
 	if (!uartclk) {
 		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
+			goto dis_clk;
+		}
 	}
 
 	/* the HW-clock divider for bcm2835aux is 8,
-- 
2.17.1

