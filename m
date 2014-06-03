From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: core: Make enable_ms() optional
Date: Tue,  3 Jun 2014 18:54:43 +0400
Message-ID: <1401807284-23811-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp25.mail.ru ([94.100.181.180]:36086 "EHLO smtp25.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080AbaFCOyy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jun 2014 10:54:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch makes enable_ms() optional, so we can eliminate a lot of
empty enable_ms() implementations from driver code.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/serial_core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index fbf6c5a..a0e2f9d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1050,6 +1050,15 @@ static int uart_do_autoconfig(struct tty_struct *tty,struct uart_state *state)
 	return ret;
 }
 
+static void uart_enable_ms(struct uart_port *uport)
+{
+	/*
+	 * Force modem status interrupts on
+	 */
+	if (uport->ops->enable_ms)
+		uport->ops->enable_ms(uport);
+}
+
 /*
  * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
  * - mask passed in arg for lines of interest
@@ -1073,11 +1082,7 @@ uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	 */
 	spin_lock_irq(&uport->lock);
 	memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
-
-	/*
-	 * Force modem status interrupts on
-	 */
-	uport->ops->enable_ms(uport);
+	uart_enable_ms(uport);
 	spin_unlock_irq(&uport->lock);
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
@@ -1508,7 +1513,7 @@ static int uart_carrier_raised(struct tty_port *port)
 	struct uart_port *uport = state->uart_port;
 	int mctrl;
 	spin_lock_irq(&uport->lock);
-	uport->ops->enable_ms(uport);
+	uart_enable_ms(uport);
 	mctrl = uport->ops->get_mctrl(uport);
 	spin_unlock_irq(&uport->lock);
 	if (mctrl & TIOCM_CAR)
-- 
1.8.5.5

