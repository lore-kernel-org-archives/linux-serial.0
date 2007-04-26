From: Corey Minyard <minyard@acm.org>
Subject: [PATCH 7/8] serial: Add a polled interface to the 8250 driver
Date: Thu, 26 Apr 2007 13:54:11 -0500
Message-ID: <20070426185411.GG25521@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta10.adelphia.net ([68.168.78.202]:65105 "EHLO
	mta10.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031450AbXDZSyN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 14:54:13 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Subject: serial: Add a polled interface to the 8250 driver

Remove the console code from the 8250 driver and add the poll code and
setup to use the console over the polled interface.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/serial/8250.c |  220 +++++++++++++++++++++++++-------------------------
 1 file changed, 112 insertions(+), 108 deletions(-)

Index: linux-2.6.21/drivers/serial/8250.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/8250.c
+++ linux-2.6.21/drivers/serial/8250.c
@@ -1549,9 +1549,14 @@ static unsigned int serial8250_tx_empty(
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long flags;
 	unsigned int ret;
+	unsigned int status;
 
 	spin_lock_irqsave(&up->port.lock, flags);
-	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	status = serial_in(up, UART_LSR);
+	/* If we see a break, record it for the serial console */
+	if (status & UART_LSR_BI)
+		up->lsr_break_flag = UART_LSR_BI;
+	ret = status & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	return ret;
@@ -1612,8 +1617,6 @@ static void serial8250_break_ctl(struct 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 /*
  *	Wait for transmitter & holding register to empty
  */
@@ -2264,6 +2267,72 @@ serial8250_type(struct uart_port *port)
 	return uart_config[type].name;
 }
 
+static unsigned int serial8250_poll(struct uart_port *port, unsigned int flags)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned int status;
+	unsigned int rv = 0;
+
+	status = serial_inp(up, UART_LSR);
+
+	if ((flags & UART_POLL_FLAGS_RX) && (status & UART_LSR_DR)) {
+		if (receive_chars(up, &status))
+			rv |= UART_POLL_RETFLAGS_RX;
+	}
+	if (flags & UART_POLL_FLAGS_MCTRL) {
+		if (check_modem_status(up, NULL))
+			rv |= UART_POLL_RETFLAGS_MCTRL;
+	}
+	if ((flags & UART_POLL_FLAGS_TX) && (status & UART_LSR_THRE)) {
+		struct circ_buf *xmit = uart_get_circ_buf(&up->port);
+
+		if (uart_circ_empty(xmit))
+			goto out;
+
+		do {
+			serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+			xmit->tail = uart_wrap_circ_buf(xmit->tail + 1);
+			up->port.icount.tx++;
+			if (uart_circ_empty(xmit))
+				break;
+			status = serial_inp(up, UART_LSR);
+		} while (status & UART_LSR_THRE);
+	}
+
+ out:
+	return rv;
+}
+
+static int serial8250_poll_startup(struct uart_port *port,
+				   unsigned long *pflags)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *) port;
+
+	*pflags = serial_in(up, UART_IER);
+
+	if (up->capabilities & UART_CAP_UUE)
+		serial_out(up, UART_IER, UART_IER_UUE);
+	else
+		serial_out(up, UART_IER, 0);
+
+	return 0;
+}
+
+static void serial8250_poll_shutdown(struct uart_port *port,
+				     unsigned long pflags)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *) port;
+
+	serial_out(up, UART_IER, pflags);
+}
+
+int serial8250_in_flow_control(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *) port;
+
+	return !(serial_in(up, UART_MSR) & UART_MSR_CTS);
+}
+
 static struct uart_ops serial8250_pops = {
 	.tx_empty	= serial8250_tx_empty,
 	.set_mctrl	= serial8250_set_mctrl,
@@ -2277,6 +2346,10 @@ static struct uart_ops serial8250_pops =
 	.shutdown	= serial8250_shutdown,
 	.set_termios	= serial8250_set_termios,
 	.pm		= serial8250_pm,
+	.poll		= serial8250_poll,
+	.poll_startup	= serial8250_poll_startup,
+	.poll_shutdown	= serial8250_poll_shutdown,
+	.in_flow_control= serial8250_in_flow_control,
 	.type		= serial8250_type,
 	.release_port	= serial8250_release_port,
 	.request_port	= serial8250_request_port,
@@ -2285,6 +2358,7 @@ static struct uart_ops serial8250_pops =
 };
 
 static struct uart_8250_port serial8250_ports[UART_NR];
