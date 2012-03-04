From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 7/9] tty : kill receive_room usage in tty_buffer
Date: Sun,  4 Mar 2012 18:59:18 +0100
Message-ID: <1330883960-8563-8-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43602 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab2CDSAC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 13:00:02 -0500
Received: by mail-we0-f174.google.com with SMTP id x9so1931855wej.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 10:00:01 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/tty/tty_buffer.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 0e0f0fa..8cc7ceb 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -437,17 +437,15 @@ static void flush_to_ldisc(struct work_struct *work)
 			 */
 			if (test_bit(TTY_LDISC_CHANGING, &tty->flags))
 				break;
-			if (!tty->receive_room)
-				break;
-			if (count > tty->receive_room)
-				count = tty->receive_room;
 			char_buf = head->char_buf_ptr + head->read;
 			flag_buf = head->flag_buf_ptr + head->read;
-			head->read += count;
 			spin_unlock_irqrestore(&tty->buf.lock, flags);
-			disc->ops->receive_buf(tty, char_buf,
+			count = disc->ops->receive_buf(tty, char_buf,
 							flag_buf, count);
 			spin_lock_irqsave(&tty->buf.lock, flags);
+			if (count == 0)
+				break;
+			head->read += count;
 		}
 		clear_bit(TTY_FLUSHING, &tty->flags);
 	}
-- 
1.7.9.1

