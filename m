From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 11/12] serial: clps711x: Fix TERMIOS-flags handling
Date: Sun, 14 Oct 2012 11:05:33 +0400
Message-ID: <1350198334-18737-11-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:47454 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:38 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index e715087..90efe05 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -273,10 +273,9 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int ubrlcr, baud, quot;
 	unsigned long flags;
 
-	/*
-	 * We don't implement CREAD.
-	 */
-	termios->c_cflag |= CREAD;
+	/* Mask termios capabilities we don't support */
+	termios->c_cflag &= ~CMSPAR;
+	termios->c_iflag &= ~(BRKINT | IGNBRK);
 
 	/* Ask the core to calculate the divisor for us */
 	baud = uart_get_baud_rate(port, termios, old, port->uartclk / 4096,
@@ -297,8 +296,10 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 		ubrlcr = UBRLCR_WRDLEN8;
 		break;
 	}
+
 	if (termios->c_cflag & CSTOPB)
 		ubrlcr |= UBRLCR_XSTOP;
+
 	if (termios->c_cflag & PARENB) {
 		ubrlcr |= UBRLCR_PRTEN;
 		if (!(termios->c_cflag & PARODD))
@@ -310,33 +311,20 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	/*
-	 * Update the per-port timeout.
-	 */
-	uart_update_timeout(port, termios->c_cflag, baud);
-
+	/* Set read status mask */
 	port->read_status_mask = UARTDR_OVERR;
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= UARTDR_PARERR | UARTDR_FRMERR;
 
-	/*
-	 * Characters to ignore
-	 */
+	/* Set status ignore mask */
 	port->ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		port->ignore_status_mask |= UARTDR_FRMERR | UARTDR_PARERR;
-	if (termios->c_iflag & IGNBRK) {
-		/*
-		 * If we're ignoring parity and break indicators,
-		 * ignore overruns to (for real raw support).
-		 */
-		if (termios->c_iflag & IGNPAR)
-			port->ignore_status_mask |= UARTDR_OVERR;
-	}
+	if (!(termios->c_cflag & CREAD))
+		port->ignore_status_mask |= UARTDR_OVERR | UARTDR_PARERR |
+					    UARTDR_FRMERR;
 
-	quot -= 1;
+	uart_update_timeout(port, termios->c_cflag, baud);
 
-	clps_writel(ubrlcr | quot, UBRLCR(port));
+	clps_writel(ubrlcr | (quot - 1), UBRLCR(port));
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-- 
1.7.8.6

