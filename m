Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28698C433E3
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D512068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgFOHtf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgFOHtX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D057EB0E6;
        Mon, 15 Jun 2020 07:49:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 37/38] vt_ioctl: move vt_kdsetmode out of vt_k_ioctl
Date:   Mon, 15 Jun 2020 09:49:09 +0200
Message-Id: <20200615074910.19267-37-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's too long to be inlined.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 78 +++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index ecf96f5e616d..224f2a564e13 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -241,6 +241,47 @@ int vt_waitactive(int n)
 #define GPLAST 0x3df
 #define GPNUM (GPLAST - GPFIRST + 1)
 
+/*
+ * currently, setting the mode from KD_TEXT to KD_GRAPHICS doesn't do a whole
+ * lot. i'm not sure if it should do any restoration of modes or what...
+ *
+ * XXX It should at least call into the driver, fbdev's definitely need to
+ * restore their engine state. --BenH
+ */
+static int vt_kdsetmode(struct vc_data *vc, unsigned long mode)
+{
+	switch (mode) {
+	case KD_GRAPHICS:
+		break;
+	case KD_TEXT0:
+	case KD_TEXT1:
+		mode = KD_TEXT;
+		fallthrough;
+	case KD_TEXT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* FIXME: this needs the console lock extending */
+	if (vc->vc_mode == mode)
+		return 0;
+
+	vc->vc_mode = mode;
+	if (vc->vc_num != fg_console)
+		return 0;
+
+	/* explicitly blank/unblank the screen if switching modes */
+	console_lock();
+	if (mode == KD_TEXT)
+		do_unblank_screen(1);
+	else
+		do_blank_screen(1);
+	console_unlock();
+
+	return 0;
+}
+
 static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 		unsigned long arg, bool perm)
 {
@@ -335,43 +376,10 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 	}
 
 	case KDSETMODE:
-		/*
-		 * currently, setting the mode from KD_TEXT to KD_GRAPHICS
-		 * doesn't do a whole lot. i'm not sure if it should do any
-		 * restoration of modes or what...
-		 *
-		 * XXX It should at least call into the driver, fbdev's definitely
-		 * need to restore their engine state. --BenH
-		 */
 		if (!perm)
 			return -EPERM;
-		switch (arg) {
-		case KD_GRAPHICS:
-			break;
-		case KD_TEXT0:
-		case KD_TEXT1:
-			arg = KD_TEXT;
-		case KD_TEXT:
-			break;
-		default:
-			return -EINVAL;
-		}
-		/* FIXME: this needs the console lock extending */
-		if (vc->vc_mode == (unsigned char) arg)
-			break;
-		vc->vc_mode = (unsigned char) arg;
-		if (console != fg_console)
-			break;
-		/*
-		 * explicitly blank/unblank the screen if switching modes
-		 */
-		console_lock();
-		if (arg == KD_TEXT)
-			do_unblank_screen(1);
-		else
-			do_blank_screen(1);
-		console_unlock();
-		break;
+
+		return vt_kdsetmode(vc, arg);
 
 	case KDGETMODE:
 		return put_user(vc->vc_mode, (int __user *)arg);
-- 
2.27.0

