From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 01/26] tty: Don't hold tty_lock for ldisc release
Date: Wed,  5 Nov 2014 12:12:44 -0500
Message-ID: <1415207589-15967-2-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:50480 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755309AbaKERNb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 12:13:31 -0500
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

The tty->ldisc_sem write lock is sufficient for serializing changes
to tty->ldisc; holding the tty lock is not required.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 2d822aa..332a622 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -764,6 +764,8 @@ static void tty_ldisc_kill(struct tty_struct *tty)
  *	Called during the final close of a tty/pty pair in order to shut down
  *	the line discpline layer. On exit the ldisc assigned is N_TTY and the
  *	ldisc has not been opened.
+ *
+ *	Holding ldisc_sem write lock serializes tty->ldisc changes.
  */
 
 void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty)
@@ -776,13 +778,9 @@ void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty)
 	tty_ldisc_debug(tty, "closing ldisc: %p\n", tty->ldisc);
 
 	tty_ldisc_lock_pair(tty, o_tty);
-	tty_lock_pair(tty, o_tty);
-
 	tty_ldisc_kill(tty);
 	if (o_tty)
 		tty_ldisc_kill(o_tty);
-
-	tty_unlock_pair(tty, o_tty);
 	tty_ldisc_unlock_pair(tty, o_tty);
 
 	/* And the memory resources remaining (buffers, termios) will be
-- 
2.1.3

