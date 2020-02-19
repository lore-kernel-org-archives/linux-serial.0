Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D4C34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C6C208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBSHj4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:39:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:41548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgBSHj4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 214FDB1A9;
        Wed, 19 Feb 2020 07:39:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/9] vt: selection, create struct from console selection globals
Date:   Wed, 19 Feb 2020 08:39:47 +0100
Message-Id: <20200219073951.16151-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219073951.16151-1-jslaby@suse.cz>
References: <20200219073951.16151-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move all the selection global variables to a structure vc_selection,
instantiated as vc_sel. This helps to group all the variables together
and see what should be protected by the embedded lock too.

It might be used later also for per-console selection support.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/selection.c | 94 +++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 33f94293f45e..0cd7072b6a56 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -38,14 +38,17 @@
 extern void poke_blanked_console(void);
 
 /* FIXME: all this needs locking */
-/* Variables for selection control. */
-/* Use a dynamic buffer, instead of static (Dec 1994) */
-struct vc_data *sel_cons;		/* must not be deallocated */
-static volatile int sel_start = -1; 	/* cleared by clear_selection */
-static int sel_end;
-static int sel_buffer_lth;
-static char *sel_buffer;
-static DEFINE_MUTEX(sel_lock);
+static struct vc_selection {
+	struct mutex lock;
+	struct vc_data *cons;			/* must not be deallocated */
+	char *buffer;
+	unsigned int buf_len;
+	volatile int start;			/* cleared by clear_selection */
+	int end;
+} vc_sel = {
+	.lock = __MUTEX_INITIALIZER(vc_sel.lock),
+	.start = -1,
+};
 
 /* clear_selection, highlight and highlight_pointer can be called
    from interrupt (via scrollback/front) */
@@ -53,22 +56,21 @@ static DEFINE_MUTEX(sel_lock);
 /* set reverse video on characters s-e of console with selection. */
 static inline void highlight(const int s, const int e)
 {
-	invert_screen(sel_cons, s, e-s+2, 1);
+	invert_screen(vc_sel.cons, s, e-s+2, 1);
 }
 
 /* use complementary color to show the pointer */
 static inline void highlight_pointer(const int where)
 {
-	complement_pos(sel_cons, where);
+	complement_pos(vc_sel.cons, where);
 }
 
 static u32
 sel_pos(int n, bool unicode)
 {
 	if (unicode)
-		return screen_glyph_unicode(sel_cons, n / 2);
-	return inverse_translate(sel_cons, screen_glyph(sel_cons, n),
-				0);
+		return screen_glyph_unicode(vc_sel.cons, n / 2);
+	return inverse_translate(vc_sel.cons, screen_glyph(vc_sel.cons, n), 0);
 }
 
 /**
@@ -80,16 +82,16 @@ sel_pos(int n, bool unicode)
 void clear_selection(void)
 {
 	highlight_pointer(-1); /* hide the pointer */
-	if (sel_start != -1) {
-		highlight(sel_start, sel_end);
-		sel_start = -1;
+	if (vc_sel.start != -1) {
+		highlight(vc_sel.start, vc_sel.end);
+		vc_sel.start = -1;
 	}
 }
 EXPORT_SYMBOL_GPL(clear_selection);
 
 bool vc_is_sel(struct vc_data *vc)
 {
-	return vc == sel_cons;
+	return vc == vc_sel.cons;
 }
 
 /*
@@ -216,13 +218,13 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 		return 0;
 	}
 
-	if (ps > pe)	/* make sel_start <= sel_end */
+	if (ps > pe)	/* make vc_sel.start <= vc_sel.end */
 		swap(ps, pe);
 
-	mutex_lock(&sel_lock);
-	if (sel_cons != vc_cons[fg_console].d) {
+	mutex_lock(&vc_sel.lock);
+	if (vc_sel.cons != vc_cons[fg_console].d) {
 		clear_selection();
-		sel_cons = vc_cons[fg_console].d;
+		vc_sel.cons = vc_cons[fg_console].d;
 	}
 	unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
 
@@ -281,35 +283,35 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 		if (isspace(sel_pos(pe, unicode)))
 			new_sel_end = pe;
 	}
