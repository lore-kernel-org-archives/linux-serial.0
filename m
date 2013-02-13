From: Johan Hovold <jhovold@gmail.com>
Subject: [RFC 2/4] tty: fix DTR/RTS not being dropped on hang up
Date: Wed, 13 Feb 2013 18:27:24 +0100
Message-ID: <1360776446-31371-3-git-send-email-jhovold@gmail.com>
References: <20130213142513.GA21078@localhost>
 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:49232 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760180Ab3BMR3K (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 12:29:10 -0500
In-Reply-To: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Johan Hovold <jhovold@gmail.com>

Move HUPCL handling to port shutdown so that DTR/RTS is dropped also on
hang up.

Currently a hung up port will return immediately from
tty_port_close_start leaving DTR/RTS unchanged.
---
 drivers/tty/tty_port.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 57a061e..ffe3689 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -198,11 +198,20 @@ EXPORT_SYMBOL(tty_port_tty_set);
 
 static void tty_port_shutdown(struct tty_port *port)
 {
+	struct tty_struct *tty = port->tty;
+
 	mutex_lock(&port->mutex);
 	if (port->console)
 		goto out;
 
 	if (test_and_clear_bit(ASYNCB_INITIALIZED, &port->flags)) {
+		/*
+		 * Drop DTR/RTS if HUPCL is set. This causes any attached
+		 * modem to hang up the line.
+		 */
+		if (!tty || tty->termios.c_cflag & HUPCL)
+			tty_port_lower_dtr_rts(port);
+
 		if (port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
@@ -225,15 +234,13 @@ void tty_port_hangup(struct tty_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	port->count = 0;
 	port->flags &= ~ASYNC_NORMAL_ACTIVE;
-	if (port->tty) {
+	if (port->tty)
 		set_bit(TTY_IO_ERROR, &port->tty->flags);
-		tty_kref_put(port->tty);
-	}
-	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_shutdown(port);
+	tty_port_tty_set(port, NULL);
 	wake_up_interruptible(&port->open_wait);
 	wake_up_interruptible(&port->delta_msr_wait);
-	tty_port_shutdown(port);
 }
 EXPORT_SYMBOL(tty_port_hangup);
 
@@ -452,11 +459,6 @@ int tty_port_close_start(struct tty_port *port,
 	/* Flush the ldisc buffering */
 	tty_ldisc_flush(tty);
 
-	/* Drop DTR/RTS if HUPCL is set. This causes any attached modem to
-	   hang up the line */
-	if (tty->termios.c_cflag & HUPCL)
-		tty_port_lower_dtr_rts(port);
-
 	/* Don't call port->drop for the last reference. Callers will want
 	   to drop the last active reference in ->shutdown() or the tty
 	   shutdown path */
-- 
1.8.1.1

