From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 5/7] tty: Fix hangup race with TIOCSETD ioctl
Date: Tue, 19 Mar 2013 15:26:07 -0400
Message-ID: <1363721169-22445-6-git-send-email-peter@hurleysoftware.com>
References: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
 <1363721169-22445-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363721169-22445-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Michel Lespinasse <walken@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
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
