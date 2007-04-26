From: Corey Minyard <minyard@acm.org>
Subject: [PATCH 2/8] serial: Add a function to abstract the tty code from the drivers
Date: Thu, 26 Apr 2007 13:47:26 -0500
Message-ID: <20070426184726.GB25521@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta16.adelphia.net ([68.168.78.211]:35774 "EHLO
	mta16.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031436AbXDZSr2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 14:47:28 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Subject: serial: Add a function to abstract the tty code from the drivers

Remove the requirement for a serial driver to know about the
tty layer by pulling the tty push into a function in the serial_core.h
file.  Also make the corresponding changes to the 8250 driver.

This is needed for a direct serial interface to be used by IPMI and a
common serial console driver (and probably other things like kgdb).
Since in those cases there is no tty layer, it is best to pull this up
into the serial core and handle not having a tty layer there.  Also,
it seems better if the individual serial drivers didn't need to know
about the tty layer.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/serial/8250.c       |    4 +---
 include/linux/serial_core.h |    7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.21/drivers/serial/8250.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/8250.c
+++ linux-2.6.21/drivers/serial/8250.c
@@ -32,8 +32,6 @@
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
 #include <linux/serial_reg.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
@@ -1355,7 +1353,7 @@ serial8250_handle_port(struct uart_8250_
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	if (recv_ready)
-		tty_flip_buffer_push(up->port.info->tty);
+		uart_push(&up->port);
 
 	if (msr_ready)
 		wake_up_interruptible(&up->port.info->delta_msr_wait);
Index: linux-2.6.21/include/linux/serial_core.h
===================================================================
--- linux-2.6.21.orig/include/linux/serial_core.h
+++ linux-2.6.21/include/linux/serial_core.h
@@ -143,6 +143,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/mutex.h>
 
 struct uart_port;
@@ -522,6 +523,12 @@ uart_insert_char(struct uart_port *port,
 		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
 }
 
+static inline void
+uart_push(struct uart_port *port)
+{
+	tty_flip_buffer_push(port->info->tty);
+}
+
 /*
  *	UART_ENABLE_MS - determine if port should enable modem status irqs
  */
