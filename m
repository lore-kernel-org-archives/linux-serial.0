From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 68/75] 8250: Serial driver changes to support future Cavium
	OCTEON serial patches.
Date: Fri, 02 Jan 2009 13:49:47 +0000
Message-ID: <20090102134946.13472.26427.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37683 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757382AbZABNtd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:49:33 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: David Daney <ddaney@caviumnetworks.com>

In order to use Cavium OCTEON specific serial i/o drivers, we first
patch the 8250 driver to use replaceable I/O functions.  Compatible
I/O functions are added for existing iotypeS.

An added benefit of this change is that it makes it easy to factor
some of the existing special cases out to board/SOC specific support
code.

The alternative is to load up 8250.c with a bunch of OCTEON specific
iotype code and bug work-arounds.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/8250.c       |  194 ++++++++++++++++++++++++++++++-------------
 include/linux/serial_8250.h |    2 
 include/linux/serial_core.h |    2 
 3 files changed, 140 insertions(+), 58 deletions(-)


diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 8e28750..849af9d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -303,16 +303,16 @@ static const u8 au_io_out_map[] = {
 };
 
 /* sane hardware needs no mapping */
-static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
+static inline int map_8250_in_reg(struct uart_port *p, int offset)
 {
-	if (up->port.iotype != UPIO_AU)
+	if (p->iotype != UPIO_AU)
 		return offset;
 	return au_io_in_map[offset];
 }
 
-static inline int map_8250_out_reg(struct uart_8250_port *up, int offset)
+static inline int map_8250_out_reg(struct uart_port *p, int offset)
 {
-	if (up->port.iotype != UPIO_AU)
+	if (p->iotype != UPIO_AU)
 		return offset;
 	return au_io_out_map[offset];
 }
@@ -341,16 +341,16 @@ static const u8
 		[UART_SCR]	= 0x2c
 	};
 
-static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
+static inline int map_8250_in_reg(struct uart_port *p, int offset)
 {
-	if (up->port.iotype != UPIO_RM9000)
+	if (p->iotype != UPIO_RM9000)
 		return offset;
 	return regmap_in[offset];
 }
 
-static inline int map_8250_out_reg(struct uart_8250_port *up, int offset)
+static inline int map_8250_out_reg(struct uart_port *p, int offset)
 {
-	if (up->port.iotype != UPIO_RM9000)
+	if (p->iotype != UPIO_RM9000)
 		return offset;
 	return regmap_out[offset];
 }
@@ -363,108 +363,170 @@ static inline int map_8250_out_reg(struct uart_8250_port *up, int offset)
 
 #endif
 
-static unsigned int serial_in(struct uart_8250_port *up, int offset)
+static unsigned int hub6_serial_in(struct uart_port *p, int offset)
 {
-	unsigned int tmp;
-	offset = map_8250_in_reg(up, offset) << up->port.regshift;
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	outb(p->hub6 - 1 + offset, p->iobase);
+	return inb(p->iobase + 1);
+}
 
-	switch (up->port.iotype) {
-	case UPIO_HUB6:
-		outb(up->port.hub6 - 1 + offset, up->port.iobase);
-		return inb(up->port.iobase + 1);
+static void hub6_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	outb(p->hub6 - 1 + offset, p->iobase);
+	outb(value, p->iobase + 1);
+}
 
-	case UPIO_MEM:
-	case UPIO_DWAPB:
-		return readb(up->port.membase + offset);
+static unsigned int mem_serial_in(struct uart_port *p, int offset)
+{
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	return readb(p->membase + offset);
+}
 
-	case UPIO_RM9000:
-	case UPIO_MEM32:
-		return readl(up->port.membase + offset);
+static void mem_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	writeb(value, p->membase + offset);
+}
+
+static void mem32_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	writel(value, p->membase + offset);
+}
+
+static unsigned int mem32_serial_in(struct uart_port *p, int offset)
+{
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	return readl(p->membase + offset);
+}
 
 #ifdef CONFIG_SERIAL_8250_AU1X00
