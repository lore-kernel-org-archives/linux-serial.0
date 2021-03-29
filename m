Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B77C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 13:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AE461938
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC2N5t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:57:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14187 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhC2N5W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 09:57:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8DbR0bRRzmbfb;
        Mon, 29 Mar 2021 21:54:43 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 21:57:10 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Al Cooper <alcooperx@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] serial: 8250_bcm7271: Fix return value check in brcmuart_probe()
Date:   Mon, 29 Mar 2021 14:06:59 +0000
Message-ID: <20210329140659.1832950-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In case of error, the function devm_ioremap() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 63883185fccd..a4f3f6301d4f 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -974,8 +974,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 			break;
 		priv->regs[x] =	devm_ioremap(dev, regs->start,
 					     resource_size(regs));
-		if (IS_ERR(priv->regs[x]))
-			return PTR_ERR(priv->regs[x]);
+		if (!priv->regs[x])
+			return -ENOMEM;
 		if (x == REGS_8250) {
 			mapbase = regs->start;
 			membase = priv->regs[x];

