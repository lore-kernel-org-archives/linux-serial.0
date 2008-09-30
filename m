From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH RFC 3/6] serial_core: use port flags to determine hardware flow control
Date: Tue, 30 Sep 2008 14:41:58 -0400
Message-ID: <20080930184157.012724464@ruivo.org>
References: <20080930184155.944902515@ruivo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:54569 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbYI3SmS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2008 14:42:18 -0400
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id 202C6526E9
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2008 14:41:56 -0400 (EDT)
Content-Disposition: inline; filename=serial_core-use_separated_pins_for_flow_control.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch makes serial_core to use hardware flow port flags instead of using
the fixed RTS/CTS.

Signed-off-by: Aristeu Rozanski <aris@ruivo.org>

---
 drivers/serial/serial_core.c |  154 ++++++++++++++++++++++++++++++++++++-------
 include/linux/serial_core.h  |    2 
 2 files changed, 133 insertions(+), 23 deletions(-)

--- linux-next.orig/drivers/serial/serial_core.c	2008-09-25 11:50:49.000000000 -0400
+++ linux-next/drivers/serial/serial_core.c	2008-09-25 11:56:00.000000000 -0400
@@ -133,6 +133,49 @@ uart_update_mctrl(struct uart_port *port
 #define uart_set_mctrl(port, set)	uart_update_mctrl(port, set, 0)
 #define uart_clear_mctrl(port, clear)	uart_update_mctrl(port, 0, clear)
 
+static void uart_flow_input_start(struct uart_port *port)
+{
+	unsigned int bit;
+
+	if (port->flags & UPF_FLOW_RTSXOFF)
+		bit = TIOCM_RTS;
+	else if (port->flags & UPF_FLOW_DTRXOFF)
+		bit = TIOCM_DTR;
+	else
+		return;
+
+	uart_set_mctrl(port, bit);
+}
+
+static void uart_flow_input_stop(struct uart_port *port)
+{
+	unsigned int bit;
+
+	if (port->flags & UPF_FLOW_RTSXOFF)
+		bit = TIOCM_RTS;
+	else if (port->flags & UPF_FLOW_DTRXOFF)
+		bit = TIOCM_DTR;
+	else
+		return;
+
+	uart_clear_mctrl(port, bit);
+}
+
+int uart_flow_output_allowed(struct uart_port *port)
+{
+	unsigned int bit;
+
+	if (port->flags & UPF_FLOW_CTSXON)
+		bit = TIOCM_CTS;
+	else if (port->flags & UPF_FLOW_DSRXON)
+		bit = TIOCM_DSR;
+	else
+		return 1;
+
+	return port->ops->get_mctrl(port) & bit;
+}
+EXPORT_SYMBOL(uart_flow_output_allowed);
+
 /*
  * Startup the port.  This will be called once per open.  All calls
  * will be serialised by the per-port mutex.
@@ -183,16 +226,16 @@ static int uart_startup(struct uart_stat
 			 * Setup the RTS and DTR signals once the
 			 * port is open and ready to respond.
 			 */
-			if (info->port.tty->termios->c_cflag & CBAUD)
-				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+			if (info->port.tty->termios->c_cflag & CBAUD) {
+				uart_set_mctrl(port, TIOCM_DTR);
+				uart_flow_input_start(port);
+			}
 		}
 
-		if (info->flags & UIF_CTS_FLOW) {
-			spin_lock_irq(&port->lock);
-			if (!(port->ops->get_mctrl(port) & TIOCM_CTS))
-				info->port.tty->hw_stopped = 1;
-			spin_unlock_irq(&port->lock);
-		}
+		spin_lock_irq(&port->lock);
+		if (!uart_flow_output_allowed(port))
+			info->port.tty->hw_stopped = 1;
+		spin_unlock_irq(&port->lock);
 
 		info->flags |= UIF_INITIALIZED;
 
@@ -609,8 +652,7 @@ static void uart_throttle(struct tty_str
 	if (I_IXOFF(tty))
 		uart_send_xchar(tty, STOP_CHAR(tty));
 
-	if (tty->termios->c_cflag & CRTSCTS)
-		uart_clear_mctrl(state->port, TIOCM_RTS);
+	uart_flow_input_stop(state->port);
 }
 
 static void uart_unthrottle(struct tty_struct *tty)
@@ -625,8 +667,7 @@ static void uart_unthrottle(struct tty_s
 			uart_send_xchar(tty, START_CHAR(tty));
 	}
 
-	if (tty->termios->c_cflag & CRTSCTS)
-		uart_set_mctrl(port, TIOCM_RTS);
+	uart_flow_input_start(port);
 }
 
 static int uart_get_info(struct uart_state *state,
@@ -1208,25 +1249,33 @@ static void uart_set_termios(struct tty_
 
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
-		unsigned int mask = TIOCM_DTR;
-		if (!(cflag & CRTSCTS) ||
-		    !test_bit(TTY_THROTTLED, &tty->flags))
-			mask |= TIOCM_RTS;
-		uart_set_mctrl(state->port, mask);
+		uart_set_mctrl(state->port, TIOCM_DTR);
+		if (!test_bit(TTY_THROTTLED, &tty->flags))
+			uart_flow_input_start(state->port);
 	}
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
 		spin_lock_irqsave(&state->port->lock, flags);
-		tty->hw_stopped = 0;
-		__uart_start(tty);
+		tty->termiox->x_cflag &= ~(RTSXOFF | CTSXON);
+		state->port->flags &= ~(UPF_FLOW_RTSXOFF | UPF_FLOW_CTSXON);
+		if (uart_flow_output_allowed(state->port)) {
+			tty->hw_stopped = 0;
+			__uart_start(tty);
+		}
 		spin_unlock_irqrestore(&state->port->lock, flags);
 	}
 
 	/* Handle turning on CRTSCTS */
 	if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
 		spin_lock_irqsave(&state->port->lock, flags);
