Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA2C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B852067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgHRI5o (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgHRI5N (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C61DB03F;
        Tue, 18 Aug 2020 08:57:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/16] vc_screen: extract vcs_read_buf
Date:   Tue, 18 Aug 2020 10:57:04 +0200
Message-Id: <20200818085706.12163-14-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

And finally, move the attributes buffer handling to a separate function.
Leaving vcs_read quite compact.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 146 ++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 68 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index ad015cd4e82f..c178a1611223 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -297,14 +297,81 @@ static void vcs_read_buf_noattr(const struct vc_data *vc, char *con_buf,
 	}
 }
 
+static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
+		unsigned int pos, unsigned int count, bool viewed,
+		unsigned int *skip)
+{
+	u16 *org, *con_buf16;
+	unsigned int col, maxcol = vc->vc_cols;
+	unsigned int filled = count;
+
+	if (pos < HEADER_SIZE) {
+		/* clamp header values if they don't fit */
+		con_buf[0] = min(vc->vc_rows, 0xFFu);
+		con_buf[1] = min(vc->vc_cols, 0xFFu);
+		getconsxy(vc, con_buf + 2);
+
+		*skip += pos;
+		count += pos;
+		if (count > CON_BUF_SIZE) {
+			count = CON_BUF_SIZE;
+			filled = count - pos;
+		}
+
+		/* Advance state pointers and move on. */
+		count -= min(HEADER_SIZE, count);
+		pos = HEADER_SIZE;
+		con_buf += HEADER_SIZE;
+		/* If count >= 0, then pos is even... */
+	} else if (pos & 1) {
+		/*
+		 * Skip first byte for output if start address is odd. Update
+		 * region sizes up/down depending on free space in buffer.
+		 */
+		(*skip)++;
+		if (count < CON_BUF_SIZE)
+			count++;
+		else
+			filled--;
+	}
+
+	if (!count)
+		return filled;
+
+	pos -= HEADER_SIZE;
+	pos /= 2;
+	col = pos % maxcol;
+
+	org = screen_pos(vc, pos, viewed);
+	pos += maxcol - col;
+
+	/*
+	 * Buffer has even length, so we can always copy character + attribute.
+	 * We do not copy last byte to userspace if count is odd.
+	 */
+	count = (count + 1) / 2;
+	con_buf16 = (u16 *)con_buf;
+
+	while (count) {
+		*con_buf16++ = vcs_scr_readw(vc, org++);
+		count--;
+		if (++col == maxcol) {
+			org = screen_pos(vc, pos, viewed);
+			col = 0;
+			pos += maxcol;
+		}
+	}
+
+	return filled;
+}
+
 static ssize_t
 vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = file_inode(file);
 	struct vc_data *vc;
 	struct vcs_poll_data *poll;
-	u16 *org;
-	unsigned int read, col, maxcol;
+	unsigned int read;
 	ssize_t ret;
 	char *con_buf;
 	loff_t pos;
@@ -341,8 +408,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	read = 0;
 	ret = 0;
 	while (count) {
-		char *con_buf0, *con_buf_start;
-		unsigned int this_round, orig_count, p = pos;
+		unsigned int this_round, skip = 0;
 		int size;
 
 		/* Check whether we are above size each round,
@@ -370,9 +436,6 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * attempt to move it to userspace.
 		 */
 
-		con_buf_start = con_buf0 = con_buf;
-		orig_count = this_round;
-		maxcol = vc->vc_cols;
 		if (uni_mode) {
 			ret = vcs_read_buf_uni(vc, con_buf, pos, this_round,
 					viewed);
@@ -382,61 +445,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			vcs_read_buf_noattr(vc, con_buf, pos, this_round,
 					viewed);
 		} else {
-			if (p < HEADER_SIZE) {
-				/* clamp header values if they don't fit */
-				con_buf0[0] = min(vc->vc_rows, 0xFFu);
-				con_buf0[1] = min(vc->vc_cols, 0xFFu);
-				getconsxy(vc, con_buf0 + 2);
-
-				con_buf_start += p;
-				this_round += p;
-				if (this_round > CON_BUF_SIZE) {
-					this_round = CON_BUF_SIZE;
-					orig_count = this_round - p;
-				}
-
-				/* Advance state pointers and move on. */
-				this_round -= min(HEADER_SIZE, this_round);
-				p = HEADER_SIZE;
-				con_buf0 = con_buf + HEADER_SIZE;
-				/* If this_round >= 0, then p is even... */
-			} else if (p & 1) {
-				/* Skip first byte for output if start address is odd
-				 * Update region sizes up/down depending on free
-				 * space in buffer.
-				 */
-				con_buf_start++;
-				if (this_round < CON_BUF_SIZE)
-					this_round++;
-				else
-					orig_count--;
-			}
-			if (this_round > 0) {
-				unsigned short *tmp_buf = (unsigned short *)con_buf0;
-
-				p -= HEADER_SIZE;
-				p /= 2;
-				col = p % maxcol;
-
-				org = screen_pos(vc, p, viewed);
-				p += maxcol - col;
-
-				/* Buffer has even length, so we can always copy
-				 * character + attribute. We do not copy last byte
-				 * to userspace if this_round is odd.
-				 */
-				this_round = (this_round + 1) >> 1;
-
-				while (this_round) {
-					*tmp_buf++ = vcs_scr_readw(vc, org++);
-					this_round --;
-					if (++col == maxcol) {
-						org = screen_pos(vc, p, viewed);
-						col = 0;
-						p += maxcol;
-					}
-				}
-			}
+			this_round = vcs_read_buf(vc, con_buf, pos, this_round,
+					viewed, &skip);
 		}
 
 		/* Finally, release the console semaphore while we push
@@ -447,18 +457,18 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 */
 
 		console_unlock();
-		ret = copy_to_user(buf, con_buf_start, orig_count);
+		ret = copy_to_user(buf, con_buf + skip, this_round);
 		console_lock();
 
 		if (ret) {
-			read += (orig_count - ret);
+			read += this_round - ret;
 			ret = -EFAULT;
 			break;
 		}
-		buf += orig_count;
-		pos += orig_count;
-		read += orig_count;
-		count -= orig_count;
+		buf += this_round;
+		pos += this_round;
+		read += this_round;
+		count -= this_round;
 	}
 	*ppos += read;
 	if (read)
-- 
2.28.0

