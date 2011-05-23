From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/48] tty: VT, remove unused variable
Date: Mon, 23 May 2011 12:10:10 -0700
Message-ID: <1306177854-18172-4-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42010 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573Ab1EWTKB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:01 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2EA4D939FD
	for <linux-serial@vger.kernel.org>; Mon, 23 May 2011 21:10:01 +0200 (CEST)
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
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

