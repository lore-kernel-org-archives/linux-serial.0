From: Rodolfo Giometti <giometti@linux.it>
Subject: [PATCH] early console for au1x00
Date: Thu, 25 May 2006 17:43:16 +0200
Message-ID: <20060525154316.GB31742@enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:35517 "EHLO
	goldrake.enneenne.com") by vger.kernel.org with ESMTP
	id S1030229AbWEYPnT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 May 2006 11:43:19 -0400
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FjHvm-0004Mt-9A
	for linux-serial@vger.kernel.org; Thu, 25 May 2006 17:39:26 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FjHzY-0003EM-Hi
	for linux-serial@vger.kernel.org; Thu, 25 May 2006 17:43:16 +0200
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--d8Lz2Tf5e5STOWUP
Content-Type: multipart/mixed; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here a patch to add early console support for au1x00.

I also attach a patch who fixes au1x00 serial address space by using
only physical addresses. Please, note that this change allow to simply
file "drivers/serial/8250.c" since functions
__raw_readl()/__raw_writel() can be replaced by functions
readl()/writel().

At boot time I get:

   Starting kernel .Linux version 2.6.17-rc4-gde4a1dae-dirty (giometti@zaig=
or) (gcc version 3.4.3) #83 Mon May 22 22:34:47 CEST 2006
   CPU revision is: 02030204
   Board WWPC1000 version 1.0
   WWPC-setup: uC=3Doff
   (PRId 02030204) @ 396MHZ
   BCLK switching enabled!
   Early serial console at AU 0x11100000 (options '115200')
   ...
   Serial: 8250/16550 driver $Revision: 1.90 $ 3 ports, IRQ sharing disabled
   serial8250.8: ttyS0 at MMIO 0x11100000 (irq =3D 0) is a 16550A
   serial8250.8: ttyS1 at MMIO 0x11200000 (irq =3D 1) is a 16550A
   serial8250.8: ttyS2 at MMIO 0x11400000 (irq =3D 3) is a 16550A
   ...
   Adding console on ttyS0 at AU 0x11100000 (options '115200')
   ...

and at system running time I get:

   hostname:~# cat /proc/iomem
   10100000-101fffff : au1xxx-ohci.0
     10100000-101fffff : ohci_hcd
   10500000-1050ffff : eth-base
   10520000-10520003 : eth-mac
   11100000-111fffff : serial
   11200000-112fffff : serial
   11400000-114fffff : serial

which is coherent with other system devices.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1x00-early-console
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bcf1b10..78dcded 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -32,6 +32,7 @@
 #include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
+#include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/mmzone.h>
 #include <linux/pfn.h>
@@ -517,6 +518,10 @@ void __init setup_arch(char **cmdline_p)
=20
 	*cmdline_p =3D command_line;
