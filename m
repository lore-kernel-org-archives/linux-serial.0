Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0495BC433ED
	for <linux-serial@archiver.kernel.org>; Sun,  9 May 2021 08:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F1C613B6
	for <linux-serial@archiver.kernel.org>; Sun,  9 May 2021 08:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhEII3X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 9 May 2021 04:29:23 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:52869 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhEII3X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 9 May 2021 04:29:23 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d86 with ME
        id 2YUJ2500S21Fzsu03YUKfS; Sun, 09 May 2021 10:28:19 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 May 2021 10:28:19 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, hjk@linutronix.de,
        jirislaby@kernel.org, lee.jones@linaro.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tty: serial: 8250: serial_cs: Fix a memory leak in error handling path
Date:   Sun,  9 May 2021 10:28:18 +0200
Message-Id: <562910a450cb86db7c2c4a4328a60e53ef95f504.1620548790.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In the probe function, if the final 'serial_config()' fails, 'info' is
leaking.

Use 'devm_kzalloc' instead to fix the leak and simplify the .remove
function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've not been able to find a Fixes tag. All I know is that it is old!
---
 drivers/tty/serial/8250/serial_cs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 63ea9c4da3d5..d18c98e0d0b0 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -310,7 +310,7 @@ static int serial_probe(struct pcmcia_device *link)
 	dev_dbg(&link->dev, "serial_attach()\n");
 
 	/* Create new serial device */
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&link->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	info->p_dev = link;
@@ -325,17 +325,12 @@ static int serial_probe(struct pcmcia_device *link)
 
 static void serial_detach(struct pcmcia_device *link)
 {
-	struct serial_info *info = link->priv;
-
 	dev_dbg(&link->dev, "serial_detach\n");
 
 	/*
 	 * Ensure that the ports have been released.
 	 */
 	serial_remove(link);
-
-	/* free bits */
-	kfree(info);
 }
 
 /*====================================================================*/
-- 
2.30.2

