From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC 2/5] 8250: introduce the idea of an operations struct for an
 8250 port
Date: Fri, 18 Mar 2011 15:25:18 +0000
Message-ID: <20110318152501.10657.31792.stgit@bob.linux.org.uk>
References: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44124 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1CRPpJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 11:45:09 -0400
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p2IFlwxB018097
	for <linux-serial@vger.kernel.org>; Fri, 18 Mar 2011 15:48:03 GMT
In-Reply-To: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We can then round up all the port specific bits and push them into the
drivers or standard library code where they belong. This will need all the
embedded driver people to tweak their board code - sorry but there's not a
nice way to do this. Once it is done however then it should be easy to keep
sane as we can add new ops for new hardware insanity without disturbance.

Signed-off-by: Alan Cox <alan@linux.intel.com>

---

 drivers/char/mwave/mwavedd.c   |    2 
 drivers/tty/serial/8250.c      |  230 +++++++++++++++++++++++-----------------
 drivers/tty/serial/8250_pci.c  |    2 
 drivers/tty/serial/8250_pnp.c  |    2 
 drivers/tty/serial/of_serial.c |    2 
 drivers/tty/serial/serial_cs.c |    2 
 include/linux/serial_8250.h    |   34 ++++--
 include/linux/serial_core.h    |    3 +
 8 files changed, 165 insertions(+), 112 deletions(-)


diff --git a/drivers/char/mwave/mwavedd.c b/drivers/char/mwave/mwavedd.c
index 1d82d58..4bbe677 100644
--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -469,7 +469,7 @@ static int register_serial_portandirq(unsigned int port, int irq)
 	uart.irq = irq;
 	uart.iotype = UPIO_PORT;
 	uart.flags =  UPF_SHARE_IRQ;
-	return serial8250_register_port(&uart);
+	return serial8250_register_port(&uart, NULL);
 }
 
 
diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index a8e43fd..c3e56a7 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -133,6 +133,7 @@ static unsigned int probe_rsa_count;
 
 struct uart_8250_port {
 	struct uart_port	port;
+	const struct serial8250_ops *ops;	/* I/O access methods */
 	struct timer_list	timer;		/* "no irq" timer */
 	struct list_head	list;		/* ports on this IRQ */
 	unsigned short		capabilities;	/* port capabilities */
@@ -387,6 +388,25 @@ static inline int map_8250_out_reg(struct uart_port *p, int offset)
 
 #endif
 
+/* Uart divisor latch read */
+static unsigned int std_serial_dl_read(struct uart_port *p)
+{
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
+	return up->ops->serial_in(p, UART_DLL) |
+			up->ops->serial_in(p, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static void std_serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
+	up->ops->serial_out(p, UART_DLL, value & 0xff);
+	up->ops->serial_out(p, UART_DLM, value >> 8 & 0xff);
+}
+
+
 static unsigned int hub6_serial_in(struct uart_port *p, int offset)
 {
 	offset = map_8250_in_reg(p, offset) << p->regshift;
@@ -401,6 +421,13 @@ static void hub6_serial_out(struct uart_port *p, int offset, int value)
 	outb(value, p->iobase + 1);
 }
 
+static const struct serial8250_ops hub6_ops = {
+	.serial_in = hub6_serial_in,
+	.serial_out = hub6_serial_out,
+	.serial_dl_read = std_serial_dl_read,
+	.serial_dl_write = std_serial_dl_write
+};
+
 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
 	offset = map_8250_in_reg(p, offset) << p->regshift;
@@ -413,6 +440,13 @@ static void mem_serial_out(struct uart_port *p, int offset, int value)
 	writeb(value, p->membase + offset);
 }
 
+static const struct serial8250_ops mem_ops = {
+	.serial_in = mem_serial_in,
+	.serial_out = mem_serial_out,
+	.serial_dl_read = std_serial_dl_read,
+	.serial_dl_write = std_serial_dl_write
+};
+
 static void mem32_serial_out(struct uart_port *p, int offset, int value)
 {
 	offset = map_8250_out_reg(p, offset) << p->regshift;
@@ -425,17 +459,12 @@ static unsigned int mem32_serial_in(struct uart_port *p, int offset)
 	return readl(p->membase + offset);
 }
 
-static unsigned int au_serial_in(struct uart_port *p, int offset)
-{
-	offset = map_8250_in_reg(p, offset) << p->regshift;
-	return __raw_readl(p->membase + offset);
-}
-
-static void au_serial_out(struct uart_port *p, int offset, int value)
-{
-	offset = map_8250_out_reg(p, offset) << p->regshift;
-	__raw_writel(value, p->membase + offset);
-}
+static const struct serial8250_ops mem32_ops = {
+	.serial_in = mem32_serial_in,
+	.serial_out = mem32_serial_out,
+	.serial_dl_read = std_serial_dl_read,
+	.serial_dl_write = std_serial_dl_write
+};
 
 static unsigned int tsi_serial_in(struct uart_port *p, int offset)
 {
@@ -455,6 +484,13 @@ static void tsi_serial_out(struct uart_port *p, int offset, int value)
 		writeb(value, p->membase + offset);
 }
 
+static const struct serial8250_ops tsi_ops = {
+	.serial_in = tsi_serial_in,
+	.serial_out = tsi_serial_out,
+	.serial_dl_read = std_serial_dl_read,
+	.serial_dl_write = std_serial_dl_write
+};
+
 /* Save the LCR value so it can be re-written when a Busy Detect IRQ occurs. */
 static inline void dwapb_save_out_value(struct uart_port *p, int offset,
 					int value)
@@ -469,8 +505,10 @@ static inline void dwapb_save_out_value(struct uart_port *p, int offset,
 /* Read the IER to ensure any interrupt is cleared before returning from ISR. */
 static inline void dwapb_check_clear_ier(struct uart_port *p, int offset)
 {
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
 	if (offset == UART_TX || offset == UART_IER)
-		p->serial_in(p, UART_IER);
+		up->ops->serial_in(p, UART_IER);
 }
 
 static void dwapb_serial_out(struct uart_port *p, int offset, int value)
@@ -482,6 +520,13 @@ static void dwapb_serial_out(struct uart_port *p, int offset, int value)
 	dwapb_check_clear_ier(p, save_offset);
 }
 
+static const struct serial8250_ops dwapb_ops = {
+	.serial_in = mem_serial_in,
+	.serial_out = dwapb_serial_out,
+	.serial_dl_read = std_serial_dl_read,
+	.serial_dl_write = std_serial_dl_write
+};
+
 static void dwapb32_serial_out(struct uart_port *p, int offset, int value)
 {
 	int save_offset = offset;
@@ -491,6 +536,13 @@ static void dwapb32_serial_out(struct uart_port *p, int offset, int value)
 	dwapb_check_clear_ier(p, save_offset);
 }
 
+static const struct serial8250_ops dwapb32_ops = {
+	.serial_in = mem32_serial_in,
+	.serial_out = dwapb32_serial_out,
+	.serial_dl_read = std_serial_dl_read,
+	.serial_dl_write = std_serial_dl_write
+};
+
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
 	offset = map_8250_in_reg(p, offset) << p->regshift;
@@ -503,17 +555,24 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 	outb(value, p->iobase + offset);
 }
 
-/* Uart divisor latch read */
-static unsigned int _serial_dl_read(struct uart_port *p)
+
+static const struct serial8250_ops pio_ops = {
+	.serial_in = io_serial_in,
+	.serial_out = io_serial_out,
+	.serial_dl_read = std_serial_dl_read,
+	.serial_dl_write = std_serial_dl_write
+};
+
+static unsigned int au_serial_in(struct uart_port *p, int offset)
 {
-	return p->serial_in(p, UART_DLL) | p->serial_in(p, UART_DLM) << 8;
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	return __raw_readl(p->membase + offset);
 }
 
-/* Uart divisor latch write */
-static void _serial_dl_write(struct uart_port *p, unsigned int value)
+static void au_serial_out(struct uart_port *p, int offset, int value)
 {
-	p->serial_out(p, UART_DLL, value & 0xff);
-	p->serial_out(p, UART_DLM, value >> 8 & 0xff);
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	__raw_writel(value, p->membase + offset);
 }
 
 /* Au1x00 haven't got a standard divisor latch */
@@ -527,6 +586,13 @@ static void au_serial_dl_write(struct uart_port *p, unsigned int value)
 	__raw_writel(value, p->membase + 0x28);
 }
 
