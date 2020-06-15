Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F385C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494E22067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgFOHuM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbgFOHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82F3EB001;
        Mon, 15 Jun 2020 07:49:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 30/38] vt_ioctl: eliminate use of uival and ucval
Date:   Mon, 15 Jun 2020 09:49:02 +0200
Message-Id: <20200615074910.19267-30-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

They were used for the first parameter of put_user. But put_user accepts
constants in the parameter and also determines the type only by the
second parameter. So we can safely drop these helpers and simplify the
code a bit.

Including the removal of set_int label.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 87fe088c3eb4..911edd8d1272 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -353,8 +353,6 @@ int vt_ioctl(struct tty_struct *tty,
 	struct vc_data *vc = tty->driver_data;
 	struct console_font_op op;	/* used in multiple places here */
 	unsigned int console = vc->vc_num;
-	unsigned char ucval;
-	unsigned int uival;
 	void __user *up = (void __user *)arg;
 	int i, perm;
 	int ret;
@@ -406,8 +404,7 @@ int vt_ioctl(struct tty_struct *tty,
 		/*
 		 * this is naïve.
 		 */
-		ucval = KB_101;
-		return put_user(ucval, (char __user *)arg);
+		return put_user(KB_101, (char __user *)arg);
 
 		/*
 		 * These cannot be implemented on any machine that implements
@@ -495,8 +492,7 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 
 	case KDGETMODE:
-		uival = vc->vc_mode;
-		goto setint;
+		return put_user(vc->vc_mode, (int __user *)arg);
 
 	case KDMAPDISP:
 	case KDUNMAPDISP:
@@ -516,8 +512,7 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 
 	case KDGKBMODE:
-		uival = vt_do_kdgkbmode(console);
-		return put_user(uival, (int __user *)arg);
+		return put_user(vt_do_kdgkbmode(console), (int __user *)arg);
 
 	/* this could be folded into KDSKBMODE, but for compatibility
 	   reasons it is not so easy to fold KDGKBMETA into KDGKBMODE */
@@ -526,9 +521,7 @@ int vt_ioctl(struct tty_struct *tty,
 
 	case KDGKBMETA:
 		/* FIXME: should review whether this is worth locking */
-		uival = vt_do_kdgkbmeta(console);
-	setint:
-		return put_user(uival, (int __user *)arg);
+		return put_user(vt_do_kdgkbmeta(console), (int __user *)arg);
 
 	case KDGETKEYCODE:
 	case KDSETKEYCODE:
@@ -650,8 +643,8 @@ int vt_ioctl(struct tty_struct *tty,
 			if (!vt_in_use(i))
 				break;
 		console_unlock();
-		uival = i < MAX_NR_CONSOLES ? (i+1) : -1;
-		goto setint;		 
+		i = i < MAX_NR_CONSOLES ? (i+1) : -1;
+		return put_user(i, (int __user *)arg);
 
 	/*
 	 * ioctl(fd, VT_ACTIVATE, num) will cause us to switch to vt # num,
-- 
2.27.0

