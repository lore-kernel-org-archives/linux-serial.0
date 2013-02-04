From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: [PATCH] OMAP/serial: Fix incorrect Rx FIFO threshold setting, LSR
 validation on Tx, and Tx FIFO IRQ generation
Date: Mon, 4 Feb 2013 12:19:46 -0500
Message-ID: <20130204171946.GA5220@inertiallabs-linux64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:46269 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab3BDRUF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Feb 2013 12:20:05 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so3449851eei.35
        for <linux-serial@vger.kernel.org>; Mon, 04 Feb 2013 09:20:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

From: Alexey Pelykh <alexey.pelykh@gmail.com>

Original configuration of Rx FIFO threshold contained an error
that resulted Rx threshold to be effectively set to 1 character
instead of 16 characters, as noted in comments.
Checking LSR to contain UART_LSR_THRE bit set caused issue when
not all UART_IER_THRI interrupts have been properly handled.
This caused gap in Tx data, visible on high baud rates using
oscilloscope.
Setting OMAP_UART_SCR_TX_EMPTY bit in SCR caused UART_IER_THRI
interrupt to be raised only when Tx FIFO and Tx shift registers
are empty.

Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 57d6b29..fad46a2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -59,6 +59,7 @@
 
 /* SCR register bitmasks */
 #define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK		(1 << 7)
+#define OMAP_UART_SCR_TX_TRIG_GRANU1_MASK		(1 << 6)
 #define OMAP_UART_SCR_TX_EMPTY			(1 << 3)
 
 /* FCR register bitmasks */
@@ -302,9 +321,6 @@ static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 	struct circ_buf *xmit = &up->port.state->xmit;
 	int count;
 
-	if (!(lsr & UART_LSR_THRE))
-		return;
-
 	if (up->port.x_char) {
 		serial_out(up, UART_TX, up->port.x_char);
 		up->port.icount.tx++;
@@ -845,7 +861,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_IER, up->ier);
 	serial_out(up, UART_LCR, cval);		/* reset DLAB */
 	up->lcr = cval;
-	up->scr = OMAP_UART_SCR_TX_EMPTY;
+	up->scr = 0;
 
 	/* FIFOs and DMA Settings */
 
@@ -869,8 +885,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	/* FIFO ENABLE, DMA MODE */
 
-	up->scr |= OMAP_UART_SCR_RX_TRIG_GRANU1_MASK;
-
 	/* Set receive FIFO threshold to 16 characters and
 	 * transmit FIFO threshold to 16 spaces
 	 */
