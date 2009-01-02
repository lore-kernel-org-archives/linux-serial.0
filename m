From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 20/75] pty: simplify resize
Date: Fri, 02 Jan 2009 13:43:17 +0000
Message-ID: <20090102134309.13472.38770.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60323 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756028AbZABNnC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:43:02 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

We have special case logic for resizing pty/tty pairs. We also have a per
driver resize method so for the pty case we should use it.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/hvc_console.c |    2 +-
 drivers/char/pty.c         |   54 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/char/tty_io.c      |   31 +++++++++----------------
 drivers/char/vt.c          |   14 +++++------
 include/linux/tty.h        |    3 +-
 include/linux/tty_driver.h |    6 ++---
 6 files changed, 74 insertions(+), 36 deletions(-)


diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 0587b66..5a8a4c2 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -529,7 +529,7 @@ static void hvc_set_winsz(struct work_struct *work)
 	tty = tty_kref_get(hp->tty);
 	spin_unlock_irqrestore(&hp->lock, hvc_flags);
 
-	tty_do_resize(tty, tty, &ws);
+	tty_do_resize(tty, &ws);
 	tty_kref_put(tty);
 }
 
diff --git a/drivers/char/pty.c b/drivers/char/pty.c
index 6d45827..b5daaaa 100644
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -230,6 +230,55 @@ static void pty_set_termios(struct tty_struct *tty,
 	tty->termios->c_cflag |= (CS8 | CREAD);
 }
 
+/**
+ *	pty_do_resize		-	resize event
+ *	@tty: tty being resized
+ *	@real_tty: real tty (not the same as tty if using a pty/tty pair)
+ *	@rows: rows (character)
+ *	@cols: cols (character)
+ *
+ *	Update the termios variables and send the neccessary signals to
+ *	peform a terminal resize correctly
+ */
+
+int pty_resize(struct tty_struct *tty,  struct winsize *ws)
+{
+	struct pid *pgrp, *rpgrp;
+	unsigned long flags;
+	struct tty_struct *pty = tty->link;
+
+	/* For a PTY we need to lock the tty side */
+	mutex_lock(&tty->termios_mutex);
+	if (!memcmp(ws, &tty->winsize, sizeof(*ws)))
+		goto done;
+
+	/* Get the PID values and reference them so we can
+	   avoid holding the tty ctrl lock while sending signals.
+	   We need to lock these individually however. */
+
+	spin_lock_irqsave(&tty->ctrl_lock, flags);
+	pgrp = get_pid(tty->pgrp);
+	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
+
+	spin_lock_irqsave(&pty->ctrl_lock, flags);
+	rpgrp = get_pid(pty->pgrp);
+	spin_unlock_irqrestore(&pty->ctrl_lock, flags);
+
+	if (pgrp)
+		kill_pgrp(pgrp, SIGWINCH, 1);
+	if (rpgrp != pgrp && rpgrp)
+		kill_pgrp(rpgrp, SIGWINCH, 1);
+
+	put_pid(pgrp);
+	put_pid(rpgrp);
+
+	tty->winsize = *ws;
+	pty->winsize = *ws;	/* Never used so will go away soon */
+done:
+	mutex_unlock(&tty->termios_mutex);
+	return 0;
+}
+
 static int pty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct tty_struct *o_tty;
@@ -290,6 +339,7 @@ static const struct tty_operations pty_ops = {
 	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
 	.set_termios = pty_set_termios,
+	.resize = pty_resize
 };
 
 /* Traditional BSD devices */
@@ -319,6 +369,7 @@ static const struct tty_operations pty_ops_bsd = {
 	.unthrottle = pty_unthrottle,
 	.set_termios = pty_set_termios,
 	.ioctl = pty_bsd_ioctl,
+	.resize = pty_resize
 };
 
 static void __init legacy_pty_init(void)
