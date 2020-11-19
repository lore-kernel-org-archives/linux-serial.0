Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C265C63697
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0522246CA
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 14:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKSOHz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Nov 2020 09:07:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7706 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKSOHz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Nov 2020 09:07:55 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CcM2C5Hmbzkbn8;
        Thu, 19 Nov 2020 22:07:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Nov 2020
 22:07:49 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] serial: 8250-mtk: Fix reference leak in mtk8250_probe
Date:   Thu, 19 Nov 2020 22:11:26 +0800
Message-ID: <20201119141126.168850-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
Thus a pairing decrement is needed on the error handling
path to keep it balanced according to context.

Fixes: e32a83c70cf98 ("serial: 8250-mtk: modify mtk uart power and clock management")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index fa876e2c13e5..f7d3023f860f 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -572,15 +572,22 @@ static int mtk8250_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	err = mtk8250_runtime_resume(&pdev->dev);
 	if (err)
-		return err;
+		goto err_pm_disable;
 
 	data->line = serial8250_register_8250_port(&uart);
-	if (data->line < 0)
-		return data->line;
+	if (data->line < 0) {
+		err = data->line;
+		goto err_pm_disable;
+	}
 
 	data->rx_wakeup_irq = platform_get_irq_optional(pdev, 1);
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+	return err;
 }
 
 static int mtk8250_remove(struct platform_device *pdev)
-- 
2.25.4