-	case UPIO_AU:
-		return __raw_readl(up->port.membase + offset);
+static unsigned int au_serial_in(struct uart_port *p, int offset)
+{
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	return __raw_readl(p->membase + offset);
+}
+
+static void au_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	__raw_writel(value, p->membase + offset);
+}
 #endif
 
-	case UPIO_TSI:
-		if (offset == UART_IIR) {
-			tmp = readl(up->port.membase + (UART_IIR & ~3));
-			return (tmp >> 16) & 0xff; /* UART_IIR % 4 == 2 */
-		} else
-			return readb(up->port.membase + offset);
+static unsigned int tsi_serial_in(struct uart_port *p, int offset)
+{
+	unsigned int tmp;
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	if (offset == UART_IIR) {
+		tmp = readl(p->membase + (UART_IIR & ~3));
+		return (tmp >> 16) & 0xff; /* UART_IIR % 4 == 2 */
+	} else
+		return readb(p->membase + offset);
+}
 
-	default:
-		return inb(up->port.iobase + offset);
-	}
+static void tsi_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	if (!((offset == UART_IER) && (value & UART_IER_UUE)))
+		writeb(value, p->membase + offset);
 }
 
-static void
-serial_out(struct uart_8250_port *up, int offset, int value)
+static void dwapb_serial_out(struct uart_port *p, int offset, int value)
 {
-	/* Save the offset before it's remapped */
 	int save_offset = offset;
-	offset = map_8250_out_reg(up, offset) << up->port.regshift;
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	/* Save the LCR value so it can be re-written when a
+	 * Busy Detect interrupt occurs. */
+	if (save_offset == UART_LCR) {
+		struct uart_8250_port *up = (struct uart_8250_port *)p;
+		up->lcr = value;
+	}
+	writeb(value, p->membase + offset);
+	/* Read the IER to ensure any interrupt is cleared before
+	 * returning from ISR. */
+	if (save_offset == UART_TX || save_offset == UART_IER)
+		value = p->serial_in(p, UART_IER);
+}
 
