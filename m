From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH v3 6/6] TTY: fix close of uninitialised ports
Date: Thu,  7 Mar 2013 15:55:53 +0100
Message-ID: <1362668153-10972-7-git-send-email-jhovold@gmail.com>
References: <51361724.4050107@suse.cz>
 <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
List-Id: linux-serial@vger.kernel.org

Make sure we do not make tty-driver callbacks or wait for port to drain
on uninitialised ports (e.g. when open failed) in
tty_port_close_start().

No callback, such as flush_buffer or wait_until_sent, needs to be made
on a port that has never been opened. Neither does it make much sense to
add drain delay for an uninitialised port.

Currently a drain delay of up to two seconds could be added when a tty
fails to open.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/tty/tty_port.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 048cc85..d028df3 100644
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