+static const struct serial8250_ops au_ops = {
+	.serial_in = au_serial_in,
+	.serial_out = au_serial_out,
+	.serial_dl_read = au_serial_dl_read,
+	.serial_dl_write = au_serial_dl_write
+};
+
 static unsigned int rm9k_serial_dl_read(struct uart_port *p)
 {
 	return	(((__raw_readl(p->membase + 0x10) << 8) |
@@ -539,58 +605,47 @@ static void rm9k_serial_dl_write(struct uart_port *p, unsigned int value)
 	__raw_writel(value >> 8, p->membase + 0x10);
 }
 
+static const struct serial8250_ops rm9k_ops = {
+	.serial_in = mem32_serial_in,
+	.serial_out = mem32_serial_out,
+	.serial_dl_read = rm9k_serial_dl_read,
+	.serial_dl_write = rm9k_serial_dl_write
+};
+
+/* This needs to move to a table where drivers register their ops. Needs
+   some thought on the module count side */
 static void set_io_from_upio(struct uart_port *p)
 {
 	struct uart_8250_port *up =
 		container_of(p, struct uart_8250_port, port);
 
-	p->serial_dl_read = _serial_dl_read;
-	p->serial_dl_write = _serial_dl_write;
-
 	switch (p->iotype) {
 	case UPIO_HUB6:
-		p->serial_in = hub6_serial_in;
-		p->serial_out = hub6_serial_out;
+		up->ops = &hub6_ops;
 		break;
-
 	case UPIO_MEM:
-		p->serial_in = mem_serial_in;
-		p->serial_out = mem_serial_out;
+		up->ops = &mem_ops;
 		break;
-
 	case UPIO_RM9000:
-		p->serial_dl_read = rm9k_serial_dl_read;
-		p->serial_dl_write = rm9k_serial_dl_write;
+		up->ops = &rm9k_ops;
+		break;
 	case UPIO_MEM32:
-		p->serial_in = mem32_serial_in;
-		p->serial_out = mem32_serial_out;
+		up->ops = &mem32_ops;
 		break;
-
 	case UPIO_AU:
-		p->serial_in = au_serial_in;
-		p->serial_out = au_serial_out;
-		p->serial_dl_read = au_serial_dl_read;
-		p->serial_dl_write = au_serial_dl_write;
+		up->ops = &au_ops;
 		break;
-
 	case UPIO_TSI:
-		p->serial_in = tsi_serial_in;
-		p->serial_out = tsi_serial_out;
+		up->ops = &tsi_ops;
 		break;
-
 	case UPIO_DWAPB:
-		p->serial_in = mem_serial_in;
-		p->serial_out = dwapb_serial_out;
+		up->ops = &dwapb_ops;
 		break;
-
 	case UPIO_DWAPB32:
-		p->serial_in = mem32_serial_in;
-		p->serial_out = dwapb32_serial_out;
+		up->ops = &dwapb32_ops;
 		break;
-
 	default:
-		p->serial_in = io_serial_in;
-		p->serial_out = io_serial_out;
+		up->ops = &pio_ops;
 		break;
 	}
 	/* Remember loaded iotype */
@@ -607,27 +662,27 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	case UPIO_AU:
 	case UPIO_DWAPB:
 	case UPIO_DWAPB32:
-		p->serial_out(p, offset, value);
-		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
+		up->ops->serial_out(p, offset, value);
+		up->ops->serial_in(p, UART_LCR); /* safe, no side-effects */
 		break;
 	default:
-		p->serial_out(p, offset, value);
+		up->ops->serial_out(p, offset, value);
 	}
 }
 
 #define serial_in(up, offset)		\
-	(up->port.serial_in(&(up)->port, (offset)))
+	(up->ops->serial_in(&(up)->port, (offset)))
 #define serial_out(up, offset, value)	\
-	(up->port.serial_out(&(up)->port, (offset), (value)))
+	(up->ops->serial_out(&(up)->port, (offset), (value)))
 
 static unsigned int serial_dl_read(struct uart_8250_port *up)
 {
-	return up->port.serial_dl_read(&up->port);
+	return up->ops->serial_dl_read(&up->port);
 }
 
 static void serial_dl_write(struct uart_8250_port *up, unsigned int value)
 {
-	up->port.serial_dl_write(&up->port, value);
+	up->ops->serial_dl_write(&up->port, value);
 }
 
 /*
@@ -2474,8 +2529,10 @@ static void
 serial8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		       struct ktermios *old)
 {
-	if (port->set_termios)
-		port->set_termios(port, termios, old);
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+	if (up->ops->set_termios)
+		up->ops->set_termios(port, termios, old);
 	else
 		serial8250_do_set_termios(port, termios, old);
 }
@@ -2505,8 +2562,11 @@ static void
 serial8250_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
-	if (port->pm)
-		port->pm(port, state, oldstate);
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+
+	if (up->ops->pm)
+		up->ops->pm(port, state, oldstate);
 	else
 		serial8250_do_pm(port, state, oldstate);
 }
@@ -2982,20 +3042,24 @@ static struct uart_driver serial8250_reg = {
 };
 
 /*
- * early_serial_setup - early registration for 8250 ports
+ * serial8250_early_setup - early registration for 8250 ports
  *
  * Setup an 8250 port structure prior to console initialisation.  Use
  * after console initialisation will cause undefined behaviour.
  */
-int __init early_serial_setup(struct uart_port *port)
+int __init serial8250_early_setup(struct uart_port *port, struct serial8250_ops *ops)
 {
 	struct uart_port *p;
+	struct uart_8250_port *up;
 
 	if (port->line >= ARRAY_SIZE(serial8250_ports))
 		return -ENODEV;
 
 	serial8250_isa_init_ports();
+
 	p = &serial8250_ports[port->line].port;
+	up = container_of(p, struct uart_8250_port, port);
+
 	p->iobase       = port->iobase;
 	p->membase      = port->membase;
 	p->irq          = port->irq;
@@ -3012,14 +3076,8 @@ int __init early_serial_setup(struct uart_port *port)
 
 	set_io_from_upio(p);
 
-	if (port->serial_in)
-		p->serial_in = port->serial_in;
-	if (port->serial_out)
-		p->serial_out = port->serial_out;
-	if (port->serial_dl_read)
-		p->serial_dl_read = port->serial_dl_read;
-	if (port->serial_dl_write)
-		p->serial_dl_write = port->serial_dl_write;
+	if (ops)
+		up->ops = ops;
 
 	return 0;
 }
@@ -3086,23 +3144,9 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.hub6		= p->hub6;
 		port.private_data	= p->private_data;
 		port.type		= p->type;
-		port.serial_in		= p->serial_in;
-		port.serial_out		= p->serial_out;
-		port.serial_dl_read	= p->serial_dl_read;
-		port.serial_dl_write	= p->serial_dl_write;
-		/* Temporary to help people transferring */
-		if (port.serial_dl_read == NULL ||
-					port.serial_dl_write == NULL) {
-			dev_warn(&dev->dev,
-				"needs updating to set dl_read/write.\n");
-			port.serial_dl_read = _serial_dl_read;
-			port.serial_dl_write = _serial_dl_write;
-		}
-		port.set_termios	= p->set_termios;
-		port.pm			= p->pm;
 		port.dev		= &dev->dev;
 		port.irqflags		|= irqflag;
-		ret = serial8250_register_port(&port);
+		ret = serial8250_register_port(&port, p->ops);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%llx IRQ%d): %d\n", i,
@@ -3216,6 +3260,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 /**
  *	serial8250_register_port - register a serial port
  *	@port: serial port template
+ *	@ops: optional I/O operations and low level ops to use
  *
  *	Configure the serial port specified by the request. If the
  *	port exists and is in use, it is hung up and unregistered
@@ -3226,7 +3271,8 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
  *
  *	On success the port is ready to use and the line number is returned.
  */
