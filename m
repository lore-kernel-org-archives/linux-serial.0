Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA4AC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jul 2022 03:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGFDCc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jul 2022 23:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiGFDCb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jul 2022 23:02:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6451AF15
        for <linux-serial@vger.kernel.org>; Tue,  5 Jul 2022 20:02:26 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ld46y1q4hzkX38;
        Wed,  6 Jul 2022 11:00:58 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 11:02:25 +0800
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Jul
 2022 11:02:24 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <f.fainelli@gmail.com>,
        <ilpo.jarvinen@linux.intel.com>, <athierry@redhat.com>,
        <linux-serial@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <xuqiang36@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [PATCH -next v2] serial: 8250_bcm2835aux: Add missing clk_disable_unprepare()
Date:   Wed, 6 Jul 2022 11:00:20 +0800
Message-ID: <20220706030020.11726-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220617025827.130497-1-guomengqi3@huawei.com>
References: <20220617025827.130497-1-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The error path when get clock frequency fails in bcm2835aux_serial
driver does not correctly disable the clock.

This flaw was found using a static analysis tool "Hulk Robot", which
reported the following warning when analyzing linux-next/master:

    drivers/tty/serial/8250/8250_bcm2835aux.c:
    warning: clk_disable_unprepare_missing.cocci

The cocci script checks for the existence of clk_disable_unprepare()
paired with clk_prepare_enable().

Add the missing clk_disable_unprepare() to the error path.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
---
v2:
- Change title to more standard format
- Add details about how Hulk Robot report this issue.
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index d9f1e618cfbd..f5718ff0cd8a 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -167,8 +167,10 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
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

