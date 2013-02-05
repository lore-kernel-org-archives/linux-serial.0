From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] pty: Remove redundant itty reset
Date: Tue,  5 Feb 2013 16:08:50 -0500
Message-ID: <1360098530-7018-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:42208 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756073Ab3BEVKL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Feb 2013 16:10:11 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

port->itty has already been reset by release_tty() before
pty_cleanup() is called.

Call stack:
release_tty()
  tty_kref_put()
    queue_release_one_tty()
      release_one_tty() : workqueue
        tty->ops->cleanup()
          pty_cleanup()

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index c24b4db..71e456a 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -413,7 +413,6 @@ static void pty_unix98_shutdown(struct tty_struct *tty)
 
 static void pty_cleanup(struct tty_struct *tty)
 {
-	tty->port->itty = NULL;
 	tty_port_put(tty->port);
 }
 
-- 
1.8.1.2

