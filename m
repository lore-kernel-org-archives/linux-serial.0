From: Johan Hovold <jhovold@gmail.com>
Subject: [RFC 3/4] tty: clean up port drain-delay handling
Date: Wed, 13 Feb 2013 18:27:25 +0100
Message-ID: <1360776446-31371-4-git-send-email-jhovold@gmail.com>
References: <20130213142513.GA21078@localhost>
 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:38741 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760179Ab3BMR3J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 12:29:09 -0500
In-Reply-To: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Johan Hovold <jhovold@gmail.com>

Move port drain-delay handling to a separate function.
---
 drivers/tty/tty_port.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ffe3689..0a5e955 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -407,6 +407,23 @@ int tty_port_block_til_ready(struct tty_port *port,
 }
 EXPORT_SYMBOL(tty_port_block_til_ready);
 
+static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
+{
+	unsigned int bps = tty_get_baud_rate(tty);
+	long timeout;
+
+	if (!port->drain_delay)
+		return;
+
+	if (bps > 1200) {
+		timeout = (HZ * 10 * port->drain_delay) / bps;
+		timeout = max_t(long, timeout, HZ / 10);
+	} else {
+		timeout = 2 * HZ;
+	}
+	schedule_timeout_interruptible(timeout);
+}
+
 int tty_port_close_start(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
@@ -445,17 +462,7 @@ int tty_port_close_start(struct tty_port *port,
 	if (test_bit(ASYNCB_INITIALIZED, &port->flags) &&
 			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent_from_close(tty, port->closing_wait);
-	if (port->drain_delay) {
-		unsigned int bps = tty_get_baud_rate(tty);
-		long timeout;
-
-		if (bps > 1200)
-			timeout = max_t(long,
-				(HZ * 10 * port->drain_delay) / bps, HZ / 10);
-		else
-			timeout = 2 * HZ;
-		schedule_timeout_interruptible(timeout);
-	}
+	tty_port_drain_delay(port, tty);
 	/* Flush the ldisc buffering */
 	tty_ldisc_flush(tty);
 
-- 
1.8.1.1

