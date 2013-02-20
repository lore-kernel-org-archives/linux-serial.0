From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 3/4] TTY: clean up port drain-delay handling
Date: Wed, 20 Feb 2013 17:02:51 +0100
Message-ID: <1361376172-31860-4-git-send-email-jhovold@gmail.com>
References: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
 <1361376172-31860-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:59247 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935724Ab3BTQDs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Feb 2013 11:03:48 -0500
In-Reply-To: <1361376172-31860-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Johan Hovold <jhovold@gmail.com>

Move port drain-delay handling to a separate function.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/tty/tty_port.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 506f579..fcb4ccb 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -408,6 +408,20 @@ int tty_port_block_til_ready(struct tty_port *port,
 }
 EXPORT_SYMBOL(tty_port_block_til_ready);
 
+static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
+{
+	unsigned int bps = tty_get_baud_rate(tty);
+	long timeout;
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
@@ -446,17 +460,8 @@ int tty_port_close_start(struct tty_port *port,
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
+	if (port->drain_delay)
+		tty_port_drain_delay(port, tty);
 	/* Flush the ldisc buffering */
 	tty_ldisc_flush(tty);
 
-- 
1.8.1.1

