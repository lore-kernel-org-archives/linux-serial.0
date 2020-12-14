Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37041C4361B
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E439E229C5
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 13:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgLNNiX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 08:38:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9174 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbgLNNiO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 08:38:14 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cvj9M0G8Kz15f87;
        Mon, 14 Dec 2020 21:36:55 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:37:24 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Zheng Yongjun" <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tty/serial/lantiq: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:37:55 +0800
Message-ID: <20201214133755.3945-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/tty/serial/lantiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 62813e421f12..497b334bc845 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -876,7 +876,7 @@ static int lqasc_probe(struct platform_device *pdev)
 	port->flags	= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops	= &lqasc_pops;
 	port->fifosize	= 16;
-	port->type	= PORT_LTQ_ASC,
+	port->type	= PORT_LTQ_ASC;
 	port->line	= line;
 	port->dev	= &pdev->dev;
 	/* unused, just to be backward-compatible */
-- 
2.22.0

