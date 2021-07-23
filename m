Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43245C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F32F60EE6
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhGWJvT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhGWJvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FAEF22646;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0sjeO+DtarSdQhqGDuCyQWpixGNzjpcEPnwUAjHyks=;
        b=J0IlGvEbRjU3GZ7fXJPJPBonjaXnFP0yekjZ1lfik+Nn267+tQhW7lgBeIWV1DpQbmjCX6
        YuHBDrXQc2Z/H4UW3i3EVsquh5e43aXEqW1z2Ex49cfQ3ZGdbjQvyIJMAuusIOklu1eKDL
        Pz4qWgqvNJRKfkFD5cFn6rmVHo4P3Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0sjeO+DtarSdQhqGDuCyQWpixGNzjpcEPnwUAjHyks=;
        b=ZVhWFq4F9nplCLsKLrzyv3guW+rpZzX9cwEBTj0LLO82xDhH/hIgCEJsjYr9SgmzUYK7nM
        bvJ0bSx9BBqVC8BA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7F422A3B9E;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/8] tty: move tty_buffer definitions to new tty_buffer.h
Date:   Fri, 23 Jul 2021 12:31:45 +0200
Message-Id: <20210723103147.18250-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty.h is large enough currently. And I am slowly adding kernel-doc
documentation, so it grows to unmaintainable long mess. To avoid this,
split tty.h further into tty_buffer.h and move there tty_buffer-related
declarations and function prototypes.

Note that many of the tty_buffer.c function prototypes reside now in
tty_flip.h. But we cannot move struct tty_buffer & friends because:
* tty_insert_flip_char() in tty_flip.h needs both struct tty_port and
  struct tty_buffer defined.
* struct tty_port in tty_port.h needs struct tty_buffer defined.

So if we moved struct tty_buffer to tty_flip.h too, tty_flip.h would
need tty_port.h and that would need tty_flip.h (to have tty_buffer)
again. Hence we introduce new header tty_buffer.h here to break this
circular dependency.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty.h        | 49 +------------------------------
 include/linux/tty_buffer.h | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 48 deletions(-)
 create mode 100644 include/linux/tty_buffer.h

diff --git a/include/linux/tty.h b/include/linux/tty.h
index fad53f69a8ca..b5f353797cec 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -6,6 +6,7 @@
 #include <linux/major.h>
 #include <linux/termios.h>
 #include <linux/workqueue.h>
+#include <linux/tty_buffer.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 #include <linux/mutex.h>
@@ -30,54 +31,6 @@
  */
 #define __DISABLED_CHAR '\0'
 
-struct tty_buffer {
-	union {
-		struct tty_buffer *next;
-		struct llist_node free;
-	};
-	int used;
-	int size;
-	int commit;
-	int read;
-	int flags;
-	/* Data points here */
-	unsigned long data[];
-};
-
-/* Values for .flags field of tty_buffer */
-#define TTYB_NORMAL	1	/* buffer has no flags buffer */
-
-static inline unsigned char *char_buf_ptr(struct tty_buffer *b, int ofs)
-{
-	return ((unsigned char *)b->data) + ofs;
-}
-
-static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
-{
-	return (char *)char_buf_ptr(b, ofs) + b->size;
-}
-
-struct tty_bufhead {
-	struct tty_buffer *head;	/* Queue head */
-	struct work_struct work;
-	struct mutex	   lock;
-	atomic_t	   priority;
-	struct tty_buffer sentinel;
-	struct llist_head free;		/* Free queue head */
-	atomic_t	   mem_used;    /* In-use buffers excluding free list */
-	int		   mem_limit;
-	struct tty_buffer *tail;	/* Active buffer */
-};
-/*
- * When a break, frame error, or parity error happens, these codes are
- * stuffed into the flags buffer.
- */
-#define TTY_NORMAL	0
-#define TTY_BREAK	1
-#define TTY_FRAME	2
-#define TTY_PARITY	3
-#define TTY_OVERRUN	4
-
 #define INTR_CHAR(tty) ((tty)->termios.c_cc[VINTR])
 #define QUIT_CHAR(tty) ((tty)->termios.c_cc[VQUIT])
 #define ERASE_CHAR(tty) ((tty)->termios.c_cc[VERASE])
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
new file mode 100644
index 000000000000..3b9d77604291
--- /dev/null
+++ b/include/linux/tty_buffer.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TTY_BUFFER_H
+#define _LINUX_TTY_BUFFER_H
+
+#include <linux/atomic.h>
+#include <linux/llist.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+
+struct tty_buffer {
+	union {
+		struct tty_buffer *next;
+		struct llist_node free;
+	};
+	int used;
+	int size;
+	int commit;
+	int read;
+	int flags;
+	/* Data points here */
+	unsigned long data[];
+};
+
+/* Values for .flags field of tty_buffer */
+#define TTYB_NORMAL	1	/* buffer has no flags buffer */
+
+static inline unsigned char *char_buf_ptr(struct tty_buffer *b, int ofs)
+{
+	return ((unsigned char *)b->data) + ofs;
+}
+
+static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
+{
+	return (char *)char_buf_ptr(b, ofs) + b->size;
+}
+
+struct tty_bufhead {
+	struct tty_buffer *head;	/* Queue head */
+	struct work_struct work;
+	struct mutex	   lock;
+	atomic_t	   priority;
+	struct tty_buffer sentinel;
+	struct llist_head free;		/* Free queue head */
+	atomic_t	   mem_used;    /* In-use buffers excluding free list */
+	int		   mem_limit;
+	struct tty_buffer *tail;	/* Active buffer */
+};
+
+/*
+ * When a break, frame error, or parity error happens, these codes are
+ * stuffed into the flags buffer.
+ */
+#define TTY_NORMAL	0
+#define TTY_BREAK	1
+#define TTY_FRAME	2
+#define TTY_PARITY	3
+#define TTY_OVERRUN	4
+
+#endif
-- 
2.32.0

