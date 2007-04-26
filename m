From: Corey Minyard <minyard@acm.org>
Subject: [PATCH 3/8] serial: Add an modem status change abstraction
Date: Thu, 26 Apr 2007 13:48:22 -0500
Message-ID: <20070426184822.GC25521@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta11.adelphia.net ([68.168.78.205]:46539 "EHLO
	mta11.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031393AbXDZSsY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 14:48:24 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Subject: serial: Add an modem status change abstraction

Add a uart_msr_change function for reporting when modem status line
change, instead of driectly waking up the wait queue.

This is needed for a direct serial interface to be used by IPMI and a
common serial console driver (and probably other things like kgdb).
In that case, they may need to know about modem status, but since they
may be on a polled interface at panic time, a wait queue will not be
helpful.  This allows the handling of modem status for a direct serial
interface to be done in the serial core code.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/serial/8250.c       |    2 +-
 include/linux/serial_core.h |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.21/drivers/serial/8250.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/8250.c
+++ linux-2.6.21/drivers/serial/8250.c
@@ -1356,7 +1356,7 @@ serial8250_handle_port(struct uart_8250_
 		uart_push(&up->port);
 
 	if (msr_ready)
-		wake_up_interruptible(&up->port.info->delta_msr_wait);
+		uart_msr_change(&up->port);
 
 	if (xmit_ready)
 		uart_write_wakeup(&up->port);
Index: linux-2.6.21/include/linux/serial_core.h
===================================================================
--- linux-2.6.21.orig/include/linux/serial_core.h
+++ linux-2.6.21/include/linux/serial_core.h
@@ -529,6 +529,12 @@ uart_push(struct uart_port *port)
 	tty_flip_buffer_push(port->info->tty);
 }
 
+static inline void
+uart_msr_change(struct uart_port *port)
+{
+	wake_up_interruptible(&port->info->delta_msr_wait);
+}
+
 /*
  *	UART_ENABLE_MS - determine if port should enable modem status irqs
  */
