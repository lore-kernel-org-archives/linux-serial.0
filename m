From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 23/75] n_tty: Output bells immediately on a full buffer
Date: Fri, 02 Jan 2009 13:43:40 +0000
Message-ID: <20090102134338.13472.60963.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60332 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756084AbZABNnf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:43:35 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Joe Peterson <joe@skyrush.com>

This patch causes "bell" (^G) characters (invoked when the input buffer
is full) to be immediately output rather than filling the echo buffer.

This is especially a problem when the tty is stopped and buffers fill, since
the bells do not serve their purpose of immediate notification that the
buffer cannot take further input, and they will flush all at once when the
tty is restarted.

Signed-off-by: Joe Peterson <joe@skyrush.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/n_tty.c |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)


diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index 4b1e96b..3922a08 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -872,7 +872,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 
 	/* FIXME: locking needed ? */
 	if (tty->read_head == tty->canon_head) {
-		/* echo_char_raw('\a', tty); */ /* what do you think? */
+		/* process_output('\a', tty); */ /* what do you think? */
 		return;
 	}
 	if (c == ERASE_CHAR(tty))
@@ -1148,10 +1148,8 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
 		if (tty->read_cnt >= (N_TTY_BUF_SIZE - parmrk - 1)) {
 			/* beep if no space */
-			if (L_ECHO(tty)) {
-				echo_char_raw('\a', tty);
-				process_echoes(tty);
-			}
+			if (L_ECHO(tty))
+				process_output('\a', tty);
 			return;
 		}
 		if (L_ECHO(tty)) {
@@ -1255,10 +1253,8 @@ send_signal:
 		}
 		if (c == '\n') {
 			if (tty->read_cnt >= N_TTY_BUF_SIZE) {
-				if (L_ECHO(tty)) {
-					echo_char_raw('\a', tty);
-					process_echoes(tty);
-				}
+				if (L_ECHO(tty))
+					process_output('\a', tty);
 				return;
 			}
 			if (L_ECHO(tty) || L_ECHONL(tty)) {
@@ -1280,10 +1276,8 @@ send_signal:
 			parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty))
 				 ? 1 : 0;
 			if (tty->read_cnt >= (N_TTY_BUF_SIZE - parmrk)) {
-				if (L_ECHO(tty)) {
-					echo_char_raw('\a', tty);
-					process_echoes(tty);
-				}
+				if (L_ECHO(tty))
+					process_output('\a', tty);
 				return;
 			}
 			/*
@@ -1320,10 +1314,8 @@ handle_newline:
 	parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
 	if (tty->read_cnt >= (N_TTY_BUF_SIZE - parmrk - 1)) {
 		/* beep if no space */
-		if (L_ECHO(tty)) {
-			echo_char_raw('\a', tty);
-			process_echoes(tty);
-		}
+		if (L_ECHO(tty))
+			process_output('\a', tty);
 		return;
 	}
 	if (L_ECHO(tty)) {

