From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/48] tty: VT, remove unused variable
Date: Mon, 23 May 2011 12:06:21 -0700
Message-ID: <1306177625-17885-4-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177625-17885-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52151 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932730Ab1EWTQU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:16:20 -0400
In-Reply-To: <1306177625-17885-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

drivers/tty/vt/vt_ioctl.c:1525:2: warning: Value stored to 'kbd' is never read
kbd = kbd_table + console;
^     ~~~~~~~~~~~~~~~~~~~

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/vt_ioctl.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 01ccd9e..5485154 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1512,7 +1512,6 @@ long vt_compat_ioctl(struct tty_struct *tty,
 {
 	struct vc_data *vc = tty->driver_data;
 	struct console_font_op op;	/* used in multiple places here */
-	struct kbd_struct *kbd;
 	unsigned int console;
 	void __user *up = (void __user *)arg;
 	int perm;
@@ -1535,7 +1534,6 @@ long vt_compat_ioctl(struct tty_struct *tty,
 	if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
 		perm = 1;
 
-	kbd = kbd_table + console;
 	switch (cmd) {
 	/*
 	 * these need special handlers for incompatible data structures
-- 
1.7.4.2

