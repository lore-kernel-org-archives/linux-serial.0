From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 24/44] tty: Remove redundant tty_wait_until_sent()
Date: Mon, 11 Mar 2013 16:44:44 -0400
Message-ID: <1363034704-28036-25-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_ioctl() already waits until sent.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 4e46c17..1afe192 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -625,15 +625,6 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 		return 0;
 	}
 
-	tty_unlock(tty);
-	/*
-	 *	Problem: What do we do if this blocks ?
-	 *	We could deadlock here
-	 */
-
-	tty_wait_until_sent(tty, 0);
-
-	tty_lock(tty);
 	mutex_lock(&tty->ldisc_mutex);
 
 	/*
-- 
1.8.1.2
