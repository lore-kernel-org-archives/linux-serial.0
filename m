Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778673101B1;
	Wed, 14 Jan 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402803; cv=none; b=czpZu74DuIOmVVUWdHUD02vJmQ9bOZzIzK/4NZPlK/j6hGgUs322jetpzW3zkwETNz76+eqChTaCO8e6hMUdW32XB8V/Qgd8QFLxbNkjfkO4EV/BoMGSRzlTzmSJ83IEKcIuuHXNeK8kNQJsiVCkhnZv9UfpB3RGpEWbtsX07fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402803; c=relaxed/simple;
	bh=1pBF1YRQNxk2lGvGbTpKbhstidHyHdbzznUXBYdEsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QcJDeNcfrQVaGp5yMR1gWheaxfZ7UY71OoNVq253YblE3sRy2v5qLyeOuRKvLDKB3F31HtmwO6j+zzXVhddjjENRi+SDv1IyAnRwUhYNxCjeFgwSl4xnSji9nEo3zK63KWqUKhGaM3vePNjWZpJP1+mGn+GZOd9C56TW54XHpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KJJwWdYj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PHq/uYCZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KJJwWdYj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PHq/uYCZ"
Date: Wed, 14 Jan 2026 15:59:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768402796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3NtpMq02bFP0cM3SxnYhJXRT6/tEC5TRWXEogu0kE8o=;
	b=KJJwWdYjqIMR9SblykjcmGBawPqMNrSMqhUInAcFQ3mJh/szFd2nOIz03aj0LNC87g3n0i
	R6VRv55dXYQAX3gJtk7TNDouRNnPID30UtBxoKSfZDttswab1zz4uvLavj4EaeGoOSDyBj
	Uo6relqJoeSY5pvKElxurMZSXBDLXVpMc7ixlxQa3KAQ8z/7W9MpxSghs4PxJUKyd2XtwC
	UapRf6XLie/85ZNRH3mbcpRQbswXg/nSSY3xhexr9mXBfRzCDaZCaXPN4q+vmbNe5Xr5CX
	rKUwc9/PwwuRWuV21KBD13i9e6rx5FstQ6sIqDJEqV/Q/2s5a2GGNYHsq7FzjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768402796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3NtpMq02bFP0cM3SxnYhJXRT6/tEC5TRWXEogu0kE8o=;
	b=PHq/uYCZjOOiVrJ1aAJFhnCsHRdBOBYigq7N7buni46q2zlZmRMgI6b3tneIvBlf55ms0o
	LGF3AnH5CiycyTDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: printk's threaded legacy console + fbcon => schedule where it should
 not
Message-ID: <20260114145955.d924Z-zu@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

legacy_kthread_func() does console_lock() which means
console_may_schedule is 1.

The other path is from vprintk_emit() where we have
         if (ft.legacy_direct) {
                 preempt_disable();
                 if (console_trylock_spinning())
                         console_unlock();
                 preempt_enable();
         }

so all printing happens from console_unlock() where
console_may_schedule is 0. This is a small difference. With the legacy
console enabled I get:

| BUG: sleeping function called from invalid context at kernel/printk/printk.c:3377
| in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15, name: pr/legacy
| preempt_count: 1, expected: 0
| RCU nest depth: 0, expected: 0
| 3 locks held by pr/legacy/15:
|  #0: ffffffffa8aebac0 (console_lock){+.+.}-{0:0}, at: legacy_kthread_func+0x6c/0x130
|  #1: ffffffffa8aebb18 (console_srcu){....}-{0:0}, at: console_flush_one_record+0x7e/0x4d0
|  #2: ffffffffa8c49818 (printing_lock){+.+.}-{3:3}, at: vt_console_print+0x55/0x490
| Preemption disabled at:
| [<0000000000000000>] 0x0
| CPU: 7 UID: 0 PID: 15 Comm: pr/legacy Not tainted 6.19.0-rc5+ #19 PREEMPT(lazy)
| Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z68 Pro3-M, BIOS P2.30 06/29/2012
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x68/0x90
|  __might_resched.cold+0xf0/0x12b
|  console_conditional_schedule+0x27/0x30
|  fbcon_redraw+0xa0/0x240
|  fbcon_scroll+0x164/0x1c0
|  con_scroll+0xfa/0x200
|  lf+0xa5/0xb0
|  vt_console_print+0x313/0x490
|  console_flush_one_record+0x2a0/0x4d0
|  legacy_kthread_func+0x83/0x130
|  kthread+0x118/0x250
|  ret_from_fork+0x309/0x3b0
|  ret_from_fork_asm+0x1a/0x30
|  </TASK>

