From: Yin Kangkai <kangkai.yin@linux.intel.com>
Subject: NS16550A should be aware of the uart_console() when goto high
 speed?
Date: Wed, 19 Jan 2011 10:29:07 +0800
Message-ID: <20110119022907.GA27827@kai-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5784 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab1ASC3J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jan 2011 21:29:09 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@linux.intel.com>

Hi

During my debugging of a platform which has a NS16550A UART chip, I
found it will print garbage in the middle of serial console. Something
like this:

    ...
    [    1.771270] ERST: Table is not found!
    [    1.777618] Linux agpgart interface v0.103
    [    1.782739] [drm] Initialized drm 1.1.0 20060810
    [    1.788749] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
    [    1.796670] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
    
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    (will show a log of garbage here)
    
    (and then it is OK again for the login prompt)
    MeeGo release 1.1.80 (MeeGo)
    Kernel 2.6.37-6.1-adaptation-oaktrail on an i686
    ...

Googled and find this thread: https://lkml.org/lkml/2005/3/25/157
Tried that patch and it fixes this issue.

I tried to do some further investigation, and seems NS16550A driver
(8250.c) sets its own baud rate to high speed in autoconfig(). Should
not it be aware of the uart_console() thing? i.e. if the uart is
console, we can't make the change brutally, right?

Below is a dirty prove of concept patch, if it's the right direction,
I will surely clean it up. Thanks.

Kangkai

>From b29b0797ce2e4798ec55d7d4d04e8d59c739c058 Mon Sep 17 00:00:00 2001
From: Yin Kangkai <kangkai.yin@intel.com>
Date: Wed, 19 Jan 2011 09:59:24 +0800
Subject: [PATCH] NS16550A be aware of the uart_console() when goto high speed mode

In currently implementation, NS16550A will goto high speed mode (high
baud base) when it can, however, if that UART is used as a console,
this will break existing the baud rate setting, e.g. when you already
set console=ttyS0,115200n8 in kernel cmdline, and NS16550 is ttyS0,
during autoconfig(), it will set its baud rate brutally to 921600, and
makes the serial console print garbage.

This patch tries to make NS16550A be aware of the uart_console() when
it goes to high speed mode.

Signed-off-by: Yin Kangkai <kangkai.yin@linux.intel.com>
---
 drivers/serial/8250.c        |   42 +++++++++++++++++++++++-------------------
 drivers/serial/serial_core.c |    6 ------
 include/linux/serial_core.h  |    5 +++++
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 09a5508..2232e56 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -991,23 +991,25 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 		serial_outp(up, UART_MCR, status1);
 
 		if ((status2 ^ status1) & UART_MCR_LOOP) {
-			unsigned short quot;
+			if (!uart_console(&up->port)) {
+				unsigned short quot;
 
-			serial_outp(up, UART_LCR, 0xE0);
+				serial_outp(up, UART_LCR, 0xE0);
 
-			quot = serial_dl_read(up);
-			quot <<= 3;
+				quot = serial_dl_read(up);
+				quot <<= 3;
 
-			status1 = serial_in(up, 0x04); /* EXCR2 */
-			status1 &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */
-			status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
-			serial_outp(up, 0x04, status1);
+				status1 = serial_in(up, 0x04); /* EXCR2 */
+				status1 &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */
+				status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
+				serial_outp(up, 0x04, status1);
 
-			serial_dl_write(up, quot);
+				serial_dl_write(up, quot);
 
-			serial_outp(up, UART_LCR, 0);
+				serial_outp(up, UART_LCR, 0);
 
-			up->port.uartclk = 921600*16;
+				up->port.uartclk = 921600*16;
+			}
 			up->port.type = PORT_NS16550A;
 			up->capabilities |= UART_NATSEMI;
 			return;
@@ -2975,17 +2977,19 @@ void serial8250_resume_port(int line)
 	struct uart_8250_port *up = &serial8250_ports[line];
 
 	if (up->capabilities & UART_NATSEMI) {
-		unsigned char tmp;
+		if (!uart_console(&up->port)) {
+			unsigned char tmp;
 
-		/* Ensure it's still in high speed mode */
-		serial_outp(up, UART_LCR, 0xE0);
+			/* Ensure it's still in high speed mode */
+			serial_outp(up, UART_LCR, 0xE0);
 
-		tmp = serial_in(up, 0x04); /* EXCR2 */
-		tmp &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */
-		tmp |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
-		serial_outp(up, 0x04, tmp);
+			tmp = serial_in(up, 0x04); /* EXCR2 */
+			tmp &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */
+			tmp |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
+			serial_outp(up, 0x04, tmp);
 
-		serial_outp(up, UART_LCR, 0);
+			serial_outp(up, UART_LCR, 0);
+		}
 	}
 	uart_resume_port(&serial8250_reg, &up->port);
 }
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 9ffa5be..f68409f 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -51,12 +51,6 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
-#ifdef CONFIG_SERIAL_CORE_CONSOLE
-#define uart_console(port)	((port)->cons && (port)->cons->index == (port)->line)
-#else
-#define uart_console(port)	(0)
-#endif
-
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void __uart_wait_until_sent(struct uart_port *port, int timeout);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 212eb4c..ad18c08 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -601,6 +601,11 @@ uart_insert_char(struct uart_port *port, unsigned int status,
 #define UART_ENABLE_MS(port,cflag)	((port)->flags & UPF_HARDPPS_CD || \
 					 (cflag) & CRTSCTS || \
 					 !((cflag) & CLOCAL))
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+#define uart_console(port)      ((port)->cons && (port)->cons->index == (port)->line)
+#else
+#define uart_console(port)      (0)
+#endif
 
 #endif
 
-- 
1.6.5

