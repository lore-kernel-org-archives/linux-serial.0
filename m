Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0DDC55178
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43483206DD
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJ2Lcq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:32:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:57250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbgJ2Lc3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8849DB223;
        Thu, 29 Oct 2020 11:32:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/17] vt: keyboard, extract and simplify vt_kdskbsent
Date:   Thu, 29 Oct 2020 12:32:17 +0100
Message-Id: <20201029113222.32640-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Setting of function key strings is now very complex. It uses a global
buffer 'func_buf' which is prefilled in defkeymap.c_shipped. Then there
is also an index table called 'func_table'. So initially, we have
something like this:
char func_buf[] =	"\e[[A\0" // for F1
			"\e[[B\0" // for F2
			...;
char *func_table[] = {
	func_buf + 0, // for F1
	func_buf + 5, // for F2
	... }

When a user changes some specific func string by KDSKBSENT, it is
changed in 'func_buf'. If it is shorter or equal to the current one, it
is handled by a very quick 'strcpy'.

When the user's string is longer, the whole 'func_buf' is reallocated to
allow expansion somewhere in the middle. The buffer before the user's
string is copied, the user's string appended and the rest appended too.
Now, the index table (func_table) needs to be recomputed, of course.
One more complication is the held spinlock -- we have to unlock,
reallocate, lock again and do the whole thing again to be sure noone
raced with us.

In this patch, we chose completely orthogonal approach: when the user's
string is longer than the current one, we simply assign the 'kstrdup'ed
copy to the index table (func_table) and modify func_buf in no way. We
only need to make sure we free the old entries. So we need a bitmap
is_kmalloc and free the old entries (but not the original func_buf
rodata string).

Also note that we do not waste so much space as previous approach. We
only allocate space for single entries which are longer, while before,
the whole buffer was duplicated plus space for the longer string.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 102 +++++++++-----------------------------
 1 file changed, 23 insertions(+), 79 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 81afe0438b34..648bdfb05e25 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2018,18 +2018,27 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 	return 0;
 }
 
-/* FIXME: This one needs untangling */
+static char *vt_kdskbsent(char *kbs, unsigned char cur)
+{
+	static DECLARE_BITMAP(is_kmalloc, MAX_NR_FUNC);
+	char *cur_f = func_table[cur];
+
+	if (cur_f && strlen(cur_f) >= strlen(kbs)) {
+		strcpy(cur_f, kbs);
+		return kbs;
+	}
+
+	func_table[cur] = kbs;
+
+	return __test_and_set_bit(cur, is_kmalloc) ? cur_f : NULL;
+}
+
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
+	unsigned char kb_func;
+	unsigned long flags;
 	char *kbs;
-	u_char *q;
-	int sz, fnw_sz;
-	int delta;
-	char *first_free, *fj, *fnw;
-	int j, k;
 	int ret;
-	unsigned long flags;
-	unsigned char kb_func;
 
 	if (!capable(CAP_SYS_TTY_CONFIG))
 		perm = 0;
@@ -2055,7 +2064,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
 			-EFAULT : 0;
 
-		goto reterr;
+		break;
 	}
 	case KDSKBSENT:
 		if (!perm)
@@ -2066,81 +2075,16 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		if (IS_ERR(kbs))
 			return PTR_ERR(kbs);
 
-		fnw = NULL;
-		fnw_sz = 0;
-		/* race aginst other writers */
-		again:
 		spin_lock_irqsave(&func_buf_lock, flags);
-		q = func_table[kb_func];
-
-		/* fj pointer to next entry after 'q' */
-		first_free = funcbufptr + (funcbufsize - funcbufleft);
-		for (j = kb_func + 1; j < MAX_NR_FUNC && !func_table[j]; j++)
-			;
-		if (j < MAX_NR_FUNC)
-			fj = func_table[j];
-		else
-			fj = first_free;
-		/* buffer usage increase by new entry */
-		delta = (q ? -strlen(q) : 1) + strlen(kbs);
-
-		if (delta <= funcbufleft) { 	/* it fits in current buf */
-		    if (j < MAX_NR_FUNC) {
-			/* make enough space for new entry at 'fj' */
-			memmove(fj + delta, fj, first_free - fj);
-			for (k = j; k < MAX_NR_FUNC; k++)
-			    if (func_table[k])
-				func_table[k] += delta;
-		    }
-		    if (!q)
-		      func_table[kb_func] = fj;
-		    funcbufleft -= delta;
-		} else {			/* allocate a larger buffer */
-		    sz = 256;
-		    while (sz < funcbufsize - funcbufleft + delta)
-		      sz <<= 1;
-		    if (fnw_sz != sz) {
-		      spin_unlock_irqrestore(&func_buf_lock, flags);
-		      kfree(fnw);
-		      fnw = kmalloc(sz, GFP_KERNEL);
-		      fnw_sz = sz;
-		      if (!fnw) {
-			ret = -ENOMEM;
-			goto reterr;
-		      }
-		      goto again;
-		    }
-
-		    if (!q)
-		      func_table[kb_func] = fj;
-		    /* copy data before insertion point to new location */
-		    if (fj > funcbufptr)
-			memmove(fnw, funcbufptr, fj - funcbufptr);
-		    for (k = 0; k < j; k++)
-		      if (func_table[k])
-			func_table[k] = fnw + (func_table[k] - funcbufptr);
-
-		    /* copy data after insertion point to new location */
-		    if (first_free > fj) {
-			memmove(fnw + (fj - funcbufptr) + delta, fj, first_free - fj);
-			for (k = j; k < MAX_NR_FUNC; k++)
-			  if (func_table[k])
-			    func_table[k] = fnw + (func_table[k] - funcbufptr) + delta;
-		    }
-		    if (funcbufptr != func_buf)
-		      kfree(funcbufptr);
-		    funcbufptr = fnw;
-		    funcbufleft = funcbufleft - delta + sz - funcbufsize;
-		    funcbufsize = sz;
-		}
-		/* finally insert item itself */
-		strcpy(func_table[kb_func], kbs);
+		kbs = vt_kdskbsent(kbs, kb_func);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
+
+		ret = 0;
 		break;
 	}
-	ret = 0;
-reterr:
+
 	kfree(kbs);
+
 	return ret;
 }
 
-- 
2.29.1

