Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1E2C001E0
	for <linux-serial@archiver.kernel.org>; Fri, 28 Jul 2023 09:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjG1JAG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Jul 2023 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjG1JAF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Jul 2023 05:00:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D61A8
        for <linux-serial@vger.kernel.org>; Fri, 28 Jul 2023 02:00:03 -0700 (PDT)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RC1jb4DyVzLnvP;
        Fri, 28 Jul 2023 16:57:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:00:00 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 16:59:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <JoseJavier.Rodriguez@duagon.com>,
        <jorge.sanjuangarcia@duagon.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] 8250_men_mcb: fix error handling in read_uarts_available_from_reg()
Date:   Fri, 28 Jul 2023 16:57:23 +0800
Message-ID: <20230728085723.3195044-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If ioremap() fails, it returns NULL pointer, not ERR_PTR(), fix the
return value check and call release_mem_region() to release resource.

Fixes: c563831ba879 ("8250_men_mcb: Make UART config auto configurable")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index c3143ffddea0..5f301195575d 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -94,8 +94,11 @@ static int read_uarts_available_from_register(struct resource *mem_res,
 
 	mem = ioremap(mem_res->start + MEN_Z025_REGISTER_OFFSET,
 		      MEM_UART_REGISTER_SIZE);
-	if (IS_ERR(mem))
+	if (!mem) {
+		release_mem_region(mem_res->start + MEN_Z025_REGISTER_OFFSET,
+				   MEM_UART_REGISTER_SIZE);
 		return -ENOMEM;
+	}
 
 	reg_value = MEN_READ_REGISTER(mem);
 
-- 
2.25.1

