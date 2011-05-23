From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/48] TTY: unify tty_init_dev fail path handling
Date: Mon, 23 May 2011 12:10:16 -0700
Message-ID: <1306177854-18172-10-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42024 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:22 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
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
 drivers/tty/tty_io.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 188632e..026bf2f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1391,16 +1391,15 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx,
 		return ERR_PTR(-ENODEV);
 
 	tty = alloc_tty_struct();
-	if (!tty)
-		goto fail_no_mem;
+	if (!tty) {
+		retval = -ENOMEM;
+		goto err_module_put;
+	}
 	initialize_tty_struct(tty, driver, idx);
 
 	retval = tty_driver_install_tty(driver, tty);
-	if (retval < 0) {
-		free_tty_struct(tty);
-		module_put(driver->owner);
-		return ERR_PTR(retval);
-	}
+	if (retval < 0)
+		goto err_free_tty;
 
 	/*
 	 * Structures all installed ... call the ldisc open routines.
@@ -1409,15 +1408,17 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx,
 	 */
 	retval = tty_ldisc_setup(tty, tty->link);
 	if (retval)
-		goto release_mem_out;
+		goto err_release_tty;
 	return tty;
 
-fail_no_mem:
+err_free_tty:
+	free_tty_struct(tty);
+err_module_put:
 	module_put(driver->owner);
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(retval);
 
 	/* call the tty release_tty routine to clean out this slot */
-release_mem_out:
+err_release_tty:
 	if (printk_ratelimit())
 		printk(KERN_INFO "tty_init_dev: ldisc open failed, "
 				 "clearing slot %d\n", idx);
-- 
1.7.4.2

