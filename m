Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44AC46467
	for <linux-serial@archiver.kernel.org>; Wed,  4 Jan 2023 15:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjADPCA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Jan 2023 10:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbjADPBu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Jan 2023 10:01:50 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01495A45E;
        Wed,  4 Jan 2023 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=YpZiooOJEO/DV1XqfZfR0XmS7SEZ4HwmdG0B2nCsIk8=;
        b=fu07e0lUeJS3NEFHej4CLn9BjlqH21fEgrbnxVVD+TRwYWP0cFsDilynu0UE8m
        gKUAQ0dhR9IjS7oj+nwUTdDZYYcf4usSxuI85B33hKNZQEt7GsENEKp8uWn3+MNz
        mt8MrgwNTcGTtdQup3lYZT1tei6Pp4/FjgMfEp6HmgPrM=
Received: from localhost.localdomain (unknown [36.4.209.174])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDHPj+JlLVjDUduAA--.8610S4;
        Wed, 04 Jan 2023 23:01:00 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhe <sensor1010@163.com>
Subject: [PATCH v3] serial: linflexuart: remove redundant uart type PORT_LINFLEXUART
Date:   Wed,  4 Jan 2023 07:00:23 -0800
Message-Id: <20230104150023.3115-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHPj+JlLVjDUduAA--.8610S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4rAw47XFW5Aw4fGF1kAFb_yoWDJrc_ur
        1DC34xWr10kFWakFn7tFyakr9agrsYvF48JF40va9aqw4DZw4fJr97XrZruwsrA3y8Zry7
        W3yxGF4ayrnrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMeHqJUUUUU==
X-Originating-IP: [36.4.209.174]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBdBTsq1gi4+vLdQAAsr
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

in linflex_config_port() the member variable type will be
assigned again. see linflex_connfig_port()

Signed-off-by: lizhe <sensor1010@163.com>
Acked-by: Jiri Slaby <jslaby@suse.com>
Acked-by: Ilpo Järvinen<ilpo.jarvinen@linux.intel.com>
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

