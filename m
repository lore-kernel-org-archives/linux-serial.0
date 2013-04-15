From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 07/20] n_tty: Factor signal char handling into separate fn
Date: Mon, 15 Apr 2013 11:32:38 -0400
Message-ID: <1366039971-8770-8-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Reduce the monolithic n_tty_receive_char() complexity; factor the
handling of INTR_CHAR, QUIT_CHAR and SUSP_CHAR into
n_tty_receive_signal_char().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index b379986..e8df595 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1219,6 +1219,26 @@ static inline void n_tty_receive_parity_error(struct tty_struct *tty,
 	wake_up_interruptible(&tty->read_wait);
 }
 
+static void
+n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
+{
+	if (!L_NOFLSH(tty)) {
+		/* flushing needs exclusive termios_rwsem */
+		up_read(&tty->termios_rwsem);
+		n_tty_flush_buffer(tty);
+		tty_driver_flush_buffer(tty);
+		down_read(&tty->termios_rwsem);
+	}
+	if (I_IXON(tty))
+		start_tty(tty);
+	if (L_ECHO(tty)) {
+		echo_char(c, tty);
+		commit_echoes(tty);
+	}
+	isig(signal, tty);
+	return;
+}
+
 /**
  *	n_tty_receive_char	-	perform processing
  *	@tty: terminal device
@@ -1314,30 +1334,14 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	}
 
 	if (L_ISIG(tty)) {
-		int signal;
-		signal = SIGINT;
-		if (c == INTR_CHAR(tty))
-			goto send_signal;
-		signal = SIGQUIT;
-		if (c == QUIT_CHAR(tty))
-			goto send_signal;
-		signal = SIGTSTP;
-		if (c == SUSP_CHAR(tty)) {
-send_signal:
-			if (!L_NOFLSH(tty)) {
-				/* flushing needs exclusive termios_rwsem */
-				up_read(&tty->termios_rwsem);
-				n_tty_flush_buffer(tty);
-				tty_driver_flush_buffer(tty);
-				down_read(&tty->termios_rwsem);
-			}
-			if (I_IXON(tty))
-				start_tty(tty);
-			if (L_ECHO(tty)) {
-				echo_char(c, tty);
-				commit_echoes(tty);
-			}
-			isig(signal, tty);
+		if (c == INTR_CHAR(tty)) {
+			n_tty_receive_signal_char(tty, SIGINT, c);
+			return;
+		} else if (c == QUIT_CHAR(tty)) {
+			n_tty_receive_signal_char(tty, SIGQUIT, c);
+			return;
+		} else if (c == SUSP_CHAR(tty)) {
+			n_tty_receive_signal_char(tty, SIGTSTP, c);
 			return;
 		}
 	}
-- 
1.8.1.2
