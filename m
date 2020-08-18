Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB691C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C52067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHRI54 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHRI5M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36F1BB03D;
        Tue, 18 Aug 2020 08:57:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/16] vc_screen: extract vcs_read_buf_uni
Date:   Tue, 18 Aug 2020 10:57:02 +0200
Message-Id: <20200818085706.12163-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The same as making write more readable, extract unicode handling from
vcs_read. The other two cases (w/ and w/o attributes) will follow.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 49 +++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 8ebb6724a804..91d2e0148a67 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -249,6 +249,33 @@ static loff_t vcs_lseek(struct file *file, loff_t offset, int orig)
 	return fixed_size_llseek(file, offset, orig, size);
 }
 
+static int vcs_read_buf_uni(struct vc_data *vc, char *con_buf,
+		unsigned int pos, unsigned int count, bool viewed)
+{
+	unsigned int nr, row, col, maxcol = vc->vc_cols;
+	int ret;
+
+	ret = vc_uniscr_check(vc);
+	if (ret)
+		return ret;
+
+	pos /= 4;
+	row = pos / maxcol;
+	col = pos % maxcol;
+	nr = maxcol - col;
+	do {
+		if (nr > count / 4)
+			nr = count / 4;
+		vc_uniscr_copy_line(vc, con_buf, viewed, row, col, nr);
+		con_buf += nr * 4;
+		count -= nr * 4;
+		row++;
+		col = 0;
+		nr = maxcol;
+	} while (count);
+
+	return 0;
+}
 
 static ssize_t
 vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
@@ -257,7 +284,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	struct vc_data *vc;
 	struct vcs_poll_data *poll;
 	u16 *org;
-	unsigned int read, row, col, maxcol;
+	unsigned int read, col, maxcol;
 	ssize_t ret;
 	char *con_buf;
 	loff_t pos;
@@ -327,26 +354,10 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		orig_count = this_round;
 		maxcol = vc->vc_cols;
 		if (uni_mode) {
-			unsigned int nr;
-
-			ret = vc_uniscr_check(vc);
+			ret = vcs_read_buf_uni(vc, con_buf, pos, this_round,
+					viewed);
 			if (ret)
 				break;
-			p /= 4;
-			row = p / vc->vc_cols;
-			col = p % maxcol;
-			nr = maxcol - col;
-			do {
-				if (nr > this_round/4)
-					nr = this_round/4;
-				vc_uniscr_copy_line(vc, con_buf0, viewed,
-						    row, col, nr);
-				con_buf0 += nr * 4;
-				this_round -= nr * 4;
-				row++;
-				col = 0;
-				nr = maxcol;
-			} while (this_round);
 		} else if (!attr) {
 			org = screen_pos(vc, p, viewed);
 			col = p % maxcol;
-- 
2.28.0

