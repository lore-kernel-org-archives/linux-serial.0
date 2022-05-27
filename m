Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCAC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 27 May 2022 06:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiE0Ghx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 May 2022 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiE0Ghu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 02:37:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E0E2771;
        Thu, 26 May 2022 23:37:49 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L8Zm553FJzRhQZ;
        Fri, 27 May 2022 14:34:45 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:37:47 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:37:47 +0800
From:   keliu <liuke94@huawei.com>
To:     <robh@kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] serdev: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 06:59:16 +0000
Message-ID: <20220527065916.2359005-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/tty/serdev/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 0180e1e4e75d..213f8cb99661 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -75,7 +75,7 @@ static bool is_serdev_device(const struct device *dev)
 static void serdev_ctrl_release(struct device *dev)
 {
 	struct serdev_controller *ctrl = to_serdev_controller(dev);
-	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	ida_free(&ctrl_ida, ctrl->nr);
 	kfree(ctrl);
 }
 
@@ -486,7 +486,7 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
 	if (!ctrl)
 		return NULL;
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(parent,
 			"unable to allocate serdev controller identifier.\n");
-- 
2.25.1