-int serial8250_register_port(struct uart_port *port)
+int serial8250_register_port(struct uart_port *port,
+					const struct serial8250_ops *ops)
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
@@ -3258,16 +3304,8 @@ int serial8250_register_port(struct uart_port *port)
 			serial8250_init_fixed_type_port(uart, port->type);
 
 		set_io_from_upio(&uart->port);
-		/* Possibly override default I/O functions.  */
-		if (port->serial_in)
-			uart->port.serial_in = port->serial_in;
-		if (port->serial_out)
-			uart->port.serial_out = port->serial_out;
-		/*  Possibly override set_termios call */
-		if (port->set_termios)
-			uart->port.set_termios = port->set_termios;
-		if (port->pm)
-			uart->port.pm = port->pm;
+		if (ops)
+			uart->port.ops = ops;
 
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(0, &uart->port,
diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 8b8930f..851e9a6 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -2473,7 +2473,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 		       serial_port.iobase, serial_port.irq, serial_port.iotype);
 #endif
 
-		priv->line[i] = serial8250_register_port(&serial_port);
+		priv->line[i] = serial8250_register_port(&serial_port, NULL);
 		if (priv->line[i] < 0) {
 			printk(KERN_WARNING "Couldn't register serial port %s: %d\n", pci_name(dev), priv->line[i]);
 			break;
diff --git a/drivers/tty/serial/8250_pnp.c b/drivers/tty/serial/8250_pnp.c
index 4822cb5..95126e2 100644
--- a/drivers/tty/serial/8250_pnp.c
+++ b/drivers/tty/serial/8250_pnp.c
@@ -457,7 +457,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	port.uartclk = 1843200;
 	port.dev = &dev->dev;
 
-	line = serial8250_register_port(&port);
+	line = serial8250_register_port(&port, NULL);
 	if (line < 0)
 		return -ENODEV;
 
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 0e8eec5..2b834e9 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -105,7 +105,7 @@ static int __devinit of_platform_serial_probe(struct platform_device *ofdev)
 	switch (port_type) {
 #ifdef CONFIG_SERIAL_8250
 	case PORT_8250 ... PORT_MAX_8250:
-		ret = serial8250_register_port(&port);
+		ret = serial8250_register_port(&port, NULL);
 		break;
 #endif
 #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
diff --git a/drivers/tty/serial/serial_cs.c b/drivers/tty/serial/serial_cs.c
index 1ef4df9..fc3b441 100644
--- a/drivers/tty/serial/serial_cs.c
+++ b/drivers/tty/serial/serial_cs.c
@@ -359,7 +359,7 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info * info,
 	if (info->quirk && info->quirk->setup)
 		info->quirk->setup(handle, &port);
 
-	line = serial8250_register_port(&port);
+	line = serial8250_register_port(&port, NULL);
 	if (line < 0) {
 		printk(KERN_NOTICE "serial_cs: serial8250_register_port() at "
 		       "0x%04lx, irq %d failed\n", (u_long)iobase, irq);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 9e42ff7..15806bb 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -14,6 +14,18 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 
+struct serial8250_ops {
+	unsigned int	(*serial_in)(struct uart_port *, int);
+	void		(*serial_out)(struct uart_port *, int, int);
+	void		(*set_termios)(struct uart_port *,
+			               struct ktermios *new,
+			               struct ktermios *old);
+	void		(*pm)(struct uart_port *, unsigned int state,
+			      unsigned old);
+	unsigned int	(*serial_dl_read)(struct uart_port *);
+	void		(*serial_dl_write)(struct uart_port *, unsigned int);
+};
+
 /*
  * This is the platform device platform_data structure
  */
@@ -30,15 +42,8 @@ struct plat_serial8250_port {
 	unsigned char	hub6;
 	upf_t		flags;		/* UPF_* flags */
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
-	unsigned int	(*serial_in)(struct uart_port *, int);
-	void		(*serial_out)(struct uart_port *, int, int);
-	void		(*set_termios)(struct uart_port *,
-			               struct ktermios *new,
-			               struct ktermios *old);
-	void		(*pm)(struct uart_port *, unsigned int state,
-			      unsigned old);
-	unsigned int	(*serial_dl_read)(struct uart_port *);
-	void		(*serial_dl_write)(struct uart_port *, unsigned int);
+	struct serial8250_ops *ops;	/* Optional ops (UPIO defaults are
+	                                   applied otherwise */
 };
 
 /*
@@ -68,13 +73,14 @@ enum {
  */
 struct uart_port;
 
-int serial8250_register_port(struct uart_port *);
+int serial8250_register_port(struct uart_port *, const struct serial8250_ops *ops);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
 
-extern int early_serial_setup(struct uart_port *port);
 
+extern int serial8250_early_setup(struct uart_port *port,
+                                        struct serial8250_ops *ops);
 extern int serial8250_find_port(struct uart_port *p);
 extern int serial8250_find_port_for_earlycon(void);
 extern int setup_early_serial8250_console(char *cmdline);
@@ -87,4 +93,10 @@ extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
 						unsigned short *capabilities));
 
+
+static inline int __deprecated early_serial_setup(struct uart_port *port)
+{
+        return serial8250_early_setup(port, NULL);
+}
+
 #endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f47f95c..84e0b01 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -291,10 +291,12 @@ struct uart_port {
 	spinlock_t		lock;			/* port lock */
 	unsigned long		iobase;			/* in/out[bwl] */
 	unsigned char __iomem	*membase;		/* read/write[bwl] */
+#if 0
 	unsigned int		(*serial_dl_read)(struct uart_port *);
 	void			(*serial_dl_write)(struct uart_port *, unsigned int);
 	unsigned int		(*serial_in)(struct uart_port *, int);
 	void			(*serial_out)(struct uart_port *, int, int);
+#endif	
 	void			(*set_termios)(struct uart_port *,
 				               struct ktermios *new,
 				               struct ktermios *old);
@@ -318,6 +320,7 @@ struct uart_port {
 #define UPIO_DWAPB		(6)			/* DesignWare APB UART */
 #define UPIO_RM9000		(7)			/* RM9000 type IO */
 #define UPIO_DWAPB32		(8)			/* DesignWare APB UART (32 bit accesses) */
+#define UPIO_MAX		(8)
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */

