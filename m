From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH][2.6.10-rc2-bk9] Assume struct uart_state closing times are
 in centiseconds
Date: Fri, 26 Nov 2004 21:29:35 +0000
Message-ID: <41A7A03F.9030400@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040600070104020903070101"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:8619 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264009AbUKZV3o (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Nov 2004 16:29:44 -0500
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CXnet-0007pU-00
	for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2004 22:29:39 +0100
Received: from mail.mev.co.uk ([62.49.15.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2004 22:29:39 +0100
Received: from abbotti by mail.mev.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2004 22:29:39 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russell King <rmk+serial@arm.linux.org.uk>

This is a multi-part message in MIME format.
--------------040600070104020903070101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[Reposting due to Cc: address mix-up the first time!]

Hi,

The current use of close_delay and closing_wait within serial_core.c is
a little messed up for the following reasons:

* The values are scaled by uart_set_info() but not scaled back by
uart_get_info(), so the values are different unless HZ==100.

* The closing_wait value is scaled by uart_set_info() and compared to an
unscaled magic value USF_CLOSING_WAIT_NONE in uart_close().

As uart_set_info already assumes that the new values are in centisecond
units and scaling could mess up the comparison with magic values (even
if the magic values are scaled), I propose to store the raw centisecond
values in struct uart_state and scale them at the point of use.  Here is
a patch to do that.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>


--------------040600070104020903070101
Content-Type: text/x-patch;
 name="serial_closing_time.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial_closing_time.patch"

diff -urN linux-2.6.10-rc2-bk9/drivers/serial/serial_core.c linux-2.6.10-rc2-bk9-ia/drivers/serial/serial_core.c
--- linux-2.6.10-rc2-bk9/drivers/serial/serial_core.c	2004-11-26 17:26:07.750667256 +0000
+++ linux-2.6.10-rc2-bk9-ia/drivers/serial/serial_core.c	2004-11-26 17:46:32.523473488 +0000
@@ -751,8 +751,8 @@
 	port->flags            = (port->flags & ~UPF_CHANGE_MASK) |
 				 (new_serial.flags & UPF_CHANGE_MASK);
 	port->custom_divisor   = new_serial.custom_divisor;
-	state->close_delay     = new_serial.close_delay * HZ / 100;
-	state->closing_wait    = new_serial.closing_wait * HZ / 100;
+	state->close_delay     = new_serial.close_delay;
+	state->closing_wait    = new_serial.closing_wait;
 	port->fifosize         = new_serial.xmit_fifo_size;
 	if (state->info->tty)
 		state->info->tty->low_latency =
@@ -1191,7 +1191,7 @@
 	tty->closing = 1;
 
 	if (state->closing_wait != USF_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, state->closing_wait);
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 
 	/*
 	 * At this point, we stop accepting input.  To do this, we
@@ -1220,7 +1220,7 @@
 
 	if (state->info->blocked_open) {
 		if (state->close_delay) {
-			msleep_interruptible(jiffies_to_msecs(state->close_delay));
+			msleep_interruptible(10 * state->close_delay);
 		}
 	} else if (!uart_console(port)) {
 		uart_change_pm(state, 3);
@@ -2082,8 +2082,8 @@
 	for (i = 0; i < drv->nr; i++) {
 		struct uart_state *state = drv->state + i;
 
-		state->close_delay     = 5 * HZ / 10;
-		state->closing_wait    = 30 * HZ;
+		state->close_delay     = 50;	/* .5 seconds */
+		state->closing_wait    = 3000;	/* 30 seconds */
 
 		init_MUTEX(&state->sem);
 	}
diff -urN linux-2.6.10-rc2-bk9/include/linux/serial_core.h linux-2.6.10-rc2-bk9-ia/include/linux/serial_core.h
--- linux-2.6.10-rc2-bk9/include/linux/serial_core.h	2004-11-26 17:26:14.787597480 +0000
+++ linux-2.6.10-rc2-bk9-ia/include/linux/serial_core.h	2004-11-26 17:49:09.499609488 +0000
@@ -241,8 +241,8 @@
  * within.
  */
 struct uart_state {
-	unsigned int		close_delay;
-	unsigned int		closing_wait;
+	unsigned int		close_delay;	/* units: centiseconds */
+	unsigned int		closing_wait;	/* units: centiseconds */
 
 #define USF_CLOSING_WAIT_INF	(0)
 #define USF_CLOSING_WAIT_NONE	(65535)


--------------040600070104020903070101--

