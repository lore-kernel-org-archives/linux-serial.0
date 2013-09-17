From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 3/3] n_tty: Style fix in n_tty_set_termios
Date: Tue, 17 Sep 2013 12:53:36 -0400
Message-ID: <1379436816-14740-4-git-send-email-peter@hurleysoftware.com>
References: <1379436816-14740-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379436816-14740-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Remove braces from single-statement conditional in
n_tty_set_termios.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 28c468c..09505ff 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1814,9 +1814,8 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	 * Fix tty hang when I_IXON(tty) is cleared, but the tty
 	 * been stopped by STOP_CHAR(tty) before it.
 	 */
-	if (!I_IXON(tty) && old && (old->c_iflag & IXON) && !tty->flow_stopped) {
+	if (!I_IXON(tty) && old && (old->c_iflag & IXON) && !tty->flow_stopped)
 		start_tty(tty);
-	}
 
 	/* The termios change make the tty ready for I/O */
 	wake_up_interruptible(&tty->write_wait);
-- 
1.8.1.2
