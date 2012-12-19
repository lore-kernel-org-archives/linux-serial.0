From: Ilya Zykov <ilya@ilyx.ru>
Subject: [PATCH] tty: Fix unreasonable write toward closed pty.
Date: Wed, 19 Dec 2012 22:59:19 +0400
Message-ID: <50D20E87.9060403@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:60429 "EHLO
	95-31-19-74.broadband.corbina.ru" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187Ab2LSS7W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Dec 2012 13:59:22 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Sasha Levin <levinsasha928@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

We should not write toward the closed pty. 
Now it happens, if one side close last file descriptor,
and other side in this moment write to it.
It also prevents scheduling unnecessary work.

Signed-off-by: Ilya Zykov <ilya@ilyx.ru>
---
 drivers/tty/pty.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index a82b399..1ce1362 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -116,6 +116,8 @@ static int pty_space(struct tty_struct *to)
 
 static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 {
+	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
+		return -EIO;
 	struct tty_struct *to = tty->link;
 
 	if (tty->stopped)
