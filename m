Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DD6C433E2
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901022068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgFOHtf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgFOHtX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03BEEB0EA;
        Mon, 15 Jun 2020 07:49:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 38/38] vt_ioctl: move perm checks level up
Date:   Mon, 15 Jun 2020 09:49:10 +0200
Message-Id: <20200615074910.19267-38-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Synchronize with others and check perm directly in vt_k_ioctl.
We do not need to pass perm to do_fontx_ioctl and do_unimap_ioctl then.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 224f2a564e13..91c301775047 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -486,7 +486,7 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 }
 
 static inline int do_fontx_ioctl(int cmd,
-		struct consolefontdesc __user *user_cfd, int perm,
+		struct consolefontdesc __user *user_cfd,
 		struct console_font_op *op)
 {
 	struct consolefontdesc cfdarg;
@@ -497,8 +497,6 @@ static inline int do_fontx_ioctl(int cmd,
 
 	switch (cmd) {
 	case PIO_FONTX:
-		if (!perm)
-			return -EPERM;
 		op->op = KD_FONT_OP_SET;
 		op->flags = KD_FONT_FLAG_OLD;
 		op->width = 8;
@@ -552,7 +550,7 @@ static int vt_io_fontreset(struct console_font_op *op)
 }
 
 static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
-		int perm, struct vc_data *vc)
+		struct vc_data *vc)
 {
 	struct unimapdesc tmp;
 
@@ -560,11 +558,9 @@ static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
 		return -EFAULT;
 	switch (cmd) {
 	case PIO_UNIMAP:
-		if (!perm)
-			return -EPERM;
 		return con_set_unimap(vc, tmp.entry_ct, tmp.entries);
 	case GIO_UNIMAP:
-		if (!perm && fg_console != vc->vc_num)
+		if (fg_console != vc->vc_num)
 			return -EPERM;
 		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct),
 				tmp.entries);
@@ -607,8 +603,12 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
                 return con_get_cmap(up);
 
 	case PIO_FONTX:
+		if (!perm)
+			return -EPERM;
+
+		fallthrough;
 	case GIO_FONTX:
-		return do_fontx_ioctl(cmd, up, perm, &op);
+		return do_fontx_ioctl(cmd, up, &op);
 
 	case PIO_FONTRESET:
 		if (!perm)
@@ -640,7 +640,10 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, up, perm, vc);
+		if (!perm)
+			return -EPERM;
+
+		return do_unimap_ioctl(cmd, up, vc);
 
 	default:
 		return -ENOIOCTLCMD;
-- 
2.27.0

