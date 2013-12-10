From: Jon Medhurst <tixy@linaro.org>
Subject: [PATCH 1/3] serial: amba-pl011: use port lock to guard control
 register access
Date: Tue, 10 Dec 2013 10:18:58 +0000
Message-ID: <1386670740-16914-2-git-send-email-tixy@linaro.org>
References: <1386670740-16914-1-git-send-email-tixy@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386670740-16914-1-git-send-email-tixy@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When the pl011 is being used for a console, pl011_console_write forces
the control register (CR) to enable the UART for transmission and then
restores this to the original value afterwards. It does this while
holding the port lock.

Unfortunately, when the uart is started or shutdown - say in response to
userland using the serial device for a terminal - then this updates the
control register without any locking.

This means we can have

  pl011_console_write   Save CR
  pl011_startup         Initialise CR, e.g. enable receive
  pl011_console_write   Restore old CR with receive not enabled

this result is a serial port which doesn't respond to any input.

A similar race in reverse could happen when the device is shutdown.

We can fix these problems by taking the port lock when updating CR.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7203864..a0dfb86 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1537,6 +1537,8 @@ static int pl011_startup(struct uart_port *port)
 	/*
 	 * Provoke TX FIFO interrupt into asserting.
 	 */
+	spin_lock_irq(&uap->port.lock);
+
 	cr = UART01x_CR_UARTEN | UART011_CR_TXE | UART011_CR_LBE;
 	writew(cr, uap->port.membase + UART011_CR);
 	writew(0, uap->port.membase + UART011_FBRD);
@@ -1561,6 +1563,8 @@ static int pl011_startup(struct uart_port *port)
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
 	writew(cr, uap->port.membase + UART011_CR);
 
+	spin_unlock_irq(&uap->port.lock);
+
 	/*
 	 * initialise the old status of the modem signals
 	 */
@@ -1629,11 +1633,13 @@ static void pl011_shutdown(struct uart_port *port)
 	 * it during startup().
 	 */
 	uap->autorts = false;
+	spin_lock_irq(&uap->port.lock);
 	cr = readw(uap->port.membase + UART011_CR);
 	uap->old_cr = cr;
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
 	writew(cr, uap->port.membase + UART011_CR);
+	spin_unlock_irq(&uap->port.lock);
 
 	/*
 	 * disable break condition and fifos
-- 
1.7.10.4
