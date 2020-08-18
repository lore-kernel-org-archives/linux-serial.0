Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4080C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AC22067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHRI6J (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:58:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgHRI5L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B9B0B032;
        Tue, 18 Aug 2020 08:57:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/16] vc_screen: sanitize types in vcs_write
Date:   Tue, 18 Aug 2020 10:56:56 +0200
Message-Id: <20200818085706.12163-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* ret can carry error codes, so make it signed, i.e. ssize_t
* pos is derived from the passed ppos, so make it long enough, i.e.
  loff_t
* attr is a boolean, so...
* size is limited by vcs_size() which returns an int
* written, p, orig_count and this_round are always ">= 0" and "< size",
  so uint is enough
* col and max_col are derived from vc->vc_cols (uint) and p, so make
  them uint too
* place con_buf0 and con_buf declaration to a single line

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 8aa0d50bcac7..2571d9067b08 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -459,14 +459,13 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = file_inode(file);
 	struct vc_data *vc;
-	long pos;
-	long attr, size, written;
-	char *con_buf0;
-	int col, maxcol;
+	char *con_buf0, *con_buf;
 	u16 *org0 = NULL, *org = NULL;
-	size_t ret;
-	char *con_buf;
-	bool viewed;
+	unsigned int written, col, maxcol;
+	int size;
+	ssize_t ret;
+	loff_t pos;
+	bool viewed, attr;
 
 	if (use_unicode(inode))
 		return -EOPNOTSUPP;
@@ -500,9 +499,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		count = size - pos;
 	written = 0;
 	while (count) {
-		long this_round = count;
-		size_t orig_count;
-		long p;
+		unsigned int orig_count, p, this_round = count;
 
 		if (this_round > CON_BUF_SIZE)
 			this_round = CON_BUF_SIZE;
-- 
2.28.0

