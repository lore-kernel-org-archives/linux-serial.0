Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE29C28D14
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2536064E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347729AbhCCCRA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:39930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835897AbhCBGZB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F106B03A;
        Tue,  2 Mar 2021 06:22:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 35/44] tty: let tty_unregister_driver return void
Date:   Tue,  2 Mar 2021 07:22:05 +0100
Message-Id: <20210302062214.29627-35-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that noone checks the return value, switch the return type of
tty_unregister_driver to void. We can do that as we always return zero.

Generally, drivers are not allowed to call tty_unregister_driver while
there are open devices.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 9 +--------
 include/linux/tty.h  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 74733ec8f565..c8cbf08b6dcf 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3525,21 +3525,14 @@ EXPORT_SYMBOL(tty_register_driver);
 /*
  * Called by a tty driver to unregister itself.
  */
-int tty_unregister_driver(struct tty_driver *driver)
+void tty_unregister_driver(struct tty_driver *driver)
 {
-#if 0
-	/* FIXME */
-	if (driver->refcount)
-		return -EBUSY;
-#endif
 	unregister_chrdev_region(MKDEV(driver->major, driver->minor_start),
 				driver->num);
 	mutex_lock(&tty_mutex);
 	list_del(&driver->tty_drivers);
 	mutex_unlock(&tty_mutex);
-	return 0;
 }
-
 EXPORT_SYMBOL(tty_unregister_driver);
 
 dev_t tty_devnum(struct tty_struct *tty)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 95fc2f100f12..51f56e5ec955 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -482,7 +482,7 @@ extern void stop_tty(struct tty_struct *tty);
 extern void __start_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
 extern int tty_register_driver(struct tty_driver *driver);
-extern int tty_unregister_driver(struct tty_driver *driver);
+extern void tty_unregister_driver(struct tty_driver *driver);
 extern struct device *tty_register_device(struct tty_driver *driver,
 					  unsigned index, struct device *dev);
 extern struct device *tty_register_device_attr(struct tty_driver *driver,
-- 
2.30.1

