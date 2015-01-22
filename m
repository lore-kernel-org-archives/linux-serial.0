From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/7] serial: 8250: Move UART_BUG_QUOT workaround
Date: Thu, 22 Jan 2015 12:24:26 -0500
Message-ID: <1421947471-6396-3-git-send-email-peter@hurleysoftware.com>
References: <1421947471-6396-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421947471-6396-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The UART_BUG_QUOT workaround adjusts the divisor computed from the
baud rate by serial8250_get_divisor(). Move the workaround into
serial8250_get_divisor(), so that divisor-from-baud computation
is encapsulated.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 3bfcfdb..fa40982 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2390,8 +2390,9 @@ static void serial8250_shutdown(struct uart_port *port)
 		serial8250_do_shutdown(port);
 }
 
-static unsigned int serial8250_get_divisor(struct uart_port *port, unsigned int baud)
+static unsigned int serial8250_get_divisor(struct uart_8250_port *up, unsigned int baud)
 {
+	struct uart_port *port = &up->port;
 	unsigned int quot;
 
 	/*
@@ -2407,6 +2408,12 @@ static unsigned int serial8250_get_divisor(struct uart_port *port, unsigned int
 	else
 		quot = uart_get_divisor(port, baud);
 
+	/*
+	 * Oxford Semi 952 rev B workaround
+	 */
+	if (up->bugs & UART_BUG_QUOT && (quot & 0xff) == 0)
+		quot++;
+
 	return quot;
 }
 
@@ -2455,13 +2462,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 0xffff,
 				  port->uartclk / 16);
-	quot = serial8250_get_divisor(port, baud);
-
-	/*
-	 * Oxford Semi 952 rev B workaround
-	 */
-	if (up->bugs & UART_BUG_QUOT && (quot & 0xff) == 0)
-		quot++;
+	quot = serial8250_get_divisor(up, baud);
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
 		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-- 
2.2.2
