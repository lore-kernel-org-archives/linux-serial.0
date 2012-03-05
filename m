From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 29/68] TTY: simserial/amiserial, use one instance of other members
Date: Mon,  5 Mar 2012 14:52:16 +0100
Message-ID: <1330955575-26641-30-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: linux-serial@vger.kernel.org

This means:
* close_delay
* closing_wait
* line
* port
* xmit_fifo_size

This actually fixes a bug in amiserial. It initializes one and uses
the other of the close delays. Yes, duplicating structure members is
evil.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/hp/sim/simserial.c |    9 +++------
 drivers/tty/amiserial.c      |   19 ++++++++-----------
 include/linux/serialP.h      |    5 -----
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index a08a53f..d32b759 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -553,7 +553,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	}
 	if (--state->count < 0) {
 		printk(KERN_ERR "rs_close: bad serial port count for ttys%d: %d\n",
-		       info->line, state->count);
+		       state->line, state->count);
 		state->count = 0;
 	}
 	if (state->count) {
@@ -572,8 +572,8 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	tty_ldisc_flush(tty);
 	info->tty = NULL;
 	if (info->blocked_open) {
-		if (info->close_delay)
-			schedule_timeout_interruptible(info->close_delay);
+		if (state->close_delay)
+			schedule_timeout_interruptible(state->close_delay);
 		wake_up_interruptible(&info->open_wait);
 	}
 	state->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
@@ -630,9 +630,6 @@ static int get_async_struct(int line, struct async_struct **ret_info)
 	}
 	init_waitqueue_head(&info->open_wait);
 	init_waitqueue_head(&info->close_wait);
-	info->port = sstate->port;
-	info->xmit_fifo_size = sstate->xmit_fifo_size;
-	info->line = line;
 	info->state = sstate;
 	if (sstate->info) {
 		kfree(info);
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 8556ca0..5540216 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -723,7 +723,7 @@ static void change_speed(struct async_struct *info,
 	if (!quot)
 		quot = baud_base / 9600;
 	info->quot = quot;
-	info->timeout = ((info->xmit_fifo_size*HZ*bits*quot) / baud_base);
+	info->timeout = ((info->state->xmit_fifo_size*HZ*bits*quot) / baud_base);
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
 	/* CTS flow control flag and modem status interrupts */
@@ -1425,7 +1425,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	}
 	if (--state->count < 0) {
 		printk("rs_close: bad serial port count for ttys%d: %d\n",
-		       info->line, state->count);
+		       state->line, state->count);
 		state->count = 0;
 	}
 	if (state->count) {
@@ -1439,8 +1439,8 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1470,8 +1470,8 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	tty->closing = 0;
 	info->tty = NULL;
 	if (info->blocked_open) {
-		if (info->close_delay) {
-			msleep_interruptible(jiffies_to_msecs(info->close_delay));
+		if (state->close_delay) {
+			msleep_interruptible(jiffies_to_msecs(state->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -1492,7 +1492,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	if (serial_paranoia_check(info, tty->name, "rs_wait_until_sent"))
 		return;
 
-	if (info->xmit_fifo_size == 0)
+	if (info->state->xmit_fifo_size == 0)
 		return; /* Just in case.... */
 
 	orig_jiffies = jiffies;
@@ -1505,7 +1505,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * Note: we have to use pretty tight timings here to satisfy
 	 * the NIST-PCTS.
 	 */
-	char_time = (info->timeout - HZ/50) / info->xmit_fifo_size;
+	char_time = (info->timeout - HZ/50) / info->state->xmit_fifo_size;
 	char_time = char_time / 5;
 	if (char_time == 0)
 		char_time = 1;
@@ -1700,9 +1700,6 @@ static int get_async_struct(int line, struct async_struct **ret_info)
 	init_waitqueue_head(&info->close_wait);
 	init_waitqueue_head(&info->delta_msr_wait);
 #endif
-	info->port = sstate->port;
-	info->xmit_fifo_size = sstate->xmit_fifo_size;
-	info->line = line;
 	info->state = sstate;
 	if (sstate->info) {
 		kfree(info);
diff --git a/include/linux/serialP.h b/include/linux/serialP.h
index 6741f57..6ce488c 100644
--- a/include/linux/serialP.h
+++ b/include/linux/serialP.h
@@ -42,8 +42,6 @@ struct serial_state {
 };
 
 struct async_struct {
-	unsigned long		port;
-	int			xmit_fifo_size;
 	struct serial_state	*state;
 	struct tty_struct 	*tty;
 	int			read_status_mask;
@@ -51,11 +49,8 @@ struct async_struct {
 	int			timeout;
 	int			quot;
 	int			x_char;	/* xon/xoff character */
-	int			close_delay;
-	unsigned short		closing_wait;
 	int			IER; 	/* Interrupt Enable Register */
 	int			MCR; 	/* Modem control register */
-	int			line;
 	int			blocked_open; /* # of blocked opens */
  	struct circ_buf		xmit;
 	wait_queue_head_t	open_wait;
-- 
1.7.9.2
