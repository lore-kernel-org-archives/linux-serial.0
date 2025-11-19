Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9881346FA9;
	Wed, 19 Nov 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546507; cv=none; b=UtNzi5iu08SlL4QbnB9lhqtOvCO6a550i41QbSqBRzzNJ/lVEaBLFFAeVWRfIEdkf3W0+0g4kJyBb2X/CwV0Khn07TKw47jXadzxkSNWi34TAqyHlRi/paf/hZfWAJ68rPUnGIBxkivGnkucS1oHDJJ2VUhRyzQ/ufya9rCPe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546507; c=relaxed/simple;
	bh=oHfJuALzS6HApxgilm4rOTfLn9HklHZ8/ZXkKq6sjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZAt82sbpg1zuB8XD12H2sx+U1hPYeb9Lvrzj5z9iIAApViVPUlzuxDxw8nghYvMcLD/V0TeEDutjr6FDlpL7io0eJLKpPAOvgBlYnY+CM2B5gHeHtD+q8+VizuyNlbcCg5Gcmk7jdWomgQ491cegPvC/wJuqKr9zmQFyUEJrns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmjzBrT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmjzBrT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272A3C2BCB3;
	Wed, 19 Nov 2025 10:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546506;
	bh=oHfJuALzS6HApxgilm4rOTfLn9HklHZ8/ZXkKq6sjmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmjzBrT+4dv/ofyCiq7HNY8tFeNNiMdzdbfRjL6abaV82vyHAR9yNfFB1LpTT7FIf
	 sCSeTCOy1POnYmw0RsuLJPPY9dalPwJi+MdwWCTXBehkE3pMxTUGHiAcasUkK/uiiI
	 1EGIfkMfWj2rcACMjIynwltBQ4esLSeA86K4DOeOofj1N8QbJBRM+VJyjCmm5MMHfH
	 ePCCaLKrgqusP3DG2nDsCrxPVoteth2WcxjtneAOHoUf3NZzNDlzw4vI0k3YhAGYwl
	 EppGEi03dqCbvf3zsiDJry9mELi6aDfnkv9TNgms4P7LPj6bx6GnZrbKaRktIPx415
	 BL+mBJ6T3d8yQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/10] tty: pty: use guard()s
Date: Wed, 19 Nov 2025 11:01:31 +0100
Message-ID: <20251119100140.830761-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119100140.830761-1-jirislaby@kernel.org>
References: <20251119100140.830761-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guards in the pty code. This improves readability, makes error
handling easier, and marks locked portions of code explicit. All that
while being sure the lock is unlocked.

pty_set_pktmode() is handled specially -- the conditions are inverted
and return called if conditions unmet. This avoid double nested 'if's.
The variable is renamed to want_pktmode so it is not confused with the
current state of pktmode.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/pty.c | 103 ++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 58 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8bb1a01fef2a..76188b8f3ba3 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -57,9 +57,8 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 	set_bit(TTY_IO_ERROR, &tty->flags);
 	wake_up_interruptible(&tty->read_wait);
 	wake_up_interruptible(&tty->write_wait);
-	spin_lock_irq(&tty->ctrl.lock);
-	tty->ctrl.packet = false;
-	spin_unlock_irq(&tty->ctrl.lock);
+	scoped_guard(spinlock_irq, &tty->ctrl.lock)
+		tty->ctrl.packet = false;
 	/* Review - krefs on tty_link ?? */
 	if (!tty->link)
 		return;
@@ -70,10 +69,9 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 		set_bit(TTY_OTHER_CLOSED, &tty->flags);
 #ifdef CONFIG_UNIX98_PTYS
 		if (tty->driver == ptm_driver) {
-			mutex_lock(&devpts_mutex);
+			guard(mutex)(&devpts_mutex);
 			if (tty->link->driver_data)
 				devpts_pty_kill(tty->link->driver_data);
-			mutex_unlock(&devpts_mutex);
 		}
 #endif
 		tty_vhangup(tty->link);
@@ -157,21 +155,23 @@ static int pty_get_lock(struct tty_struct *tty, int __user *arg)
 /* Set the packet mode on a pty */
 static int pty_set_pktmode(struct tty_struct *tty, int __user *arg)
 {
-	int pktmode;
+	int want_pktmode;
 
-	if (get_user(pktmode, arg))
+	if (get_user(want_pktmode, arg))
 		return -EFAULT;
 
-	spin_lock_irq(&tty->ctrl.lock);
-	if (pktmode) {
-		if (!tty->ctrl.packet) {
-			tty->link->ctrl.pktstatus = 0;
-			smp_mb();
-			tty->ctrl.packet = true;
-		}
-	} else
+	guard(spinlock_irq)(&tty->ctrl.lock);
+	if (!want_pktmode) {
 		tty->ctrl.packet = false;
-	spin_unlock_irq(&tty->ctrl.lock);
+		return 0;
+	}
+
+	if (tty->ctrl.packet)
+		return 0;
+
+	tty->link->ctrl.pktstatus = 0;
+	smp_mb();
+	tty->ctrl.packet = true;
 
 	return 0;
 }
@@ -210,10 +210,9 @@ static void pty_flush_buffer(struct tty_struct *tty)
 
 	tty_buffer_flush(to, NULL);
 	if (to->ctrl.packet) {
-		spin_lock_irq(&tty->ctrl.lock);
+		guard(spinlock_irq)(&tty->ctrl.lock);
 		tty->ctrl.pktstatus |= TIOCPKT_FLUSHWRITE;
 		wake_up_interruptible(&to->read_wait);
-		spin_unlock_irq(&tty->ctrl.lock);
 	}
 }
 
