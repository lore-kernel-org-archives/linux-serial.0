Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CECC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC35B2067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHRI5N (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgHRI5L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58AA1B03E;
        Tue, 18 Aug 2020 08:57:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/16] vc_screen: extract vcs_read_buf_noattr
Date:   Tue, 18 Aug 2020 10:57:03 +0200
Message-Id: <20200818085706.12163-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now, move the code for no-attributes handling to a separate function.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 91d2e0148a67..ad015cd4e82f 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -277,6 +277,26 @@ static int vcs_read_buf_uni(struct vc_data *vc, char *con_buf,
 	return 0;
 }
 
+static void vcs_read_buf_noattr(const struct vc_data *vc, char *con_buf,
+		unsigned int pos, unsigned int count, bool viewed)
+{
+	u16 *org;
+	unsigned int col, maxcol = vc->vc_cols;
+
+	org = screen_pos(vc, pos, viewed);
+	col = pos % maxcol;
+	pos += maxcol - col;
+
+	while (count-- > 0) {
+		*con_buf++ = (vcs_scr_readw(vc, org++) & 0xff);
+		if (++col == maxcol) {
+			org = screen_pos(vc, pos, viewed);
+			col = 0;
+			pos += maxcol;
+		}
+	}
+}
+
 static ssize_t
 vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
@@ -359,17 +379,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			if (ret)
 				break;
 		} else if (!attr) {
-			org = screen_pos(vc, p, viewed);
-			col = p % maxcol;
-			p += maxcol - col;
-			while (this_round-- > 0) {
-				*con_buf0++ = (vcs_scr_readw(vc, org++) & 0xff);
-				if (++col == maxcol) {
-					org = screen_pos(vc, p, viewed);
-					col = 0;
-					p += maxcol;
-				}
-			}
+			vcs_read_buf_noattr(vc, con_buf, pos, this_round,
+					viewed);
 		} else {
 			if (p < HEADER_SIZE) {
 				/* clamp header values if they don't fit */
-- 
2.28.0

