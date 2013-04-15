From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/9] n_tty: Remove unused echo_overrun field
Date: Mon, 15 Apr 2013 11:29:39 -0400
Message-ID: <1366039787-8719-2-git-send-email-peter@hurleysoftware.com>
References: <1366039567-8620-1-git-send-email-peter@hurleysoftware.com>
 <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The echo_overrun field is only assigned and never tested; remove it.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4dbb558..e9a392a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -96,7 +96,6 @@ struct n_tty_data {
 
 	/* must hold exclusive termios_rwsem to reset these */
 	unsigned char lnext:1, erasing:1, raw:1, real_raw:1, icanon:1;
-	unsigned char echo_overrun:1;
 
 	/* shared by producer and consumer */
 	char *read_buf;
@@ -325,7 +324,7 @@ static void reset_buffer_flags(struct n_tty_data *ldata)
 	ldata->read_head = ldata->canon_head = ldata->read_tail = 0;
 
 	mutex_lock(&ldata->echo_lock);
-	ldata->echo_pos = ldata->echo_cnt = ldata->echo_overrun = 0;
+	ldata->echo_pos = ldata->echo_cnt = 0;
 	mutex_unlock(&ldata->echo_lock);
 
 	ldata->erasing = 0;
@@ -782,14 +781,11 @@ static void process_echoes(struct tty_struct *tty)
 	if (nr == 0) {
 		ldata->echo_pos = 0;
 		ldata->echo_cnt = 0;
-		ldata->echo_overrun = 0;
 	} else {
 		int num_processed = ldata->echo_cnt - nr;
 		ldata->echo_pos += num_processed;
 		ldata->echo_pos &= N_TTY_BUF_SIZE - 1;
 		ldata->echo_cnt = nr;
-		if (num_processed > 0)
-			ldata->echo_overrun = 0;
 	}
 
 	mutex_unlock(&ldata->echo_lock);
@@ -835,8 +831,6 @@ static void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 			ldata->echo_pos++;
 		}
 		ldata->echo_pos &= N_TTY_BUF_SIZE - 1;
-
-		ldata->echo_overrun = 1;
 	} else {
 		new_byte_pos = ldata->echo_pos + ldata->echo_cnt;
 		new_byte_pos &= N_TTY_BUF_SIZE - 1;
-- 
1.8.1.2
