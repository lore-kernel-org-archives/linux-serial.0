Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7006BC07E9C
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5641761374
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhGNJQM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhGNJQI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DAFC72027D;
        Wed, 14 Jul 2021 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UupelVpR/QHiLH+r7Ic+eZ6bFluEGEEJzyV0/5Od9sM=;
        b=nF6GC+5ybqNxXGrXehcsP0yNXPQY/8BYShusmENlNPYsR7xvjYEizFFYosGufnsgNyFB3L
        FgIT/ELCR7YrpM0pncONY6jWjqp6Fon3uUy5htet1SsWn7jUvwSr03i548FltNnX1Rppzb
        UI+7uShuvxkzvVsLL6cENX8beor7dH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UupelVpR/QHiLH+r7Ic+eZ6bFluEGEEJzyV0/5Od9sM=;
        b=cp5nzF62PC1knLuAdJZQ+DWIHLe9vqdKliTKAsNV4LkMG1ZDmoYdPxYuPaZxuyOGmmTTXY
        GzJFjxuykv31QdAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0419A3B81;
        Wed, 14 Jul 2021 09:13:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/11] amiserial: remove serial_* strings
Date:   Wed, 14 Jul 2021 11:13:05 +0200
Message-Id: <20210714091314.8292-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove a print of serial_name and serial_version from the probe
function, i.e. show_serial_version() from amiga_serial_probe(). The
value of such a print is minimal.

Aside from that, the version is artificial (copied from the serial core
in 2.3.45pre2 and never increased). So inline the version into
seq_printf's format string in rs_proc_show() and remove both strings
completely.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 08987c438408..b2ff5861ca78 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -40,8 +40,6 @@
 #include <linux/types.h>
 #include <linux/serial.h>
 #include <linux/serial_reg.h>
-static char *serial_version = "4.30";
-
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -91,7 +89,6 @@ struct serial_state {
 };
 
 #define custom amiga_custom
-static char *serial_name = "Amiga-builtin serial driver";
 
 static struct tty_driver *serial_driver;
 
@@ -1452,7 +1449,7 @@ static inline void line_info(struct seq_file *m, int line,
 
 static int rs_proc_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "serinfo:1.0 driver:%s\n", serial_version);
+	seq_printf(m, "serinfo:1.0 driver:4.30\n");
 	line_info(m, 0, &rs_table[0]);
 	return 0;
 }
@@ -1465,17 +1462,6 @@ static int rs_proc_show(struct seq_file *m, void *v)
  * ---------------------------------------------------------------------
  */
 
-/*
- * This routine prints out the appropriate serial driver version
- * number, and identifies which options were configured into this
- * driver.
- */
-static void show_serial_version(void)
-{
- 	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
-}
-
-
 static const struct tty_operations serial_ops = {
 	.open = rs_open,
 	.close = rs_close,
@@ -1542,8 +1528,6 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	if (!serial_driver)
 		return -ENOMEM;
 
-	show_serial_version();
-
 	/* Initialize the tty_driver structure */
 
 	serial_driver->driver_name = "amiserial";
@@ -1628,7 +1612,6 @@ static int __exit amiga_serial_remove(struct platform_device *pdev)
 {
 	struct serial_state *state = platform_get_drvdata(pdev);
 
-	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
 	tty_unregister_driver(serial_driver);
 	put_tty_driver(serial_driver);
 	tty_port_destroy(&state->tport);
-- 
2.32.0

