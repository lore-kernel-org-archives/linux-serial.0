From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 21/23] tty: Re-parent orphaned tty_set_ldisc() comments
Date: Tue,  5 Feb 2013 15:20:36 -0500
Message-ID: <1360095638-6624-22-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 92629c1..49e4825 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -545,10 +545,18 @@ static int tty_ldisc_halt(struct tty_struct *tty, struct tty_struct *o_tty,
 {
 	int scheduled, o_scheduled, retval;
 
+	/*
+	 *	The TTY_LDISC bit prevents anyone taking an ldisc
+	 *	reference once it is clear.
+	 */
 	clear_bit(TTY_LDISC, &tty->flags);
 	if (o_tty)
 		clear_bit(TTY_LDISC, &o_tty->flags);
 
+	/*
+	 *	Make sure we don't change while someone holds a
+	 *	reference to the line discipline.
+	 */
 	retval = tty_ldisc_wait_idle(tty, timeout);
 	if (!retval && o_tty)
 		retval = tty_ldisc_wait_idle(o_tty, timeout);
@@ -702,13 +710,9 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 	o_ldisc = tty->ldisc;
 
 	tty_unlock(tty);
+
 	/*
-	 *	Make sure we don't change while someone holds a
-	 *	reference to the line discipline. The TTY_LDISC bit
-	 *	prevents anyone taking a reference once it is clear.
-	 *	We need the lock to avoid racing reference takers.
-	 *
-	 *	We must clear the TTY_LDISC bit here to avoid a livelock
+	 *	We must halt the line discipline here to avoid a livelock
 	 *	with a userspace app continually trying to use the tty in
 	 *	parallel to the change and re-referencing the tty.
 	 */
-- 
1.8.1.2
