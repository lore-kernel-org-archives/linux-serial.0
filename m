From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH RFC 5/6] serial_core: dont assert DTR pin when its being used for flow control
Date: Tue, 30 Sep 2008 14:42:00 -0400
Message-ID: <20080930184157.507877099@ruivo.org>
References: <20080930184155.944902515@ruivo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:54582 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbYI3Smm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2008 14:42:42 -0400
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id 90E07526EB
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2008 14:41:56 -0400 (EDT)
Content-Disposition: inline; filename=serial_core-isolate_dtr_use.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

By default, serial_core will assert DTR for compatibility. In the case DTR is
being used for flow control this should not happen.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

---
 drivers/serial/serial_core.c |   25 ++++++++++++++++++-------
 include/linux/serial_core.h  |   10 +++++++---
 2 files changed, 25 insertions(+), 10 deletions(-)

--- linux-next.orig/drivers/serial/serial_core.c	2008-09-25 11:56:00.000000000 -0400
+++ linux-next/drivers/serial/serial_core.c	2008-09-25 12:02:43.000000000 -0400
@@ -227,7 +227,9 @@ static int uart_startup(struct uart_stat
 			 * port is open and ready to respond.
 			 */
 			if (info->port.tty->termios->c_cflag & CBAUD) {
-				uart_set_mctrl(port, TIOCM_DTR);
+				if (!(info->port.tty->termiox->x_cflag &
+								 DTRXOFF))
+					uart_set_mctrl(port, TIOCM_DTR);
 				uart_flow_input_start(port);
 			}
 		}
@@ -1249,7 +1251,12 @@ static void uart_set_termios(struct tty_
 
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
-		uart_set_mctrl(state->port, TIOCM_DTR);
+		/*
+		 * by default, we keep DTR on all the time, except
+		 * when DTR is being used for flow control
+		 */
+		if (!(tty->termiox->x_cflag & DTRXOFF))
+			uart_set_mctrl(state->port, TIOCM_DTR);
 		if (!test_bit(TTY_THROTTLED, &tty->flags))
 			uart_flow_input_start(state->port);
 	}
@@ -1506,7 +1513,8 @@ static void uart_update_termios(struct u
 		 * And finally enable the DTR signal.
 		 */
 		if (tty->termios->c_cflag & CBAUD) {
-			uart_set_mctrl(port, TIOCM_DTR);
+			if (!(tty->termiox->x_cflag & DTRXOFF))
+				uart_set_mctrl(port, TIOCM_DTR);
 			uart_flow_input_start(port);
 		}
 	}
@@ -1562,7 +1570,8 @@ uart_block_til_ready(struct file *filp, 
 		 * not set RTS here - we want to make sure we catch
 		 * the data from the modem.
 		 */
-		if (info->port.tty->termios->c_cflag & CBAUD)
+		if (info->port.tty->termios->c_cflag & CBAUD &&
+		    !(info->port.tty->termiox->x_cflag & DTRXOFF))
 			uart_set_mctrl(port, TIOCM_DTR);
 
 		/*
@@ -2268,9 +2277,11 @@ uart_configure_port(struct uart_driver *
 		 * keep the DTR setting that is set in uart_set_options()
 		 * We probably don't need a spinlock around this, but
 		 */
-		spin_lock_irqsave(&port->lock, flags);
-		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
-		spin_unlock_irqrestore(&port->lock, flags);
+		if (!(port->flags & UPF_FLOW_DTRXOFF)) {
+			spin_lock_irqsave(&port->lock, flags);
+			port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
+			spin_unlock_irqrestore(&port->lock, flags);
+		}
 
 		/*
 		 * If this driver supports console, and it hasn't been
--- linux-next.orig/include/linux/serial_core.h	2008-09-25 12:00:55.000000000 -0400
+++ linux-next/include/linux/serial_core.h	2008-09-25 12:02:43.000000000 -0400
@@ -581,12 +581,16 @@ uart_insert_char(struct uart_port *port,
 
 int uart_flow_output_allowed(struct uart_port *port);
 
+#define uart_has_hw_flow_control(p) ((p)->flags & (UPF_FLOW_DTRXOFF | \
+						   UPF_FLOW_RTSXOFF | \
+						   UPF_FLOW_DSRXON | \
+						   UPF_FLOW_CTSXON))
 /*
  *	UART_ENABLE_MS - determine if port should enable modem status irqs
  */
-#define UART_ENABLE_MS(port,cflag)	((port)->flags & UPF_HARDPPS_CD || \
-					 (cflag) & CRTSCTS || \
-					 !((cflag) & CLOCAL))
+#define UART_ENABLE_MS(p,cflag)	((p)->flags & UPF_HARDPPS_CD || \
+				 uart_has_hw_flow_control(p) || \
+				 !((cflag) & CLOCAL))
 
 #endif
 

-- 
Aristeu

