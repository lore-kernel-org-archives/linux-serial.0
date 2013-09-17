From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 2/3] n_tty: Remove unnecessary local variable
Date: Tue, 17 Sep 2013 12:53:35 -0400
Message-ID: <1379436816-14740-3-git-send-email-peter@hurleysoftware.com>
References: <1379436816-14740-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379436816-14740-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Flatten conditional evaluation in n_tty_set_termios; remove
canon_change.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 42d7ae7..28c468c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1752,11 +1752,8 @@ int is_ignored(int sig)
 static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int canon_change = 1;
 
-	if (old)
-		canon_change = (old->c_lflag ^ tty->termios.c_lflag) & ICANON;
-	if (canon_change) {
+	if (!old || (old->c_lflag ^ tty->termios.c_lflag) & ICANON) {
 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 		ldata->line_start = ldata->canon_head = ldata->read_tail;
 		ldata->erasing = 0;
-- 
1.8.1.2