+static struct uart_port *serial8250_pollable_ports[UART_NR];
 
 static void __init serial8250_isa_init_ports(void)
 {
@@ -2346,108 +2420,10 @@ serial8250_register_ports(struct uart_dr
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-
-static void serial8250_console_putchar(struct uart_port *port, int ch)
-{
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
-
-	wait_for_xmitr(up, UART_LSR_THRE);
-	serial_out(up, UART_TX, ch);
-}
-
-/*
- *	Print a string to the serial port trying not to disturb
- *	any possible real use of the port...
- *
- *	The console_lock must be held when we get here.
- */
-static void
-serial8250_console_write(struct console *co, const char *s, unsigned int count)
-{
-	struct uart_8250_port *up = &serial8250_ports[co->index];
-	unsigned long flags;
-	unsigned int ier;
-	int locked = 1;
-
-	touch_nmi_watchdog();
-
-	local_irq_save(flags);
-	if (up->port.sysrq) {
-		/* serial8250_handle_port() already took the lock */
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = spin_trylock(&up->port.lock);
-	} else
-		spin_lock(&up->port.lock);
-
-	/*
-	 *	First save the IER then disable the interrupts
-	 */
-	ier = serial_in(up, UART_IER);
-
-	if (up->capabilities & UART_CAP_UUE)
-		serial_out(up, UART_IER, UART_IER_UUE);
-	else
-		serial_out(up, UART_IER, 0);
-
-	uart_console_write(&up->port, s, count, serial8250_console_putchar);
-
-	/*
-	 *	Finally, wait for transmitter to become empty
-	 *	and restore the IER
-	 */
-	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_out(up, UART_IER, ier);
-
-	if (locked)
-		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
-}
-
-static int __init serial8250_console_setup(struct console *co, char *options)
-{
-	struct uart_port *port;
-	int baud = 9600;
-	int bits = 8;
-	int parity = 'n';
-	int flow = 'n';
-
-	/*
-	 * Check whether an invalid uart number has been specified, and
-	 * if so, search for the first available port that does have
-	 * console support.
-	 */
-	if (co->index >= nr_uarts)
-		co->index = 0;
-	port = &serial8250_ports[co->index].port;
-	if (!port->iobase && !port->membase)
-		return -ENODEV;
-
-	if (options)
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
-
-	return uart_set_options(port, co, baud, parity, bits, flow);
-}
-
-static struct uart_driver serial8250_reg;
 static struct console serial8250_console = {
-	.name		= "ttyS",
-	.write		= serial8250_console_write,
-	.device		= uart_console_device,
-	.setup		= serial8250_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &serial8250_reg,
+	.name		= "ttyS"
 };
 
-static int __init serial8250_console_init(void)
-{
-	serial8250_isa_init_ports();
-	register_console(&serial8250_console);
-	return 0;
-}
-console_initcall(serial8250_console_init);
-
 static int __init find_port(struct uart_port *p)
 {
 	int line;
@@ -2496,6 +2472,36 @@ static struct uart_driver serial8250_reg
 	.cons			= SERIAL8250_CONSOLE,
 };
 
+static int __init serial8250_polled_init(void)
+{
+	int i;
+	static int initialized = 0;
+
+	if (initialized)
+		return 0;
+	initialized = 1;
+
+	if (nr_uarts > UART_NR)
+		nr_uarts = UART_NR;
+
+	serial8250_isa_init_ports();
+
+	for (i = 0; i < NR_IRQS; i++)
+		spin_lock_init(&irq_lists[i].lock);
+
+	for (i = 0; i < nr_uarts; i++) {
+		serial8250_ports[i].port.ops = &serial8250_pops;
+		serial8250_pollable_ports[i] = &serial8250_ports[i].port;
+	}
+	serial8250_reg.pollable_ports = serial8250_pollable_ports;
+	serial8250_reg.nr_pollable = nr_uarts;
+
+	uart_register_polled(&serial8250_reg);
+
+	return 0;
+}
+console_initcall(serial8250_polled_init);
+
 /*
  * early_serial_setup - early registration for 8250 ports
  *
@@ -2747,17 +2753,13 @@ EXPORT_SYMBOL(serial8250_unregister_port
 
 static int __init serial8250_init(void)
 {
-	int ret, i;
-
-	if (nr_uarts > UART_NR)
-		nr_uarts = UART_NR;
+	int ret;
 
 	printk(KERN_INFO "Serial: 8250/16550 driver $Revision: 1.90 $ "
 		"%d ports, IRQ sharing %sabled\n", nr_uarts,
 		share_irqs ? "en" : "dis");
 
-	for (i = 0; i < NR_IRQS; i++)
-		spin_lock_init(&irq_lists[i].lock);
+	serial8250_polled_init();
 
 	ret = uart_register_driver(&serial8250_reg);
 	if (ret)
@@ -2804,6 +2806,8 @@ static void __exit serial8250_exit(void)
 	platform_device_unregister(isa_dev);
 
 	uart_unregister_driver(&serial8250_reg);
+
+	uart_unregister_polled(&serial8250_reg);
 }
 
 module_init(serial8250_init);
