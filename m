From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/12] serial: 8250: enable AFE on ports where FIFO is 16 bytes
Date: Thu,  7 Apr 2016 23:37:09 +0300
Message-ID: <1460061433-63750-9-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Intel Quark has 16550A compatible UART with autoflow feature enabled. It has
only 16 bytes of FIFO. Currently serial8250_do_set_termios() prevents to enable
autoflow since the minimum requirement of 32 bytes of FIFO size.

Decrease a FIFO size limitation to 16 bytes to allow autoflow control be
enabled on such UARTs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e213da0..3f8121e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2522,9 +2522,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * the trigger, or the MCR RTS bit is cleared.  In the case where
 	 * the remote UART is not using CTS auto flow control, we must
 	 * have sufficient FIFO entries for the latency of the remote
-	 * UART to respond.  IOW, at least 32 bytes of FIFO.
+	 * UART to respond.  IOW, at least 16 bytes of FIFO.
 	 */
-	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
+	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 16) {
 		up->mcr &= ~UART_MCR_AFE;
 		if (termios->c_cflag & CRTSCTS)
 			up->mcr |= UART_MCR_AFE;
-- 
2.8.0.rc3
