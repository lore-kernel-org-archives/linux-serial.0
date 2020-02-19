Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE55C3404F
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8680824672
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgBSHkC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:40:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:41556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgBSHjz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B366AE9E;
        Wed, 19 Feb 2020 07:39:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/9] vt: switch vt_dont_switch to bool
Date:   Wed, 19 Feb 2020 08:39:48 +0100
Message-Id: <20200219073951.16151-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219073951.16151-1-jslaby@suse.cz>
References: <20200219073951.16151-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

vt_dont_switch is pure boolean, no need for whole char.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 6 +++---
 include/linux/vt_kern.h   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 693d9d7ffb68..38948ac5fc49 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -39,7 +39,7 @@
 #include <linux/kbd_diacr.h>
 #include <linux/selection.h>
 
-char vt_dont_switch;
+bool vt_dont_switch;
 
 static inline bool vt_in_use(unsigned int i)
 {
@@ -1026,12 +1026,12 @@ int vt_ioctl(struct tty_struct *tty,
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
-		vt_dont_switch = 1;
+		vt_dont_switch = true;
 		break;
 	case VT_UNLOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
-		vt_dont_switch = 0;
+		vt_dont_switch = false;
 		break;
 	case VT_GETHIFONTMASK:
 		ret = put_user(vc->vc_hi_font_mask,
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 8dc77e40bc03..ded5c48598f3 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -135,7 +135,7 @@ extern int do_unbind_con_driver(const struct consw *csw, int first, int last,
 			     int deflt);
 int vty_init(const struct file_operations *console_fops);
 
-extern char vt_dont_switch;
+extern bool vt_dont_switch;
 extern int default_utf8;
 extern int global_cursor_default;
 
-- 
2.25.0

