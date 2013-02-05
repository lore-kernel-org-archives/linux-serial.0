From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 11/23] n_tty: Correct unthrottle-with-buffer-flush comments
Date: Tue,  5 Feb 2013 15:20:26 -0500
Message-ID: <1360095638-6624-12-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The driver is no longer unthrottled on buffer reset, so remove
comments that claim it is.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 7be6ca8..5073dd1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -212,9 +212,8 @@ static void check_unthrottle(struct tty_struct *tty)
  *	reset_buffer_flags	-	reset buffer state
  *	@tty: terminal to reset
  *
- *	Reset the read buffer counters, clear the flags,
- *	and make sure the driver is unthrottled. Called
- *	from n_tty_open() and n_tty_flush_buffer().
+ *	Reset the read buffer counters and clear the flags.
+ *	Called from n_tty_open() and n_tty_flush_buffer().
  *
  *	Locking: tty_read_lock for read fields.
  */
@@ -253,17 +252,15 @@ static void packet_mode_flush(struct tty_struct *tty)
  *	n_tty_flush_buffer	-	clean input queue
  *	@tty:	terminal device
  *
- *	Flush the input buffer. Called when the line discipline is
- *	being closed, when the tty layer wants the buffer flushed (eg
- *	at hangup) or when the N_TTY line discipline internally has to
- *	clean the pending queue (for example some signals).
+ *	Flush the input buffer. Called when the tty layer wants the
+ *	buffer flushed (eg at hangup) or when the N_TTY line discipline
+ *	internally has to clean the pending queue (for example some signals).
  *
  *	Locking: ctrl_lock, read_lock.
  */
 
 static void n_tty_flush_buffer(struct tty_struct *tty)
 {
-	/* clear everything and unthrottle the driver */
 	reset_buffer_flags(tty);
 
 	if (tty->link)
-- 
1.8.1.2
