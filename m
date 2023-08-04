Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0454BC00528
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 10:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjHDKJQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHDKJO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 06:09:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADC2118
        for <linux-serial@vger.kernel.org>; Fri,  4 Aug 2023 03:09:13 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHLvJ0R66ztRqJ;
        Fri,  4 Aug 2023 18:05:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 18:09:11 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <JoseJavier.Rodriguez@duagon.com>, <jorge.sanjuangarcia@duagon.com>
CC:     <lizetao1@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <yangyingliang@huawei.com>, <linux-serial@vger.kernel.org>
Subject: [PATCH -next] 8250_men_mcb: Remove redundant initialization owner in mcb_driver
Date:   Fri, 4 Aug 2023 18:08:43 +0800
Message-ID: <20230804100843.100348-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The module_mcb_driver() will set "THIS_MODULE" to driver.owner when
register a mcb_driver driver, so it is redundant initialization to set
driver.owner in mcb_driver statement. Remove it for clean code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 14cf6011a002..55ed82a10e64 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -256,7 +256,6 @@ MODULE_DEVICE_TABLE(mcb, serial_8250_men_mcb_ids);
 static struct mcb_driver mcb_driver = {
 	.driver = {
 		.name = "8250_men_mcb",
-		.owner = THIS_MODULE,
 	},
 	.probe = serial_8250_men_mcb_probe,
 	.remove = serial_8250_men_mcb_remove,
-- 
2.34.1

