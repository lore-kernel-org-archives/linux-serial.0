Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E124338F;
	Fri, 25 Apr 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579602; cv=none; b=MRR9tK9wT7paBPKfr2GL5cS8H6NLCRG4D/1FAFfR9qpu2a5inB2xs3u1aO0gRE6Pc1Jh8DeRz4dLRhL1VaDoWY5TEbWLFvdfqq3Oq5O2yTm9vuA3JTff7/6nJ97bYlVY+xpqKK2MYTKg7qmI899uO2vvic9TjcFjp28vyDcT3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579602; c=relaxed/simple;
	bh=KJ//6wn7lzLUYBzt9g92iu6mOBp+OD5S2mTUu31bq6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knQz7qRM9pGbsy4KBSnl2tbRI3yIyJ8T9UPSB12iynkHPEv9YfFvNvsif1ADs5x2aFsB4UIwEqAFjKez4tFtF3N9LzKFZMEIabn5jWpWy4sv+JSir63qsVlAEHE2eBDQ8BPRMazE879w8817HGuQDrZ1eIGi4NWjxg4JiIlSO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giBpK8lG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giBpK8lG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5B1C4CEEA;
	Fri, 25 Apr 2025 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579601;
	bh=KJ//6wn7lzLUYBzt9g92iu6mOBp+OD5S2mTUu31bq6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giBpK8lGGh1i1wNtGuMjgzpYFBwY/Kh8woLj6uvVKQXWs4lFwflV9g5JM5YvOPZe7
	 hiNKzn5knpkUiYnoFmTeeiX6Jn96fxYMUAcaKXycFloydSZg3Yn9X5r9mAuDI2TdDl
	 RlzbZnt/tOynD7lO+a/sBFaDZq6peOy08sfRBSLaZZJ67dNUzZsdyjjZT+CWsMt/LJ
	 Xdt9prQ9OaMjhLyObY16EcV0sqqFBlD8jkDDkuFva5XGJmiy3D8Jucq3Up3sYjFW9w
	 JG68HyHGBd97yHV75LfROeivqU5LIK/p6Y1YAMMJs0y3I+iXnWsuwjc0qMv1qOVuyz
	 K8JNCTsz+AxRg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/6] tty: use lock guard()s in tty_io
Date: Fri, 25 Apr 2025 13:13:11 +0200
Message-ID: <20250425111315.1036184-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111315.1036184-1-jirislaby@kernel.org>
References: <20250425111315.1036184-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

guard()s and scoped_guard()s express more clearly what is protected by
locks. And also makes the code cleaner as it can return immediately in
case of short returns.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 96 ++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ca9b7d7bad2b..e2d92cf70eb7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -276,11 +276,10 @@ static void check_tty_count(struct tty_struct *tty, const char *routine)
 	struct list_head *p;
 	int count = 0, kopen_count = 0;
 
-	spin_lock(&tty->files_lock);
-	list_for_each(p, &tty->tty_files) {
-		count++;
-	}
-	spin_unlock(&tty->files_lock);
+	scoped_guard(spinlock, &tty->files_lock)
+		list_for_each(p, &tty->tty_files)
+			count++;
+
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_SLAVE &&
 	    tty->link && tty->link->count)
@@ -378,7 +377,7 @@ EXPORT_SYMBOL_GPL(tty_dev_name_to_number);
  */
 struct tty_driver *tty_find_polling_driver(char *name, int *line)
 {
-	struct tty_driver *p, *res = NULL;
+	struct tty_driver *p;
 	int tty_line = 0;
 	int len;
 	char *str, *stp;
@@ -392,7 +391,8 @@ struct tty_driver *tty_find_polling_driver(char *name, int *line)
 	len = str - name;
 	tty_line = simple_strtoul(str, &str, 10);
 
-	mutex_lock(&tty_mutex);
+	guard(mutex)(&tty_mutex);
+
 	/* Search through the tty devices to look for a match */
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (!len || strncmp(name, p->name, len) != 0)
@@ -405,14 +405,12 @@ struct tty_driver *tty_find_polling_driver(char *name, int *line)
 
 		if (tty_line >= 0 && tty_line < p->num && p->ops &&
 		    p->ops->poll_init && !p->ops->poll_init(p, tty_line, stp)) {
-			res = tty_driver_kref_get(p);
 			*line = tty_line;
-			break;
+			return tty_driver_kref_get(p);
 		}
 	}
-	mutex_unlock(&tty_mutex);
 
-	return res;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(tty_find_polling_driver);
 #endif
@@ -531,16 +529,15 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
  */
 static struct file *tty_release_redirect(struct tty_struct *tty)
 {
-	struct file *f = NULL;
+	guard(spinlock)(&redirect_lock);
 
-	spin_lock(&redirect_lock);
 	if (redirect && file_tty(redirect) == tty) {
-		f = redirect;
+		struct file *f = redirect;
 		redirect = NULL;
+		return f;
 	}
-	spin_unlock(&redirect_lock);
 
-	return f;
+	return NULL;
 }
 
 /**
@@ -765,11 +762,8 @@ void __stop_tty(struct tty_struct *tty)
  */
 void stop_tty(struct tty_struct *tty)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&tty->flow.lock, flags);
+	guard(spinlock_irqsave)(&tty->flow.lock);
 	__stop_tty(tty);
-	spin_unlock_irqrestore(&tty->flow.lock, flags);
 }
 EXPORT_SYMBOL(stop_tty);
 
@@ -796,11 +790,8 @@ void __start_tty(struct tty_struct *tty)
  */
 void start_tty(struct tty_struct *tty)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&tty->flow.lock, flags);
