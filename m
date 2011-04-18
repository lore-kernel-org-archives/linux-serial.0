From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] Serial: Remove unused code.
Date: Mon, 18 Apr 2011 20:27:35 +0530
Message-ID: <1303138655-1127-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53003 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab1DRO4l (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Apr 2011 10:56:41 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Remove stale code in serial_core layer.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/serial_core.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 733fe8e..e3e2026 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1240,17 +1240,6 @@ static void uart_set_termios(struct tty_struct *tty,
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
1.7.1

