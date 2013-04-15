From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 15/24] n_tty: Reset lnext if canonical mode changes
Date: Mon, 15 Apr 2013 11:19:19 -0400
Message-ID: <1366039168-8510-16-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

lnext escapes the next input character as a literal, and must
be reset when canonical mode changes (to avoid misinterpreting
a special character as a literal if canonical mode is changed
back again).

lnext is specifically not reset on a buffer flush so as to avoid
misinterpreting the next input character as a special character.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6691920..98bc9df 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1575,6 +1575,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 		ldata->canon_head = ldata->read_tail;
 		ldata->erasing = 0;
+		ldata->lnext = 0;
 	}
 
 	if (canon_change && !L_ICANON(tty) && read_cnt(ldata))
-- 
1.8.1.2
