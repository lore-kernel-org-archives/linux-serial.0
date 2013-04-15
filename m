From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 8/9] n_tty: Eliminate counter in __process_echoes
Date: Mon, 15 Apr 2013 11:29:46 -0400
Message-ID: <1366039787-8719-9-git-send-email-peter@hurleysoftware.com>
References: <1366039567-8620-1-git-send-email-peter@hurleysoftware.com>
 <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Since neither echo_commit nor echo_tail can change for the duration
of __process_echoes loop, substitute index comparison for the
snapshot counter.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index a601c46..eb20777 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -655,8 +655,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 	old_space = space = tty_write_room(tty);
 
 	tail = ldata->echo_tail;
-	nr = ldata->echo_commit - ldata->echo_tail;
-	while (nr > 0) {
+	while (ldata->echo_commit != tail) {
 		c = echo_buf(ldata, tail);
 		if (c == ECHO_OP_START) {
 			unsigned char op;
@@ -700,20 +699,17 @@ static size_t __process_echoes(struct tty_struct *tty)
 						ldata->column--;
 				}
 				tail += 3;
-				nr -= 3;
 				break;
 
 			case ECHO_OP_SET_CANON_COL:
 				ldata->canon_column = ldata->column;
 				tail += 2;
-				nr -= 2;
 				break;
 
 			case ECHO_OP_MOVE_BACK_COL:
 				if (ldata->column > 0)
 					ldata->column--;
 				tail += 2;
-				nr -= 2;
 				break;
 
 			case ECHO_OP_START:
@@ -726,7 +722,6 @@ static size_t __process_echoes(struct tty_struct *tty)
 				ldata->column++;
 				space--;
 				tail += 2;
-				nr -= 2;
 				break;
 
 			default:
@@ -748,7 +743,6 @@ static size_t __process_echoes(struct tty_struct *tty)
 				ldata->column += 2;
 				space -= 2;
 				tail += 2;
-				nr -= 2;
 			}
 
 			if (no_space_left)
@@ -767,7 +761,6 @@ static size_t __process_echoes(struct tty_struct *tty)
 				space -= 1;
 			}
 			tail += 1;
-			nr -= 1;
 		}
 	}
 
-- 
1.8.1.2
