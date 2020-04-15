Return-Path: <SRS0=rV5n=57=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56182C38A2B
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 09:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B6120771
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 09:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895654AbgDOJgO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:36:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895653AbgDOJgL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Apr 2020 05:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8EEC0AE48;
        Wed, 15 Apr 2020 09:36:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] vt: selection, split __set_selection_kernel
Date:   Wed, 15 Apr 2020 11:36:07 +0200
Message-Id: <20200415093608.10348-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Handle these actions:
* poking console
* TIOCL_SELCLEAR
* TIOCL_SELMOUSEREPORT
* start/end precomputation
* clear_selection if the console changed
in a separate function, thus making __set_selection_kernel way shorter
and more readable. The function still needs dissection, but we are
approaching.

This includes introduction of vc_selection and renaming
__set_selection_kernel to vc_do_selection.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/selection.c | 80 ++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index d54a549c5892..a9693c0e8d04 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -185,47 +185,16 @@ int set_selection_user(const struct tiocl_selection __user *sel,
 	return set_selection_kernel(&v, tty);
 }
 
-static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
+static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
+		int pe)
 {
-	struct vc_data *vc = vc_cons[fg_console].d;
 	int new_sel_start, new_sel_end, spc;
 	char *bp, *obp;
-	int i, ps, pe;
 	u32 c;
-	int ret = 0;
-	bool unicode;
-
-	poke_blanked_console();
-
-	v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
-	v->ys = min_t(u16, v->ys - 1, vc->vc_rows - 1);
-	v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);
-	v->ye = min_t(u16, v->ye - 1, vc->vc_rows - 1);
-	ps = v->ys * vc->vc_size_row + (v->xs << 1);
-	pe = v->ye * vc->vc_size_row + (v->xe << 1);
-
-	if (v->sel_mode == TIOCL_SELCLEAR) {
-		/* useful for screendump without selection highlights */
-		clear_selection();
-		return 0;
-	}
-
-	if (mouse_reporting() && (v->sel_mode & TIOCL_SELMOUSEREPORT)) {
-		mouse_report(tty, v->sel_mode & TIOCL_SELBUTTONMASK, v->xs,
-			     v->ys);
-		return 0;
-	}
+	int i, ret = 0;
+	bool unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
 
-	if (ps > pe)	/* make vc_sel.start <= vc_sel.end */
-		swap(ps, pe);
-
-	if (vc_sel.cons != vc_cons[fg_console].d) {
-		clear_selection();
-		vc_sel.cons = vc_cons[fg_console].d;
-	}
-	unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
-
-	switch (v->sel_mode) {
+	switch (mode) {
 	case TIOCL_SELCHAR:	/* character-by-character selection */
 		new_sel_start = ps;
 		new_sel_end = pe;
@@ -339,13 +308,50 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 	return ret;
 }
 
+static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
+		struct tty_struct *tty)
+{
+	int ps, pe;
+
+	poke_blanked_console();
+
+	if (v->sel_mode == TIOCL_SELCLEAR) {
+		/* useful for screendump without selection highlights */
+		clear_selection();
+		return 0;
+	}
+
+	v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
+	v->ys = min_t(u16, v->ys - 1, vc->vc_rows - 1);
+	v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);
+	v->ye = min_t(u16, v->ye - 1, vc->vc_rows - 1);
+
+	if (mouse_reporting() && (v->sel_mode & TIOCL_SELMOUSEREPORT)) {
+		mouse_report(tty, v->sel_mode & TIOCL_SELBUTTONMASK, v->xs,
+			     v->ys);
+		return 0;
+	}
+
+	ps = v->ys * vc->vc_size_row + (v->xs << 1);
+	pe = v->ye * vc->vc_size_row + (v->xe << 1);
+	if (ps > pe)	/* make vc_sel.start <= vc_sel.end */
+		swap(ps, pe);
+
+	if (vc_sel.cons != vc) {
+		clear_selection();
+		vc_sel.cons = vc;
+	}
+
+	return vc_do_selection(vc, v->sel_mode, ps, pe);
+}
+
 int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 {
 	int ret;
 
 	mutex_lock(&vc_sel.lock);
 	console_lock();
-	ret = __set_selection_kernel(v, tty);
+	ret = vc_selection(vc_cons[fg_console].d, v, tty);
 	console_unlock();
 	mutex_unlock(&vc_sel.lock);
 
-- 
2.26.1

