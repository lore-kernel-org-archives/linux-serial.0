From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/48] TTY: unify pty_unix98_install fail path handling
Date: Mon, 23 May 2011 12:06:29 -0700
Message-ID: <1306177625-17885-12-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177625-17885-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48091 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932732Ab1EWTQU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:16:20 -0400
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
 drivers/tty/pty.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index f511918..b25d6c4 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -560,20 +560,19 @@ static int pty_unix98_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENOMEM;
 	if (!try_module_get(driver->other->owner)) {
 		/* This cannot in fact currently happen */
-		free_tty_struct(o_tty);
-		return -ENOMEM;
+		goto err_free_tty;
 	}
 	initialize_tty_struct(o_tty, driver->other, idx);
 
 	tty->termios = kzalloc(sizeof(struct ktermios[2]), GFP_KERNEL);
 	if (tty->termios == NULL)
-		goto free_mem_out;
+		goto err_free_mem;
 	*tty->termios = driver->init_termios;
 	tty->termios_locked = tty->termios + 1;
 
 	o_tty->termios = kzalloc(sizeof(struct ktermios[2]), GFP_KERNEL);
 	if (o_tty->termios == NULL)
-		goto free_mem_out;
+		goto err_free_mem;
 	*o_tty->termios = driver->other->init_termios;
 	o_tty->termios_locked = o_tty->termios + 1;
 
@@ -592,11 +591,12 @@ static int pty_unix98_install(struct tty_driver *driver, struct tty_struct *tty)
 	tty->count++;
 	pty_count++;
 	return 0;
-free_mem_out:
+err_free_mem:
 	kfree(o_tty->termios);
+	kfree(tty->termios);
 	module_put(o_tty->driver->owner);
+err_free_tty:
 	free_tty_struct(o_tty);
-	kfree(tty->termios);
 	return -ENOMEM;
 }
 
-- 
1.7.4.2

