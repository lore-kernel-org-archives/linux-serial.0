From: "Michael Kohne" <mhkohne@discordia.org>
Subject: [PATCH] Improve low latency behaviour of 16550 driver
Date: Thu, 15 Apr 2004 14:16:14 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <10966.209.92.255.18.1082052974.squirrel@www.discordia.org>
References: <11992.209.92.255.18.1069169329.squirrel@www.discordia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from techno.discordia.org ([66.92.231.194]:4080 "EHLO
	techno.discordia.org") by vger.kernel.org with ESMTP
	id S264098AbUDOSQQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Apr 2004 14:16:16 -0400
In-Reply-To: <11992.209.92.255.18.1069169329.squirrel@www.discordia.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tytso@mit.edu, rmk+serial@arm.linux.org.uk

This patch enhances the functionality of the low_latency flag for 16550
type serial ports. It reduces the latency of small numbers of recieved
characters by lowering the receive fifo trigger level whenever the
low_latency flag is set. This means that in situations where a small
(say, 1 character) response is expected, you can get that response to
the application layer more quickly using this patch. On a normal 16550A,
the latency (time from send of small packet to application receive of
first response character) drops by about 7 milliseconds when using this
patch on a 4800 baud setup.

A note on testing: My tests work by bouncing small packets off of our own
equipment on a 422 bus. A suitable test rig would be anything that could
respond to a serial packet in constant time with a single byte.

This patch was developed by Michael Kohne at Gasboy International.

I've included patches for kernel 2.4.26 and 2.6.5, and I offer this patch
for inclusion in the kernel. It's small, well contained, and I think the
extension of the behaviour of the low_latency flag is appropriate. If it
isn't appropriate for some reason, I'd appreciate knowning why.

Thank you.

Patch for 2.4.26 kernel:

diff -urN linux-2.4.26.orig/drivers/char/serial.c
linux-2.4.26/drivers/char/serial.c
--- linux-2.4.26.orig/drivers/char/serial.c     2004-04-15
11:49:00.000000000 -0400
+++ linux-2.4.26/drivers/char/serial.c  2004-04-15 11:51:34.000000000 -0400
@@ -1733,7 +1733,9 @@

        /* Set up FIFO's */
        if (uart_config[info->state->type].flags & UART_USE_FIFO) {
-               if ((info->state->baud_base / quot) < 2400)
+               /* minimize latency on low baud or user command */
+               if ( ((info->state->baud_base / quot) < 2400) ||
+                       (info->tty->low_latency) )
                        fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
 #ifdef CONFIG_SERIAL_RSA
                else if (info->state->type == PORT_RSA)



Patch for 2.6.5 kernel:

diff -uprN linux-2.6.5.orig/drivers/serial/8250.c
linux-2.6.5/drivers/serial/8250.c
--- linux-2.6.5.orig/drivers/serial/8250.c      2004-04-14
05:21:36.000000000 -0400
+++ linux-2.6.5/drivers/serial/8250.c   2004-04-14 05:18:45.000000000 -0400
@@ -1441,8 +1441,9 @@ serial8250_set_termios(struct uart_port
                quot ++;

        if (up->capabilities & UART_USE_FIFO) {
-               if (baud < 2400)
-                       fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+               /* Minimize fifo size on low speed link or user cmd */
+               if ( (baud < 2400) || (port->flags & UPF_LOW_LATENCY) )
+                       fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
 #ifdef CONFIG_SERIAL_8250_RSA
                else if (up->port.type == PORT_RSA)
                        fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_14;



