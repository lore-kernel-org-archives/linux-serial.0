Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F169C2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D534A2072C
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgJ2LdX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:33:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgJ2Lc2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AAA9B222;
        Thu, 29 Oct 2020 11:32:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/17] vt: keyboard, rename i to kb_func in vt_do_kdgkb_ioctl
Date:   Thu, 29 Oct 2020 12:32:15 +0100
Message-Id: <20201029113222.32640-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are too many one-letter variables in vt_do_kdgkb_ioctl which is
rather confusing.  Rename 'i' to 'kb_func' and change its type to be the
same as its originating value (struct kbsentry.kb_func) -- unsigned
char.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index e47a1c6bfa44..55014f57a3de 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2026,9 +2026,10 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	int sz, fnw_sz;
 	int delta;
 	char *first_free, *fj, *fnw;
-	int i, j, k;
+	int j, k;
 	int ret;
 	unsigned long flags;
+	unsigned char kb_func;
 
 	if (!capable(CAP_SYS_TTY_CONFIG))
 		perm = 0;
@@ -2045,7 +2046,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		goto reterr;
 	}
 	kbs->kb_string[sizeof(kbs->kb_string)-1] = '\0';
-	i = array_index_nospec(kbs->kb_func, MAX_NR_FUNC);
+	kb_func = array_index_nospec(kbs->kb_func, MAX_NR_FUNC);
 
 	switch (cmd) {
 	case KDGKBSENT: {
@@ -2053,7 +2054,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		ssize_t len = sizeof(user_kdgkb->kb_string);
 
 		spin_lock_irqsave(&func_buf_lock, flags);
-		len = strlcpy(kbs->kb_string, func_table[i] ? : "", len);
+		len = strlcpy(kbs->kb_string, func_table[kb_func] ? : "", len);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 
 		ret = copy_to_user(user_kdgkb->kb_string, kbs->kb_string,
@@ -2072,11 +2073,11 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		/* race aginst other writers */
 		again:
 		spin_lock_irqsave(&func_buf_lock, flags);
-		q = func_table[i];
+		q = func_table[kb_func];
 
 		/* fj pointer to next entry after 'q' */
 		first_free = funcbufptr + (funcbufsize - funcbufleft);
-		for (j = i+1; j < MAX_NR_FUNC && !func_table[j]; j++)
+		for (j = kb_func + 1; j < MAX_NR_FUNC && !func_table[j]; j++)
 			;
 		if (j < MAX_NR_FUNC)
 			fj = func_table[j];
@@ -2094,7 +2095,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 				func_table[k] += delta;
 		    }
 		    if (!q)
-		      func_table[i] = fj;
+		      func_table[kb_func] = fj;
 		    funcbufleft -= delta;
 		} else {			/* allocate a larger buffer */
 		    sz = 256;
@@ -2113,7 +2114,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		    }
 
 		    if (!q)
-		      func_table[i] = fj;
+		      func_table[kb_func] = fj;
 		    /* copy data before insertion point to new location */
 		    if (fj > funcbufptr)
 			memmove(fnw, funcbufptr, fj - funcbufptr);
@@ -2135,7 +2136,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		    funcbufsize = sz;
 		}
 		/* finally insert item itself */
-		strcpy(func_table[i], kbs->kb_string);
+		strcpy(func_table[kb_func], kbs->kb_string);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 		break;
 	}
-- 
2.29.1

