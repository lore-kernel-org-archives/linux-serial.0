From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC v2 2/4] tty: fix DTR/RTS not being dropped on hang up
Date: Wed, 13 Feb 2013 19:06:52 +0100
Message-ID: <1360778812-920-1-git-send-email-jhovold@gmail.com>
References: <1360776446-31371-3-git-send-email-jhovold@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360776446-31371-3-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Move HUPCL handling to port shutdown so that DTR/RTS is dropped also on
hang up.

Currently a hung up port will return immediately from
tty_port_close_start leaving DTR/RTS unchanged.
---

v2: fix tty refcounting in shutdown

 drivers/tty/tty_port.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 57a061e..506f579 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -198,15 +198,25 @@ EXPORT_SYMBOL(tty_port_tty_set);
 
 static void tty_port_shutdown(struct tty_port *port)
 {
+	struct tty_struct *tty = tty_port_tty_get(port);
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
 out:
+	tty_kref_put(tty);
 	mutex_unlock(&port->mutex);
 }
 
@@ -225,15 +235,13 @@ void tty_port_hangup(struct tty_port *port)
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
 
@@ -452,11 +460,6 @@ int tty_port_close_start(struct tty_port *port,
 	/* Flush the ldisc buffering */
 	tty_ldisc_flush(tty);
 
-	/* Drop DTR/RTS if HUPCL is set. This causes any attached modem to
-	   hang up the line */
-	if (tty->termios.c_cflag & HUPCL)
-		tty_port_lower_dtr_rts(port);
