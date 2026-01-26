Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4F2E54D3;
	Mon, 26 Jan 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450922; cv=none; b=jhlQ7yI5lza0h9pOTJiQj8T49ckQkd+YgNwzhECzpIwOAAoZRX9fOE5jpMDxpFT2sPgpS2FJRryzIy9UJ7IQloSBjbrT1kf7xSNQ8PK7nDPumnvojclMb2JlSuUqtQ0EoO9ttZFpAJpN1abwN7Zc3+WsuHAphcpZUeTNRVNlB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450922; c=relaxed/simple;
	bh=A6IciAb2xnYWGVMWPriEZm7A4sDXFXGVxz6UL8XwdxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AGdpdzUdlSviJf7quDvM0xV+oyU4A81R9TBQqWRZPuH6i2Dk2/pvPKAZplgaqu4Tcev/zqitAoCKQVn8KvA2uMqzPSzVFh7HpWA8SdWVD929SxaHmTjdDG+N015+31K2LMxxo9tmMLv2o/12diDaOm2mbmSMQoMj9B3jKetXLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zA71ZuEe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixutS52Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zA71ZuEe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixutS52Y"
Date: Mon, 26 Jan 2026 19:08:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769450918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=n25mEkYQU/glokJCvaiTwx52pP8eauU0AvEm85TLH8I=;
	b=zA71ZuEewFBi4MT7lBql2Gddc58rxd16xkRREuW8LoYi9IKPBrocQiXvXzP1tu67DM96+2
	uwycgmoTK7l0P/C99zd8qDMFtgCUaT9iqkMWoskgqt8aryA/L/O0+bmWUTjX/WLPVp/K6y
	U4dGaW4wW5Fi/zTUu/QxXkuHs4ZEjMLXQVFo2PISmS2ypzjgLA9wjb+IjRgMfy30jFHLd+
	NVHaBfbVD+09jDgxBYSk0Z7Rt9YL9Xjj7mi3dKfvgTPRcECkuld4JH4p6iUmluU2qWeE0M
	3UG1QQ3ngGUQD4k+jMXGIB5BUrRpj08LfIqH+ntOgfgRsWJhw87Cx+jVVPEeJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769450918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=n25mEkYQU/glokJCvaiTwx52pP8eauU0AvEm85TLH8I=;
	b=ixutS52YHuUN8cAazK53op9LSVXKYj+L7tTcuTfX0ZgExwcqBlUynQDi28APWYREAjSiEV
	cUFDysE+f9Wo9ECA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH] printk, vt, fbcon: Remove console_conditional_schedule()
Message-ID: <20260126180836.SNCdMW2f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

do_con_write(), fbcon_redraw.*() invoke console_conditional_schedule()
which is a conditional scheduling point based on printk's internal
variables console_may_schedule. It may only be used if the console lock
is acquired for instance via console_lock() or console_trylock().

Prinkt sets the internal variable to 1 (and allows to schedule)
if the console lock has been acquired via console_lock(). The trylock
does not allow it.

The console_conditional_schedule() invocation in do_con_write() is
invoked shortly before console_unlock().
The console_conditional_schedule() invocation in fbcon_redraw.*()
original from fbcon_scroll() / vt's con_scroll() which originate from a
line feed.

In console_unlock() the variable is set to 0 (forbids to schedule) and
it tries to schedule while making progress printing. This is brand new
compared to when console_conditional_schedule() was added in v2.4.9.11.

In v2.6.38-rc3, console_unlock() (started its existence) iterated over
all consoles and flushed them with disabled interrupts. A scheduling
attempt here was not possible, it relied that a long print scheduled
before console_unlock().

Since commit 8d91f8b15361d ("printk: do cond_resched() between lines
while outputting to consoles"), which appeared in v4.5-rc1,
console_unlock() attempts to schedule if it was allowed to schedule
while during console_lock(). Each record is idealy one line so after
every line feed.

This console_conditional_schedule() is also only relevant on
PREEMPT_NONE and PREEMPT_VOLUNTARY builds. In other configurations
cond_resched() becomes a nop and has no impact.

I'm bringing this all up just proof that it is not required anymore. It
becomes a problem on a PREEMPT_RT build with debug code enabled because
that might_sleep() in cond_resched() remains and triggers a warnings.
This is due to

 legacy_kthread_func-> console_flush_one_record ->  vt_console_print-> lf
   -> con_scroll -> fbcon_scroll

and vt_console_print() acquires a spinlock_t which does not allow a
voluntary schedule. There is no need to fb_scroll() to schedule since
console_flush_one_record() attempts to schedule after each line.
!PREEMPT_RT is not affected because the legacy printing thread is only
enabled on PREEMPT_RT builds.

Therefore I suggest to remove console_conditional_schedule().

Cc: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Fixes: 5f53ca3ff83b4 ("printk: Implement legacy printer kthread for PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

A follow-up to
	https://lore.kernel.org/all/20260114145955.d924Z-zu@linutronix.de/

 drivers/tty/vt/vt.c              |  1 -
 drivers/video/fbdev/core/fbcon.c |  6 ------
 include/linux/console.h          |  1 -
 kernel/printk/printk.c           | 16 ----------------
 4 files changed, 24 deletions(-)

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
index 1d765ad242b82..9296bf41aa49d 100644
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
-- 
2.51.0

