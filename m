From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 04/10] uml: Fix unsafe pid reference to foreground process group
Date: Thu, 16 Oct 2014 14:59:44 -0400
Message-ID: <1413485990-16855-5-git-send-email-peter@hurleysoftware.com>
References: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-serial@vger.kernel.org

Although the tty core maintains a pid reference for the foreground
process group, if the foreground process group is changed that
pid reference is dropped. Thus, the pid reference used for signalling
could become stale.

Safely obtain a pid reference to the foreground process group and
release the reference after signalling is complete.

cc: Jeff Dike <jdike@addtoit.com>
cc: Richard Weinberger <richard@nod.at>
cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 arch/um/drivers/line.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 8035145..6208702 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -632,6 +632,7 @@ static irqreturn_t winch_interrupt(int irq, void *data)
 	int fd = winch->fd;
 	int err;
 	char c;
+	struct pid *pgrp;
 
 	if (fd != -1) {
 		err = generic_read(fd, &c, NULL);
@@ -657,7 +658,10 @@ static irqreturn_t winch_interrupt(int irq, void *data)
 		if (line != NULL) {
 			chan_window_size(line, &tty->winsize.ws_row,
 					 &tty->winsize.ws_col);
-			kill_pgrp(tty->pgrp, SIGWINCH, 1);
+			pgrp = tty_get_pgrp(tty);
+			if (pgrp)
+				kill_pgrp(pgrp, SIGWINCH, 1);
+			put_pid(pgrp);
 		}
 		tty_kref_put(tty);
 	}
-- 
2.1.1
