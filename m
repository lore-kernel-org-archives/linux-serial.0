Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF915C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62392067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHRI5z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgHRI5M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A48CFB036;
        Tue, 18 Aug 2020 08:57:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/16] vc_screen: extract vcs_write_buf
Date:   Tue, 18 Aug 2020 10:56:58 +0200
Message-Id: <20200818085706.12163-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is the counterpart of the previous patch: here, we extract buffer
writing with attributes from vcs_write.

Now, there is no need for org to be initialized to NULL. The org0
check before update_region() confuses compilers, so check org instead.
It provides the same semantics. And it also eliminates the need for
initialization of org0.

We switch the branches of the attr 'if' too, as the inversion brings only
confusion now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 168 ++++++++++++++++++++-----------------
 1 file changed, 92 insertions(+), 76 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 62e6d240f0dd..10a26fd5f1b7 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -481,14 +481,93 @@ static u16 *vcs_write_buf_noattr(struct vc_data *vc, const char *con_buf,
 	return org;
 }
 
+static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
+		unsigned int pos, unsigned int count, bool viewed, u16 **org0)
+{
+	u16 *org;
+	unsigned int col, maxcol = vc->vc_cols;
+	unsigned char c;
+
+	/* header */
+	if (pos < HEADER_SIZE) {
+		char header[HEADER_SIZE];
+
+		getconsxy(vc, header + 2);
+		while (pos < HEADER_SIZE && count > 0) {
+			count--;
+			header[pos++] = *con_buf++;
+		}
+		if (!viewed)
+			putconsxy(vc, header + 2);
+	}
+
+	if (!count)
+		return NULL;
+
+	pos -= HEADER_SIZE;
+	col = (pos/2) % maxcol;
+
+	*org0 = org = screen_pos(vc, pos/2, viewed);
+
+	/* odd pos -- the first single character */
+	if (pos & 1) {
+		count--;
+		c = *con_buf++;
+#ifdef __BIG_ENDIAN
+		vcs_scr_writew(vc, c |
+		     (vcs_scr_readw(vc, org) & 0xff00), org);
+#else
+		vcs_scr_writew(vc, (c << 8) |
+		     (vcs_scr_readw(vc, org) & 0xff), org);
+#endif
+		org++;
+		pos++;
+		if (++col == maxcol) {
+			org = screen_pos(vc, pos/2, viewed);
+			col = 0;
+		}
+	}
+
+	pos /= 2;
+	pos += maxcol - col;
+
+	/* even pos -- handle attr+character pairs */
+	while (count > 1) {
+		unsigned short w;
+
+		w = get_unaligned(((unsigned short *)con_buf));
+		vcs_scr_writew(vc, w, org++);
+		con_buf += 2;
+		count -= 2;
+		if (++col == maxcol) {
+			org = screen_pos(vc, pos, viewed);
+			col = 0;
+			pos += maxcol;
+		}
+	}
+
+	if (!count)
+		return org;
+
+	/* odd pos -- the remaining character */
+	c = *con_buf++;
+#ifdef __BIG_ENDIAN
+	vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff) | (c << 8), org);
+#else
+	vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff00) | c, org);
+#endif
+
+	return org;
+}
+
 static ssize_t
 vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = file_inode(file);
 	struct vc_data *vc;
-	char *con_buf0, *con_buf;
-	u16 *org0 = NULL, *org = NULL;
-	unsigned int written, col, maxcol;
+	char *con_buf;
+	u16 *org0, *org;
+	unsigned int written;
 	int size;
 	ssize_t ret;
 	loff_t pos;
@@ -526,7 +605,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		count = size - pos;
 	written = 0;
 	while (count) {
-		unsigned int orig_count, p, this_round = count;
+		unsigned int this_round = count;
 
 		if (this_round > CON_BUF_SIZE)
 			this_round = CON_BUF_SIZE;
@@ -571,81 +650,18 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		 * under the lock using the local kernel buffer.
 		 */
 
-		if (!attr) {
+		if (attr)
+			org = vcs_write_buf(vc, con_buf, pos, this_round,
+					viewed, &org0);
+		else
 			org = vcs_write_buf_noattr(vc, con_buf, pos, this_round,
 					viewed, &org0);
-		} else {
-			con_buf0 = con_buf;
-			orig_count = this_round;
-			maxcol = vc->vc_cols;
-			p = pos;
-
-			if (p < HEADER_SIZE) {
-				char header[HEADER_SIZE];
-
-				getconsxy(vc, header + 2);
-				while (p < HEADER_SIZE && this_round > 0) {
-					this_round--;
-					header[p++] = *con_buf0++;
-				}
-				if (!viewed)
-					putconsxy(vc, header + 2);
-			}
-			p -= HEADER_SIZE;
-			col = (p/2) % maxcol;
-			if (this_round > 0) {
-				org0 = org = screen_pos(vc, p/2, viewed);
-				if ((p & 1) && this_round > 0) {
-					char c;
-
-					this_round--;
-					c = *con_buf0++;
-#ifdef __BIG_ENDIAN
-					vcs_scr_writew(vc, c |
-					     (vcs_scr_readw(vc, org) & 0xff00), org);
-#else
-					vcs_scr_writew(vc, (c << 8) |
-					     (vcs_scr_readw(vc, org) & 0xff), org);
-#endif
-					org++;
-					p++;
-					if (++col == maxcol) {
-						org = screen_pos(vc, p/2, viewed);
-						col = 0;
-					}
-				}
-				p /= 2;
-				p += maxcol - col;
-			}
-			while (this_round > 1) {
-				unsigned short w;
 
-				w = get_unaligned(((unsigned short *)con_buf0));
-				vcs_scr_writew(vc, w, org++);
-				con_buf0 += 2;
-				this_round -= 2;
-				if (++col == maxcol) {
-					org = screen_pos(vc, p, viewed);
-					col = 0;
-					p += maxcol;
-				}
-			}
-			if (this_round > 0) {
-				unsigned char c;
-
-				c = *con_buf0++;
-#ifdef __BIG_ENDIAN
-				vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff) | (c << 8), org);
-#else
-				vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff00) | c, org);
-#endif
-			}
-		}
-		count -= orig_count;
-		written += orig_count;
-		buf += orig_count;
-		pos += orig_count;
-		if (org0)
+		count -= this_round;
+		written += this_round;
+		buf += this_round;
+		pos += this_round;
+		if (org)
 			update_region(vc, (unsigned long)(org0), org - org0);
 	}
 	*ppos += written;
-- 
2.28.0

