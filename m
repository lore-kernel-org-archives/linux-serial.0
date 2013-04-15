From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 7/9] n_tty: Only flush echo output if actually output
Date: Mon, 15 Apr 2013 11:29:45 -0400
Message-ID: <1366039787-8719-8-git-send-email-peter@hurleysoftware.com>
References: <1366039567-8620-1-git-send-email-peter@hurleysoftware.com>
 <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Don't have the driver flush received echoes if no echoes were
actually output.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6f507f5..a601c46 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -645,14 +645,14 @@ break_out:
  *	Locking: callers must hold output_lock
  */
 
-static void __process_echoes(struct tty_struct *tty)
+static size_t __process_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int	space, nr;
+	int	space, old_space;
 	size_t tail;
 	unsigned char c;
 
-	space = tty_write_room(tty);
+	old_space = space = tty_write_room(tty);
 
 	tail = ldata->echo_tail;
 	nr = ldata->echo_commit - ldata->echo_tail;
@@ -785,12 +785,13 @@ static void __process_echoes(struct tty_struct *tty)
 	}
 
 	ldata->echo_tail = tail;
+	return old_space - space;
 }
 
 static void commit_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	size_t nr, old;
+	size_t nr, old, echoed;
 	size_t head;
 
 	head = ldata->echo_head;
@@ -805,25 +806,26 @@ static void commit_echoes(struct tty_struct *tty)
 
 	mutex_lock(&ldata->output_lock);
 	ldata->echo_commit = head;
-	__process_echoes(tty);
+	echoed = __process_echoes(tty);
 	mutex_unlock(&ldata->output_lock);
 
-	if (tty->ops->flush_chars)
+	if (echoed && tty->ops->flush_chars)
 		tty->ops->flush_chars(tty);
 }
 
 static void process_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
+	size_t echoed;
 
 	if (!L_ECHO(tty) || ldata->echo_commit == ldata->echo_tail)
 		return;
 
 	mutex_lock(&ldata->output_lock);
-	__process_echoes(tty);
+	echoed = __process_echoes(tty);
 	mutex_unlock(&ldata->output_lock);
 
-	if (tty->ops->flush_chars)
+	if (echoed && tty->ops->flush_chars)
 		tty->ops->flush_chars(tty);
 }
 
-- 
1.8.1.2
