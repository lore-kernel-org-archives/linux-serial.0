Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B9C001E0
	for <linux-serial@archiver.kernel.org>; Wed,  9 Aug 2023 08:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjHII4V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Aug 2023 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHII4U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Aug 2023 04:56:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B631FDC
        for <linux-serial@vger.kernel.org>; Wed,  9 Aug 2023 01:56:17 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLP2j2VHBz9tmL;
        Wed,  9 Aug 2023 16:52:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 16:56:13 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ilpo.jarvinen@linux.intel.com>, <richard.genoud@gmail.com>,
        <samuel.holland@sifive.com>, <frank.li@vivo.com>,
        <linux-serial@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] serial: sifive: Remove redundant of_match_ptr()
Date:   Wed, 9 Aug 2023 16:55:41 +0800
Message-ID: <20230809085541.2969654-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/tty/serial/sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 3ac9fbd0226e..e2efc3f84eff 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1031,7 +1031,7 @@ static struct platform_driver sifive_serial_platform_driver = {
 	.remove		= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
-		.of_match_table = of_match_ptr(sifive_serial_of_match),
+		.of_match_table = sifive_serial_of_match,
 	},
 };
 
-- 
2.34.1

