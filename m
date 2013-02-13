From: Johan Hovold <jhovold@gmail.com>
Subject: [RFC 4/4] tty: fix close of uninitialised ports
Date: Wed, 13 Feb 2013 18:27:26 +0100
Message-ID: <1360776446-31371-5-git-send-email-jhovold@gmail.com>
References: <20130213142513.GA21078@localhost>
 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:48943 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760182Ab3BMR3K (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 12:29:10 -0500
In-Reply-To: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Johan Hovold <jhovold@gmail.com>

Make sure we do not make tty driver callbacks or wait for port to drain
on uninitialised ports (e.g. when open failed) in
tty_port_close_start().

No callbacks should be made on a port that has never been opened.
Neither does it make any sense to add drain delay for an uninitialised
port.

Currently a drain delay of up to two seconds could be added when a tty
fails to open.
---
 drivers/tty/tty_port.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 0a5e955..46edb98 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -456,13 +456,15 @@ int tty_port_close_start(struct tty_port *port,
 	set_bit(ASYNCB_CLOSING, &port->flags);
 	tty->closing = 1;
 	spin_unlock_irqrestore(&port->lock, flags);
-	/* Don't block on a stalled port, just pull the chain */
-	if (tty->flow_stopped)
-		tty_driver_flush_buffer(tty);
-	if (test_bit(ASYNCB_INITIALIZED, &port->flags) &&
-			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent_from_close(tty, port->closing_wait);
-	tty_port_drain_delay(port, tty);
+
+	if (test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+		/* Don't block on a stalled port, just pull the chain */
+		if (tty->flow_stopped)
+			tty_driver_flush_buffer(tty);
+		if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+			tty_wait_until_sent_from_close(tty, port->closing_wait);
+		tty_port_drain_delay(port, tty);
+	}
 	/* Flush the ldisc buffering */
 	tty_ldisc_flush(tty);
 
-- 
1.8.1.1