@@ -561,7 +612,8 @@ static const struct tty_operations ptm_unix98_ops = {
 	.unthrottle = pty_unthrottle,
 	.set_termios = pty_set_termios,
 	.ioctl = pty_unix98_ioctl,
-	.shutdown = pty_unix98_shutdown
+	.shutdown = pty_unix98_shutdown,
+	.resize = pty_resize
 };
 
 static const struct tty_operations pty_unix98_ops = {
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 2a15af6..d33e5ab 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2048,7 +2048,6 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 /**
  *	tty_do_resize		-	resize event
  *	@tty: tty being resized
- *	@real_tty: real tty (not the same as tty if using a pty/tty pair)
  *	@rows: rows (character)
  *	@cols: cols (character)
  *
@@ -2056,41 +2055,34 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
  *	peform a terminal resize correctly
  */
 
-int tty_do_resize(struct tty_struct *tty, struct tty_struct *real_tty,
-					struct winsize *ws)
+int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 {
-	struct pid *pgrp, *rpgrp;
+	struct pid *pgrp;
 	unsigned long flags;
 
-	/* For a PTY we need to lock the tty side */
-	mutex_lock(&real_tty->termios_mutex);
-	if (!memcmp(ws, &real_tty->winsize, sizeof(*ws)))
+	/* Lock the tty */
+	mutex_lock(&tty->termios_mutex);
+	if (!memcmp(ws, &tty->winsize, sizeof(*ws)))
 		goto done;
 	/* Get the PID values and reference them so we can
 	   avoid holding the tty ctrl lock while sending signals */
 	spin_lock_irqsave(&tty->ctrl_lock, flags);
 	pgrp = get_pid(tty->pgrp);
-	rpgrp = get_pid(real_tty->pgrp);
 	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 
 	if (pgrp)
 		kill_pgrp(pgrp, SIGWINCH, 1);
-	if (rpgrp != pgrp && rpgrp)
-		kill_pgrp(rpgrp, SIGWINCH, 1);
-
 	put_pid(pgrp);
-	put_pid(rpgrp);
 
 	tty->winsize = *ws;
-	real_tty->winsize = *ws;
 done:
-	mutex_unlock(&real_tty->termios_mutex);
+	mutex_unlock(&tty->termios_mutex);
 	return 0;
 }
 
 /**
  *	tiocswinsz		-	implement window size set ioctl
- *	@tty; tty
+ *	@tty; tty side of tty
  *	@arg: user buffer for result
  *
  *	Copies the user idea of the window size to the kernel. Traditionally
@@ -2103,17 +2095,16 @@ done:
  *	then calls into the default method.
  */
 
-static int tiocswinsz(struct tty_struct *tty, struct tty_struct *real_tty,
-	struct winsize __user *arg)
+static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	struct winsize tmp_ws;
 	if (copy_from_user(&tmp_ws, arg, sizeof(*arg)))
 		return -EFAULT;
 
 	if (tty->ops->resize)
-		return tty->ops->resize(tty, real_tty, &tmp_ws);
+		return tty->ops->resize(tty, &tmp_ws);
 	else
-		return tty_do_resize(tty, real_tty, &tmp_ws);
+		return tty_do_resize(tty, &tmp_ws);
 }
 
 /**
@@ -2538,7 +2529,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case TIOCGWINSZ:
 		return tiocgwinsz(real_tty, p);
 	case TIOCSWINSZ:
-		return tiocswinsz(tty, real_tty, p);
+		return tiocswinsz(real_tty, p);
 	case TIOCCONS:
 		return real_tty != tty ? -EINVAL : tioccons(file);
 	case FIONBIO:
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 639e126..8001421 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -819,8 +819,8 @@ static inline int resize_screen(struct vc_data *vc, int width, int height,
  *	ctrl_lock of the tty IFF a tty is passed.
  */
 
