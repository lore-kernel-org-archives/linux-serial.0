From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: [PATCH]
Date: Thu, 4 Nov 2004 14:30:37 +0100
Message-ID: <200411041430.38006.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.baslerweb.com ([145.253.187.130]:63348 "EHLO
	mail.baslerweb.com") by vger.kernel.org with ESMTP id S262181AbUKDN0v
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2004 08:26:51 -0500
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id iA4DQ3U4032493
	for <linux-serial@vger.kernel.org>; Thu, 4 Nov 2004 14:26:03 +0100
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

Hi,

I made the 8250 driver work on the internal UART found on
PMC-Sierra RM9000 MIPS CPUs. To do so, I did

- define the register layout, which is different from the standard
  layout, in include/linux/serial_reg.h

- add a new register access type named UPIO_PORT32 for I/O
  registers that must be accessed as 32-bit entities

- add a new port type PORT_RM9000 in include/linux/serial_core.h

While being at it, I also fixed a couple of missing resource
allocations for UPIO_MEM32.

tk


Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>



diff -rpu linux-2.6.9-old/drivers/serial/8250.c linux-2.6.9/drivers/serial/8250.c
--- linux-2.6.9-old/drivers/serial/8250.c	2004-10-28 12:45:30.000000000 +0200
+++ linux-2.6.9/drivers/serial/8250.c	2004-11-04 14:11:42.636338544 +0100
@@ -174,6 +174,7 @@ static const struct serial8250_config ua
 	{ "RSA",	2048,	2048,	UART_CAP_FIFO },
 	{ "NS16550A",	16,	16,	UART_CAP_FIFO | UART_NATSEMI },
 	{ "XScale",	32,	32,	UART_CAP_FIFO },
+	{ "RM9000",	16,	16,	UART_CAP_FIFO }
 };
 
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
@@ -191,6 +192,9 @@ static _INLINE_ unsigned int serial_in(s
 	case UPIO_MEM32:
 		return readl(up->port.membase + offset);
 
+	case UPIO_PORT32:
+		return inl(up->port.iobase + offset);
+
 	default:
 		return inb(up->port.iobase + offset);
 	}
@@ -215,6 +219,10 @@ serial_out(struct uart_8250_port *up, in
 		writel(value, up->port.membase + offset);
 		break;
 
+	case UPIO_PORT32:
+		outl(value, up->port.iobase + offset);
+		break;
+
 	default:
 		outb(value, up->port.iobase + offset);
 	}
@@ -1624,6 +1633,7 @@ serial8250_request_std_resource(struct u
 	int ret = 0;
 
 	switch (up->port.iotype) {
+	case UPIO_MEM32:
 	case UPIO_MEM:
 		if (up->port.mapbase) {
 			*res = request_mem_region(up->port.mapbase, size, "serial");
@@ -1634,6 +1644,7 @@ serial8250_request_std_resource(struct u
 
 	case UPIO_HUB6:
 	case UPIO_PORT:
+	case UPIO_PORT32:
 		*res = request_region(up->port.iobase, size, "serial");
 		if (!*res)
 			ret = -EBUSY;
@@ -1651,6 +1662,7 @@ serial8250_request_rsa_resource(struct u
 
 	switch (up->port.iotype) {
 	case UPIO_MEM:
+	case UPIO_MEM32:
 		if (up->port.mapbase) {
 			start = up->port.mapbase;
 			start += UART_RSA_BASE << up->port.regshift;
@@ -1662,6 +1674,7 @@ serial8250_request_rsa_resource(struct u
 
 	case UPIO_HUB6:
 	case UPIO_PORT:
+	case UPIO_PORT32:
 		start = up->port.iobase;
 		start += UART_RSA_BASE << up->port.regshift;
 		*res = request_region(start, size, "serial-rsa");
@@ -1687,6 +1700,7 @@ static void serial8250_release_port(stru
 
 	switch (up->port.iotype) {
 	case UPIO_MEM:
+	case UPIO_MEM32:
 		if (up->port.mapbase) {
 			/*
 			 * Unmap the area.
@@ -1704,6 +1718,7 @@ static void serial8250_release_port(stru
 
 	case UPIO_HUB6:
 	case UPIO_PORT:
+	case UPIO_PORT32:
 		start = up->port.iobase;
 
 		if (size)
diff -rpu linux-2.6.9-old/include/linux/serial_core.h linux-2.6.9/include/linux/serial_core.h
--- linux-2.6.9-old/include/linux/serial_core.h	2004-10-28 12:46:02.000000000 +0200
+++ linux-2.6.9/include/linux/serial_core.h	2004-11-04 14:11:42.637338392 +0100
@@ -37,7 +37,8 @@
 #define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
+#define PORT_MAX_8250	16	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
@@ -177,6 +178,7 @@ struct uart_port {
 #define UPIO_HUB6		(1)
 #define UPIO_MEM		(2)
 #define UPIO_MEM32		(3)
+#define UPIO_PORT32		(4)
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
diff -rpu linux-2.6.9-old/include/linux/serial_reg.h linux-2.6.9/include/linux/serial_reg.h
--- linux-2.6.9-old/include/linux/serial_reg.h	2004-10-28 12:46:03.000000000 +0200
+++ linux-2.6.9/include/linux/serial_reg.h	2004-11-04 14:11:42.638338240 +0100
@@ -14,6 +14,40 @@
 #ifndef _LINUX_SERIAL_REG_H
 #define _LINUX_SERIAL_REG_H
 
+#include <linux/config.h>
+
+#if defined(CONFIG_SERIAL_RM9000)
+
+/*
+ * The internal UART present on PMC-Sierra MIPS RM9000 CPUs
+ * has a different register layout
+ */
+#define UART_RX		0x00	/* In:  Receive buffer (DLAB=0) */
+#define UART_TX		0x04	/* Out: Transmit buffer (DLAB=0) */
+#define UART_DLL	0x08	/* Out: Divisor Latch Low (DLAB=1) */
+
+#define UART_DLM	0x10	/* Out: Divisor Latch High (DLAB=1) */
+#define UART_IER	0x0c	/* Out: Interrupt Enable Register */
+
+#define UART_IIR	0x14	/* In:  Interrupt ID Register */
+#define UART_FCR	0x18	/* Out: FIFO Control Register */
+
+#define UART_LCR	0x1c	/* Out: Line Control Register */
+#define UART_MCR	0x20	/* Out: Modem Control Register */
+#define UART_LSR	0x24	/* In:  Line Status Register */
+#define UART_MSR	0x28	/* In:  Modem Status Register */
+#define UART_SCR	0x2c	/* I/O: Scratch Register */
+
+/* Unimplemented registers */
+#define UART_EFR	0xff	/* I/O: Extended Features Register */
+#define UART_EMSR	0xff	/* (LCR=BF) Extended Mode Select Register */
+
+/* Dummies */
+#define UART_FCTR	1
+#define UART_TRG	0
+
+#else
+
 #define UART_RX		0	/* In:  Receive buffer (DLAB=0) */
 #define UART_TX		0	/* Out: Transmit buffer (DLAB=0) */
 #define UART_DLL	0	/* Out: Divisor Latch Low (DLAB=1) */
@@ -40,6 +74,7 @@
 #define UART_EMSR	7	/* (LCR=BF) Extended Mode Select Register 
 				 * FCTR bit 6 selects SCR or EMSR
 				 * XR16c85x only */
+#endif /* defined(SERIAL_RM9000) */
 
 /*
  * These are the definitions for the FIFO Control Register

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

