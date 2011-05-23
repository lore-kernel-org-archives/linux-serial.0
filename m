From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/48] TTY: plug in deinitialize_tty_struct
Date: Mon, 23 May 2011 12:10:20 -0700
Message-ID: <1306177854-18172-14-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47285 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:36 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Used the newly introduced deinitialize_tty_struct to properly shut
down ldisc.

It is intended to fix the Julian's reported problem. He reports that
kmemleak checker warns about memory leak:
unreferenced object 0xc0e19860 (size 8):
comm cat, pid 1226, jiffies 4294919464 (age 287.476s)
hex dump (first 8 bytes):
44 de 2d c1 01 00 00 00 D.-.....
backtrace:
[<c1065a74>] create_object+0x109/0x1ad
[<c1063d2b>] kmem_cache_alloc+0x60/0x68
[<c113505c>] tty_ldisc_get+0x54/0x76
[<c11358c9>] tty_ldisc_init+0xa/0x20
[<c1130ab4>] initialize_tty_struct+0x2d/0x1ac
[<c1130c8c>] tty_init_dev+0x59/0x10d
[<c113136d>] tty_open+0x24a/0x3a2
...

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Reported-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/pty.c    |    6 ++++--
 drivers/tty/tty_io.c |    5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index b25d6c4..21bddf3 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -304,7 +304,7 @@ static int pty_install(struct tty_driver *driver, struct tty_struct *tty)
 	   the easy way .. */
 	retval = tty_init_termios(tty);
 	if (retval)
-		goto err_module_put;
+		goto err_deinit_tty;
 
 	retval = tty_init_termios(o_tty);
 	if (retval)
@@ -327,7 +327,8 @@ static int pty_install(struct tty_driver *driver, struct tty_struct *tty)
 	return 0;
 err_free_termios:
 	tty_free_termios(tty);
-err_module_put:
+err_deinit_tty:
+	deinitialize_tty_struct(o_tty);
 	module_put(o_tty->driver->owner);
 err_free_tty:
 	free_tty_struct(o_tty);
@@ -592,6 +593,7 @@ static int pty_unix98_install(struct tty_driver *driver, struct tty_struct *tty)
 	pty_count++;
 	return 0;
 err_free_mem:
+	deinitialize_tty_struct(o_tty);
 	kfree(o_tty->termios);
 	kfree(tty->termios);
 	module_put(o_tty->driver->owner);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f5dd235..8540f2b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1399,7 +1399,7 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx,
 
 	retval = tty_driver_install_tty(driver, tty);
 	if (retval < 0)
-		goto err_free_tty;
+		goto err_deinit_tty;
 
 	/*
 	 * Structures all installed ... call the ldisc open routines.
@@ -1411,7 +1411,8 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx,
 		goto err_release_tty;
 	return tty;
 
-err_free_tty:
+err_deinit_tty:
+	deinitialize_tty_struct(tty);
 	free_tty_struct(tty);
 err_module_put:
 	module_put(driver->owner);
-- 
1.7.4.2

