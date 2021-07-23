Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92DDC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF4B60EE2
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhGWJvQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32852 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhGWJvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3471C1FF7D;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlJ+J2bH9ijztnXv4nOjkf3xz4zV2YNnAbmKG0t3kas=;
        b=i8iSf9jIVJERA2jtmWYi9Yk5Xy9W/fBhfdeFXEWv0ybN25tkdBle6Og+cfntQWcrjO+fY6
        fDoEX3zgGYT64DIhM0yatJHSrogQAx75/5GakA+pr0i39PfBND4uD5hlriGEkhbLZIDyvC
        pev3U5ou8s9TKiOtwa8E6gxv+wnb45o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlJ+J2bH9ijztnXv4nOjkf3xz4zV2YNnAbmKG0t3kas=;
        b=NcTkBXINSTh2ygvDTYPKN6fYWolH5N+7wne6k33bc7n1DgJzHi673UUyeeyvM78ORkhRLK
        PcvLXS7jXRDqntDQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 176D1A3B9D;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/8] tty: move ldisc prototypes to tty_ldisc.h
Date:   Fri, 23 Jul 2021 12:31:42 +0200
Message-Id: <20210723103147.18250-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We already have tty_ldisc.h, so cleanup tty.h a bit by moving out
tty_ldisc-related function prototypes and a variable into tty_ldisc.h.
They are implemented in tty_ldisc.c anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty.h       | 10 ----------
 include/linux/tty_ldisc.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1550c1d49baa..7f088d43db45 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -10,7 +10,6 @@
 #include <linux/tty_ldisc.h>
 #include <linux/mutex.h>
 #include <linux/tty_flags.h>
-#include <linux/seq_file.h>
 #include <uapi/linux/tty.h>
 #include <linux/rwsem.h>
 #include <linux/llist.h>
@@ -493,13 +492,7 @@ extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
-extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
-extern void tty_ldisc_deref(struct tty_ldisc *);
-extern struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);
-extern const struct seq_operations tty_ldiscs_seq_ops;
-
 extern void tty_wakeup(struct tty_struct *tty);
-extern void tty_ldisc_flush(struct tty_struct *tty);
 
 extern int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg);
@@ -629,9 +622,6 @@ static inline int tty_port_users(struct tty_port *port)
 	return port->count + port->blocked_open;
 }
 
-extern int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc);
-extern void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc);
-extern int tty_set_ldisc(struct tty_struct *tty, int disc);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 const char *f, int count);
 
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index fbe9de278629..62131bb9251f 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_TTY_LDISC_H
 #define _LINUX_TTY_LDISC_H
 
+struct tty_struct;
+
 /*
  * This structure defines the interface between the tty line discipline
  * implementation and the tty routines.  The following routines can be
@@ -126,6 +128,7 @@
 #include <linux/fs.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/seq_file.h>
 
 /*
  * the semaphore definition
@@ -220,4 +223,16 @@ struct tty_ldisc {
 #define MODULE_ALIAS_LDISC(ldisc) \
 	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
 
+extern const struct seq_operations tty_ldiscs_seq_ops;
+
+struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
+void tty_ldisc_deref(struct tty_ldisc *);
+struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);
+
+void tty_ldisc_flush(struct tty_struct *tty);
+
+int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc);
+void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc);
+int tty_set_ldisc(struct tty_struct *tty, int disc);
+
 #endif /* _LINUX_TTY_LDISC_H */
-- 
2.32.0

