From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 01/18] tty: Don't change receive_room for ioctl(TIOCSETD)
Date: Tue, 19 Mar 2013 16:21:36 -0400
Message-ID: <1363724513-15604-2-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Min Zhang <mzhang@mvista.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_set_ldisc() is guaranteed exclusive use of the line discipline
by tty_ldisc_lock_pair_timeout(); shutting off input by resetting
receive_room is unnecessary.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index ba49c0e..5a6c43d 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -537,9 +537,6 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 		return 0;
 	}
 
-	/* FIXME: why 'shutoff' input if the ldisc is locked? */
-	tty->receive_room = 0;
-
 	old_ldisc = tty->ldisc;
 	tty_lock(tty);
 
-- 
1.8.1.2
