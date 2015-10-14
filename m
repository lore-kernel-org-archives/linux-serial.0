From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] n_tty: Remove reader wakeups for TTY_BREAK/TTY_PARITY chars
Date: Wed, 14 Oct 2015 07:52:27 -0400
Message-ID: <1444823547-8064-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Waking the reader immediately upon receipt of TTY_BREAK or TTY_PARITY
chars has no effect on the outcome of read():
1. Only non-canonical/EXTPROC mode applies since canonical mode
   will not return data until a line termination is received anyway
2. EXTPROC mode - the reader will always be woken by the input worker
3. Non-canonical modes
   a. MIN == 0, TIME == 0
   b. MIN == 0, TIME > 0
   c. MIN > 0, TIME > 0
      minimum_to_wake is always 1 in these modes so the reader will always
      be woken by the input worker
   d. MIN > 0, TIME == 0
      although the reader will not be woken by the input worker unless the
      minimum data is received, the reader would not otherwise have
      returned the received data

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index bd383c4..53ba0d6 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1180,8 +1180,6 @@ static void n_tty_receive_break(struct tty_struct *tty)
 		put_tty_queue('\0', ldata);
 	}
 	put_tty_queue('\0', ldata);
-	if (waitqueue_active(&tty->read_wait))
-		wake_up_interruptible_poll(&tty->read_wait, POLLIN);
 }
 
 /**
@@ -1238,8 +1236,6 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 			put_tty_queue('\0', ldata);
 	} else
 		put_tty_queue(c, ldata);
-	if (waitqueue_active(&tty->read_wait))
-		wake_up_interruptible_poll(&tty->read_wait, POLLIN);
 }
 
 static void
-- 
2.6.1
