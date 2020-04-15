Return-Path: <SRS0=rV5n=57=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C69C2BA19
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 09:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D80220771
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 09:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895660AbgDOJgO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:36:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895655AbgDOJgN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Apr 2020 05:36:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD059AE4B;
        Wed, 15 Apr 2020 09:36:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] vt: extract selection chars storing from vc_do_selection
Date:   Wed, 15 Apr 2020 11:36:08 +0200
Message-Id: <20200415093608.10348-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200415093608.10348-1-jslaby@suse.cz>
References: <20200415093608.10348-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Let's put it to a separate function, named vc_selection_store_chars.
Again, this makes vc_do_selection a bit shorter and more readable.
Having 4 local variables instead of 12 (5.6-rc1) looks much better now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/selection.c | 79 ++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index a9693c0e8d04..31bb3647a99c 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -185,13 +185,51 @@ int set_selection_user(const struct tiocl_selection __user *sel,
 	return set_selection_kernel(&v, tty);
 }
 
+static int vc_selection_store_chars(struct vc_data *vc, bool unicode)
+{
+	char *bp, *obp;
+	unsigned int i;
+
+	/* Allocate a new buffer before freeing the old one ... */
+	/* chars can take up to 4 bytes with unicode */
+	bp = kmalloc_array((vc_sel.end - vc_sel.start) / 2 + 1, unicode ? 4 : 1,
+			   GFP_KERNEL);
+	if (!bp) {
+		printk(KERN_WARNING "selection: kmalloc() failed\n");
+		clear_selection();
+		return -ENOMEM;
+	}
+	kfree(vc_sel.buffer);
+	vc_sel.buffer = bp;
+
+	obp = bp;
+	for (i = vc_sel.start; i <= vc_sel.end; i += 2) {
+		u32 c = sel_pos(i, unicode);
+		if (unicode)
+			bp += store_utf8(c, bp);
+		else
+			*bp++ = c;
+		if (!isspace(c))
+			obp = bp;
+		if (!((i + 2) % vc->vc_size_row)) {
+			/* strip trailing blanks from line and add newline,
+			   unless non-space at end of line. */
+			if (obp != bp) {
+				bp = obp;
+				*bp++ = '\r';
+			}
+			obp = bp;
+		}
+	}
+	vc_sel.buf_len = bp - vc_sel.buffer;
+
+	return 0;
+}
+
 static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 		int pe)
 {
 	int new_sel_start, new_sel_end, spc;
-	char *bp, *obp;
-	u32 c;
-	int i, ret = 0;
 	bool unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
 
 	switch (mode) {
@@ -272,40 +310,7 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 	vc_sel.start = new_sel_start;
 	vc_sel.end = new_sel_end;
 
-	/* Allocate a new buffer before freeing the old one ... */
-	/* chars can take up to 4 bytes with unicode */
-	bp = kmalloc_array((vc_sel.end - vc_sel.start) / 2 + 1, unicode ? 4 : 1,
-			   GFP_KERNEL);
-	if (!bp) {
-		printk(KERN_WARNING "selection: kmalloc() failed\n");
-		clear_selection();
-		return -ENOMEM;
-	}
-	kfree(vc_sel.buffer);
-	vc_sel.buffer = bp;
-
-	obp = bp;
-	for (i = vc_sel.start; i <= vc_sel.end; i += 2) {
-		c = sel_pos(i, unicode);
-		if (unicode)
-			bp += store_utf8(c, bp);
-		else
-			*bp++ = c;
-		if (!isspace(c))
-			obp = bp;
-		if (! ((i + 2) % vc->vc_size_row)) {
-			/* strip trailing blanks from line and add newline,
-			   unless non-space at end of line. */
-			if (obp != bp) {
-				bp = obp;
-				*bp++ = '\r';
-			}
-			obp = bp;
-		}
-	}
-	vc_sel.buf_len = bp - vc_sel.buffer;
-
-	return ret;
+	return vc_selection_store_chars(vc, unicode);
 }
 
 static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
-- 
2.26.1

