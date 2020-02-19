Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDDC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1CC2465D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgBSHkP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:40:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:41518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgBSHjy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30456AEA8;
        Wed, 19 Feb 2020 07:39:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/9] vt: ioctl, switch VT_IS_IN_USE and VT_BUSY to inlines
Date:   Wed, 19 Feb 2020 08:39:44 +0100
Message-Id: <20200219073951.16151-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219073951.16151-1-jslaby@suse.cz>
References: <20200219073951.16151-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These two were macros. Switch them to static inlines, so that it's more
understandable what they are doing.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index bf4daa0c7930..693d9d7ffb68 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -40,10 +40,25 @@
 #include <linux/selection.h>
 
 char vt_dont_switch;
-extern struct tty_driver *console_driver;
 
-#define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
-#define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_is_sel(vc_cons[i].d))
+static inline bool vt_in_use(unsigned int i)
+{
+	extern struct tty_driver *console_driver;
+
+	return console_driver->ttys[i] && console_driver->ttys[i]->count;
+}
+
+static inline bool vt_busy(int i)
+{
+	if (vt_in_use(i))
+		return true;
+	if (i == fg_console)
+		return true;
+	if (vc_is_sel(vc_cons[i].d))
+		return true;
+
+	return false;
+}
 
 /*
  * Console (vt and kd) routines, as defined by USL SVR4 manual, and by
@@ -289,7 +304,7 @@ static int vt_disallocate(unsigned int vc_num)
 	int ret = 0;
 
 	console_lock();
-	if (VT_BUSY(vc_num))
+	if (vt_busy(vc_num))
 		ret = -EBUSY;
 	else if (vc_num)
 		vc = vc_deallocate(vc_num);
@@ -311,7 +326,7 @@ static void vt_disallocate_all(void)
 
 	console_lock();
 	for (i = 1; i < MAX_NR_CONSOLES; i++)
-		if (!VT_BUSY(i))
+		if (!vt_busy(i))
 			vc[i] = vc_deallocate(i);
 		else
 			vc[i] = NULL;
@@ -648,7 +663,7 @@ int vt_ioctl(struct tty_struct *tty,
 			state = 1;	/* /dev/tty0 is always open */
 			for (i = 0, mask = 2; i < MAX_NR_CONSOLES && mask;
 							++i, mask <<= 1)
-				if (VT_IS_IN_USE(i))
+				if (vt_in_use(i))
 					state |= mask;
 			ret = put_user(state, &vtstat->v_state);
 		}
@@ -661,7 +676,7 @@ int vt_ioctl(struct tty_struct *tty,
 	case VT_OPENQRY:
 		/* FIXME: locking ? - but then this is a stupid API */
 		for (i = 0; i < MAX_NR_CONSOLES; ++i)
-			if (! VT_IS_IN_USE(i))
+			if (!vt_in_use(i))
 				break;
 		uival = i < MAX_NR_CONSOLES ? (i+1) : -1;
 		goto setint;		 
-- 
2.25.0

