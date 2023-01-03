Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F3DC46467
	for <linux-serial@archiver.kernel.org>; Tue,  3 Jan 2023 11:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjACLTO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Jan 2023 06:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbjACLTK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Jan 2023 06:19:10 -0500
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 03:19:08 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D65F7F035
        for <linux-serial@vger.kernel.org>; Tue,  3 Jan 2023 03:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=GHdossT2byz3FqStEt
        qVa55bg+jCObJwbTHYvOwN8s8=; b=DGV4X3BtLm/3TLos2Wj+DmKVH25CHJQjni
        nCc+eqa5AEZqduKjZnUCCL8+zHlEaf3umoq1KTTww92kDotIC3Mby58F8l5mrf8k
        m703AbpY9zXdFBHI5hMZi4hE9WUtR54BW2yrjCX3/raY/zhaixxywGXyM9MrPuF/
        JzIGuEk5U=
Received: from localhost.localdomain (unknown [36.4.209.174])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wBX5gFjC7Rji6FaAA--.47821S4;
        Tue, 03 Jan 2023 19:03:39 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhe <sensor1010@163.com>
Subject: [PATCH v1] drivers/fsl_linflexuart.c : remove redundant uart type
Date:   Tue,  3 Jan 2023 03:02:55 -0800
Message-Id: <20230103110255.2699-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wBX5gFjC7Rji6FaAA--.47821S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFykZryrZr4xCr15tw1rtFb_yoW3WFb_Cw
        1DC34xWr109FyayFnrXFWYkrZagrs5ZF48ZF10vasaqw4DZw4rXryIqrZrursxJ3yUXr9r
        G397Wr12yrsrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [36.4.209.174]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhLrq1aEAVEOTAAAsM
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

	in linflex_config_port() the member variable will be
	assigned again . see linflex_config_port()

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 6fc21b6684e6..34400cc6ac7f 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
 		return PTR_ERR(sport->membase);
 
 	sport->dev = &pdev->dev;
-	sport->type = PORT_LINFLEXUART;
 	sport->iotype = UPIO_MEM;
 	sport->irq = platform_get_irq(pdev, 0);
 	sport->ops = &linflex_pops;
-- 
2.17.1

