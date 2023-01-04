Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB4BC4332F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Jan 2023 15:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjADPZn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Jan 2023 10:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjADPZm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Jan 2023 10:25:42 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 699CF2AF4;
        Wed,  4 Jan 2023 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=xHX97vFou7CZnafP0E
        zQLsxSqdqEy43T2DctXuby9FQ=; b=JQ2YOVyQoEAK/rmg8+RQPGkMHF0KuzkKI/
        MTcJ+75oDWfAzuOrL9kYHSCYsplXO+Tkoh+UOb86CjVEEPwCXJ/DGcqWlRJYgbTD
        fRG+R1yyPdn8xKCHZ/qp6H6uZ4c1xk2QijmPnAxDzLkkIxFHC7EK6Ofs3UbmXX1R
        QxCqv5O4Y=
Received: from localhost.localdomain (unknown [36.4.209.174])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wBHo5g9mrVjhjNwAA--.49442S4;
        Wed, 04 Jan 2023 23:25:16 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhe <sensor1010@163.com>
Subject: [PATCH v4] serial: linflexuart: remove redundant uart type assignment
Date:   Wed,  4 Jan 2023 07:24:44 -0800
Message-Id: <20230104152444.3407-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wBHo5g9mrVjhjNwAA--.49442S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4rAw47XF48Cr17XFy3XFb_yoWfGrX_ur
        1DA34xWr10kFWakFnrtFyYkr9agFs5ZF48JF10qa9aqw4DZw4rXryxXrZrurnrJw48Zry7
        G3y7Jr12yrnrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [36.4.209.174]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBogPsq1aEHDuKVAAAsN
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

in linflex_config_port() the member variable type will be
assigned again. see linflex_connfig_port()

Signed-off-by: lizhe <sensor1010@163.com>
Link: https://lore.kernel.org/all/20230103170948.3777-1-sensor1010@163.com/
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

