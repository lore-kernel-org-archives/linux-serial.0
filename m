Return-Path: <SRS0=C9ms=DX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCBAC43457
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 12:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F542073A
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 12:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407463AbgJPMYR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Oct 2020 08:24:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405286AbgJPMYP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Oct 2020 08:24:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C972ACA0;
        Fri, 16 Oct 2020 12:24:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minh Yuan <yuanmingbuaa@gmail.com>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl
Date:   Fri, 16 Oct 2020 14:24:10 +0200
Message-Id: <20201016122412.31767-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

KDGKBSENT (the getter) needs only user_kdgkb->kb_func from the
userspace, i.e. the index. So do the complete copy only in KDSKBSENT
(the setter). That means, we obtain the index before the switch-case
and use it in both paths and copy the string only in the setter case.
And we do it by strndup_user helper now which was not available when
this function was written.

Given we copy the two members of struct kbsentry separately, we no
longer need a local definition. Hence we need to change all the sizeofs
here too.

And also the getter now returns in all fail paths, not freeing the
setter's string.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 51 ++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 0db53b5b3acf..d8e2452da1bd 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1994,7 +1994,7 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 /* FIXME: This one needs untangling and locking */
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
-	struct kbsentry *kbs;
+	char *kbs;
 	char *p;
 	u_char *q;
 	u_char __user *up;
@@ -2008,43 +2008,34 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	if (!capable(CAP_SYS_TTY_CONFIG))
 		perm = 0;
 
-	kbs = kmalloc(sizeof(*kbs), GFP_KERNEL);
-	if (!kbs) {
-		ret = -ENOMEM;
-		goto reterr;
-	}
+	if (get_user(i, &user_kdgkb->kb_func))
+		return -EFAULT;
 
-	/* we mostly copy too much here (512bytes), but who cares ;) */
-	if (copy_from_user(kbs, user_kdgkb, sizeof(struct kbsentry))) {
-		ret = -EFAULT;
-		goto reterr;
-	}
-	kbs->kb_string[sizeof(kbs->kb_string)-1] = '\0';
-	i = array_index_nospec(kbs->kb_func, MAX_NR_FUNC);
+	i = array_index_nospec(i, MAX_NR_FUNC);
 
 	switch (cmd) {
 	case KDGKBSENT:
-		sz = sizeof(kbs->kb_string) - 1; /* sz should have been
-						  a struct member */
+		/* sz should have been a struct member */
+		sz = sizeof_field(struct kbsentry, kb_string) - 1;
 		up = user_kdgkb->kb_string;
 		p = func_table[i];
 		if(p)
 			for ( ; *p && sz; p++, sz--)
-				if (put_user(*p, up++)) {
-					ret = -EFAULT;
-					goto reterr;
-				}
-		if (put_user('\0', up)) {
-			ret = -EFAULT;
-			goto reterr;
-		}
-		kfree(kbs);
+				if (put_user(*p, up++))
+					return -EFAULT;
+
+		if (put_user('\0', up))
+			return -EFAULT;
+
 		return ((p && *p) ? -EOVERFLOW : 0);
 	case KDSKBSENT:
-		if (!perm) {
-			ret = -EPERM;
-			goto reterr;
-		}
+		if (!perm)
+			return -EPERM;
+
+		kbs = strndup_user(user_kdgkb->kb_string,
+				sizeof(user_kdgkb->kb_string));
+		if (IS_ERR(kbs))
+			return PTR_ERR(kbs);
 
 		fnw = NULL;
 		fnw_sz = 0;
@@ -2062,7 +2053,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		else
 			fj = first_free;
 		/* buffer usage increase by new entry */
-		delta = (q ? -strlen(q) : 1) + strlen(kbs->kb_string);
+		delta = (q ? -strlen(q) : 1) + strlen(kbs);
 
 		if (delta <= funcbufleft) { 	/* it fits in current buf */
 		    if (j < MAX_NR_FUNC) {
@@ -2114,7 +2105,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		    funcbufsize = sz;
 		}
 		/* finally insert item itself */
-		strcpy(func_table[i], kbs->kb_string);
+		strcpy(func_table[i], kbs);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 		break;
 	}
-- 
2.28.0

