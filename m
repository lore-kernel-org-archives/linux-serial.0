From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] 8250: add a UPIO_DWAPB32 for 32 bit accesses (v2)
Date: Wed, 1 Dec 2010 08:10:44 +0000
Message-ID: <20101201081044.GM4398@pulham.picochip.com>
References: <1290436007-683-1-git-send-email-jamie@jamieiles.com>
 <20101201011758.GA21009@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60614 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab0LAIKs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Dec 2010 03:10:48 -0500
Received: by wyb28 with SMTP id 28so6651530wyb.19
        for <linux-serial@vger.kernel.org>; Wed, 01 Dec 2010 00:10:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201011758.GA21009@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org

On Tue, Nov 30, 2010 at 05:17:58PM -0800, Greg KH wrote:
> On Mon, Nov 22, 2010 at 02:26:47PM +0000, Jamie Iles wrote:
> > +		writeb(value, p->membase + offset);
> > +	else
> > +		writel(value, p->membase + offset);
> > +
> 
> As this is on the "fast path" for writing data out, isn't it going to
> slow down the UPIO_DWAPB users as well?
Yes, that's a fair point. Perhaps I was trying too hard to avoid copy and 
paste code! How about this instead?

Jamie

>From 19f6bf46ed0da675e8f98f58b3374634cfe3a7f2 Mon Sep 17 00:00:00 2001
From: Jamie Iles <jamie@jamieiles.com>
Date: Wed, 1 Dec 2010 07:44:37 +0000
Subject: [PATCH] 8250: add a UPIO_DWAPB32 for 32 bit accesses

Some platforms contain a Synopsys DesignWare APB UART that is attached
to a 32-bit APB bus where sub-word accesses are not allowed. Add a new
IO type (UPIO_DWAPB32) that performs 32 bit acccesses to the UART.

v2:
	- don't test for 32 bit in the output fast path, provide a
	  separate dwabp32_serial_out() function. Refactor
	  dwabp_serial_out() so that we can reuse the LCR saving
	  code.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/serial/8250.c        |   50 ++++++++++++++++++++++++++++++++---------
 drivers/serial/serial_core.c |    2 +
 include/linux/serial_core.h  |    1 +
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 4d8e14b..df43cc3 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -454,21 +454,40 @@ static void tsi_serial_out(struct uart_port *p, int offset, int value)
 		writeb(value, p->membase + offset);
 }
 
+/* Save the LCR value so it can be re-written when a Busy Detect IRQ occurs. */
+static inline void dwapb_save_out_value(struct uart_port *p, int offset,
+					int value)
+{
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
+
+	if (offset == UART_LCR)
+		up->lcr = value;
+}
+
+/* Read the IER to ensure any interrupt is cleared before returning from ISR. */
+static inline void dwapb_check_clear_ier(struct uart_port *p, int offset)
+{
+	if (offset == UART_TX || offset == UART_IER)
+		p->serial_in(p, UART_IER);
+}
+
 static void dwapb_serial_out(struct uart_port *p, int offset, int value)
 {
 	int save_offset = offset;
 	offset = map_8250_out_reg(p, offset) << p->regshift;
-	/* Save the LCR value so it can be re-written when a
-	 * Busy Detect interrupt occurs. */
-	if (save_offset == UART_LCR) {
-		struct uart_8250_port *up = (struct uart_8250_port *)p;
-		up->lcr = value;
-	}
+	dwapb_save_out_value(p, save_offset, value);
 	writeb(value, p->membase + offset);
-	/* Read the IER to ensure any interrupt is cleared before
-	 * returning from ISR. */
-	if (save_offset == UART_TX || save_offset == UART_IER)
-		value = p->serial_in(p, UART_IER);
+	dwapb_check_clear_ier(p, save_offset);
+}
+
+static void dwapb32_serial_out(struct uart_port *p, int offset, int value)
+{
+	int save_offset = offset;
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	dwapb_save_out_value(p, save_offset, value);
+	writel(value, p->membase + offset);
+	dwapb_check_clear_ier(p, save_offset);
 }
 
 static unsigned int io_serial_in(struct uart_port *p, int offset)
@@ -518,6 +537,11 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = dwapb_serial_out;
 		break;
 
+	case UPIO_DWAPB32:
+		p->serial_in = mem32_serial_in;
+		p->serial_out = dwapb32_serial_out;
+		break;
+
 	default:
 		p->serial_in = io_serial_in;
 		p->serial_out = io_serial_out;
@@ -536,6 +560,7 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	case UPIO_MEM32:
 	case UPIO_AU:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
 		break;
@@ -1581,7 +1606,8 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 			handled = 1;
 
 			end = NULL;
-		} else if (up->port.iotype == UPIO_DWAPB &&
+		} else if ((up->port.iotype == UPIO_DWAPB ||
+			    up->port.iotype == UPIO_DWAPB32) &&
 			  (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 			/* The DesignWare APB UART has an Busy Detect (0x07)
 			 * interrupt meaning an LCR write attempt occured while the
@@ -2476,6 +2502,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_MEM32:
 	case UPIO_MEM:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		if (!up->port.mapbase)
 			break;
 
@@ -2513,6 +2540,7 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	case UPIO_MEM32:
 	case UPIO_MEM:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		if (!up->port.mapbase)
 			break;
 
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 9ffa5be..143103b 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2134,6 +2134,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
 		break;
@@ -2554,6 +2555,7 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_DWAPB:
+	case UPIO_DWAPB32:
 		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 212eb4c..8681e7c 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -311,6 +311,7 @@ struct uart_port {
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
 #define UPIO_DWAPB		(6)			/* DesignWare APB UART */
 #define UPIO_RM9000		(7)			/* RM9000 type IO */
+#define UPIO_DWAPB32		(8)			/* DesignWare APB UART (32 bit accesses) */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
-- 
1.7.2.3

