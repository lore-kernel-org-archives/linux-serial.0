From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH] serial: 8250: Support XR17V35x fraction divisor
Date: Tue, 11 Feb 2014 18:30:01 -0600 (CST)
Message-ID: <1442475818.84768.1392165001658.JavaMail.zimbra@xes-inc.com>
References: <2007190186.84300.1392164036297.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:64654 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbaBLAaF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Feb 2014 19:30:05 -0500
In-Reply-To: <2007190186.84300.1392164036297.JavaMail.zimbra@xes-inc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Schultz <jschultz@xes-inc.com>

From: Joe Schultz <jschultz@xes-inc.com>

The Exar XR17V35x family of UARTs have an additional fractional divisor
register (DLD) which was not being used. Calculate and set this
register for these devices to reduce their baud rate error.

Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/tty/serial/8250/8250_core.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 61ecd70..69932b7 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2433,6 +2433,24 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_dl_write(up, quot);
 
 	/*
+	 * XR17V35x UARTs have an extra fractional divisor register (DLD)
+	 *
+	 * We need to recalculate all of the registers, because DLM and DLL
+	 * are already rounded to a whole integer.
+	 *
+	 * When recalculating we use a 32x clock instead of a 16x clock to
+	 * allow 1-bit for rounding in the fractional part.
+	 */
+	if (up->port.type == PORT_XR17V35X) {
+		unsigned int baud_x32 = (port->uartclk * 2) / baud;
+		u16 quot = baud_x32 / 32;
+		u8 quot_frac = DIV_ROUND_CLOSEST(baud_x32 % 32, 2);
+
+		serial_dl_write(up, quot);
+		serial_port_out(port, 0x2, quot_frac & 0xf);
+	}
+
+	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
 	 */
-- 
1.7.9.5