-	if (sel_start == -1)	/* no current selection */
+	if (vc_sel.start == -1)	/* no current selection */
 		highlight(new_sel_start, new_sel_end);
-	else if (new_sel_start == sel_start)
+	else if (new_sel_start == vc_sel.start)
 	{
-		if (new_sel_end == sel_end)	/* no action required */
+		if (new_sel_end == vc_sel.end)	/* no action required */
 			goto unlock;
-		else if (new_sel_end > sel_end)	/* extend to right */
-			highlight(sel_end + 2, new_sel_end);
+		else if (new_sel_end > vc_sel.end)	/* extend to right */
+			highlight(vc_sel.end + 2, new_sel_end);
 		else				/* contract from right */
-			highlight(new_sel_end + 2, sel_end);
+			highlight(new_sel_end + 2, vc_sel.end);
 	}
-	else if (new_sel_end == sel_end)
+	else if (new_sel_end == vc_sel.end)
 	{
-		if (new_sel_start < sel_start)	/* extend to left */
-			highlight(new_sel_start, sel_start - 2);
+		if (new_sel_start < vc_sel.start) /* extend to left */
+			highlight(new_sel_start, vc_sel.start - 2);
 		else				/* contract from left */
-			highlight(sel_start, new_sel_start - 2);
+			highlight(vc_sel.start, new_sel_start - 2);
 	}
 	else	/* some other case; start selection from scratch */
 	{
 		clear_selection();
 		highlight(new_sel_start, new_sel_end);
 	}
-	sel_start = new_sel_start;
-	sel_end = new_sel_end;
+	vc_sel.start = new_sel_start;
+	vc_sel.end = new_sel_end;
 
 	/* Allocate a new buffer before freeing the old one ... */
 	/* chars can take up to 4 bytes with unicode */
-	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, unicode ? 4 : 1,
+	bp = kmalloc_array((vc_sel.end - vc_sel.start) / 2 + 1, unicode ? 4 : 1,
 			   GFP_KERNEL);
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
@@ -317,11 +319,11 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 		ret = -ENOMEM;
 		goto unlock;
 	}
-	kfree(sel_buffer);
-	sel_buffer = bp;
+	kfree(vc_sel.buffer);
+	vc_sel.buffer = bp;
 
 	obp = bp;
-	for (i = sel_start; i <= sel_end; i += 2) {
+	for (i = vc_sel.start; i <= vc_sel.end; i += 2) {
 		c = sel_pos(i, unicode);
 		if (unicode)
 			bp += store_utf8(c, bp);
@@ -339,9 +341,9 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 			obp = bp;
 		}
 	}
-	sel_buffer_lth = bp - sel_buffer;
+	vc_sel.buf_len = bp - vc_sel.buffer;
 unlock:
-	mutex_unlock(&sel_lock);
+	mutex_unlock(&vc_sel.lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(set_selection_kernel);
@@ -372,26 +374,26 @@ int paste_selection(struct tty_struct *tty)
 	tty_buffer_lock_exclusive(&vc->port);
 
 	add_wait_queue(&vc->paste_wait, &wait);
-	mutex_lock(&sel_lock);
-	while (sel_buffer && sel_buffer_lth > pasted) {
+	mutex_lock(&vc_sel.lock);
+	while (vc_sel.buffer && vc_sel.buf_len > pasted) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current)) {
 			ret = -EINTR;
 			break;
 		}
 		if (tty_throttled(tty)) {
-			mutex_unlock(&sel_lock);
+			mutex_unlock(&vc_sel.lock);
 			schedule();
-			mutex_lock(&sel_lock);
+			mutex_lock(&vc_sel.lock);
 			continue;
 		}
 		__set_current_state(TASK_RUNNING);
-		count = sel_buffer_lth - pasted;
-		count = tty_ldisc_receive_buf(ld, sel_buffer + pasted, NULL,
+		count = vc_sel.buf_len - pasted;
+		count = tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL,
 					      count);
 		pasted += count;
 	}
-	mutex_unlock(&sel_lock);
+	mutex_unlock(&vc_sel.lock);
 	remove_wait_queue(&vc->paste_wait, &wait);
 	__set_current_state(TASK_RUNNING);
 
-- 
2.25.0

