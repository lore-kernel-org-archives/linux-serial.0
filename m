From: John Linn <john.linn@xilinx.com>
Subject: [PATCH] [V2] uartlite: move from byte accesses to word accesses
Date: Wed, 20 Jan 2010 17:06:39 -0700
Message-ID: <70e0020c-98ac-48d0-bfa6-1f2230ad2d0b@VA3EHSMHS026.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:59390
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753688Ab0AUAHG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jan 2010 19:07:06 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, jacmet@sunsite.dk, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com
Cc: John Linn <john.linn@xilinx.com>

Byte accesses for I/O devices in Xilinx IP are going to be less
desired in the future such that the driver is being changed to
use 32 bit accesses.

This change facilitates using the uartlite IP over a PCIe bus
which only allows 32 bit accesses.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/serial/uartlite.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 377f271..9f83949 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -86,7 +86,7 @@ static int ulite_receive(struct uart_port *port, int stat)
 	/* stats */
 	if (stat & ULITE_STATUS_RXVALID) {
 		port->icount.rx++;
-		ch = readb(port->membase + ULITE_RX);
+		ch = (u8)in_be32(port->membase + ULITE_RX);
 
 		if (stat & ULITE_STATUS_PARITY)
 			port->icount.parity++;
@@ -131,7 +131,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 		return 0;
 
 	if (port->x_char) {
-		writeb(port->x_char, port->membase + ULITE_TX);
+		out_be32(port->membase + ULITE_TX, (u32)port->x_char);
 		port->x_char = 0;
 		port->icount.tx++;
 		return 1;
@@ -140,7 +140,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return 0;
 
-	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
+	out_be32(port->membase + ULITE_TX, (u32)xmit->buf[xmit->tail]);
 	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
 	port->icount.tx++;
 
@@ -157,7 +157,7 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 	int busy, n = 0;
 
 	do {
-		int stat = readb(port->membase + ULITE_STATUS);
+		int stat = in_be32(port->membase + ULITE_STATUS);
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
 		n++;
@@ -178,7 +178,7 @@ static unsigned int ulite_tx_empty(struct uart_port *port)
 	unsigned int ret;
 
 	spin_lock_irqsave(&port->lock, flags);
-	ret = readb(port->membase + ULITE_STATUS);
+	ret = in_be32(port->membase + ULITE_STATUS);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
@@ -201,7 +201,7 @@ static void ulite_stop_tx(struct uart_port *port)
 
 static void ulite_start_tx(struct uart_port *port)
 {
-	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
+	ulite_transmit(port, (u8)in_be32(port->membase + ULITE_STATUS));
 }
 
 static void ulite_stop_rx(struct uart_port *port)
@@ -230,17 +230,17 @@ static int ulite_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
-	       port->membase + ULITE_CONTROL);
-	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+	out_be32(port->membase + ULITE_CONTROL,
+			ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
+	out_be32(port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
 
 	return 0;
 }
 
 static void ulite_shutdown(struct uart_port *port)
 {
-	writeb(0, port->membase + ULITE_CONTROL);
-	readb(port->membase + ULITE_CONTROL); /* dummy */
+	out_be32(port->membase + ULITE_CONTROL, 0);
+	in_be32(port->membase + ULITE_CONTROL); /* dummy */
 	free_irq(port->irq, port);
 }
 
@@ -348,11 +348,11 @@ static struct uart_ops ulite_ops = {
 static void ulite_console_wait_tx(struct uart_port *port)
 {
 	int i;
-	u8 val;
+	u32 val;
 
 	/* Spin waiting for TX fifo to have space available */
 	for (i = 0; i < 100000; i++) {
-		val = readb(port->membase + ULITE_STATUS);
+		val = in_be32(port->membase + ULITE_STATUS);
 		if ((val & ULITE_STATUS_TXFULL) == 0)
 			break;
 		cpu_relax();
@@ -362,7 +362,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 static void ulite_console_putchar(struct uart_port *port, int ch)
 {
 	ulite_console_wait_tx(port);
-	writeb(ch, port->membase + ULITE_TX);
+	out_be32(port->membase + ULITE_TX, (u32)ch);
 }
 
 static void ulite_console_write(struct console *co, const char *s,
@@ -379,8 +379,8 @@ static void ulite_console_write(struct console *co, const char *s,
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
-	writeb(0, port->membase + ULITE_CONTROL);
+	ier = in_be32(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
+	out_be32(port->membase + ULITE_CONTROL, 0);
 
 	uart_console_write(port, s, count, ulite_console_putchar);
 
@@ -388,7 +388,7 @@ static void ulite_console_write(struct console *co, const char *s,
 
 	/* restore interrupt state */
 	if (ier)
-		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+		out_be32(port->membase + ULITE_CONTROL, ULITE_CONTROL_IE);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -601,7 +601,7 @@ ulite_of_probe(struct of_device *op, const struct of_device_id *match)
 
 	id = of_get_property(op->node, "port-number", NULL);
 
-	return ulite_assign(&op->dev, id ? *id : -1, res.start+3, irq);
+	return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
 }
 
 static int __devexit ulite_of_remove(struct of_device *op)
-- 
1.6.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


