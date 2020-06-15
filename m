Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE76C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F82074D
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgFOHtg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:40056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgFOHtW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0CECB0BE;
        Mon, 15 Jun 2020 07:49:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 36/38] vt_ioctl: move vt_io_fontreset out of vt_io_ioctl
Date:   Mon, 15 Jun 2020 09:49:08 +0200
Message-Id: <20200615074910.19267-36-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This also eliminates the ifdeffery by using if and __is_defined.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 44 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index f671e94a94a9..ecf96f5e616d 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -518,6 +518,31 @@ static inline int do_fontx_ioctl(int cmd,
 	return -EINVAL;
 }
 
+static int vt_io_fontreset(struct console_font_op *op)
+{
+	int ret;
+
+	if (__is_defined(BROKEN_GRAPHICS_PROGRAMS)) {
+		/*
+		 * With BROKEN_GRAPHICS_PROGRAMS defined, the default font is
+		 * not saved.
+		 */
+		return -ENOSYS;
+	}
+
+	op->op = KD_FONT_OP_SET_DEFAULT;
+	op->data = NULL;
+	ret = con_font_op(vc_cons[fg_console].d, op);
+	if (ret)
+		return ret;
+
+	console_lock();
+	con_set_default_unimap(vc_cons[fg_console].d);
+	console_unlock();
+
+	return 0;
+}
+
 static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
 		int perm, struct vc_data *vc)
 {
@@ -581,24 +606,7 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 		if (!perm)
 			return -EPERM;
 
-#ifdef BROKEN_GRAPHICS_PROGRAMS
-		/* With BROKEN_GRAPHICS_PROGRAMS defined, the default
-		   font is not saved. */
-		return -ENOSYS;
-#else
-		{
-		int ret;
-		op.op = KD_FONT_OP_SET_DEFAULT;
-		op.data = NULL;
-		ret = con_font_op(vc_cons[fg_console].d, &op);
-		if (ret)
-			return ret;
-		console_lock();
-		con_set_default_unimap(vc_cons[fg_console].d);
-		console_unlock();
-		break;
-		}
-#endif
+		return vt_io_fontreset(&op);
 
 	case PIO_SCRNMAP:
 		if (!perm)
-- 
2.27.0

