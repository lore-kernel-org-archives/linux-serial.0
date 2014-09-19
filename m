From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 04/10] drivers: PL011: refactor pl011_set_termios()
Date: Fri, 19 Sep 2014 13:21:17 +0100
Message-ID: <1411129283-17219-5-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36073 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756028AbaISMWH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:07 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Split the pl011_set_termios() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   60 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 17ba997..9219127 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1695,6 +1695,38 @@ static void pl011_shutdown(struct uart_port *port)
 }
 
 static void
+pl011_setup_status_masks(struct uart_port *port, struct ktermios *termios)
+{
+	port->read_status_mask = UART011_DR_OE | 255;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= UART011_DR_FE | UART011_DR_PE;
+	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
+		port->read_status_mask |= UART011_DR_BE;
+
+	/*
+	 * Characters to ignore
+	 */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= UART011_DR_FE | UART011_DR_PE;
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |= UART011_DR_BE;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |= UART011_DR_OE;
+	}
+
+	/*
+	 * Ignore all characters if CREAD is not set.
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		port->ignore_status_mask |= UART_DUMMY_DR_RX;
+}
+
+static void
 pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		     struct ktermios *old)
 {
@@ -1757,33 +1789,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	port->read_status_mask = UART011_DR_OE | 255;
-	if (termios->c_iflag & INPCK)
-		port->read_status_mask |= UART011_DR_FE | UART011_DR_PE;
-	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		port->read_status_mask |= UART011_DR_BE;
-
-	/*
-	 * Characters to ignore
-	 */
-	port->ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		port->ignore_status_mask |= UART011_DR_FE | UART011_DR_PE;
-	if (termios->c_iflag & IGNBRK) {
-		port->ignore_status_mask |= UART011_DR_BE;
-		/*
-		 * If we're ignoring parity and break indicators,
-		 * ignore overruns too (for real raw support).
-		 */
-		if (termios->c_iflag & IGNPAR)
-			port->ignore_status_mask |= UART011_DR_OE;
-	}
-
-	/*
-	 * Ignore all characters if CREAD is not set.
-	 */
-	if ((termios->c_cflag & CREAD) == 0)
-		port->ignore_status_mask |= UART_DUMMY_DR_RX;
+	pl011_setup_status_masks(port, termios);
 
 	if (UART_ENABLE_MS(port, termios->c_cflag))
 		pl011_enable_ms(port);
-- 
1.7.9.5

