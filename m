Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A8C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614B92068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgFOHtg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:40182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgFOHtV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D77F7B07B;
        Mon, 15 Jun 2020 07:49:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 32/38] vt_ioctl: move io ioctls to a separate function
Date:   Mon, 15 Jun 2020 09:49:04 +0200
Message-Id: <20200615074910.19267-32-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We create a new vt_io_ioctl here and move there all the IO ioctls.  This
makes vt_ioctl significantly smaller.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 177 +++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 79 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 1b423bdc488e..978c33ad6619 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -539,6 +539,100 @@ static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
 	return 0;
 }
 
+static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
+		bool perm)
+{
+	struct console_font_op op;	/* used in multiple places here */
+
+	switch (cmd) {
+	case PIO_FONT:
+		if (!perm)
+			return -EPERM;
+		op.op = KD_FONT_OP_SET;
+		op.flags = KD_FONT_FLAG_OLD | KD_FONT_FLAG_DONT_RECALC;	/* Compatibility */
+		op.width = 8;
+		op.height = 0;
+		op.charcount = 256;
+		op.data = up;
+		return con_font_op(vc_cons[fg_console].d, &op);
+
+	case GIO_FONT:
+		op.op = KD_FONT_OP_GET;
+		op.flags = KD_FONT_FLAG_OLD;
+		op.width = 8;
+		op.height = 32;
+		op.charcount = 256;
+		op.data = up;
+		return con_font_op(vc_cons[fg_console].d, &op);
+
+	case PIO_CMAP:
+                if (!perm)
+			return -EPERM;
+		return con_set_cmap(up);
+
+	case GIO_CMAP:
+                return con_get_cmap(up);
+
+	case PIO_FONTX:
+	case GIO_FONTX:
+		return do_fontx_ioctl(cmd, up, perm, &op);
+
+	case PIO_FONTRESET:
+		if (!perm)
+			return -EPERM;
+
+#ifdef BROKEN_GRAPHICS_PROGRAMS
+		/* With BROKEN_GRAPHICS_PROGRAMS defined, the default
+		   font is not saved. */
+		return -ENOSYS;
+#else
+		{
+		int ret;
+		op.op = KD_FONT_OP_SET_DEFAULT;
+		op.data = NULL;
+		ret = con_font_op(vc_cons[fg_console].d, &op);
+		if (ret)
+			return ret;
+		console_lock();
+		con_set_default_unimap(vc_cons[fg_console].d);
+		console_unlock();
+		break;
+		}
+#endif
+
+	case PIO_SCRNMAP:
+		if (!perm)
+			return -EPERM;
+		return con_set_trans_old(up);
+
+	case GIO_SCRNMAP:
+		return con_get_trans_old(up);
+
+	case PIO_UNISCRNMAP:
+		if (!perm)
+			return -EPERM;
+		return con_set_trans_new(up);
+
+	case GIO_UNISCRNMAP:
+		return con_get_trans_new(up);
+
+	case PIO_UNIMAPCLR:
+		if (!perm)
+			return -EPERM;
+		con_clear_unimap(vc);
+		break;
+
+	case PIO_UNIMAP:
+	case GIO_UNIMAP:
+		return do_unimap_ioctl(cmd, up, perm, vc);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
 /* deallocate a single console, if possible (leave 0) */
 static int vt_disallocate(unsigned int vc_num)
 {
@@ -586,7 +680,6 @@ int vt_ioctl(struct tty_struct *tty,
 	     unsigned int cmd, unsigned long arg)
 {
 	struct vc_data *vc = tty->driver_data;
-	struct console_font_op op;	/* used in multiple places here */
 	void __user *up = (void __user *)arg;
 	int i, perm;
 	int ret;
@@ -603,6 +696,10 @@ int vt_ioctl(struct tty_struct *tty,
 	if (ret != -ENOIOCTLCMD)
 		return ret;
 
+	ret = vt_io_ioctl(vc, cmd, up, perm);
+	if (ret != -ENOIOCTLCMD)
+		return ret;
+
 	switch (cmd) {
 	case TIOCLINUX:
 		return tioclinux(tty, arg);
@@ -903,84 +1000,6 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 	}
 
-	case PIO_FONT:
-		if (!perm)
-			return -EPERM;
-		op.op = KD_FONT_OP_SET;
-		op.flags = KD_FONT_FLAG_OLD | KD_FONT_FLAG_DONT_RECALC;	/* Compatibility */
-		op.width = 8;
-		op.height = 0;
-		op.charcount = 256;
-		op.data = up;
-		return con_font_op(vc_cons[fg_console].d, &op);
-
-	case GIO_FONT:
-		op.op = KD_FONT_OP_GET;
-		op.flags = KD_FONT_FLAG_OLD;
-		op.width = 8;
-		op.height = 32;
-		op.charcount = 256;
-		op.data = up;
-		return con_font_op(vc_cons[fg_console].d, &op);
-
-	case PIO_CMAP:
-                if (!perm)
-			return -EPERM;
-		return con_set_cmap(up);
-
-	case GIO_CMAP:
-                return con_get_cmap(up);
-
-	case PIO_FONTX:
-	case GIO_FONTX:
-		return do_fontx_ioctl(cmd, up, perm, &op);
-
-	case PIO_FONTRESET:
-		if (!perm)
-			return -EPERM;
-
-#ifdef BROKEN_GRAPHICS_PROGRAMS
-		/* With BROKEN_GRAPHICS_PROGRAMS defined, the default
-		   font is not saved. */
-		return -ENOSYS;
-#else
-		op.op = KD_FONT_OP_SET_DEFAULT;
-		op.data = NULL;
-		ret = con_font_op(vc_cons[fg_console].d, &op);
-		if (ret)
-			return ret;
-		console_lock();
-		con_set_default_unimap(vc_cons[fg_console].d);
-		console_unlock();
-		break;
-#endif
-
-	case PIO_SCRNMAP:
-		if (!perm)
-			return -EPERM;
-		return con_set_trans_old(up);
-
-	case GIO_SCRNMAP:
-		return con_get_trans_old(up);
-
-	case PIO_UNISCRNMAP:
-		if (!perm)
-			return -EPERM;
-		return con_set_trans_new(up);
-
-	case GIO_UNISCRNMAP:
-		return con_get_trans_new(up);
-
-	case PIO_UNIMAPCLR:
-		if (!perm)
-			return -EPERM;
-		con_clear_unimap(vc);
-		break;
-
-	case PIO_UNIMAP:
-	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, up, perm, vc);
-
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
-- 
2.27.0

