From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 5/7] n_tty: Refactor input_available_p() by call site
Date: Fri, 22 Nov 2013 10:59:23 -0500
Message-ID: <1385135965-4235-6-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Distinguish if caller is n_tty_poll() or n_tty_read(), and
set the read/wakeup threshold accordingly.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9298b68..8f2356e 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1878,14 +1878,15 @@ static int n_tty_open(struct tty_struct *tty)
 	return 0;
 }
 
-static inline int input_available_p(struct tty_struct *tty, int amt)
+static inline int input_available_p(struct tty_struct *tty, int poll)
 {
 	struct n_tty_data *ldata = tty->disc_data;
+	int amt = poll && !TIME_CHAR(tty) ? MIN_CHAR(tty) : 1;
 
 	if (ldata->icanon && !L_EXTPROC(tty)) {
 		if (ldata->canon_head != ldata->read_tail)
 			return 1;
-	} else if (read_cnt(ldata) >= (amt ? amt : 1))
+	} else if (read_cnt(ldata) >= amt)
 		return 1;
 
 	return 0;
@@ -2384,7 +2385,7 @@ static unsigned int n_tty_poll(struct tty_struct *tty, struct file *file,
 
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
-	if (input_available_p(tty, TIME_CHAR(tty) ? 0 : MIN_CHAR(tty)))
+	if (input_available_p(tty, 1))
 		mask |= POLLIN | POLLRDNORM;
 	else if (ldata->icanon)
 		n_tty_set_room(tty);
-- 
1.8.1.2
