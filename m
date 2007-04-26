From: Corey Minyard <minyard@acm.org>
Subject: [PATCH 6/8] serial: Add support for doing a console using the poll interface
Date: Thu, 26 Apr 2007 13:53:11 -0500
Message-ID: <20070426185311.GF25521@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta9.adelphia.net ([68.168.78.199]:63085 "EHLO
	mta9.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031450AbXDZSxN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 14:53:13 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Subject: serial: Add support for doing a console using the poll interface

Add code to do most of the serial port console handling in the serial
core layer instead of in each individual driver.  This requires that
the driver implement the poll interface.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/serial/serial_core.c |  196 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 191 insertions(+), 5 deletions(-)

Index: linux-2.6.21/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/serial_core.c
+++ linux-2.6.21/drivers/serial/serial_core.c
@@ -60,6 +60,7 @@ static struct lock_class_key port_lock_k
 #define uart_users(state)	((state)->count + ((state)->info ? (state)->info->blocked_open : 0))
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
+#include <linux/nmi.h>
 #define uart_console(port)	((port)->cons && (port)->cons->index == (port)->line)
 #else
 #define uart_console(port)	(0)
@@ -455,16 +456,22 @@ uart_change_speed(struct uart_state *sta
 static inline void
 __uart_put_char(struct uart_port *port, struct circ_buf *circ, unsigned char c)
 {
+	if (uart_circ_chars_free(circ) != 0) {
+		circ->buf[circ->head] = c;
+		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
+	}
+}
+
+static inline void
+_uart_put_char(struct uart_port *port, struct circ_buf *circ, unsigned char c)
+{
 	unsigned long flags;
 
 	if (!circ->buf)
 		return;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (uart_circ_chars_free(circ) != 0) {
-		circ->buf[circ->head] = c;
-		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
-	}
+	__uart_put_char(port, circ, c);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -472,7 +479,7 @@ static void uart_put_char(struct tty_str
 {
 	struct uart_state *state = tty->driver_data;
 
-	__uart_put_char(state->port, &state->info->xmit, ch);
+	_uart_put_char(state->port, &state->info->xmit, ch);
 }
 
 static void uart_flush_chars(struct tty_struct *tty)
@@ -1933,6 +1940,168 @@ uart_set_options(struct uart_port *port,
 
 	return 0;
 }
+
+static void uartdrv_console_write(struct console *co, const char *s,
+				  unsigned count)
+{
+	struct uart_driver *drv = co->data;
+	struct uart_port *port = drv->pollable_ports[co->index];
+	unsigned long flags, pstate;
+	struct circ_buf *circ;
+	int rv;
+	int locked = 1;
+	int tmout;
+	int free;
+
+	touch_nmi_watchdog();
+
+	if (count == 0)
+		return;
+
+	local_irq_save(flags);
+	if (port->sysrq) {
+		/* serial8250_handle_port() already took the lock */
+		locked = 0;
+	} else if (oops_in_progress) {
+		locked = spin_trylock(&port->lock);
+	} else
+		spin_lock(&port->lock);
+
+	circ = &port->info->xmit;
+
+	rv = port->ops->poll_startup(port, &pstate);
+	if (rv)
+		goto out_err;
+
+	tmout = 10000;
+	while (count > 0) {
+		port->ops->poll(port, UART_POLL_FLAGS_TX);
+
+		free = uart_circ_chars_free(circ);
+
+		if (free) {
+			if (*s == '\n') {
+				if (free < 2)
+					goto do_timer;
+				__uart_put_char(port, circ, '\r');
+				free--;
+			}
+			__uart_put_char(port, circ, *s);
+			tmout = 10000;
+			count--;
+			free--;
+			s++;
+			continue;
+		}
+
+	do_timer:
+		if (--tmout > 0) {
+			udelay(1);
+			continue;
+		}
+
+		if (port->ops->in_flow_control &&
+		                            (port->flags & UPF_CONS_FLOW)) {
+			/* Wait up to 1s for flow control. */
+			tmout = 1000000;
+			while (port->ops->in_flow_control(port)) {
+				if (--tmout == 0)
+					break;
+				udelay(1);
+				touch_nmi_watchdog();
+			}
+		}
+
+		port->ops->poll(port, UART_POLL_FLAGS_TX);
+		if (uart_circ_chars_free(circ) == 0) {
+			/*
+			 * We have timed out this character,
+			 * just go on.
+			 */
+			s++;
+			count--;
+		}
+		tmout = 10000;
+	}
+
+	/*
+	 * All the characters are in the buffer, wait for transmit to
+	 * finish.
+	 */
+
+	tmout = 10000;
+	free = uart_circ_chars_free(circ);
+	while ((free > 0) || !port->ops->tx_empty(port)) {
+		port->ops->poll(port, UART_POLL_FLAGS_TX);
+
+		if (free != uart_circ_chars_free(circ)) {
+			tmout = 10000;
+			free = uart_circ_chars_free(circ);
+			continue;
+		}
+		if (--tmout == 0)
+			break;
+		udelay(1);
+	}
+
+	port->ops->poll_shutdown(port, pstate);
+
+ out_err:
+
+	if (locked)
+		spin_unlock(&port->lock);
+	local_irq_restore(flags);
+}
+
+static char console_buffer[UART_XMIT_SIZE];
+static struct uart_info console_info;
+
+static int uartdrv_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	struct uart_info *info;
+	struct uart_driver *drv = co->data;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int rv;
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index >= drv->nr_pollable)
+		co->index = 0;
+	port = drv->pollable_ports[co->index];
+
+	if (!port || (!port->iobase && !port->membase))
+		return -ENODEV;
+
+	if (port->ops->port_defaults) {
+		rv = port->ops->port_defaults(port, &baud, &parity, &bits,
+					      &flow);
+		if (rv)
+			return rv;
+	}
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	rv = uart_set_options(port, co, baud, parity, bits, flow);
+	if (rv)
+		return rv;
+
+	info = &console_info;
+	port->info = info;
+	info->xmit.buf = console_buffer;
+	info->flags |= UIF_BOOT_ALLOCATED;
+	uart_circ_clear(&info->xmit);
+	init_waitqueue_head(&info->open_wait);
+	init_waitqueue_head(&info->delta_msr_wait);
+	return 0;
+}
 #endif /* CONFIG_SERIAL_CORE_CONSOLE */
 
 static void uart_change_pm(struct uart_state *state, int pm_state)
@@ -2178,6 +2347,18 @@ static const struct tty_operations uart_
  */
 void uart_register_polled(struct uart_driver *drv)
 {
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+	if (drv->nr_pollable && drv->cons) {
+		/* We manage the consoles for this driver. */
+		drv->cons->write = uartdrv_console_write;
+		drv->cons->device = uart_console_device;
+		drv->cons->setup = uartdrv_console_setup;
+		drv->cons->flags = CON_PRINTBUFFER;
+		drv->cons->data = drv;
+		drv->cons->index = -1;
+		register_console(drv->cons);
+	}
+#endif
 }
 
 /**
@@ -2187,6 +2368,11 @@ void uart_register_polled(struct uart_dr
  */
 void uart_unregister_polled(struct uart_driver *drv)
 {
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+	if (drv->nr_pollable && drv->cons) {
+		unregister_console(drv->cons);
+	}
+#endif
 }
 
 /**