-		if (!(state->port->ops->get_mctrl(state->port) & TIOCM_CTS)) {
+		tty->termiox->x_cflag |= (RTSXOFF | CTSXON);
+		state->port->flags |= (UPF_FLOW_RTSXOFF | UPF_FLOW_CTSXON);
+		/* not supported right now */
+		tty->termiox->x_cflag &= ~(DTRXOFF | DSRXON);
+		state->port->flags &= ~(UPF_FLOW_DTRXOFF | UPF_FLOW_DSRXON);
+
+		if (!uart_flow_output_allowed(state->port)) {
 			tty->hw_stopped = 1;
 			state->port->ops->stop_tx(state->port);
 		}
@@ -1454,10 +1503,12 @@ static void uart_update_termios(struct u
 		uart_change_speed(state, NULL);
 
 		/*
-		 * And finally enable the RTS and DTR signals.
+		 * And finally enable the DTR signal.
 		 */
-		if (tty->termios->c_cflag & CBAUD)
-			uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+		if (tty->termios->c_cflag & CBAUD) {
+			uart_set_mctrl(port, TIOCM_DTR);
+			uart_flow_input_start(port);
+		}
 	}
 }
 
@@ -2295,9 +2346,66 @@ static void uart_poll_put_char(struct tt
 #ifdef TCSETX
 static int uart_set_termiox(struct tty_struct *tty, struct termiox *new)
 {
+	struct uart_state *state = tty->driver_data;
+	struct ktermios old_termios;
+	unsigned long flags;
+
+	if (((new->x_cflag & RTSXOFF) && (new->x_cflag & DTRXOFF)) ||
+	    ((new->x_cflag & CTSXON) && (new->x_cflag & DSRXON)))
+		/* not supported (yet?) */
+		return 1;
+
+	/* saving current settings */
+	memcpy(&old_termios, tty->termios, sizeof(old_termios));
+
+	/* stop input flow control */
+	uart_flow_input_stop(state->port);
+
+	/* import the settings */
 	tty->termiox->x_cflag = new->x_cflag &
 				(RTSXOFF | CTSXON | DTRXOFF | DSRXON);
 
+	state->port->flags = 0;
+	if (new->x_cflag & RTSXOFF)
+		state->port->flags |= UPF_FLOW_RTSXOFF;
+	if (new->x_cflag & CTSXON)
+		state->port->flags |= UPF_FLOW_CTSXON;
+	if (new->x_cflag & DTRXOFF)
+		state->port->flags |= UPF_FLOW_DTRXOFF;
+	if (new->x_cflag & DSRXON)
+		state->port->flags |= UPF_FLOW_DSRXON;
+	if (new->x_cflag != (RTSXOFF | CTSXON))
+		tty->termios->c_cflag &= ~CRTSCTS;
+
+	/*
+	 * we need to call uart_change_speed() to propagate the changes like
+	 * disabling CRTSCTS and enabling/disabling interrupts
+	 */
+	uart_change_speed(state, &old_termios);
+
+	/* and restart it if it's possible */
+	if ((tty->termios->c_cflag & CBAUD) &&
+	    !(test_bit(TTY_THROTTLED, &tty->flags)))
+		uart_flow_input_start(state->port);
+
+	/*
+	 * if the TX wasn't enabled before and now it's possible to transmit
+	 * due the changes, do it
+	 */
+	if (tty->hw_stopped && uart_flow_output_allowed(state->port)) {
+		spin_lock_irqsave(&state->port->lock, flags);
+		tty->hw_stopped = 0;
+		__uart_start(tty);
+		spin_unlock_irqrestore(&state->port->lock, flags);
+	} else if (!tty->hw_stopped) {
+		spin_lock_irqsave(&state->port->lock, flags);
+		if (!uart_flow_output_allowed(state->port)) {
+			tty->hw_stopped = 1;
+			state->port->ops->stop_tx(state->port);
+		}
+		spin_unlock_irqrestore(&state->port->lock, flags);
+	}
+
 	return 0;
 }
 #endif
--- linux-next.orig/include/linux/serial_core.h	2008-09-25 11:53:57.000000000 -0400
+++ linux-next/include/linux/serial_core.h	2008-09-25 11:56:00.000000000 -0400
@@ -558,6 +558,8 @@ uart_insert_char(struct uart_port *port,
 		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
 }
 
+int uart_flow_output_allowed(struct uart_port *port);
+
 /*
  *	UART_ENABLE_MS - determine if port should enable modem status irqs
  */

-- 
Aristeu

