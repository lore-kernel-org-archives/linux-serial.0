From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 19/79] tty: serial8250: remove UPIO_DWAPB{,32}
Date: Wed, 26 Oct 2011 14:12:24 +0200
Message-ID: <1319631204-23262-19-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60953 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932863Ab1JZMNg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:36 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jamie Iles <jamie@jamieiles.com>

Now that platforms can override the port IRQ handler and the only user
of these UPIO modes has been converted over, kill off UPIO_DWAPB and
UPIO_DWAPB32.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250.c        |   68 --------------------------------------
 drivers/tty/serial/serial_core.c |    4 --
 include/linux/serial_core.h      |    4 +--
 3 files changed, 1 insertions(+), 75 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 833e011..6f594d2 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -461,42 +461,6 @@ static void tsi_serial_out(struct uart_port *p, int offset, int value)
 		writeb(value, p->membase + offset);
 }
 
-/* Save the LCR value so it can be re-written when a Busy Detect IRQ occurs. */
-static inline void dwapb_save_out_value(struct uart_port *p, int offset,
-					int value)
-{
-	struct uart_8250_port *up =
-		container_of(p, struct uart_8250_port, port);
-
-	if (offset == UART_LCR)
-		up->lcr = value;
-}
-
-/* Read the IER to ensure any interrupt is cleared before returning from ISR. */
-static inline void dwapb_check_clear_ier(struct uart_port *p, int offset)
-{
-	if (offset == UART_TX || offset == UART_IER)
-		p->serial_in(p, UART_IER);
-}
-
-static void dwapb_serial_out(struct uart_port *p, int offset, int value)
-{
-	int save_offset = offset;
-	offset = map_8250_out_reg(p, offset) << p->regshift;
-	dwapb_save_out_value(p, save_offset, value);
-	writeb(value, p->membase + offset);
-	dwapb_check_clear_ier(p, save_offset);
-}
-
-static void dwapb32_serial_out(struct uart_port *p, int offset, int value)
-{
-	int save_offset = offset;
-	offset = map_8250_out_reg(p, offset) << p->regshift;
-	dwapb_save_out_value(p, save_offset, value);
-	writel(value, p->membase + offset);
-	dwapb_check_clear_ier(p, save_offset);
-}
-
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
 	offset = map_8250_in_reg(p, offset) << p->regshift;
@@ -542,16 +506,6 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = tsi_serial_out;
 		break;
 
-	case UPIO_DWAPB:
-		p->serial_in = mem_serial_in;
-		p->serial_out = dwapb_serial_out;
-		break;
-
-	case UPIO_DWAPB32:
-		p->serial_in = mem32_serial_in;
-		p->serial_out = dwapb32_serial_out;
-		break;
-
 	default:
 		p->serial_in = io_serial_in;
 		p->serial_out = io_serial_out;
@@ -570,8 +524,6 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	case UPIO_MEM:
 	case UPIO_MEM32:
 	case UPIO_AU:
-	case UPIO_DWAPB:
-	case UPIO_DWAPB32:
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
 		break;
@@ -1679,23 +1631,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 		port = &up->port;
 
 		if (port->handle_irq(port)) {
-
 			handled = 1;
-
-			end = NULL;
-		} else if ((up->port.iotype == UPIO_DWAPB ||
-			    up->port.iotype == UPIO_DWAPB32) &&
-			  (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
-			/* The DesignWare APB UART has an Busy Detect (0x07)
-			 * interrupt meaning an LCR write attempt occurred while the
-			 * UART was busy. The interrupt must be cleared by reading
-			 * the UART status register (USR) and the LCR re-written. */
-			unsigned int status;
-			status = *(volatile u32 *)up->port.private_data;
-			serial_out(up, UART_LCR, up->lcr);
-
-			handled = 1;
-
 			end = NULL;
 		} else if (end == NULL)
 			end = l;
@@ -2592,8 +2528,6 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_TSI:
 	case UPIO_MEM32:
 	case UPIO_MEM:
-	case UPIO_DWAPB:
-	case UPIO_DWAPB32:
 		if (!up->port.mapbase)
 			break;
 
@@ -2630,8 +2564,6 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	case UPIO_TSI:
 	case UPIO_MEM32:
 	case UPIO_MEM:
-	case UPIO_DWAPB:
-	case UPIO_DWAPB32:
 		if (!up->port.mapbase)
 			break;
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 44c2963..3844980 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2032,8 +2032,6 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 	case UPIO_MEM32:
 	case UPIO_AU:
 	case UPIO_TSI:
-	case UPIO_DWAPB:
-	case UPIO_DWAPB32:
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
 		break;
@@ -2446,8 +2444,6 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
 	case UPIO_MEM32:
 	case UPIO_AU:
 	case UPIO_TSI:
-	case UPIO_DWAPB:
-	case UPIO_DWAPB32:
 		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c31ae43..493773e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -318,9 +318,7 @@ struct uart_port {
 #define UPIO_MEM32		(3)
 #define UPIO_AU			(4)			/* Au1x00 type IO */
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
-#define UPIO_DWAPB		(6)			/* DesignWare APB UART */
-#define UPIO_RM9000		(7)			/* RM9000 type IO */
-#define UPIO_DWAPB32		(8)			/* DesignWare APB UART (32 bit accesses) */
+#define UPIO_RM9000		(6)			/* RM9000 type IO */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
-- 
1.7.7

