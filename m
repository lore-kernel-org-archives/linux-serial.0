Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D18C001DF
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 03:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjHCDY4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Aug 2023 23:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHCDYd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Aug 2023 23:24:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687DE358D
        for <linux-serial@vger.kernel.org>; Wed,  2 Aug 2023 20:24:25 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGYyh4TTNztRn5;
        Thu,  3 Aug 2023 11:21:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 11:24:22 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <ychuang3@nuvoton.com>, <schung@nuvoton.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <lizetao1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Subject: [PATCH -next] tty: serial: Remove redundant initialization for ma35d1serial_driver
Date:   Thu, 3 Aug 2023 11:23:53 +0800
Message-ID: <20230803032353.3045221-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a warning reported by coccinelle:

./drivers/tty/serial/ma35d1_serial.c:791:3-8:
	No need to set .owner here. The core will do it.

The module_platform_driver() will set "THIS_MODULE" to driver.owner
when register a driver for platform-level devices, so it is redundant
initialization to set driver.owner in ma35d1serial_driver statement.
Remove it to silence the warning.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/tty/serial/ma35d1_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 789593495a80..465b1def9e11 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -788,7 +788,6 @@ static struct platform_driver ma35d1serial_driver = {
 	.resume     = ma35d1serial_resume,
 	.driver     = {
 		.name   = "ma35d1-uart",
-		.owner  = THIS_MODULE,
 		.of_match_table = of_match_ptr(ma35d1_serial_of_match),
 	},
 };
-- 
2.34.1

