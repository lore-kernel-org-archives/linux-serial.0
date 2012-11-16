From: Noam Camus <noamc@ezchip.com>
Subject: RE: [PATCH] tty/8250_early: Turn serial_in/serial_out into weak
	symbols.
Date: Fri, 16 Nov 2012 07:03:05 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC3049A0F@ezexch.ezchip.com>
References: <20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
	<20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
	<20121014133216.686277e1@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC300184F@ezexch.ezchip.com>
	<20121025121815.0689c196@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499FF@ezexch.ezchip.com>,<20121116011124.GA12506@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:45226 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab2KPFDm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 00:03:42 -0500
In-Reply-To: <20121116011124.GA12506@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Gilad Ben Yossef <giladb@ezchip.com>


>From: Greg KH [gregkh@linuxfoundation.org]
>Sent: Friday, November 16, 2012 3:11 AM

>This patch no longer applies to my tree.  Can you please refresh it
>against the tty-next tree and resend it, with Alan's ack kept on it, so
>I remember it is there?

Hello Greg,
Here is my refreshed patch:

>From b1f527ea26ce6ef2bbe3efcb7872aa4a4e6b77d5 Mon Sep 17 00:00:00 2001
From: Noam Camus <noamc@ezchip.com>
Date: Fri, 16 Nov 2012 06:42:53 +0200
Subject: [PATCH] tty/8250_early: Turn serial_in/serial_out into weak symbols.

Allows overriding default methods serial_in/serial_out.

In such platform specific replacement it is possible to use
other regshift, biased register offset, any other manipulation
that is not covered with common default methods.

Overriding default methods may be useful for platforms which got
serial peripheral with registers represented in big endian.
In this situation and assuming that 32 bit operations / alignment
is required then it may be useful to swab words before/after
accessing the serial registers.

Signed-off-by: Noam Camus <noamc@ezchip.com>
Acked-by: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/8250/8250_early.c |   42 +++++++++++++++++-----------------
 include/linux/serial_8250.h          |    2 +
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 843a150..f53a7db 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -48,7 +48,7 @@ struct early_serial8250_device {
 
 static struct early_serial8250_device early_device;
 
-static unsigned int __init serial_in(struct uart_port *port, int offset)
+unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offset)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
@@ -62,7 +62,7 @@ static unsigned int __init serial_in(struct uart_port *port, int offset)
 	}
 }
 
-static void __init serial_out(struct uart_port *port, int offset, int value)
+void __weak __init serial8250_early_out(struct uart_port *port, int offset, int value)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
@@ -84,7 +84,7 @@ static void __init wait_for_xmitr(struct uart_port *port)
 	unsigned int status;
 
 	for (;;) {
-		status = serial_in(port, UART_LSR);
+		status = serial8250_early_in(port, UART_LSR);
 		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
 			return;
 		cpu_relax();
@@ -94,7 +94,7 @@ static void __init wait_for_xmitr(struct uart_port *port)
 static void __init serial_putc(struct uart_port *port, int c)
 {
 	wait_for_xmitr(port);
-	serial_out(port, UART_TX, c);
+	serial8250_early_out(port, UART_TX, c);
 }
 
 static void __init early_serial8250_write(struct console *console,
@@ -104,14 +104,14 @@ static void __init early_serial8250_write(struct console *console,
 	unsigned int ier;
 
 	/* Save the IER and disable interrupts */
-	ier = serial_in(port, UART_IER);
-	serial_out(port, UART_IER, 0);
+	ier = serial8250_early_in(port, UART_IER);
+	serial8250_early_out(port, UART_IER, 0);
 
 	uart_console_write(port, s, count, serial_putc);
 
 	/* Wait for transmitter to become empty and restore the IER */
 	wait_for_xmitr(port);
-	serial_out(port, UART_IER, ier);
+	serial8250_early_out(port, UART_IER, ier);
 }
 
 static unsigned int __init probe_baud(struct uart_port *port)
@@ -119,11 +119,11 @@ static unsigned int __init probe_baud(struct uart_port *port)
 	unsigned char lcr, dll, dlm;
 	unsigned int quot;
 
-	lcr = serial_in(port, UART_LCR);
-	serial_out(port, UART_LCR, lcr | UART_LCR_DLAB);
-	dll = serial_in(port, UART_DLL);
-	dlm = serial_in(port, UART_DLM);
-	serial_out(port, UART_LCR, lcr);
+	lcr = serial8250_early_in(port, UART_LCR);
+	serial8250_early_out(port, UART_LCR, lcr | UART_LCR_DLAB);
+	dll = serial8250_early_in(port, UART_DLL);
+	dlm = serial8250_early_in(port, UART_DLM);
+	serial8250_early_out(port, UART_LCR, lcr);
 
 	quot = (dlm << 8) | dll;
 	return (port->uartclk / 16) / quot;
@@ -135,17 +135,17 @@ static void __init init_port(struct early_serial8250_device *device)
 	unsigned int divisor;
 	unsigned char c;
 
-	serial_out(port, UART_LCR, 0x3);	/* 8n1 */
-	serial_out(port, UART_IER, 0);		/* no interrupt */
-	serial_out(port, UART_FCR, 0);		/* no fifo */
-	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
+	serial8250_early_out(port, UART_LCR, 0x3);	/* 8n1 */
+	serial8250_early_out(port, UART_IER, 0);	/* no interrupt */
+	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
+	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
 
 	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
-	c = serial_in(port, UART_LCR);
-	serial_out(port, UART_LCR, c | UART_LCR_DLAB);
-	serial_out(port, UART_DLL, divisor & 0xff);
-	serial_out(port, UART_DLM, (divisor >> 8) & 0xff);
-	serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+	c = serial8250_early_in(port, UART_LCR);
+	serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
+	serial8250_early_out(port, UART_DLL, divisor & 0xff);
+	serial8250_early_out(port, UART_DLM, (divisor >> 8) & 0xff);
+	serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
 }
 
 static int __init parse_options(struct early_serial8250_device *device,
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index c174c90..c490d20 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -105,6 +105,8 @@ extern int early_serial_setup(struct uart_port *port);
 
 extern int serial8250_find_port(struct uart_port *p);
 extern int serial8250_find_port_for_earlycon(void);
+extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
+extern void serial8250_early_out(struct uart_port *port, int offset, int value);
 extern int setup_early_serial8250_console(char *cmdline);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
-- 
1.7.1

Noam Camus