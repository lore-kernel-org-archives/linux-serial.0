From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] Revert "tty: Fix pty master poll() after slave closes v2"
Date: Tue, 30 Dec 2014 07:17:09 -0500
Message-ID: <1419941829-6536-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Francesco Ruggeri <fruggeri@aristanetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Francesco Ruggeri <fruggeri@arista.com>
List-Id: linux-serial@vger.kernel.org

This reverts commit c4dc304677e8d566572c4738d95c48be150c6606.
This fix is superseded by commit 52bce7f8d4fc633c9a9d0646eef58ba6ae9a3b73,
'pty, n_tty: Simplify input processing on final close'.

The final close now waits for input processing to complete before
destroying the pty, so poll() does not need to special case this
condition.

Cc: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index a618b10..d2dc10f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2399,17 +2399,12 @@ static unsigned int n_tty_poll(struct tty_struct *tty, struct file *file,
 
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
-	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
-		mask |= POLLHUP;
 	if (input_available_p(tty, 1))
 		mask |= POLLIN | POLLRDNORM;
-	else if (mask & POLLHUP) {
-		tty_flush_to_ldisc(tty);
-		if (input_available_p(tty, 1))
-			mask |= POLLIN | POLLRDNORM;
-	}
 	if (tty->packet && tty->link->ctrl_status)
 		mask |= POLLPRI | POLLIN | POLLRDNORM;
+	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
+		mask |= POLLHUP;
 	if (tty_hung_up_p(file))
 		mask |= POLLHUP;
 	if (!(mask & (POLLHUP | POLLIN | POLLRDNORM))) {
-- 
2.2.1
