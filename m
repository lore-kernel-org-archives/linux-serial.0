From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 4/4] pty: Ignore slave open count for master pty open
Date: Wed, 30 Jan 2013 12:43:52 -0500
Message-ID: <1359567832-25318-5-git-send-email-peter@hurleysoftware.com>
References: <1359567832-25318-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:37335 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756327Ab3A3RqZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2013 12:46:25 -0500
In-Reply-To: <1359567832-25318-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Multiple slave pty opens may be performed in parallel with the
master open. Of course, all the slave opens will fail because the
master pty is still locked but during this time the slave pty
count will be artificially greater than 1. This is should not
cause the master pty open to fail.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 6eb3e80..7a18600 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -256,7 +256,7 @@ static int pty_open(struct tty_struct *tty, struct file *filp)
 		goto out;
 	if (test_bit(TTY_PTY_LOCK, &tty->link->flags))
 		goto out;
-	if (tty->link->count != 1)
+	if (tty->driver->subtype == PTY_TYPE_SLAVE && tty->link->count != 1)
 		goto out;
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
-- 
1.8.1.1

