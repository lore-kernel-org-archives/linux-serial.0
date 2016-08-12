From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v10 07/11] serial: 8250: enable AFE on ports where FIFO is 16 bytes
Date: Fri, 12 Aug 2016 19:01:52 +0300
Message-ID: <1471017716-44893-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1471017716-44893-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471017716-44893-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Intel Quark has 16550A compatible UART with autoflow feature enabled. It has
only 16 bytes of FIFO. Currently serial8250_do_set_termios() prevents to enable
autoflow since the minimum requirement of 32 bytes of FIFO size.

Drop a FIFO size limitation to allow autoflow control be enabled on such UARTs.

While here, comment out UART_CAP_AFE for PORT_AR7 since it wasn't working and
it will be not a good idea to use it in conjunction with trigger level of 1
byte.

Suggested-by: Peter Hurley <peter@hurleysoftware.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index bdfa659..9bad1c5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -178,7 +178,7 @@ static const struct serial8250_config uart_config[] = {
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
-		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+		.flags		= UART_CAP_FIFO /* | UART_CAP_AFE */,
 	},
 	[PORT_U6_16550A] = {
 		.name		= "U6_16550A",
@@ -2546,12 +2546,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * MCR-based auto flow control.  When AFE is enabled, RTS will be
 	 * deasserted when the receive FIFO contains more characters than
-	 * the trigger, or the MCR RTS bit is cleared.  In the case where
-	 * the remote UART is not using CTS auto flow control, we must
-	 * have sufficient FIFO entries for the latency of the remote
-	 * UART to respond.  IOW, at least 32 bytes of FIFO.
+	 * the trigger, or the MCR RTS bit is cleared.
 	 */
-	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
+	if (up->capabilities & UART_CAP_AFE) {
 		up->mcr &= ~UART_MCR_AFE;
 		if (termios->c_cflag & CRTSCTS)
 			up->mcr |= UART_MCR_AFE;
-- 
2.8.1
