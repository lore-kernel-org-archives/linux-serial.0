Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B562C83F2D
	for <linux-serial@archiver.kernel.org>; Sun,  3 Sep 2023 10:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbjICKNn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 3 Sep 2023 06:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjICKNn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 3 Sep 2023 06:13:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C509D93
        for <linux-serial@vger.kernel.org>; Sun,  3 Sep 2023 03:13:39 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RdnYw6vDRztRgf;
        Sun,  3 Sep 2023 18:09:40 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sun, 3 Sep 2023 18:13:36 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <jag.raman@oracle.com>
CC:     <linux-serial@vger.kernel.org>
Subject: [PATCH] tty: vcc: Add check for kstrdup() in vcc_probe()
Date:   Sun, 3 Sep 2023 18:13:22 +0800
Message-ID: <20230903101322.205537-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add check for the return value of kstrdup() and return the error, if it
fails in order to avoid NULL pointer dereference.

Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/tty/vcc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index a39ed981bfd3..420d334f6077 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -579,6 +579,10 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		return -ENOMEM;
 
 	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
+	if (!name) {
+		kfree(port);
+		return -ENOMEM;
+	}
 
 	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
 			     ARRAY_SIZE(vcc_versions), NULL, name);
@@ -624,6 +628,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto unreg_tty;
 	}
 	port->domain = kstrdup(domain, GFP_KERNEL);
+	if (!port->domain) {
+		rv = -ENOMEM;
+		goto unreg_tty;
+	}
+
 
 	mdesc_release(hp);
 
-- 
2.17.1

