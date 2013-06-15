From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 22/24] n_tty: Move n_tty_write_wakeup() to avoid forward declaration
Date: Sat, 15 Jun 2013 09:14:34 -0400
Message-ID: <1371302076-4688-23-git-send-email-peter@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prepare to special case pty flow control; avoid forward declaration.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9e13c80..0e3efc1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -214,6 +214,21 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
 	return n;
 }
 
+/**
+ *	n_tty_write_wakeup	-	asynchronous I/O notifier
+ *	@tty: tty device
+ *
+ *	Required for the ptys, serial driver etc. since processes
+ *	that attach themselves to the master and rely on ASYNC
+ *	IO must be woken up
+ */
+
+static void n_tty_write_wakeup(struct tty_struct *tty)
+{
+	if (tty->fasync && test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags))
+		kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
+}
+
 static inline void n_tty_check_throttle(struct tty_struct *tty)
 {
 	/*
@@ -1458,22 +1473,6 @@ handle_newline:
 	put_tty_queue(c, ldata);
 }
 
-
-/**
- *	n_tty_write_wakeup	-	asynchronous I/O notifier
- *	@tty: tty device
- *
- *	Required for the ptys, serial driver etc. since processes
- *	that attach themselves to the master and rely on ASYNC
- *	IO must be woken up
- */
-
-static void n_tty_write_wakeup(struct tty_struct *tty)
-{
-	if (tty->fasync && test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags))
-		kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
-}
-
 /**
  *	n_tty_receive_buf	-	data receive
  *	@tty: terminal device
-- 
1.8.1.2
