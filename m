From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/48] TTY: unify pty_install fail path handling
Date: Mon, 23 May 2011 12:06:28 -0700
Message-ID: <1306177625-17885-11-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177625-17885-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51147 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932750Ab1EWTQV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:16:21 -0400
In-Reply-To: <1306177625-17885-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Julian Anastasov <ja@ssi.bg>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Change it so that we call the deinit functions at one place at the end
of the function (by gotos). And while at it use some sane label names.

This is a preparation for the deinitialization of tty in the next
patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/pty.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 2107747..f511918 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -295,8 +295,8 @@ static int pty_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENOMEM;
 	if (!try_module_get(driver->other->owner)) {
 		/* This cannot in fact currently happen */
-		free_tty_struct(o_tty);
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err_free_tty;
 	}
 	initialize_tty_struct(o_tty, driver->other, idx);
 
@@ -304,13 +304,11 @@ static int pty_install(struct tty_driver *driver, struct tty_struct *tty)
 	   the easy way .. */
 	retval = tty_init_termios(tty);
 	if (retval)
-		goto free_mem_out;
+		goto err_module_put;
 
 	retval = tty_init_termios(o_tty);
-	if (retval) {
-		tty_free_termios(tty);
-		goto free_mem_out;
-	}
+	if (retval)
+		goto err_free_termios;
 
 	/*
 	 * Everything allocated ... set up the o_tty structure.
@@ -327,10 +325,13 @@ static int pty_install(struct tty_driver *driver, struct tty_struct *tty)
 	tty->count++;
 	driver->ttys[idx] = tty;
 	return 0;
-free_mem_out:
+err_free_termios:
+	tty_free_termios(tty);
+err_module_put:
 	module_put(o_tty->driver->owner);
+err_free_tty:
 	free_tty_struct(o_tty);
-	return -ENOMEM;
+	return retval;
 }
 
 static int pty_bsd_ioctl(struct tty_struct *tty,
-- 
1.7.4.2

