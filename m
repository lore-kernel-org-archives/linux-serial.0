From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 24/48] Serial: Remove unused code.
Date: Mon, 23 May 2011 12:10:30 -0700
Message-ID: <1306177854-18172-24-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47317 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTLK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:10 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Govindraj.R <govindraj.raja@ti.com>

Remove stale code in serial_core layer.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1d7aedc..55965d5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1242,17 +1242,6 @@ static void uart_set_termios(struct tty_struct *tty,
 		}
 		spin_unlock_irqrestore(&state->uart_port->lock, flags);
 	}
-#if 0
-	/*
-	 * No need to wake up processes in open wait, since they
-	 * sample the CLOCAL flag once, and don't recheck it.
-	 * XXX  It's not clear whether the current behavior is correct
-	 * or not.  Hence, this may change.....
-	 */
-	if (!(old_termios->c_cflag & CLOCAL) &&
-	    (tty->termios->c_cflag & CLOCAL))
-		wake_up_interruptible(&state->uart_port.open_wait);
-#endif
 }
 
 /*
-- 
1.7.4.2

