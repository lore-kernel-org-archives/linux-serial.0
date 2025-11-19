Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B6347BDD;
	Wed, 19 Nov 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546508; cv=none; b=HK1ywP2KI8L8CjZ0kd6Xaz+2AvgIBZg9hNwfaeONy3aHyV9N2jsPTk6GkNUsks0ZPxqf6ny1R+/q8zGsOjo9kd+rg9anVJ77lX+Vt8zwKIg3j1fitIu0QxkSakuMPopmyh0OL7SopQtmQnFC5LDuicB38tpVeq2fXGJEj6l2HP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546508; c=relaxed/simple;
	bh=6CyRYFoc296f9e9x6WJYtypiKPAL54TTjJEqM44Kyqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCrbvmecGwjrr1Xwik+iqaGK1CSVqHAvh7Efv+ANdUf/SWcGJCAL++kuqhSFU7ceeByjtuiV5n8B6fdaLiVYwSwceXJdGx88xc7aP89QfttQDTE/e8TTBgr2YKq1fuflmYYNBXDEqrBbHam86rNz3rvv2SDXyVlMTRuXdJ0o8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd3V45u8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd3V45u8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62F5C19425;
	Wed, 19 Nov 2025 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546508;
	bh=6CyRYFoc296f9e9x6WJYtypiKPAL54TTjJEqM44Kyqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cd3V45u8u9xQQ7snOxd0xxaKwWA4ROZZHEfjOTPify/ivpbxMYbhNweT8n1AsHkUT
	 dMO/gKLx8XcI2VzoFBsz1hFm3XkM9lk+EWI6Q/wdBNoGeeiCTZCYXLACqv30UHvGQJ
	 zrwJiKuqlvrP6451jrUFmGDBRKjzb8WuHzZwpm6yn7PRlSUiWbmg2lvdgi7KL6nGt8
	 eFynMVUvW1YzvxniTp7MXgVeHWH2PParJ5fbg1XByyCGED6z8zA1wZIjFBQbtU7wud
	 PbCWUUnCIOT3OemEcWeWQprFVzFPDbAGZ+iViky+Ny2e+7+B2FF4ODvuQuHeZ3XdeK
	 EIbrbhUQaKvpA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/10] tty: n_tty: use guard()s
Date: Wed, 19 Nov 2025 11:01:32 +0100
Message-ID: <20251119100140.830761-3-jirislaby@kernel.org>
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

Use guards in the n_tty code. This improves readability, makes error
handling easier, and marks locked portions of code explicit. All that
while being sure the lock is unlocked.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 109 +++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6af3f3a0b531..e6a0f5b40d0a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -324,12 +324,9 @@ static void reset_buffer_flags(struct n_tty_data *ldata)
 
 static void n_tty_packet_mode_flush(struct tty_struct *tty)
 {
-	unsigned long flags;
-
 	if (tty->link->ctrl.packet) {
-		spin_lock_irqsave(&tty->ctrl.lock, flags);
-		tty->ctrl.pktstatus |= TIOCPKT_FLUSHREAD;
-		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
+		scoped_guard(spinlock_irqsave, &tty->ctrl.lock)
+			tty->ctrl.pktstatus |= TIOCPKT_FLUSHREAD;
 		wake_up_interruptible(&tty->link->read_wait);
 	}
 }
@@ -349,13 +346,12 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
  */
 static void n_tty_flush_buffer(struct tty_struct *tty)
 {
-	down_write(&tty->termios_rwsem);
+	guard(rwsem_write)(&tty->termios_rwsem);
 	reset_buffer_flags(tty->disc_data);
 	n_tty_kick_worker(tty);
 
 	if (tty->link)
 		n_tty_packet_mode_flush(tty);
-	up_write(&tty->termios_rwsem);
 }
 
 /**
@@ -737,24 +733,22 @@ static void commit_echoes(struct tty_struct *tty)
 	size_t nr, old, echoed;
 	size_t head;
 
-	mutex_lock(&ldata->output_lock);
-	head = ldata->echo_head;
-	ldata->echo_mark = head;
-	old = ldata->echo_commit - ldata->echo_tail;
-
-	/* Process committed echoes if the accumulated # of bytes
-	 * is over the threshold (and try again each time another
-	 * block is accumulated) */
-	nr = head - ldata->echo_tail;
-	if (nr < ECHO_COMMIT_WATERMARK ||
-	    (nr % ECHO_BLOCK > old % ECHO_BLOCK)) {
-		mutex_unlock(&ldata->output_lock);
-		return;
-	}
+	scoped_guard(mutex, &ldata->output_lock) {
+		head = ldata->echo_head;
+		ldata->echo_mark = head;
+		old = ldata->echo_commit - ldata->echo_tail;
+
+		/*
+		 * Process committed echoes if the accumulated # of bytes is over the threshold
+		 * (and try again each time another block is accumulated)
+		 */
+		nr = head - ldata->echo_tail;
+		if (nr < ECHO_COMMIT_WATERMARK || (nr % ECHO_BLOCK > old % ECHO_BLOCK))
+			return;
 
-	ldata->echo_commit = head;
-	echoed = __process_echoes(tty);
-	mutex_unlock(&ldata->output_lock);
+		ldata->echo_commit = head;
+		echoed = __process_echoes(tty);
+	}
 
 	if (echoed && tty->ops->flush_chars)
 		tty->ops->flush_chars(tty);
@@ -768,10 +762,10 @@ static void process_echoes(struct tty_struct *tty)
 	if (ldata->echo_mark == ldata->echo_tail)
 		return;
 
