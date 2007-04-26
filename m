From: Corey Minyard <minyard@acm.org>
Subject: [PATCH 4/8] serial: Add circular buffer helpers
Date: Thu, 26 Apr 2007 13:50:22 -0500
Message-ID: <20070426185022.GD25521@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta13.mail.adelphia.net ([68.168.78.44]:48276 "EHLO
	mta13.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031442AbXDZSuZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 14:50:25 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Subject: serial: Add circular buffer helpers

Add some helper macros to neaten things up a little in the serial
drivers.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/serial/8250.c       |    7 ++++---
 include/linux/serial_core.h |    2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.21/drivers/serial/8250.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/8250.c
+++ linux-2.6.21/drivers/serial/8250.c
@@ -1265,7 +1265,7 @@ static int receive_chars(struct uart_825
 
 static int transmit_chars(struct uart_8250_port *up)
 {
-	struct circ_buf *xmit = &up->port.info->xmit;
+	struct circ_buf *xmit = uart_get_circ_buf(&up->port);
 	int count;
 	int xmit_ready = 0;
 
@@ -1287,7 +1287,7 @@ static int transmit_chars(struct uart_82
 	count = up->tx_loadsz;
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		xmit->tail = uart_wrap_circ_buf(xmit->tail + 1);
 		up->port.icount.tx++;
 		if (uart_circ_empty(xmit))
 			break;
@@ -1507,6 +1507,7 @@ static void serial8250_timeout(unsigned 
 static void serial8250_backup_timeout(unsigned long data)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)data;
+	struct circ_buf *xmit = uart_get_circ_buf(&up->port);
 	unsigned int iir, ier = 0;
 
 	/*
@@ -1527,7 +1528,7 @@ static void serial8250_backup_timeout(un
 	 * ia64 and parisc boxes.
 	 */
 	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
-	    (!uart_circ_empty(&up->port.info->xmit) || up->port.x_char) &&
+	    (!uart_circ_empty(xmit) || up->port.x_char) &&
 	    (serial_in(up, UART_LSR) & UART_LSR_THRE)) {
 		iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
 		iir |= UART_IIR_THRI;
Index: linux-2.6.21/include/linux/serial_core.h
===================================================================
--- linux-2.6.21.orig/include/linux/serial_core.h
+++ linux-2.6.21/include/linux/serial_core.h
@@ -398,6 +398,8 @@ int uart_resume_port(struct uart_driver 
 
 #define uart_circ_empty(circ)		((circ)->head == (circ)->tail)
 #define uart_circ_clear(circ)		((circ)->head = (circ)->tail = 0)
+#define uart_get_circ_buf(port)		(&(port)->info->xmit)
+#define uart_wrap_circ_buf(val)		((val) & (UART_XMIT_SIZE - 1))
 
 #define uart_circ_chars_pending(circ)	\
 	(CIRC_CNT((circ)->head, (circ)->tail, UART_XMIT_SIZE))