=20
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	early_serial_console_init(*cmdline_p);
+#endif
+
 	parse_cmdline_early();
 	bootmem_init();
 	sparse_init();
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index bbf78aa..784d9d3 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2336,8 +2336,11 @@ int __init serial8250_start_console(stru
=20
 	add_preferred_console("ttyS", line, options);
 	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
-		line, port->iotype =3D=3D UPIO_MEM ? "MMIO" : "I/O port",
-		port->iotype =3D=3D UPIO_MEM ? (unsigned long) port->mapbase :
+		line,
+	       	(port->iotype =3D=3D UPIO_MEM) ? "MMIO" : \
+		(port->iotype =3D=3D UPIO_AU)  ? "AU"   : "I/O port",
+		(port->iotype =3D=3D UPIO_MEM) || \
+		(port->iotype =3D=3D UPIO_AU) ? (unsigned long) port->mapbase :
 		    (unsigned long) port->iobase, options);
 	if (!(serial8250_console.flags & CON_ENABLED)) {
 		serial8250_console.flags &=3D ~CON_PRINTBUFFER;
diff --git a/drivers/serial/8250_early.c b/drivers/serial/8250_early.c
index 7e51119..319baa9 100644
--- a/drivers/serial/8250_early.c
+++ b/drivers/serial/8250_early.c
@@ -4,6 +4,13 @@
  * (c) Copyright 2004 Hewlett-Packard Development Company, L.P.
  *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  *
+ * 2006 - Support for AU1x00 CPUs
+ *        Rodolfo Giometti <giometti@linux.it>
+ *
+ * Know bugs:
+ *    * for au1x00 probe_baud() is not correct so you _must_ specify
+ *      baudrate at command line!
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -19,6 +26,7 @@
  * The user can specify the device directly, e.g.,
  *	console=3Duart,io,0x3f8,9600n8
  *	console=3Duart,mmio,0xff5e0000,115200n8
+ *	console=3Duart,au,0x11100000,115200
  * or platform code can call early_uart_console_init() to set
  * the early UART device.
  *
@@ -44,22 +52,133 @@ struct early_uart_device {
 static struct early_uart_device early_device __initdata;
 static int early_uart_registered __initdata;
=20
-static unsigned int __init serial_in(struct uart_port *port, int offset)
+#define CPU_SPEED 	396000000	/* Default Au1x00 CPU speed */
+#define SYS_POWERCTRL	((u32 *) 0xB190003C)
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+
+/* Au1x00 UART hardware has a weird register layout */
+static const u8 au_io_in_map[] =3D {
+	[UART_RX]  =3D 0,
+	[UART_IER] =3D 2,
+	[UART_IIR] =3D 3,
+	[UART_LCR] =3D 5,
+	[UART_MCR] =3D 6,
+	[UART_LSR] =3D 7,
+};
+
+static const u8 au_io_out_map[] =3D {
+	[UART_TX]  =3D 1,
+	[UART_IER] =3D 2,
+	[UART_FCR] =3D 4,
+	[UART_LCR] =3D 5,
+	[UART_MCR] =3D 6,
+};
+
+/* sane hardware needs no mapping */
+static inline int map_in_reg(struct uart_port *port, int offset)
+{
+	if (port->iotype !=3D UPIO_AU)
+		return offset;
+	return au_io_in_map[offset];
+}
+
+static inline int map_out_reg(struct uart_port *port, int offset)
+{
+	if (port->iotype !=3D UPIO_AU)
+		return offset;
+	return au_io_out_map[offset];
+}
+
+#else
+
+/* sane hardware needs no mapping */
+#define map_in_reg(port, offset) (offset)
+#define map_out_reg(port, offset) (offset)
+
+#endif
+
+static unsigned int serial_in(struct uart_port *port, int offset)
 {
-	if (port->iotype =3D=3D UPIO_MEM)
+	offset =3D map_in_reg(port, offset) << port->regshift;
+
+	switch (port->iotype) {
+	case UPIO_HUB6:
+		outb(port->hub6 - 1 + offset, port->iobase);
+		return inb(port->iobase + 1);
+
+	case UPIO_MEM:
 		return readb(port->membase + offset);
-	else
+
+	case UPIO_MEM32:
+	case UPIO_AU:
+		return readl(port->membase + offset);
+
+	default:
 		return inb(port->iobase + offset);
+	}
 }
=20
-static void __init serial_out(struct uart_port *port, int offset, int valu=
e)
+static void
+serial_out(struct uart_port *port, int offset, int value)
 {
-	if (port->iotype =3D=3D UPIO_MEM)
+	offset =3D map_out_reg(port, offset) << port->regshift;
+
+	switch (port->iotype) {
+	case UPIO_HUB6:
+		outb(port->hub6 - 1 + offset, port->iobase);
+		outb(value, port->iobase + 1);
+		break;
+
+	case UPIO_MEM:
 		writeb(value, port->membase + offset);
-	else
+		break;
+
+	case UPIO_MEM32:
+	case UPIO_AU:
+		writel(value, port->membase + offset);
+		break;
+
+	default:
 		outb(value, port->iobase + offset);
+	}
+}
+
+/* Uart divisor latch read */
+static inline int _serial_dl_read(struct uart_port *port)
+{
+	return serial_in(port, UART_DLL) | serial_in(port, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static inline void _serial_dl_write(struct uart_port *port, int value)
+{
+	serial_out(port, UART_DLL, value & 0xff);
+	serial_out(port, UART_DLM, value >> 8 & 0xff);
+}
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+/* Au1x00 haven't got a standard divisor latch */
+static int serial_dl_read(struct uart_port *port)
+{
+	if (port->iotype =3D=3D UPIO_AU)
+		return readl(port->membase + 0x28);
+	else
+		return _serial_dl_read(port);
 }
=20
+static void serial_dl_write(struct uart_port *port, int value)
+{
+	if (port->iotype =3D=3D UPIO_AU)
+		writel(value, port->membase + 0x28);
+	else
+		_serial_dl_write(port, value);
+}
+#else
+#define serial_dl_read(port) _serial_dl_read(port)
+#define serial_dl_write(port, value) _serial_dl_write(port, value)
+#endif
+
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
=20
 static void __init wait_for_xmitr(struct uart_port *port)
@@ -98,16 +217,17 @@ static void __init early_uart_write(stru
=20
 static unsigned int __init probe_baud(struct uart_port *port)
 {
-	unsigned char lcr, dll, dlm;
+	unsigned char lcr;
 	unsigned int quot;
+	int sd =3D ((int)(__raw_readl(SYS_POWERCTRL)&0x03)) + 2;   /* Au1x00 SD */
=20
 	lcr =3D serial_in(port, UART_LCR);
 	serial_out(port, UART_LCR, lcr | UART_LCR_DLAB);
-	dll =3D serial_in(port, UART_DLL);
-	dlm =3D serial_in(port, UART_DLM);
+	quot =3D serial_dl_read(port);
 	serial_out(port, UART_LCR, lcr);
=20
-	quot =3D (dlm << 8) | dll;
+	if (port->iotype =3D=3D UPIO_AU)
+		return CPU_SPEED / (sd * quot * 32);
 	return (port->uartclk / 16) / quot;
 }
=20
@@ -116,17 +236,20 @@ static void __init init_port(struct earl
 	struct uart_port *port =3D &device->port;
 	unsigned int divisor;
 	unsigned char c;
+	int sd =3D ((int)(__raw_readl(SYS_POWERCTRL)&0x03)) + 2;   /* Au1x00 SD */
=20
 	serial_out(port, UART_LCR, 0x3);	/* 8n1 */
 	serial_out(port, UART_IER, 0);		/* no interrupt */
 	serial_out(port, UART_FCR, 0);		/* no fifo */
 	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
=20
-	divisor =3D port->uartclk / (16 * device->baud);
+	if (port->iotype =3D=3D UPIO_AU)
+		divisor =3D CPU_SPEED / ( sd * device->baud * 32);
+	else
+		divisor =3D port->uartclk / (16 * device->baud);
 	c =3D serial_in(port, UART_LCR);
 	serial_out(port, UART_LCR, c | UART_LCR_DLAB);
-	serial_out(port, UART_DLL, divisor & 0xff);
-	serial_out(port, UART_DLM, (divisor >> 8) & 0xff);
+	serial_dl_write(port, divisor);
 	serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
 }
=20
@@ -135,6 +258,7 @@ static int __init parse_options(struct e
 	struct uart_port *port =3D &device->port;
 	int mapsize =3D 64;
 	int mmio, length;
+	char buf[16];
=20
 	if (!options)
 		return -ENODEV;
@@ -142,6 +266,7 @@ static int __init parse_options(struct e
 	port->uartclk =3D BASE_BAUD * 16;
 	if (!strncmp(options, "mmio,", 5)) {
 		port->iotype =3D UPIO_MEM;
+		port->regshift =3D 0;
 		port->mapbase =3D simple_strtoul(options + 5, &options, 0);
 		port->membase =3D ioremap(port->mapbase, mapsize);
 		if (!port->membase) {
@@ -150,10 +275,25 @@ static int __init parse_options(struct e
 			return -ENOMEM;
 		}
 		mmio =3D 1;
+		strcpy(buf, "MMIO");
+	} else if (!strncmp(options, "au,", 3)) {
+		port->iotype =3D UPIO_AU;
+		port->regshift =3D 2;
+		port->mapbase =3D simple_strtoul(options + 3, &options, 0);
+		port->membase =3D ioremap(port->mapbase, mapsize);
+		if (!port->membase) {
+			printk(KERN_ERR "%s: Couldn't ioremap 0x%lx\n",
+				__FUNCTION__, port->mapbase);
+			return -ENOMEM;
+		}
+		mmio =3D 1;
+		strcpy(buf, "AU");
 	} else if (!strncmp(options, "io,", 3)) {
 		port->iotype =3D UPIO_PORT;
+		port->regshift =3D 0;
 		port->iobase =3D simple_strtoul(options + 3, &options, 0);
 		mmio =3D 0;
+		strcpy(buf, "IO");
 	} else
 		return -EINVAL;
=20
@@ -169,8 +309,7 @@ static int __init parse_options(struct e
 	}
=20
 	printk(KERN_INFO "Early serial console at %s 0x%lx (options '%s')\n",
-		mmio ? "MMIO" : "I/O port",
-		mmio ? port->mapbase : (unsigned long) port->iobase,
+		buf, mmio ? port->mapbase : (unsigned long) port->iobase,
 		device->options);
 	return 0;
 }
@@ -227,22 +366,23 @@ static int __init early_uart_console_swi
 {
 	struct early_uart_device *device =3D &early_device;
 	struct uart_port *port =3D &device->port;
-	int mmio, line;
+	int line;
=20
 	if (!(early_uart_console.flags & CON_ENABLED))
 		return 0;
=20
 	/* Try to start the normal driver on a matching line.  */
-	mmio =3D (port->iotype =3D=3D UPIO_MEM);
 	line =3D serial8250_start_console(port, device->options);
 	if (line < 0)
 		printk("No ttyS device at %s 0x%lx for console\n",
-			mmio ? "MMIO" : "I/O port",
-			mmio ? port->mapbase :
+			(port->iotype =3D=3D UPIO_MEM) ? "MMIO" : \
+			(port->iotype =3D=3D UPIO_AU)  ? "AU"   : "I/O port",
+			(port->iotype =3D=3D UPIO_MEM) || \
+			(port->iotype =3D=3D UPIO_AU) ? port->mapbase :
 			    (unsigned long) port->iobase);
=20
 	unregister_console(&early_uart_console);
-	if (mmio)
+	if ((port->iotype =3D=3D UPIO_MEM) || (port->iotype =3D=3D UPIO_AU))
 		iounmap(port->membase);
=20
 	return 0;
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 17839e7..9e27aee 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2367,6 +2367,7 @@ int uart_match_port(struct uart_port *po
 		return (port1->iobase =3D=3D port2->iobase) &&
 		       (port1->hub6   =3D=3D port2->hub6);
 	case UPIO_MEM:
+	case UPIO_AU:
 		return (port1->mapbase =3D=3D port2->mapbase);
 	}
 	return 0;

--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1x00-serial-phys-addr
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 784d9d3..40c9097 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -311,12 +311,8 @@ static unsigned int serial_in(struct uar
 		return readb(up->port.membase + offset);
=20
 	case UPIO_MEM32:
-		return readl(up->port.membase + offset);
-
-#ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
-		return __raw_readl(up->port.membase + offset);
-#endif
+		return readl(up->port.membase + offset);
=20
 	default:
 		return inb(up->port.iobase + offset);
@@ -339,14 +335,9 @@ serial_out(struct uart_8250_port *up, in
 		break;
=20
 	case UPIO_MEM32:
-		writel(value, up->port.membase + offset);
-		break;
-
-#ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
-		__raw_writel(value, up->port.membase + offset);
+		writel(value, up->port.membase + offset);
 		break;
-#endif
=20
 	default:
 		outb(value, up->port.iobase + offset);
@@ -380,7 +371,7 @@ static inline void _serial_dl_write(stru
 static int serial_dl_read(struct uart_8250_port *up)
 {
 	if (up->port.iotype =3D=3D UPIO_AU)
-		return __raw_readl(up->port.membase + 0x28);
+		return readl(up->port.membase + 0x28);
 	else
 		return _serial_dl_read(up);
 }
@@ -388,7 +379,7 @@ static int serial_dl_read(struct uart_82
 static void serial_dl_write(struct uart_8250_port *up, int value)
 {
 	if (up->port.iotype =3D=3D UPIO_AU)
-		__raw_writel(value, up->port.membase + 0x28);
+		writel(value, up->port.membase + 0x28);
 	else
 		_serial_dl_write(up, value);
 }
diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
index 58015fd..9d0f1be 100644
--- a/drivers/serial/8250_au1x00.c
+++ b/drivers/serial/8250_au1x00.c
@@ -29,36 +29,36 @@
 #define PORT(_base, _irq)				\
 	{						\
 		.iobase		=3D _base,		\
-		.membase	=3D (void __iomem *)_base,\
-		.mapbase	=3D CPHYSADDR(_base),	\
+		.mapbase	=3D _base,		\
 		.irq		=3D _irq,			\
 		.uartclk	=3D 0,	/* filled */	\
 		.regshift	=3D 2,			\
 		.iotype		=3D UPIO_AU,		\
-		.flags		=3D UPF_SKIP_TEST 	\
+		.flags		=3D UPF_SKIP_TEST | 	\
+				  UPF_IOREMAP		\
 	}
=20
 static struct plat_serial8250_port au1x00_data[] =3D {
 #if defined(CONFIG_SOC_AU1000)
-	PORT(UART0_ADDR, AU1000_UART0_INT),
-	PORT(UART1_ADDR, AU1000_UART1_INT),
-	PORT(UART2_ADDR, AU1000_UART2_INT),
-	PORT(UART3_ADDR, AU1000_UART3_INT),
+	PORT(UART0_PHYS_ADDR, AU1000_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1000_UART1_INT),
+	PORT(UART2_PHYS_ADDR, AU1000_UART2_INT),
+	PORT(UART3_PHYS_ADDR, AU1000_UART3_INT),
 #elif defined(CONFIG_SOC_AU1500)
-	PORT(UART0_ADDR, AU1500_UART0_INT),
-	PORT(UART3_ADDR, AU1500_UART3_INT),
+	PORT(UART0_PHYS_ADDR, AU1500_UART0_INT),
+	PORT(UART3_PHYS_ADDR, AU1500_UART3_INT),
 #elif defined(CONFIG_SOC_AU1100)
-	PORT(UART0_ADDR, AU1100_UART0_INT),
-	PORT(UART1_ADDR, AU1100_UART1_INT),
+	PORT(UART0_PHYS_ADDR, AU1100_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1100_UART1_INT),
 	/* The internal UART2 does not exist on the AU1100 processor. */
-	PORT(UART3_ADDR, AU1100_UART3_INT),
+	PORT(UART3_PHYS_ADDR, AU1100_UART3_INT),
 #elif defined(CONFIG_SOC_AU1550)
-	PORT(UART0_ADDR, AU1550_UART0_INT),
-	PORT(UART1_ADDR, AU1550_UART1_INT),
-	PORT(UART3_ADDR, AU1550_UART3_INT),
+	PORT(UART0_PHYS_ADDR, AU1550_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1550_UART1_INT),
+	PORT(UART3_PHYS_ADDR, AU1550_UART3_INT),
 #elif defined(CONFIG_SOC_AU1200)
-	PORT(UART0_ADDR, AU1200_UART0_INT),
-	PORT(UART1_ADDR, AU1200_UART1_INT),
+	PORT(UART0_PHYS_ADDR, AU1200_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1200_UART1_INT),
 #endif
 	{ },
 };

--OROCMA9jn6tkzFBc--

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEddCUQaTCYNJaVjMRAuzyAJ9Qw4giRyvWyJQTdjEZyw0dyyhklACfY22P
0AuQyFkqFifkRYeE2+dVnuk=
=WEsD
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
