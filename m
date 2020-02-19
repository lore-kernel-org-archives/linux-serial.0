Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57115C3404E
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0AF208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgBSHkC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:40:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:41566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgBSHj4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B93E9B1EA;
        Wed, 19 Feb 2020 07:39:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/9] vt: vt_kern.h, remove extern from functions
Date:   Wed, 19 Feb 2020 08:39:49 +0100
Message-Id: <20200219073951.16151-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219073951.16151-1-jslaby@suse.cz>
References: <20200219073951.16151-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Unify the declarations of functions in vt_kern.h: some are with extern,
some are not. Remove extern from the former as it is not needed for
functions.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/vt_kern.h | 62 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index ded5c48598f3..abf5bccf906a 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -28,8 +28,9 @@
 #define BROKEN_GRAPHICS_PROGRAMS 1
 #endif
 
-extern void kd_mksound(unsigned int hz, unsigned int ticks);
-extern int kbd_rate(struct kbd_repeat *rep);
+void kd_mksound(unsigned int hz, unsigned int ticks);
+int kbd_rate(struct kbd_repeat *rep);
+
 extern int fg_console, last_console, want_console;
 
 /* console.c */
@@ -131,8 +132,8 @@ void vt_event_post(unsigned int event, unsigned int old, unsigned int new);
 int vt_waitactive(int n);
 void change_console(struct vc_data *new_vc);
 void reset_vc(struct vc_data *vc);
-extern int do_unbind_con_driver(const struct consw *csw, int first, int last,
-			     int deflt);
+int do_unbind_con_driver(const struct consw *csw, int first, int last,
+			 int deflt);
 int vty_init(const struct file_operations *console_fops);
 
 extern bool vt_dont_switch;
@@ -146,7 +147,7 @@ struct vt_spawn_console {
 };
 extern struct vt_spawn_console vt_spawn_con;
 
-extern int vt_move_to_console(unsigned int vt, int alloc);
+int vt_move_to_console(unsigned int vt, int alloc);
 
 /* Interfaces for VC notification of character events (for accessibility etc) */
 
@@ -155,35 +156,34 @@ struct vt_notifier_param {
 	unsigned int c;		/* Printed char */
 };
 
-extern int register_vt_notifier(struct notifier_block *nb);
-extern int unregister_vt_notifier(struct notifier_block *nb);
+int register_vt_notifier(struct notifier_block *nb);
+int unregister_vt_notifier(struct notifier_block *nb);
 
-extern void hide_boot_cursor(bool hide);
+void hide_boot_cursor(bool hide);
 
 /* keyboard  provided interfaces */
-extern int vt_do_diacrit(unsigned int cmd, void __user *up, int eperm);
-extern int vt_do_kdskbmode(int console, unsigned int arg);
-extern int vt_do_kdskbmeta(int console, unsigned int arg);
-extern int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
-								int perm);
-extern int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe,
-					int perm, int console);
-extern int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb,
-                                        int perm);
-extern int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm);
-extern int vt_do_kdgkbmode(int console);
-extern int vt_do_kdgkbmeta(int console);
-extern void vt_reset_unicode(int console);
-extern int vt_get_shift_state(void);
-extern void vt_reset_keyboard(int console);
-extern int vt_get_leds(int console, int flag);
-extern int vt_get_kbd_mode_bit(int console, int bit);
-extern void vt_set_kbd_mode_bit(int console, int bit);
-extern void vt_clr_kbd_mode_bit(int console, int bit);
-extern void vt_set_led_state(int console, int leds);
-extern void vt_set_led_state(int console, int leds);
-extern void vt_kbd_con_start(int console);
-extern void vt_kbd_con_stop(int console);
+int vt_do_diacrit(unsigned int cmd, void __user *up, int eperm);
+int vt_do_kdskbmode(int console, unsigned int arg);
+int vt_do_kdskbmeta(int console, unsigned int arg);
+int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
+			  int perm);
+int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
+		     int console);
+int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm);
+int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm);
+int vt_do_kdgkbmode(int console);
+int vt_do_kdgkbmeta(int console);
+void vt_reset_unicode(int console);
+int vt_get_shift_state(void);
+void vt_reset_keyboard(int console);
+int vt_get_leds(int console, int flag);
+int vt_get_kbd_mode_bit(int console, int bit);
+void vt_set_kbd_mode_bit(int console, int bit);
+void vt_clr_kbd_mode_bit(int console, int bit);
+void vt_set_led_state(int console, int leds);
+void vt_set_led_state(int console, int leds);
+void vt_kbd_con_start(int console);
+void vt_kbd_con_stop(int console);
 
 void vc_scrolldelta_helper(struct vc_data *c, int lines,
 		unsigned int rolled_over, void *_base, unsigned int size);
-- 
2.25.0

