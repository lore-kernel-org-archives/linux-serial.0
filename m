From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 29/32] tty: Fix hangup race with TIOCSETD ioctl
Date: Wed, 20 Feb 2013 15:03:16 -0500
Message-ID: <1361390599-15195-30-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The hangup may already have happened; check for that state also.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 9ace119..84ba790 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -543,10 +543,8 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 	old_ldisc = tty->ldisc;
 	tty_lock(tty);
 
-	/* FIXME: for testing only */
-	WARN_ON(test_bit(TTY_HUPPED, &tty->flags));
-
-	if (test_bit(TTY_HUPPING, &tty->flags)) {
+	if (test_bit(TTY_HUPPING, &tty->flags) ||
+	    test_bit(TTY_HUPPED, &tty->flags)) {
 		/* We were raced by the hangup method. It will have stomped
 		   the ldisc data and closed the ldisc down */
 		tty_ldisc_enable_pair(tty, o_tty);
-- 
1.8.1.2
