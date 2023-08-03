Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E33C04A94
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 14:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjHCOWQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 10:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjHCOVr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 10:21:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200493A9F
        for <linux-serial@vger.kernel.org>; Thu,  3 Aug 2023 07:21:25 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGrbQ1vV2zrS4q;
        Thu,  3 Aug 2023 22:20:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 22:21:22 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <jorge.sanjuangarcia@duagon.com>, <JoseJavier.Rodriguez@duagon.com>
CC:     <lizetao1@huawei.com>, <yangyingliang@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <linux-serial@vger.kernel.org>
Subject: [PATCH -next] 8250_men_mcb: Fix unsigned expression compared with zero
Date:   Thu, 3 Aug 2023 22:20:53 +0800
Message-ID: <20230803142053.1308926-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a warning reported by coccinelle:

./drivers/tty/serial/8250/8250_men_mcb.c:226:6-19: WARNING:
	Unsigned expression compared with zero: data -> line [ i ]     <     0

The array "line" of serial_8250_men_mcb_data is used to record the
registered serial port. When register a port failed, it will return
an error code, but the type of "line" is "unsigned int", causing
the error code to reverse. Modify the type of "data -> line" to solve
this problem.

Fixes: 2554e6ba28a2 ("8250_men_mcb: Read num ports from register data.")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 5f301195575d..14cf6011a002 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -46,7 +46,7 @@
 
 struct serial_8250_men_mcb_data {
 	int num_ports;
-	unsigned int line[MAX_PORTS];
+	int line[MAX_PORTS];
 	unsigned int offset[MAX_PORTS];
 };
 
-- 
2.34.1

