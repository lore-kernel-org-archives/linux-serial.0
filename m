From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 6/7] tty: core: Improve ldisc debug messages
Date: Sun, 12 Jul 2015 22:49:12 -0400
Message-ID: <1436755753-7746-7-git-send-email-peter@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Add debug messages for ldisc open and close, and remove
"closing ldisc" message from tty_ldisc_release(), because a
close message is now printed for both ldiscs; always print ldisc
pointer first so ldisc changes are easier to identify.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 8191680..71750cb 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -447,6 +447,8 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 		ret = ld->ops->open(tty);
 		if (ret)
 			clear_bit(TTY_LDISC_OPEN, &tty->flags);
+
+		tty_ldisc_debug(tty, "%p: opened\n", tty->ldisc);
 		return ret;
 	}
 	return 0;
@@ -467,6 +469,7 @@ static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 	clear_bit(TTY_LDISC_OPEN, &tty->flags);
 	if (ld->ops->close)
 		ld->ops->close(tty);
+	tty_ldisc_debug(tty, "%p: closed\n", tty->ldisc);
 }
 
 /**
@@ -660,7 +663,7 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	int reset = tty->driver->flags & TTY_DRIVER_RESET_TERMIOS;
 	int err = 0;
 
-	tty_ldisc_debug(tty, "closing ldisc: %p\n", tty->ldisc);
+	tty_ldisc_debug(tty, "%p: closing\n", tty->ldisc);
 
 	ld = tty_ldisc_ref(tty);
 	if (ld != NULL) {
@@ -710,7 +713,7 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	if (reset)
 		tty_reset_termios(tty);
 
-	tty_ldisc_debug(tty, "re-opened ldisc: %p\n", tty->ldisc);
+	tty_ldisc_debug(tty, "%p: re-opened\n", tty->ldisc);
 }
 
 /**
@@ -774,8 +777,6 @@ void tty_ldisc_release(struct tty_struct *tty)
 	 * it does not race with the set_ldisc code path.
 	 */
 
-	tty_ldisc_debug(tty, "closing ldisc: %p\n", tty->ldisc);
-
 	tty_ldisc_lock_pair(tty, o_tty);
 	tty_ldisc_kill(tty);
 	if (o_tty)
@@ -785,7 +786,7 @@ void tty_ldisc_release(struct tty_struct *tty)
 	/* And the memory resources remaining (buffers, termios) will be
 	   disposed of when the kref hits zero */
 
-	tty_ldisc_debug(tty, "ldisc closed\n");
+	tty_ldisc_debug(tty, "released\n");
 }
 
 /**
-- 
2.4.5
