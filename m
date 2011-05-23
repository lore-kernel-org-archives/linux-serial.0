From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/48] TTY: introduce deinit helpers for proper ldisc shutdown
Date: Mon, 23 May 2011 12:10:19 -0700
Message-ID: <1306177854-18172-13-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47281 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:32 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Julian Anastasov <ja@ssi.bg>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Introduce deinitialize_tty_struct which should be called after
initialize_tty_struct and before successfull tty_ldisc_setup.

It calls tty_ldisc_deinit which is opposite of tty_ldisc_init. It only
puts a reference to ldisc and assigns NULL to tty->ldisc.

It will be used to shut down ldisc when tty_release cannot be called
yet.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c    |   14 ++++++++++++++
 drivers/tty/tty_ldisc.c |   13 +++++++++++++
 include/linux/tty.h     |    2 ++
 3 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 026bf2f..f5dd235 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2887,6 +2887,20 @@ void initialize_tty_struct(struct tty_struct *tty,
 }
 
 /**
+ *	deinitialize_tty_struct
+ *	@tty: tty to deinitialize
+ *
+ *	This subroutine deinitializes a tty structure that has been newly
+ *	allocated but tty_release cannot be called on that yet.
+ *
+ *	Locking: none - tty in question must not be exposed at this point
+ */
+void deinitialize_tty_struct(struct tty_struct *tty)
+{
+	tty_ldisc_deinit(tty);
+}
+
+/**
  *	tty_put_char	-	write one character to a tty
  *	@tty: tty
  *	@ch: character
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index e19e136..5d01d32 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -956,6 +956,19 @@ void tty_ldisc_init(struct tty_struct *tty)
 	tty_ldisc_assign(tty, ld);
 }
 
+/**
+ *	tty_ldisc_init		-	ldisc cleanup for new tty
+ *	@tty: tty that was allocated recently
+ *
+ *	The tty structure must not becompletely set up (tty_ldisc_setup) when
+ *      this call is made.
+ */
+void tty_ldisc_deinit(struct tty_struct *tty)
+{
+	put_ldisc(tty->ldisc);
+	tty_ldisc_assign(tty, NULL);
+}
+
 void tty_ldisc_begin(void)
 {
 	/* Setup the default TTY line discipline. */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 9f469c7..4db4ca7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -472,6 +472,7 @@ extern int tty_add_file(struct tty_struct *tty, struct file *file);
 extern void free_tty_struct(struct tty_struct *tty);
 extern void initialize_tty_struct(struct tty_struct *tty,
 		struct tty_driver *driver, int idx);
+extern void deinitialize_tty_struct(struct tty_struct *tty);
 extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx,
 								int first_ok);
 extern int tty_release(struct inode *inode, struct file *filp);
@@ -525,6 +526,7 @@ extern int tty_set_ldisc(struct tty_struct *tty, int ldisc);
 extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_init(struct tty_struct *tty);
+extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern void tty_ldisc_begin(void);
 /* This last one is just for the tty layer internals and shouldn't be used elsewhere */
 extern void tty_ldisc_enable(struct tty_struct *tty);
-- 
1.7.4.2