@@ -252,17 +251,17 @@ static void pty_set_termios(struct tty_struct *tty,
 				STOP_CHAR(tty) == '\023' &&
 				START_CHAR(tty) == '\021');
 		if ((old_flow != new_flow) || extproc) {
-			spin_lock_irq(&tty->ctrl.lock);
-			if (old_flow != new_flow) {
-				tty->ctrl.pktstatus &= ~(TIOCPKT_DOSTOP | TIOCPKT_NOSTOP);
-				if (new_flow)
-					tty->ctrl.pktstatus |= TIOCPKT_DOSTOP;
-				else
-					tty->ctrl.pktstatus |= TIOCPKT_NOSTOP;
+			scoped_guard(spinlock_irq, &tty->ctrl.lock) {
+				if (old_flow != new_flow) {
+					tty->ctrl.pktstatus &= ~(TIOCPKT_DOSTOP | TIOCPKT_NOSTOP);
+					if (new_flow)
+						tty->ctrl.pktstatus |= TIOCPKT_DOSTOP;
+					else
+						tty->ctrl.pktstatus |= TIOCPKT_NOSTOP;
+				}
+				if (extproc)
+					tty->ctrl.pktstatus |= TIOCPKT_IOCTL;
 			}
-			if (extproc)
-				tty->ctrl.pktstatus |= TIOCPKT_IOCTL;
-			spin_unlock_irq(&tty->ctrl.lock);
 			wake_up_interruptible(&tty->link->read_wait);
 		}
 	}
@@ -286,9 +285,9 @@ static int pty_resize(struct tty_struct *tty,  struct winsize *ws)
 	struct tty_struct *pty = tty->link;
 
 	/* For a PTY we need to lock the tty side */
-	mutex_lock(&tty->winsize_mutex);
+	guard(mutex)(&tty->winsize_mutex);
 	if (!memcmp(ws, &tty->winsize, sizeof(*ws)))
-		goto done;
+		return 0;
 
 	/* Signal the foreground process group of both ptys */
 	pgrp = tty_get_pgrp(tty);
@@ -304,8 +303,7 @@ static int pty_resize(struct tty_struct *tty,  struct winsize *ws)
 
 	tty->winsize = *ws;
 	pty->winsize = *ws;	/* Never used so will go away soon */
-done:
-	mutex_unlock(&tty->winsize_mutex);
+
 	return 0;
 }
 
@@ -321,28 +319,26 @@ static int pty_resize(struct tty_struct *tty,  struct winsize *ws)
  */
 static void pty_start(struct tty_struct *tty)
 {
-	unsigned long flags;
+	if (!tty->link || !tty->link->ctrl.packet)
+		return;
 
-	if (tty->link && tty->link->ctrl.packet) {
-		spin_lock_irqsave(&tty->ctrl.lock, flags);
+	scoped_guard(spinlock_irqsave, &tty->ctrl.lock) {
 		tty->ctrl.pktstatus &= ~TIOCPKT_STOP;
 		tty->ctrl.pktstatus |= TIOCPKT_START;
-		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
-		wake_up_interruptible_poll(&tty->link->read_wait, EPOLLIN);
 	}
+	wake_up_interruptible_poll(&tty->link->read_wait, EPOLLIN);
 }
 
 static void pty_stop(struct tty_struct *tty)
 {
-	unsigned long flags;
+	if (!tty->link || !tty->link->ctrl.packet)
+		return;
 
-	if (tty->link && tty->link->ctrl.packet) {
-		spin_lock_irqsave(&tty->ctrl.lock, flags);
+	scoped_guard(spinlock_irqsave, &tty->ctrl.lock) {
 		tty->ctrl.pktstatus &= ~TIOCPKT_START;
 		tty->ctrl.pktstatus |= TIOCPKT_STOP;
-		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
-		wake_up_interruptible_poll(&tty->link->read_wait, EPOLLIN);
 	}
+	wake_up_interruptible_poll(&tty->link->read_wait, EPOLLIN);
 }
 
 /**
@@ -705,15 +701,9 @@ static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
 static struct tty_struct *pts_unix98_lookup(struct tty_driver *driver,
 		struct file *file, int idx)
 {
-	struct tty_struct *tty;
-
-	mutex_lock(&devpts_mutex);
-	tty = devpts_get_priv(file->f_path.dentry);
-	mutex_unlock(&devpts_mutex);
+	guard(mutex)(&devpts_mutex);
 	/* Master must be open before slave */
-	if (!tty)
-		return ERR_PTR(-EIO);
-	return tty;
+	return devpts_get_priv(file->f_path.dentry) ? : ERR_PTR(-EIO);
 }
 
 static int pty_unix98_install(struct tty_driver *driver, struct tty_struct *tty)
@@ -811,20 +801,17 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 	}
 
 	/* find a device that is not in use. */
-	mutex_lock(&devpts_mutex);
-	index = devpts_new_index(fsi);
-	mutex_unlock(&devpts_mutex);
+	scoped_guard(mutex, &devpts_mutex)
+		index = devpts_new_index(fsi);
 
 	retval = index;
 	if (index < 0)
 		goto out_put_fsi;
 
 
-	mutex_lock(&tty_mutex);
-	tty = tty_init_dev(ptm_driver, index);
-	/* The tty returned here is locked so we can safely
-	   drop the mutex */
-	mutex_unlock(&tty_mutex);
+	/* The tty returned here is locked so we can safely drop the mutex */
+	scoped_guard(mutex, &tty_mutex)
+		tty = tty_init_dev(ptm_driver, index);
 
 	retval = PTR_ERR(tty);
 	if (IS_ERR(tty))
-- 
2.51.1

