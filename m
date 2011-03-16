From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/76] vt: Add virtual console keyboard mode OFF
Date: Wed, 16 Mar 2011 14:11:45 -0700
Message-ID: <1300309966-5745-15-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32907 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712Ab1CPVNN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:13 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Arthur Taylor <art@ified.ca>, Greg Kroah-Hartman <gregkh@suse.de>

From: Arthur Taylor <art@ified.ca>

virtual console: add keyboard mode OFF

Add a new mode for the virtual console keyboard OFF in which all input
other than shift keys is ignored. Prevents vt input buffers from
overflowing when a program opens but doesn't read from a tty, like X11
using evdev for input.

Signed-off-by: Arthur Taylor <art@ified.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/keyboard.c |    5 +++--
 drivers/tty/vt/vt_ioctl.c |    3 +++
 include/linux/kbd_kern.h  |    3 ++-
 include/linux/kd.h        |    1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index e95d787..6dd3c68 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -654,7 +654,8 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
 	if (value >= ARRAY_SIZE(fn_handler))
 		return;
 	if ((kbd->kbdmode == VC_RAW ||
-	     kbd->kbdmode == VC_MEDIUMRAW) &&
+	     kbd->kbdmode == VC_MEDIUMRAW ||
+	     kbd->kbdmode == VC_OFF) &&
 	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
 	fn_handler[value](vc);
@@ -1295,7 +1296,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	if (rc == NOTIFY_STOP)
 		return;
 
-	if (raw_mode && type != KT_SPEC && type != KT_SHIFT)
+	if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
 		return;
 
 	(*k_handler[type])(vc, keysym & 0xff, !down);
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 1235ebd..6bcf05b 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -688,6 +688,9 @@ int vt_ioctl(struct tty_struct *tty, struct file * file,
 			kbd->kbdmode = VC_UNICODE;
 			compute_shiftstate();
 			break;
+		  case K_OFF:
+			kbd->kbdmode = VC_OFF;
+			break;
 		  default:
 			ret = -EINVAL;
 			goto out;
diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index 506ad20..4b0761c 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -50,11 +50,12 @@ struct kbd_struct {
 #define VC_CAPSLOCK	2	/* capslock mode */
 #define VC_KANALOCK	3	/* kanalock mode */
 
-	unsigned char kbdmode:2;	/* one 2-bit value */
+	unsigned char kbdmode:3;	/* one 3-bit value */
 #define VC_XLATE	0	/* translate keycodes using keymap */
 #define VC_MEDIUMRAW	1	/* medium raw (keycode) mode */
 #define VC_RAW		2	/* raw (scancode) mode */
 #define VC_UNICODE	3	/* Unicode mode */
+#define VC_OFF		4	/* disabled mode */
 
 	unsigned char modeflags:5;
 #define VC_APPLIC	0	/* application key mode */
diff --git a/include/linux/kd.h b/include/linux/kd.h
index 15f2853..c36d847 100644
--- a/include/linux/kd.h
+++ b/include/linux/kd.h
@@ -81,6 +81,7 @@ struct unimapinit {
 #define		K_XLATE		0x01
 #define		K_MEDIUMRAW	0x02
 #define		K_UNICODE	0x03
+#define		K_OFF		0x04
 #define KDGKBMODE	0x4B44	/* gets current keyboard mode */
 #define KDSKBMODE	0x4B45	/* sets current keyboard mode */
 
-- 
1.7.4.1

