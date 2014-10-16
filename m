From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 10/10] tty: Update code comment in __proc_set_tty()
Date: Thu, 16 Oct 2014 14:59:50 -0400
Message-ID: <1413485990-16855-11-git-send-email-peter@hurleysoftware.com>
References: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The session and foreground process group pid references will be
non-NULL if tiocsctty() is stealing the controlling tty from another
session (ie., arg == 1 in tiocsctty()).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7def510..e18491a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -516,8 +516,11 @@ static void __proc_set_tty(struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	/* We should not have a session or pgrp to put here but.... */
 	spin_lock_irqsave(&tty->ctrl_lock, flags);
+	/*
+	 * The session and fg pgrp references will be non-NULL if
+	 * tiocsctty() is stealing the controlling tty
+	 */
 	put_pid(tty->session);
 	put_pid(tty->pgrp);
 	tty->pgrp = get_pid(task_pgrp(current));
-- 
2.1.1
