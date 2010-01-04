From: Jamie Iles <jamie.iles@picochip.com>
Subject: [PATCH] 8250: add a UPIO_DWAPB32 for 32 bit accesses
Date: Mon,  4 Jan 2010 17:11:56 +0000
Message-ID: <1262625116-22712-1-git-send-email-jamie.iles@picochip.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail2.picochip.com ([82.111.145.34]:56174 "EHLO
	thurne.picochip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752235Ab0ADRjp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jan 2010 12:39:45 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie.iles@picochip.com>

Some platforms contain a Synopsys DesignWare APB UART that is attached
to a 32-bit APB bus where sub-word accesses are not allowed. Add a new
IO type (UPIO_DWAPB32) that performs 32 bit acccesses to the UART.

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
---
 drivers/serial/8250.c        |   18 ++++++++++++++++--
 drivers/serial/8250_early.c  |    6 +++++-
 drivers/serial/serial_core.c |    2 ++
 include/linux/serial_core.h  |    1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index c87f7bd..b03a8c8 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -463,7 +463,12 @@ static void dwapb_serial_out(struct uart_port *p, int offset, int value)
 		struct uart_8250_port *up = (struct uart_8250_port *)p;
 		up->lcr = value;
 	}
-	writeb(value, p->membase + offset);
+
+	if (UPIO_DWAPB == p->iotype)
+		writeb(value, p->membase + offset);
+	else
+		writel(value, p->membase + offset);
+
 	/* Read the IER to ensure any interrupt is cleared before
 	 * returning from ISR. */
 	if (save_offset == UART_TX || save_offset == UART_IER)
@@ -518,6 +523,11 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = dwapb_serial_out;
 		break;
 
+	case UPIO_DWAPB32:
+		p->serial_in = mem32_serial_in;
+		p->serial_out = dwapb_serial_out;
+		break;
+
 	default:
 		p->serial_in = io_serial_in;
 		p->serial_out = io_serial_out;
@@ -538,6 +548,7 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	case UPIO_AU:
 #endif
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
 		break;
@@ -1574,7 +1585,8 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 			handled = 1;
 
 			end = NULL;
-		} else if (up->port.iotype == UPIO_DWAPB &&
+		} else if ((up->port.iotype == UPIO_DWAPB ||
+			    up->port.iotype == UPIO_DWAPB32) &&
 			  (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 			/* The DesignWare APB UART has an Busy Detect (0x07)
 			 * interrupt meaning an LCR write attempt occured while the
@@ -2444,6 +2456,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_MEM32:
 	case UPIO_MEM:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		if (!up->port.mapbase)
 			break;
 
@@ -2481,6 +2494,7 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	case UPIO_MEM32:
 	case UPIO_MEM:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		if (!up->port.mapbase)
 			break;
 
diff --git a/drivers/serial/8250_early.c b/drivers/serial/8250_early.c
index f279745..51a3497 100644
--- a/drivers/serial/8250_early.c
+++ b/drivers/serial/8250_early.c
@@ -48,7 +48,9 @@ static struct early_serial8250_device early_device;
 
 static unsigned int __init serial_in(struct uart_port *port, int offset)
 {
-	if (port->iotype == UPIO_MEM)
+        if (port->iotype == UPIO_MEM32)
+                return readl(port->membase + offset);
+        else if (port->iotype == UPIO_MEM)
 		return readb(port->membase + offset);
 	else
 		return inb(port->iobase + offset);
@@ -56,6 +58,8 @@ static unsigned int __init serial_in(struct uart_port *port, int offset)
 
 static void __init serial_out(struct uart_port *port, int offset, int value)
 {
+        if (port->iotype == UPIO_MEM32)
+                writel(value, port->membase + offset);
 	if (port->iotype == UPIO_MEM)
 		writeb(value, port->membase + offset);
 	else
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index fa4f170..71ce227 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2142,6 +2142,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
 		break;
@@ -2555,6 +2556,7 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d40db83..6eea6cf 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -289,6 +289,7 @@ struct uart_port {
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
 #define UPIO_DWAPB		(6)			/* DesignWare APB UART */
 #define UPIO_RM9000		(7)			/* RM9000 type IO */
+#define UPIO_DWAPB32		(8)			/* DesignWare APB UART (32 bit accesses) */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
-- 
1.6.5.4