-	switch (up->port.iotype) {
+static unsigned int io_serial_in(struct uart_port *p, int offset)
+{
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	return inb(p->iobase + offset);
+}
+
+static void io_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	outb(value, p->iobase + offset);
+}
+
+static void set_io_from_upio(struct uart_port *p)
+{
+	switch (p->iotype) {
 	case UPIO_HUB6:
-		outb(up->port.hub6 - 1 + offset, up->port.iobase);
-		outb(value, up->port.iobase + 1);
+		p->serial_in = hub6_serial_in;
+		p->serial_out = hub6_serial_out;
 		break;
 
 	case UPIO_MEM:
-		writeb(value, up->port.membase + offset);
+		p->serial_in = mem_serial_in;
+		p->serial_out = mem_serial_out;
 		break;
 
 	case UPIO_RM9000:
 	case UPIO_MEM32:
-		writel(value, up->port.membase + offset);
+		p->serial_in = mem32_serial_in;
+		p->serial_out = mem32_serial_out;
 		break;
 
 #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
-		__raw_writel(value, up->port.membase + offset);
+		p->serial_in = au_serial_in;
+		p->serial_out = au_serial_out;
 		break;
 #endif
 	case UPIO_TSI:
-		if (!((offset == UART_IER) && (value & UART_IER_UUE)))
-			writeb(value, up->port.membase + offset);
+		p->serial_in = tsi_serial_in;
+		p->serial_out = tsi_serial_out;
 		break;
 
 	case UPIO_DWAPB:
-		/* Save the LCR value so it can be re-written when a
-		 * Busy Detect interrupt occurs. */
-		if (save_offset == UART_LCR)
-			up->lcr = value;
-		writeb(value, up->port.membase + offset);
-		/* Read the IER to ensure any interrupt is cleared before
-		 * returning from ISR. */
-		if (save_offset == UART_TX || save_offset == UART_IER)
-			value = serial_in(up, UART_IER);
+		p->serial_in = mem_serial_in;
+		p->serial_out = dwapb_serial_out;
 		break;
 
 	default:
-		outb(value, up->port.iobase + offset);
+		p->serial_in = io_serial_in;
+		p->serial_out = io_serial_out;
+		break;
 	}
 }
 
 static void
 serial_out_sync(struct uart_8250_port *up, int offset, int value)
 {
-	switch (up->port.iotype) {
+	struct uart_port *p = &up->port;
+	switch (p->iotype) {
 	case UPIO_MEM:
 	case UPIO_MEM32:
 #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
 #endif
 	case UPIO_DWAPB:
-		serial_out(up, offset, value);
-		serial_in(up, UART_LCR);	/* safe, no side-effects */
+		p->serial_out(p, offset, value);
+		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
 		break;
 	default:
-		serial_out(up, offset, value);
+		p->serial_out(p, offset, value);
 	}
 }
 
+#define serial_in(up, offset)		\
+	(up->port.serial_in(&(up)->port, (offset)))
+#define serial_out(up, offset, value)	\
+	(up->port.serial_out(&(up)->port, (offset), (value)))
 /*
  * We used to support using pause I/O for certain machines.  We
  * haven't supported this for a while, but just in case it's badly
@@ -2576,6 +2638,7 @@ static void __init serial8250_isa_init_ports(void)
 		up->port.membase  = old_serial_port[i].iomem_base;
 		up->port.iotype   = old_serial_port[i].io_type;
 		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		set_io_from_upio(&up->port);
 		if (share_irqs)
 			up->port.flags |= UPF_SHARE_IRQ;
 	}
@@ -2769,6 +2832,13 @@ int __init early_serial_setup(struct uart_port *port)
 	p->flags        = port->flags;
 	p->mapbase      = port->mapbase;
 	p->private_data = port->private_data;
+
+	set_io_from_upio(p);
+	if (port->serial_in)
+		p->serial_in = port->serial_in;
+	if (port->serial_out)
+		p->serial_out = port->serial_out;
+
 	return 0;
 }
 
@@ -2833,6 +2903,8 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.mapbase		= p->mapbase;
 		port.hub6		= p->hub6;
 		port.private_data	= p->private_data;
+		port.serial_in		= p->serial_in;
+		port.serial_out		= p->serial_out;
 		port.dev		= &dev->dev;
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
@@ -2986,6 +3058,12 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.private_data = port->private_data;
 		if (port->dev)
 			uart->port.dev = port->dev;
+		set_io_from_upio(&uart->port);
+		/* Possibly override default I/O functions.  */
+		if (port->serial_in)
+			uart->port.serial_in = port->serial_in;
+		if (port->serial_out)
+			uart->port.serial_out = port->serial_out;
 
 		ret = uart_add_one_port(&serial8250_reg, &uart->port);
 		if (ret == 0)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 3d37c94..77d83d9 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -28,6 +28,8 @@ struct plat_serial8250_port {
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
 	upf_t		flags;		/* UPF_* flags */
+	unsigned int	(*serial_in)(struct uart_port *, int);
+	void		(*serial_out)(struct uart_port *, int, int);
 };
 
 /*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2395969..60061f4 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -248,6 +248,8 @@ struct uart_port {
 	spinlock_t		lock;			/* port lock */
 	unsigned long		iobase;			/* in/out[bwl] */
 	unsigned char __iomem	*membase;		/* read/write[bwl] */
+	unsigned int		(*serial_in)(struct uart_port *, int);
+	void			(*serial_out)(struct uart_port *, int, int);
 	unsigned int		irq;			/* irq number */
 	unsigned int		uartclk;		/* base uart clock */
 	unsigned int		fifosize;		/* tx fifo size */