-	mutex_lock(&ldata->output_lock);
-	ldata->echo_commit = ldata->echo_mark;
-	echoed = __process_echoes(tty);
-	mutex_unlock(&ldata->output_lock);
+	scoped_guard(mutex, &ldata->output_lock) {
+		ldata->echo_commit = ldata->echo_mark;
+		echoed = __process_echoes(tty);
+	}
 
 	if (echoed && tty->ops->flush_chars)
 		tty->ops->flush_chars(tty);
@@ -786,10 +780,9 @@ static void flush_echoes(struct tty_struct *tty)
 	    ldata->echo_commit == ldata->echo_head)
 		return;
 
-	mutex_lock(&ldata->output_lock);
+	guard(mutex)(&ldata->output_lock);
 	ldata->echo_commit = ldata->echo_head;
 	__process_echoes(tty);
-	mutex_unlock(&ldata->output_lock);
 }
 
 /**
@@ -1078,18 +1071,19 @@ static void isig(int sig, struct tty_struct *tty)
 	if (L_NOFLSH(tty)) {
 		/* signal only */
 		__isig(sig, tty);
+		return;
+	}
 
-	} else { /* signal and flush */
-		up_read(&tty->termios_rwsem);
-		down_write(&tty->termios_rwsem);
-
+	/* signal and flush */
+	up_read(&tty->termios_rwsem);
+	scoped_guard(rwsem_write, &tty->termios_rwsem) {
 		__isig(sig, tty);
 
 		/* clear echo buffer */
-		mutex_lock(&ldata->output_lock);
-		ldata->echo_head = ldata->echo_tail = 0;
-		ldata->echo_mark = ldata->echo_commit = 0;
-		mutex_unlock(&ldata->output_lock);
+		scoped_guard(mutex, &ldata->output_lock) {
+			ldata->echo_head = ldata->echo_tail = 0;
+			ldata->echo_mark = ldata->echo_commit = 0;
+		}
 
 		/* clear output buffer */
 		tty_driver_flush_buffer(tty);
@@ -1100,10 +1094,8 @@ static void isig(int sig, struct tty_struct *tty)
 		/* notify pty master of flush */
 		if (tty->link)
 			n_tty_packet_mode_flush(tty);
-
-		up_write(&tty->termios_rwsem);
-		down_read(&tty->termios_rwsem);
 	}
+	down_read(&tty->termios_rwsem);
 }
 
 /**
@@ -1683,7 +1675,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 	size_t n, rcvd = 0;
 	int room, overflow;
 
-	down_read(&tty->termios_rwsem);
+	guard(rwsem_read)(&tty->termios_rwsem);
 
 	do {
 		/*
@@ -1752,8 +1744,6 @@ n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 			n_tty_kick_worker(tty);
 	}
 
-	up_read(&tty->termios_rwsem);
-
 	return rcvd;
 }
 
@@ -1879,10 +1869,9 @@ static void n_tty_close(struct tty_struct *tty)
 	if (tty->link)
 		n_tty_packet_mode_flush(tty);
 
-	down_write(&tty->termios_rwsem);
+	guard(rwsem_write)(&tty->termios_rwsem);
 	vfree(ldata);
 	tty->disc_data = NULL;
-	up_write(&tty->termios_rwsem);
 }
 
 /**
@@ -2247,10 +2236,10 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 			u8 cs;
 			if (kb != kbuf)
 				break;
-			spin_lock_irq(&tty->link->ctrl.lock);
-			cs = tty->link->ctrl.pktstatus;
-			tty->link->ctrl.pktstatus = 0;
-			spin_unlock_irq(&tty->link->ctrl.lock);
+			scoped_guard(spinlock_irq, &tty->link->ctrl.lock) {
+				cs = tty->link->ctrl.pktstatus;
+				tty->link->ctrl.pktstatus = 0;
+			}
 			*kb++ = cs;
 			nr--;
 			break;
@@ -2357,7 +2346,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 			return retval;
 	}
 
-	down_read(&tty->termios_rwsem);
+	guard(rwsem_read)(&tty->termios_rwsem);
 
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
@@ -2395,9 +2384,8 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 			struct n_tty_data *ldata = tty->disc_data;
 
 			while (nr > 0) {
-				mutex_lock(&ldata->output_lock);
-				num = tty->ops->write(tty, b, nr);
-				mutex_unlock(&ldata->output_lock);
+				scoped_guard(mutex, &ldata->output_lock)
+					num = tty->ops->write(tty, b, nr);
 				if (num < 0) {
 					retval = num;
 					goto break_out;
@@ -2424,7 +2412,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	remove_wait_queue(&tty->write_wait, &wait);
 	if (nr && tty->fasync)
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	up_read(&tty->termios_rwsem);
+
 	return (b - buf) ? b - buf : retval;
 }
 
@@ -2498,12 +2486,11 @@ static int n_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	case TIOCOUTQ:
 		return put_user(tty_chars_in_buffer(tty), (int __user *) arg);
 	case TIOCINQ:
-		down_write(&tty->termios_rwsem);
-		if (L_ICANON(tty) && !L_EXTPROC(tty))
-			num = inq_canon(ldata);
-		else
-			num = read_cnt(ldata);
-		up_write(&tty->termios_rwsem);
+		scoped_guard(rwsem_write, &tty->termios_rwsem)
+			if (L_ICANON(tty) && !L_EXTPROC(tty))
+				num = inq_canon(ldata);
+			else
+				num = read_cnt(ldata);
 		return put_user(num, (unsigned int __user *) arg);
 	default:
 		return n_tty_ioctl_helper(tty, cmd, arg);
-- 
2.51.1

