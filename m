From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 47/75] tty: N_TTY SIGIO only works for read
Date: Fri, 02 Jan 2009 13:47:13 +0000
Message-ID: <20090102134711.13472.45435.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37610 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752315AbZABNq7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:59 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Thomas Pfaff <tpfaff@pcs.com>

The N_TTY ldisc layer does not send SIGIO POLL_OUTs correctly when output is
possible due to flawed handling of the TTY_DO_WRITE_WAKEUP bit. It will
either send no SIGIOs at all or on every tty wakeup.

The fix is to set the bit when the tty driver write would block and test
and clear it on write wakeup.

[Merged with existing N_TTY patches and a small buglet fixed -- Alan]

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/n_tty.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index 3922a08..f6f0e4e 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -1352,10 +1352,8 @@ static void n_tty_write_wakeup(struct tty_struct *tty)
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
 
-	if (tty->fasync) {
-		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+	if (tty->fasync && test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags))
 		kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
-	}
 }
 
 /**
@@ -2014,6 +2012,8 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 break_out:
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tty->write_wait, &wait);
+	if (b - buf != nr && tty->fasync)
+		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	return (b - buf) ? b - buf : retval;
 }
 

