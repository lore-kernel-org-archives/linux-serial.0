From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 7/7] serial: 8250: Prevent concurrent updates to shadow registers
Date: Thu, 22 Jan 2015 12:24:31 -0500
Message-ID: <1421947471-6396-8-git-send-email-peter@hurleysoftware.com>
References: <1421947471-6396-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421947471-6396-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The port shadow registers, ->fcr and ->mcr, must be protected from
concurrent updates. Relocate the shadow register updates in
serial8250_do_set_termios() to the port lock critical section.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 8fd4b57..ed15341 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2526,6 +2526,15 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 				  port->uartclk / 16);
 	quot = serial8250_get_divisor(up, baud, &frac);
 
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	serial8250_rpm_get(up);
+	spin_lock_irqsave(&port->lock, flags);
+
+	up->lcr = cval;					/* Save computed LCR */
+
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
 		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
 		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
@@ -2549,15 +2558,6 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/*
-	 * Ok, we're now changing the port state.  Do it with
-	 * interrupts disabled.
-	 */
-	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
-
-	up->lcr = cval;					/* Save computed LCR */
-
-	/*
 	 * Update the per-port timeout.
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
-- 
2.2.2
