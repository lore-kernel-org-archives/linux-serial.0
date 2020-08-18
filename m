Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49AEC433E4
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55C92067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHRI5P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgHRI5L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E793BB039;
        Tue, 18 Aug 2020 08:57:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/16] vc_screen: sanitize types in vcs_read
Date:   Tue, 18 Aug 2020 10:57:00 +0200
Message-Id: <20200818085706.12163-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* pos is derived from the passed ppos, so make it long enough, i.e.
  loff_t
* attr and uni_mode are booleans, so...
* size is limited by vcs_size() which returns an int
* read, p, orig_count and this_round are always ">= 0" and "< size",
  so uint is enough
* row, col, and max_col are derived from vc->vc_cols (uint) and p, so
  make them uint too
* tmp_count is derived from this_round, so make it an uint too.
* use u16 * for org (instead of unsigned short *). No need to initialize
  org too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 36b967825f68..c62c590ed816 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -256,12 +256,12 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	struct inode *inode = file_inode(file);
 	struct vc_data *vc;
 	struct vcs_poll_data *poll;
-	long pos, read;
-	int attr, uni_mode, row, col, maxcol;
-	unsigned short *org = NULL;
+	u16 *org;
+	unsigned int read, row, col, maxcol;
 	ssize_t ret;
 	char *con_buf;
-	bool viewed;
+	loff_t pos;
+	bool viewed, attr, uni_mode;
 
 	con_buf = (char *) __get_free_page(GFP_KERNEL);
 	if (!con_buf)
@@ -295,9 +295,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	ret = 0;
 	while (count) {
 		char *con_buf0, *con_buf_start;
-		long this_round, size;
-		ssize_t orig_count;
-		long p = pos;
+		unsigned int this_round, orig_count, p = pos;
+		int size;
 
 		/* Check whether we are above size each round,
 		 * as copy_to_user at the end of this loop
@@ -362,7 +361,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			}
 		} else {
 			if (p < HEADER_SIZE) {
-				size_t tmp_count;
+				unsigned int tmp_count;
 
 				/* clamp header values if they don't fit */
 				con_buf0[0] = min(vc->vc_rows, 0xFFu);
-- 
2.28.0

