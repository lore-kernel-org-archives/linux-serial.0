Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C39C433E5
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EBB2067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHRI6K (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:37984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgHRI5L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E229B035;
        Tue, 18 Aug 2020 08:57:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/16] vc_screen: extract vcs_write_buf_noattr
Date:   Tue, 18 Aug 2020 10:56:57 +0200
Message-Id: <20200818085706.12163-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

vcs_write is too long to be readable. Extract buffer handling w/o
attributes from there to a separate function.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 55 +++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 2571d9067b08..62e6d240f0dd 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -454,6 +454,33 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	return ret;
 }
 
+static u16 *vcs_write_buf_noattr(struct vc_data *vc, const char *con_buf,
+		unsigned int pos, unsigned int count, bool viewed, u16 **org0)
+{
+	u16 *org;
+	unsigned int col, maxcol = vc->vc_cols;
+
+	*org0 = org = screen_pos(vc, pos, viewed);
+	col = pos % maxcol;
+	pos += maxcol - col;
+
+	while (count > 0) {
+		unsigned char c = *con_buf++;
+
+		count--;
+		vcs_scr_writew(vc,
+			       (vcs_scr_readw(vc, org) & 0xff00) | c, org);
+		org++;
+		if (++col == maxcol) {
+			org = screen_pos(vc, pos, viewed);
+			col = 0;
+			pos += maxcol;
+		}
+	}
+
+	return org;
+}
+
 static ssize_t
 vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
@@ -544,29 +571,15 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		 * under the lock using the local kernel buffer.
 		 */
 
-		con_buf0 = con_buf;
-		orig_count = this_round;
-		maxcol = vc->vc_cols;
-		p = pos;
 		if (!attr) {
-			org0 = org = screen_pos(vc, p, viewed);
-			col = p % maxcol;
-			p += maxcol - col;
-
-			while (this_round > 0) {
-				unsigned char c = *con_buf0++;
-
-				this_round--;
-				vcs_scr_writew(vc,
-					       (vcs_scr_readw(vc, org) & 0xff00) | c, org);
-				org++;
-				if (++col == maxcol) {
-					org = screen_pos(vc, p, viewed);
-					col = 0;
-					p += maxcol;
-				}
-			}
+			org = vcs_write_buf_noattr(vc, con_buf, pos, this_round,
+					viewed, &org0);
 		} else {
+			con_buf0 = con_buf;
+			orig_count = this_round;
+			maxcol = vc->vc_cols;
+			p = pos;
+
 			if (p < HEADER_SIZE) {
 				char header[HEADER_SIZE];
 
-- 
2.28.0

