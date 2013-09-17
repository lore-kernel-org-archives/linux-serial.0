From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 1/3] n_tty: Remove superfluous reader wakeup
Date: Tue, 17 Sep 2013 12:53:34 -0400
Message-ID: <1379436816-14740-2-git-send-email-peter@hurleysoftware.com>
References: <1379436816-14740-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379436816-14740-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

n_tty's .set_termios method unconditionally performs reader wakeup;
remove extra reader wakeup for canonical mode changes.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 01bf5eb..42d7ae7 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1763,9 +1763,6 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 		ldata->lnext = 0;
 	}
 
-	if (canon_change && !L_ICANON(tty) && read_cnt(ldata))
-		wake_up_interruptible(&tty->read_wait);
-
 	ldata->icanon = (L_ICANON(tty) != 0);
 
 	if (I_ISTRIP(tty) || I_IUCLC(tty) || I_IGNCR(tty) ||
-- 
1.8.1.2