because vt_console_print() acquires a spin_lock for synchronisation
against another caller while console_conditional_schedule() would like
to schedule.
Most callers of console_unlock() do trylock except for few such as
__pr_flush() which are affected by this the same way as the legacy
printing thread. But we don't have much pr_flush() so this is hidden.

Is there a strict need for fbcon_scroll() to schedule in fbcon_redraw()?
From a quick look it looks that intense callers such the printk flush do
cond_resched() on their own and tty does it, too

| fbcon_scroll+0x164/0x1c0
| con_scroll+0xfa/0x200
| lf+0xa5/0xb0
| do_con_write+0xc68/0x2630
| con_write+0xf/0x40
| do_output_char+0x180/0x1e0
| n_tty_write+0x1ba/0x580
| file_tty_write.isra.0+0x17e/0x2c0

the cond_resched() is in file_tty_write()/ iterate_tty_write().

Therefore I would suggest to simply

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 59b4b5e126ba1..53daf7614b1af 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3236,7 +3236,6 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
 			goto rescan_last_byte;
 	}
 	con_flush(vc, &draw);
-	console_conditional_schedule();
 	notify_update(vc);
 
 	return n;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 7be9e865325d9..36dd9d4a46ae0 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1607,12 +1607,10 @@ static void fbcon_redraw_move(struct vc_data *vc, struct fbcon_display *p,
 					start = s;
 				}
 			}
-			console_conditional_schedule();
 			s++;
 		} while (s < le);
 		if (s > start)
 			fbcon_putcs(vc, start, s - start, dy, x);
-		console_conditional_schedule();
 		dy++;
 	}
 }
@@ -1648,14 +1646,12 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 			}
 
 			scr_writew(c, d);
-			console_conditional_schedule();
 			s++;
 			d++;
 		} while (s < le);
 		if (s > start)
 			par->bitops->bmove(vc, info, line + ycount, x, line, x, 1,
 					     s - start);
-		console_conditional_schedule();
 		if (ycount > 0)
 			line++;
 		else {
@@ -1703,13 +1699,11 @@ static void fbcon_redraw(struct vc_data *vc, int line, int count, int offset)
 				}
 			}
 			scr_writew(c, d);
-			console_conditional_schedule();
 			s++;
 			d++;
 		} while (s < le);
 		if (s > start)
 			fbcon_putcs(vc, start, s - start, line, x);
-		console_conditional_schedule();
 		if (offset > 0)
 			line++;
 		else {
diff --git a/include/linux/console.h b/include/linux/console.h
index fc9f5c5c1b04c..ec506d3501965 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -697,7 +697,6 @@ extern int unregister_console(struct console *);
 extern void console_lock(void);
 extern int console_trylock(void);
 extern void console_unlock(void);
-extern void console_conditional_schedule(void);
 extern void console_unblank(void);
 extern void console_flush_on_panic(enum con_flush_mode mode);
 extern struct tty_driver *console_device(int *);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1d765ad242b82..52b1fefdff4e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3362,22 +3362,6 @@ void console_unlock(void)
 }
 EXPORT_SYMBOL(console_unlock);
 
-/**
- * console_conditional_schedule - yield the CPU if required
- *
- * If the console code is currently allowed to sleep, and
- * if this CPU should yield the CPU to another task, do
- * so here.
- *
- * Must be called within console_lock();.
- */
-void __sched console_conditional_schedule(void)
-{
-	if (console_may_schedule)
-		cond_resched();
-}
-EXPORT_SYMBOL(console_conditional_schedule);
-
 void console_unblank(void)
 {
 	bool found_unblank = false;

Sebastian
