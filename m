Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6982DC4320A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F70960EE6
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhGWJvP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhGWJvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E38EE22642;
        Fri, 23 Jul 2021 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgUpkYwsP162Uaz8zofrkm9ediJGS03SDNiPkVlVEns=;
        b=jURiwmbV7jI/OdcIYe8a497k/Xai/nmFpwO7bVXYj1MyUC+Gy8CjUEoQpO5WGvuh9nCjC7
        Ml94ID/JYhDpHwfuMRIe9HSccaA/Z/H33Lkdq15z4zomqVaQ9u3qgqtgLN+ki6RWD8Lab9
        lb1KB+0zkuytQuP5MlsoSGTGLu6YFII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgUpkYwsP162Uaz8zofrkm9ediJGS03SDNiPkVlVEns=;
        b=8sj9jWFrAhxt+BKIGj0HAzv5HHqOHNPcvztulWIeUfaOpCIIUS2RRxlrT3usVXGbJgiqBK
        0TXulnqmMWahS4DA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C87CFA3B9E;
        Fri, 23 Jul 2021 10:31:47 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/8] tty: move tty_driver related prototypes to tty_driver.h
Date:   Fri, 23 Jul 2021 12:31:40 +0200
Message-Id: <20210723103147.18250-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We already have tty_driver.h, so cleanup tty.h a bit by moving out
tty_driver-related function prototypes into tty_driver.h.

Note that tty.h already includes tty_driver.h.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty.h        | 17 -----------------
 include/linux/tty_driver.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 19dc1097e09c..1550c1d49baa 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -446,15 +446,6 @@ extern const char *tty_driver_name(const struct tty_struct *tty);
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
 extern void stop_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
-extern int tty_register_driver(struct tty_driver *driver);
-extern void tty_unregister_driver(struct tty_driver *driver);
-extern struct device *tty_register_device(struct tty_driver *driver,
-					  unsigned index, struct device *dev);
-extern struct device *tty_register_device_attr(struct tty_driver *driver,
-				unsigned index, struct device *device,
-				void *drvdata,
-				const struct attribute_group **attr_grp);
-extern void tty_unregister_device(struct tty_driver *driver, unsigned index);
 extern void tty_write_message(struct tty_struct *tty, char *msg);
 extern int tty_send_xchar(struct tty_struct *tty, char ch);
 extern int tty_put_char(struct tty_struct *tty, unsigned char c);
@@ -691,12 +682,4 @@ extern void tty_lock_slave(struct tty_struct *tty);
 extern void tty_unlock_slave(struct tty_struct *tty);
 extern void tty_set_lock_subclass(struct tty_struct *tty);
 
-#ifdef CONFIG_PROC_FS
-extern void proc_tty_register_driver(struct tty_driver *);
-extern void proc_tty_unregister_driver(struct tty_driver *);
-#else
-static inline void proc_tty_register_driver(struct tty_driver *d) {}
-static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
-#endif
-
 #endif
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 448f8ee6db6e..e15f8635aa36 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -434,4 +434,21 @@ static inline struct tty_driver *tty_driver_kref_get(struct tty_driver *d)
 /* serial subtype definitions */
 #define SERIAL_TYPE_NORMAL	1
 
+int tty_register_driver(struct tty_driver *driver);
+void tty_unregister_driver(struct tty_driver *driver);
+struct device *tty_register_device(struct tty_driver *driver, unsigned index,
+		struct device *dev);
+struct device *tty_register_device_attr(struct tty_driver *driver,
+		unsigned index, struct device *device, void *drvdata,
+		const struct attribute_group **attr_grp);
+void tty_unregister_device(struct tty_driver *driver, unsigned index);
+
+#ifdef CONFIG_PROC_FS
+void proc_tty_register_driver(struct tty_driver *);
+void proc_tty_unregister_driver(struct tty_driver *);
+#else
+static inline void proc_tty_register_driver(struct tty_driver *d) {}
+static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
+#endif
+
 #endif /* #ifdef _LINUX_TTY_DRIVER_H */
-- 
2.32.0

