From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC 1/5] 8250: Make serial_dl_write a port operation
Date: Fri, 18 Mar 2011 15:24:50 +0000
Message-ID: <20110318152439.10657.19067.stgit@bob.linux.org.uk>
References: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44123 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1CRPol (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 11:44:41 -0400
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p2IFlUoT018093
	for <linux-serial@vger.kernel.org>; Fri, 18 Mar 2011 15:47:36 GMT
In-Reply-To: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

This is pre-requisite to splitting out some of the platform specific stuff

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/8250.c   |  122 +++++++++++++++++++++++++------------------
 include/linux/serial_8250.h |    2 +
 include/linux/serial_core.h |    2 +
 3 files changed, 74 insertions(+), 52 deletions(-)


diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b3b881b..a8e43fd 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -503,10 +503,50 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 	outb(value, p->iobase + offset);
 }
 
+/* Uart divisor latch read */
+static unsigned int _serial_dl_read(struct uart_port *p)
+{
+	return p->serial_in(p, UART_DLL) | p->serial_in(p, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static void _serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	p->serial_out(p, UART_DLL, value & 0xff);
+	p->serial_out(p, UART_DLM, value >> 8 & 0xff);
+}
+
+/* Au1x00 haven't got a standard divisor latch */
+static unsigned int au_serial_dl_read(struct uart_port *p)
+{
+	return __raw_readl(p->membase + 0x28);
+}
+
+static void au_serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	__raw_writel(value, p->membase + 0x28);
+}
+
+static unsigned int rm9k_serial_dl_read(struct uart_port *p)
+{
+	return	(((__raw_readl(p->membase + 0x10) << 8) |
+		(__raw_readl(p->membase + 0x08) & 0xff)) & 0xffff);
+}
+
+static void rm9k_serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	__raw_writel(value, p->membase + 0x08);
+	__raw_writel(value >> 8, p->membase + 0x10);
+}
+
 static void set_io_from_upio(struct uart_port *p)
 {
 	struct uart_8250_port *up =
 		container_of(p, struct uart_8250_port, port);
+
+	p->serial_dl_read = _serial_dl_read;
+	p->serial_dl_write = _serial_dl_write;
+
 	switch (p->iotype) {
 	case UPIO_HUB6:
 		p->serial_in = hub6_serial_in;
@@ -519,6 +559,8 @@ static void set_io_from_upio(struct uart_port *p)
 		break;
 
 	case UPIO_RM9000:
+		p->serial_dl_read = rm9k_serial_dl_read;
+		p->serial_dl_write = rm9k_serial_dl_write;
 	case UPIO_MEM32:
 		p->serial_in = mem32_serial_in;
 		p->serial_out = mem32_serial_out;
@@ -527,6 +569,8 @@ static void set_io_from_upio(struct uart_port *p)
 	case UPIO_AU:
 		p->serial_in = au_serial_in;
 		p->serial_out = au_serial_out;
+		p->serial_dl_read = au_serial_dl_read;
+		p->serial_dl_write = au_serial_dl_write;
 		break;
 
 	case UPIO_TSI:
@@ -575,6 +619,17 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	(up->port.serial_in(&(up)->port, (offset)))
 #define serial_out(up, offset, value)	\
 	(up->port.serial_out(&(up)->port, (offset), (value)))
+
+static unsigned int serial_dl_read(struct uart_8250_port *up)
+{
+	return up->port.serial_dl_read(&up->port);
+}
+
+static void serial_dl_write(struct uart_8250_port *up, unsigned int value)
+{
+	up->port.serial_dl_write(&up->port, value);
+}
+
 /*
  * We used to support using pause I/O for certain machines.  We
  * haven't supported this for a while, but just in case it's badly
@@ -584,58 +639,6 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 #define serial_inp(up, offset)		serial_in(up, offset)
 #define serial_outp(up, offset, value)	serial_out(up, offset, value)
 
-/* Uart divisor latch read */
-static inline int _serial_dl_read(struct uart_8250_port *up)
-{
-	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
-}
-
-/* Uart divisor latch write */
-static inline void _serial_dl_write(struct uart_8250_port *up, int value)
-{
-	serial_outp(up, UART_DLL, value & 0xff);
-	serial_outp(up, UART_DLM, value >> 8 & 0xff);
-}
-
-#if defined(CONFIG_MIPS_ALCHEMY)
-/* Au1x00 haven't got a standard divisor latch */
-static int serial_dl_read(struct uart_8250_port *up)
-{
-	if (up->port.iotype == UPIO_AU)
-		return __raw_readl(up->port.membase + 0x28);
-	else
-		return _serial_dl_read(up);
-}
-
-static void serial_dl_write(struct uart_8250_port *up, int value)
-{
-	if (up->port.iotype == UPIO_AU)
-		__raw_writel(value, up->port.membase + 0x28);
-	else
-		_serial_dl_write(up, value);
-}
-#elif defined(CONFIG_SERIAL_8250_RM9K)
-static int serial_dl_read(struct uart_8250_port *up)
-{
-	return	(up->port.iotype == UPIO_RM9000) ?
-		(((__raw_readl(up->port.membase + 0x10) << 8) |
-		(__raw_readl(up->port.membase + 0x08) & 0xff)) & 0xffff) :
-		_serial_dl_read(up);
-}
-
-static void serial_dl_write(struct uart_8250_port *up, int value)
-{
-	if (up->port.iotype == UPIO_RM9000) {
-		__raw_writel(value, up->port.membase + 0x08);
-		__raw_writel(value >> 8, up->port.membase + 0x10);
-	} else {
-		_serial_dl_write(up, value);
-	}
-}
-#else
-#define serial_dl_read(up) _serial_dl_read(up)
-#define serial_dl_write(up, value) _serial_dl_write(up, value)
-#endif
 
 /*
  * For the 16C950
@@ -3008,10 +3011,15 @@ int __init early_serial_setup(struct uart_port *port)
 	p->line		= port->line;
 
 	set_io_from_upio(p);
+
 	if (port->serial_in)
 		p->serial_in = port->serial_in;
 	if (port->serial_out)
 		p->serial_out = port->serial_out;
+	if (port->serial_dl_read)
+		p->serial_dl_read = port->serial_dl_read;
+	if (port->serial_dl_write)
+		p->serial_dl_write = port->serial_dl_write;
 
 	return 0;
 }
@@ -3080,6 +3088,16 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.type		= p->type;
 		port.serial_in		= p->serial_in;
 		port.serial_out		= p->serial_out;
+		port.serial_dl_read	= p->serial_dl_read;
+		port.serial_dl_write	= p->serial_dl_write;
+		/* Temporary to help people transferring */
+		if (port.serial_dl_read == NULL ||
+					port.serial_dl_write == NULL) {
+			dev_warn(&dev->dev,
+				"needs updating to set dl_read/write.\n");
+			port.serial_dl_read = _serial_dl_read;
+			port.serial_dl_write = _serial_dl_write;
+		}
 		port.set_termios	= p->set_termios;
 		port.pm			= p->pm;
 		port.dev		= &dev->dev;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 97f5b45..9e42ff7 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -37,6 +37,8 @@ struct plat_serial8250_port {
 			               struct ktermios *old);
 	void		(*pm)(struct uart_port *, unsigned int state,
 			      unsigned old);
+	unsigned int	(*serial_dl_read)(struct uart_port *);
+	void		(*serial_dl_write)(struct uart_port *, unsigned int);
 };
 
 /*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 758c5b0..f47f95c 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -291,6 +291,8 @@ struct uart_port {
 	spinlock_t		lock;			/* port lock */
 	unsigned long		iobase;			/* in/out[bwl] */
 	unsigned char __iomem	*membase;		/* read/write[bwl] */
+	unsigned int		(*serial_dl_read)(struct uart_port *);
+	void			(*serial_dl_write)(struct uart_port *, unsigned int);
 	unsigned int		(*serial_in)(struct uart_port *, int);
 	void			(*serial_out)(struct uart_port *, int, int);
 	void			(*set_termios)(struct uart_port *,

