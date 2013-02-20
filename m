From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] TTY: fix close of uninitialised ports
Date: Wed, 20 Feb 2013 17:02:52 +0100
Message-ID: <1361376172-31860-5-git-send-email-jhovold@gmail.com>
References: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
 <1361376172-31860-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361376172-31860-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Make sure we do not make tty-driver callbacks or wait for port to drain
on uninitialised ports (e.g. when open failed) in
tty_port_close_start().

No callback, such as flush_buffer or wait_until_sent, needs to be made
on a port that has never been opened. Neither does it make much sense to
add drain delay for an uninitialised port.

Currently a drain delay of up to two seconds could be added when a tty
fails to open.

Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/tty_port.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index fcb4ccb..2ff454c 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -454,14 +454,16 @@ int tty_port_close_start(struct tty_port *port,
 	set_bit(ASYNCB_CLOSING, &port->flags);
 	tty->closing = 1;
 	spin_unlock_irqrestore(&port->lock, flags);
-	/* Don't block on a stalled port, just pull the chain */
-	if (tty->flow_stopped)
-		tty_driver_flush_buffer(tty);
-	if (test_bit(ASYNCB_INITIALIZED, &port->flags) &&
-			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent_from_close(tty, port->closing_wait);
-	if (port->drain_delay)
-		tty_port_drain_delay(port, tty);
+
+	if (test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+		/* Don't block on a stalled port, just pull the chain */
+		if (tty->flow_stopped)
+			tty_driver_flush_buffer(tty);
+		if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+			tty_wait_until_sent_from_close(tty, port->closing_wait);
+		if (port->drain_delay)
+			tty_port_drain_delay(port, tty);
+	}
 	/* Flush the ldisc buffering */
 	tty_ldisc_flush(tty);
 
-- 
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
