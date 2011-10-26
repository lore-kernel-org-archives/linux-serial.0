From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/79] tty: serial8250: allow platforms to override irq handler
Date: Wed, 26 Oct 2011 14:12:21 +0200
Message-ID: <1319631204-23262-16-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMNe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:34 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jamie Iles <jamie@jamieiles.com>

Some ports (e.g. Synopsys DesignWare 8250) have special requirements for
handling the interrupts.  Allow these platforms to specify their own
interrupt handler that will override the default.
serial8250_handle_irq() is provided so that platforms can extend the IRQ
handler rather than completely replacing it.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250.c   |   39 +++++++++++++++++++++++++++++++++++----
 include/linux/serial_8250.h |    2 ++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index f2dfec8..833e011 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -509,6 +509,8 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 	outb(value, p->iobase + offset);
 }
 
+static int serial8250_default_handle_irq(struct uart_port *port);
+
 static void set_io_from_upio(struct uart_port *p)
 {
 	struct uart_8250_port *up =
@@ -557,6 +559,7 @@ static void set_io_from_upio(struct uart_port *p)
 	}
 	/* Remember loaded iotype */
 	up->cur_iotype = p->iotype;
+	p->handle_irq = serial8250_default_handle_irq;
 }
 
 static void
@@ -1621,6 +1624,28 @@ static void serial8250_handle_port(struct uart_8250_port *up)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
+int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+{
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+
+	if (!(iir & UART_IIR_NO_INT)) {
+		serial8250_handle_port(up);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int serial8250_default_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+	unsigned int iir = serial_in(up, UART_IIR);
+
+	return serial8250_handle_irq(port, iir);
+}
+
 /*
  * This is the serial driver's interrupt routine.
  *
@@ -1648,13 +1673,12 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	l = i->head;
 	do {
 		struct uart_8250_port *up;
-		unsigned int iir;
+		struct uart_port *port;
 
 		up = list_entry(l, struct uart_8250_port, list);
+		port = &up->port;
 
-		iir = serial_in(up, UART_IIR);
-		if (!(iir & UART_IIR_NO_INT)) {
-			serial8250_handle_port(up);
+		if (port->handle_irq(port)) {
 
 			handled = 1;
 
@@ -3048,6 +3072,10 @@ int __init early_serial_setup(struct uart_port *port)
 		p->serial_in = port->serial_in;
 	if (port->serial_out)
 		p->serial_out = port->serial_out;
+	if (port->handle_irq)
+		p->handle_irq = port->handle_irq;
+	else
+		p->handle_irq = serial8250_default_handle_irq;
 
 	return 0;
 }
@@ -3116,6 +3144,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.type		= p->type;
 		port.serial_in		= p->serial_in;
 		port.serial_out		= p->serial_out;
+		port.handle_irq		= p->handle_irq;
 		port.set_termios	= p->set_termios;
 		port.pm			= p->pm;
 		port.dev		= &dev->dev;
@@ -3281,6 +3310,8 @@ int serial8250_register_port(struct uart_port *port)
 			uart->port.serial_in = port->serial_in;
 		if (port->serial_out)
 			uart->port.serial_out = port->serial_out;
+		if (port->handle_irq)
+			uart->port.handle_irq = port->handle_irq;
 		/*  Possibly override set_termios call */
 		if (port->set_termios)
 			uart->port.set_termios = port->set_termios;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 97f5b45..1f05bbe 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -35,6 +35,7 @@ struct plat_serial8250_port {
 	void		(*set_termios)(struct uart_port *,
 			               struct ktermios *new,
 			               struct ktermios *old);
+	int		(*handle_irq)(struct uart_port *);
 	void		(*pm)(struct uart_port *, unsigned int state,
 			      unsigned old);
 };
@@ -80,6 +81,7 @@ extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
 extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
 			     unsigned int oldstate);
+int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 
 extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
-- 
1.7.7