+	guard(spinlock_irqsave)(&tty->flow.lock);
 	__start_tty(tty);
-	spin_unlock_irqrestore(&tty->flow.lock, flags);
 }
 EXPORT_SYMBOL(start_tty);
 
@@ -809,7 +800,8 @@ static void tty_update_time(struct tty_struct *tty, bool mtime)
 	time64_t sec = ktime_get_real_seconds();
 	struct tty_file_private *priv;
 
-	spin_lock(&tty->files_lock);
+	guard(spinlock)(&tty->files_lock);
+
 	list_for_each_entry(priv, &tty->tty_files, list) {
 		struct inode *inode = file_inode(priv->file);
 		struct timespec64 time = mtime ? inode_get_mtime(inode) : inode_get_atime(inode);
@@ -827,7 +819,6 @@ static void tty_update_time(struct tty_struct *tty, bool mtime)
 				inode_set_atime(inode, sec, 0);
 		}
 	}
-	spin_unlock(&tty->files_lock);
 }
 
 /*
@@ -2314,13 +2305,12 @@ static int tiocsti(struct tty_struct *tty, u8 __user *p)
  */
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
-	int err;
+	guard(mutex)(&tty->winsize_mutex);
 
-	mutex_lock(&tty->winsize_mutex);
-	err = copy_to_user(arg, &tty->winsize, sizeof(*arg));
-	mutex_unlock(&tty->winsize_mutex);
+	if (copy_to_user(arg, &tty->winsize, sizeof(*arg)))
+		return -EFAULT;
 
-	return err ? -EFAULT : 0;
+	return 0;
 }
 
 /**
@@ -2335,10 +2325,10 @@ int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 {
 	struct pid *pgrp;
 
-	/* Lock the tty */
-	mutex_lock(&tty->winsize_mutex);
+	guard(mutex)(&tty->winsize_mutex);
+
 	if (!memcmp(ws, &tty->winsize, sizeof(*ws)))
-		goto done;
+		return 0;
 
 	/* Signal the foreground process group */
 	pgrp = tty_get_pgrp(tty);
@@ -2347,8 +2337,7 @@ int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 	put_pid(pgrp);
 
 	tty->winsize = *ws;
-done:
-	mutex_unlock(&tty->winsize_mutex);
+
 	return 0;
 }
 EXPORT_SYMBOL(tty_do_resize);
@@ -2409,13 +2398,14 @@ static int tioccons(struct file *file)
 		return -EBADF;
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
-	spin_lock(&redirect_lock);
-	if (redirect) {
-		spin_unlock(&redirect_lock);
+
+	guard(spinlock)(&redirect_lock);
+
+	if (redirect)
 		return -EBUSY;
-	}
+
 	redirect = get_file(file);
-	spin_unlock(&redirect_lock);
+
 	return 0;
 }
 
@@ -3028,11 +3018,9 @@ void __do_SAK(struct tty_struct *tty)
 	struct task_struct *g, *p;
 	struct pid *session;
 	int i;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tty->ctrl.lock, flags);
-	session = get_pid(tty->ctrl.session);
-	spin_unlock_irqrestore(&tty->ctrl.lock, flags);
+	scoped_guard(spinlock_irqsave, &tty->ctrl.lock)
+		session = get_pid(tty->ctrl.session);
 
 	tty_ldisc_flush(tty);
 
@@ -3055,7 +3043,7 @@ void __do_SAK(struct tty_struct *tty)
 					PIDTYPE_SID);
 			continue;
 		}
-		task_lock(p);
+		guard(task_lock)(p);
 		i = iterate_fd(p->files, 0, this_tty, tty);
 		if (i != 0) {
 			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
@@ -3063,7 +3051,6 @@ void __do_SAK(struct tty_struct *tty)
 			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p,
 					PIDTYPE_SID);
 		}
-		task_unlock(p);
 	}
 	read_unlock(&tasklist_lock);
 	put_pid(session);
@@ -3465,9 +3452,8 @@ int tty_register_driver(struct tty_driver *driver)
 			goto err_unreg_char;
 	}
 
-	mutex_lock(&tty_mutex);
-	list_add(&driver->tty_drivers, &tty_drivers);
-	mutex_unlock(&tty_mutex);
+	scoped_guard(mutex, &tty_mutex)
+		list_add(&driver->tty_drivers, &tty_drivers);
 
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_DEV)) {
 		for (i = 0; i < driver->num; i++) {
@@ -3486,9 +3472,8 @@ int tty_register_driver(struct tty_driver *driver)
 	for (i--; i >= 0; i--)
 		tty_unregister_device(driver, i);
 
-	mutex_lock(&tty_mutex);
-	list_del(&driver->tty_drivers);
-	mutex_unlock(&tty_mutex);
+	scoped_guard(mutex, &tty_mutex)
+		list_del(&driver->tty_drivers);
 
 err_unreg_char:
 	unregister_chrdev_region(dev, driver->num);
@@ -3507,9 +3492,8 @@ void tty_unregister_driver(struct tty_driver *driver)
 {
 	unregister_chrdev_region(MKDEV(driver->major, driver->minor_start),
 				driver->num);
-	mutex_lock(&tty_mutex);
-	list_del(&driver->tty_drivers);
-	mutex_unlock(&tty_mutex);
+	scoped_guard(mutex, &tty_mutex)
+		list_del(&driver->tty_drivers);
 }
 EXPORT_SYMBOL(tty_unregister_driver);
 
-- 
2.49.0

