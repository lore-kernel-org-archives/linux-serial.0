Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BFC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jul 2022 02:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiGOCgA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCf7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 22:35:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C9481E6
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 19:35:58 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lkb5L3n6JzkX72;
        Fri, 15 Jul 2022 10:33:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 10:35:33 +0800
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Jul
 2022 10:35:32 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>
CC:     <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <athierry@redhat.com>, <linux-serial@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <xuqiang36@huawei.com>
Subject: [PATCH -next v3] serial: 8250_bcm2835aux: Add missing clk_disable_unprepare()
Date:   Fri, 15 Jul 2022 10:33:12 +0800
Message-ID: <20220715023312.37808-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7c4eaa8e-2812-b805-c81b-9964a5cb6b52@huawei.com>
References: <7c4eaa8e-2812-b805-c81b-9964a5cb6b52@huawei.com>
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

Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
---
v2:
- Change title to more standard format
- Add details about how Hulk Robot report this issue.
v3:
- add which commit this patch fixes
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 047e14ccb165..15a2387a5b25 100644
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

