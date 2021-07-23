Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E6C432BE
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6491B60E91
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhGWHCv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:02:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55428 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhGWHCr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A088722610;
        Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYYo0gw5ZhJ7963VEJqmCfeVwA2noe4glvbECiErLts=;
        b=UY7kn4h7bfuo//1O02v9RCppQuR0O4av92uH718g7Le6WyXiuVwNYGCVd8tVTaVMYzD18P
        jSwtjj8dyYG1OB5BKLy2//KIpKKPPEl/ui2ipMdBG0SuyhAcAkT2Al2kYUwSLn4jeBkdhT
        FpSy0KMEOiImpFWL6W1vDw7JRRHf23M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYYo0gw5ZhJ7963VEJqmCfeVwA2noe4glvbECiErLts=;
        b=r7q5SWzyseUgXxYwBCiPa+UAVtqYgpUfg21HwefA2OAwSK1No3gVGqp9UL6K8lR/yYFGau
        hHaR+/sYBn9Km7Cg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85553A3B87;
        Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/8] tty: make tty_set_operations an inline
Date:   Fri, 23 Jul 2021 09:43:15 +0200
Message-Id: <20210723074317.32690-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit f34d7a5b7010 (tty: The big operations rework) in 2008,
tty_set_operations() is a simple one-line assignment. There is no reason
for this to be an exported function, hence move it to a header and make
an inline from that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c       | 7 -------
 include/linux/tty_driver.h | 8 ++++++--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 26debec26b4e..16e3fce6f88d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3438,13 +3438,6 @@ void tty_driver_kref_put(struct tty_driver *driver)
 }
 EXPORT_SYMBOL(tty_driver_kref_put);
 
-void tty_set_operations(struct tty_driver *driver,
-			const struct tty_operations *op)
-{
-	driver->ops = op;
-};
-EXPORT_SYMBOL(tty_set_operations);
-
 void put_tty_driver(struct tty_driver *d)
 {
 	tty_driver_kref_put(d);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index c7746dee58a6..6092ce9180aa 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -330,8 +330,6 @@ extern struct list_head tty_drivers;
 extern struct tty_driver *__tty_alloc_driver(unsigned int lines,
 		struct module *owner, unsigned long flags);
 extern void put_tty_driver(struct tty_driver *driver);
-extern void tty_set_operations(struct tty_driver *driver,
-			const struct tty_operations *op);
 extern struct tty_driver *tty_find_polling_driver(char *name, int *line);
 
 extern void tty_driver_kref_put(struct tty_driver *driver);
@@ -346,6 +344,12 @@ static inline struct tty_driver *tty_driver_kref_get(struct tty_driver *d)
 	return d;
 }
 
+static inline void tty_set_operations(struct tty_driver *driver,
+		const struct tty_operations *op)
+{
+	driver->ops = op;
+}
+
 /* tty driver magic number */
 #define TTY_DRIVER_MAGIC		0x5402
 
-- 
2.32.0

