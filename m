From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH v2 4/4] TTY: fix close of uninitialised ports
Date: Tue, 26 Feb 2013 12:14:32 +0100
Message-ID: <1361877272-6074-5-git-send-email-jhovold@gmail.com>
References: <1361877272-6074-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55819 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3BZLRL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2013 06:17:11 -0500
In-Reply-To: <1361877272-6074-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Johan Hovold <jhovold@gmail.com>

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
index ce4b591..e73ac90 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -451,14 +451,16 @@ int tty_port_close_start(struct tty_port *port,
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

