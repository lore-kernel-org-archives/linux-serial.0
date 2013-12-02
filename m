From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 tty-next 1/8] n_tty: Merge .receive_buf() flavors
Date: Mon,  2 Dec 2013 14:24:41 -0500
Message-ID: <1386012288-5079-2-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
 <1386012288-5079-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386012288-5079-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

N_TTY's direct and flow-controlled flavors of the .receive_buf()
method are nearly identical; fold together.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index d4d63b0..446ccfd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1677,32 +1677,9 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	}
 }
 
-static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
-{
-	int room, n;
-
-	down_read(&tty->termios_rwsem);
-
-	while (1) {
-		room = receive_room(tty);
-		n = min(count, room);
-		if (!n)
-			break;
-		__receive_buf(tty, cp, fp, n);
-		cp += n;
-		if (fp)
-			fp += n;
-		count -= n;
-	}
-
-	tty->receive_room = room;
-	n_tty_check_throttle(tty);
-	up_read(&tty->termios_rwsem);
-}
-
-static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
+static int
+n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
+			 char *fp, int count, int flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	int room, n, rcvd = 0;
@@ -1713,7 +1690,7 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
 		room = receive_room(tty);
 		n = min(count, room);
 		if (!n) {
-			if (!room)
+			if (flow && !room)
 				ldata->no_room = 1;
 			break;
 		}
@@ -1732,6 +1709,18 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
 	return rcvd;
 }
 
+static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+			      char *fp, int count)
+{
+	n_tty_receive_buf_common(tty, cp, fp, count, 0);
+}
+
+static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
+			      char *fp, int count)
+{
+	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
+}
+
 int is_ignored(int sig)
 {
 	return (sigismember(&current->blocked, sig) ||
-- 
1.8.1.2