-static int vc_do_resize(struct tty_struct *tty, struct tty_struct *real_tty,
-		struct vc_data *vc, unsigned int cols, unsigned int lines)
+static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
+				unsigned int cols, unsigned int lines)
 {
 	unsigned long old_origin, new_origin, new_scr_end, rlth, rrem, err = 0;
 	unsigned int old_cols, old_rows, old_row_size, old_screen_size;
@@ -932,7 +932,7 @@ static int vc_do_resize(struct tty_struct *tty, struct tty_struct *real_tty,
 		ws.ws_row = vc->vc_rows;
 		ws.ws_col = vc->vc_cols;
 		ws.ws_ypixel = vc->vc_scan_lines;
-		tty_do_resize(tty, real_tty, &ws);
+		tty_do_resize(tty, &ws);
 	}
 
 	if (CON_IS_VISIBLE(vc))
@@ -954,13 +954,12 @@ static int vc_do_resize(struct tty_struct *tty, struct tty_struct *real_tty,
 
 int vc_resize(struct vc_data *vc, unsigned int cols, unsigned int rows)
 {
-	return vc_do_resize(vc->vc_tty, vc->vc_tty, vc, cols, rows);
+	return vc_do_resize(vc->vc_tty, vc, cols, rows);
 }
 
 /**
  *	vt_resize		-	resize a VT
  *	@tty: tty to resize
- *	@real_tty: tty if a pty/tty pair
  *	@ws: winsize attributes
  *
  *	Resize a virtual terminal. This is called by the tty layer as we
@@ -971,14 +970,13 @@ int vc_resize(struct vc_data *vc, unsigned int cols, unsigned int rows)
  *	termios_mutex and the tty ctrl_lock in that order.
  */
 
-int vt_resize(struct tty_struct *tty, struct tty_struct *real_tty,
-	struct winsize *ws)
+int vt_resize(struct tty_struct *tty, struct winsize *ws)
 {
 	struct vc_data *vc = tty->driver_data;
 	int ret;
 
 	acquire_console_sem();
-	ret = vc_do_resize(tty, real_tty, vc, ws->ws_col, ws->ws_row);
+	ret = vc_do_resize(tty, vc, ws->ws_col, ws->ws_row);
 	release_console_sem();
 	return ret;
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index dfc77de..f881697 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -360,8 +360,7 @@ extern int tty_write_room(struct tty_struct *tty);
 extern void tty_driver_flush_buffer(struct tty_struct *tty);
 extern void tty_throttle(struct tty_struct *tty);
 extern void tty_unthrottle(struct tty_struct *tty);
-extern int tty_do_resize(struct tty_struct *tty, struct tty_struct *real_tty,
-						struct winsize *ws);
+extern int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
 extern void tty_shutdown(struct tty_struct *tty);
 extern void tty_free_termios(struct tty_struct *tty);
 extern int is_current_pgrp_orphaned(void);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 78416b9..08e0883 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -196,8 +196,7 @@
  *	Optional: If not provided then the write method is called under
  *	the atomic write lock to keep it serialized with the ldisc.
  *
- * int (*resize)(struct tty_struct *tty, struct tty_struct *real_tty,
- *				unsigned int rows, unsigned int cols);
+ * int (*resize)(struct tty_struct *tty, struct winsize *ws)
  *
  *	Called when a termios request is issued which changes the
  *	requested terminal geometry.
@@ -258,8 +257,7 @@ struct tty_operations {
 	int (*tiocmget)(struct tty_struct *tty, struct file *file);
 	int (*tiocmset)(struct tty_struct *tty, struct file *file,
 			unsigned int set, unsigned int clear);
-	int (*resize)(struct tty_struct *tty, struct tty_struct *real_tty,
-				struct winsize *ws);
+	int (*resize)(struct tty_struct *tty, struct winsize *ws);
 	int (*set_termiox)(struct tty_struct *tty, struct termiox *tnew);
 #ifdef CONFIG_CONSOLE_POLL
 	int (*poll_init)(struct tty_driver *driver, int line, char *options);

