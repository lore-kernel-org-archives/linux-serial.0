From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 2/5] tty: serial8250: allow platforms to override irq handler
Date: Thu, 16 Jun 2011 10:19:58 +0100
Message-ID: <1308216001-5299-3-git-send-email-jamie@jamieiles.com>
References: <1308216001-5299-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54149 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab1FPJUL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 05:20:11 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1330937wwa.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Jun 2011 02:20:10 -0700 (PDT)
In-Reply-To: <1308216001-5299-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

Some ports (e.g. Synopsys DesignWare 8250) have special requirements for
handling the interrupts.  Allow these platforms to specify their own
interrupt handler that will override the default.
serial8250_handle_irq() is provided so that platforms can extend the IRQ
handler rather than completely replacing it.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/tty/serial/8250.c   |   39 +++++++++++++++++++++++++++++++++++----
 include/linux/serial_8250.h |    2 ++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 6611535..59190b6 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -503,6 +503,8 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 	outb(value, p->iobase + offset);
 }
 
+static int serial8250_default_handle_irq(struct uart_port *port);
+
 static void set_io_from_upio(struct uart_port *p)
 {
 	struct uart_8250_port *up =
@@ -551,6 +553,7 @@ static void set_io_from_upio(struct uart_port *p)
 	}
 	/* Remember loaded iotype */
 	up->cur_iotype = p->iotype;
+	p->handle_irq = serial8250_default_handle_irq;
 }
 
 static void
@@ -1587,6 +1590,28 @@ static void serial8250_handle_port(struct uart_8250_port *up)
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
@@ -1614,13 +1639,12 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
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
 
@@ -3012,6 +3036,10 @@ int __init early_serial_setup(struct uart_port *port)
 		p->serial_in = port->serial_in;
 	if (port->serial_out)
 		p->serial_out = port->serial_out;
+	if (port->handle_irq)
+		p->handle_irq = port->handle_irq;
+	else
+		p->handle_irq = serial8250_default_handle_irq;
 
 	return 0;
 }
@@ -3080,6 +3108,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.type		= p->type;
 		port.serial_in		= p->serial_in;
 		port.serial_out		= p->serial_out;
+		port.handle_irq		= p->handle_irq;
 		port.set_termios	= p->set_termios;
 		port.pm			= p->pm;
 		port.dev		= &dev->dev;
@@ -3245,6 +3274,8 @@ int serial8250_register_port(struct uart_port *port)
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
1.7.4.1

