Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAECC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD182176D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBSHj4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:39:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:41538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBSHjy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9993B06A;
        Wed, 19 Feb 2020 07:39:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/9] vt: selection, localize use_unicode
Date:   Wed, 19 Feb 2020 08:39:46 +0100
Message-Id: <20200219073951.16151-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219073951.16151-1-jslaby@suse.cz>
References: <20200219073951.16151-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

use_unicode needs not be global. It is used only in set_selection_kernel
and sel_pos (a callee). It is also always set there prior calling
sel_pos. So make use_unicode local and rename it to plain shorter
"unicode". Finally, propagate it to sel_pos via parameter.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/selection.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 6541c09d8bba..33f94293f45e 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -41,7 +41,6 @@ extern void poke_blanked_console(void);
 /* Variables for selection control. */
 /* Use a dynamic buffer, instead of static (Dec 1994) */
 struct vc_data *sel_cons;		/* must not be deallocated */
-static int use_unicode;
 static volatile int sel_start = -1; 	/* cleared by clear_selection */
 static int sel_end;
 static int sel_buffer_lth;
@@ -64,9 +63,9 @@ static inline void highlight_pointer(const int where)
 }
 
 static u32
-sel_pos(int n)
+sel_pos(int n, bool unicode)
 {
-	if (use_unicode)
+	if (unicode)
 		return screen_glyph_unicode(sel_cons, n / 2);
 	return inverse_translate(sel_cons, screen_glyph(sel_cons, n),
 				0);
@@ -194,6 +193,7 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 	int i, ps, pe;
 	u32 c;
 	int ret = 0;
+	bool unicode;
 
 	poke_blanked_console();
 
@@ -224,7 +224,7 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 		clear_selection();
 		sel_cons = vc_cons[fg_console].d;
 	}
-	use_unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
+	unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
 
 	switch (v->sel_mode)
 	{
@@ -233,21 +233,21 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 			new_sel_end = pe;
 			break;
 		case TIOCL_SELWORD:	/* word-by-word selection */
-			spc = isspace(sel_pos(ps));
+			spc = isspace(sel_pos(ps, unicode));
 			for (new_sel_start = ps; ; ps -= 2)
 			{
-				if ((spc && !isspace(sel_pos(ps))) ||
-				    (!spc && !inword(sel_pos(ps))))
+				if ((spc && !isspace(sel_pos(ps, unicode))) ||
+				    (!spc && !inword(sel_pos(ps, unicode))))
 					break;
 				new_sel_start = ps;
 				if (!(ps % vc->vc_size_row))
 					break;
 			}
-			spc = isspace(sel_pos(pe));
+			spc = isspace(sel_pos(pe, unicode));
 			for (new_sel_end = pe; ; pe += 2)
 			{
-				if ((spc && !isspace(sel_pos(pe))) ||
-				    (!spc && !inword(sel_pos(pe))))
+				if ((spc && !isspace(sel_pos(pe, unicode))) ||
+				    (!spc && !inword(sel_pos(pe, unicode))))
 					break;
 				new_sel_end = pe;
 				if (!((pe + 2) % vc->vc_size_row))
@@ -273,12 +273,12 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 	/* select to end of line if on trailing space */
 	if (new_sel_end > new_sel_start &&
 		!atedge(new_sel_end, vc->vc_size_row) &&
-		isspace(sel_pos(new_sel_end))) {
+		isspace(sel_pos(new_sel_end, unicode))) {
 		for (pe = new_sel_end + 2; ; pe += 2)
-			if (!isspace(sel_pos(pe)) ||
+			if (!isspace(sel_pos(pe, unicode)) ||
 			    atedge(pe, vc->vc_size_row))
 				break;
-		if (isspace(sel_pos(pe)))
+		if (isspace(sel_pos(pe, unicode)))
 			new_sel_end = pe;
 	}
 	if (sel_start == -1)	/* no current selection */
@@ -309,7 +309,7 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 
 	/* Allocate a new buffer before freeing the old one ... */
 	/* chars can take up to 4 bytes with unicode */
-	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, use_unicode ? 4 : 1,
+	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, unicode ? 4 : 1,
 			   GFP_KERNEL);
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
@@ -322,8 +322,8 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 
 	obp = bp;
 	for (i = sel_start; i <= sel_end; i += 2) {
-		c = sel_pos(i);
-		if (use_unicode)
+		c = sel_pos(i, unicode);
+		if (unicode)
 			bp += store_utf8(c, bp);
 		else
 			*bp++ = c;
-- 
2.25.0

