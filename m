From: california.l.sullivan@intel.com
Subject: [PATCH RFC] serial: 8250: Handle invalid UART state
Date: Wed, 19 Aug 2015 13:12:04 -0700
Message-ID: <1440015124-28393-1-git-send-email-california.l.sullivan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, alan@linux.intel.com, darren.hart@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com, california.l.sullivan@intel.com, heikki.krogerus@intel.com, andriy.shevchenko@intel.com, arjan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

From: California Sullivan <california.l.sullivan@intel.com>

The debug UART on the Bay Trail is buggy and will sometimes enter a
state where there is a Character Timeout interrupt, but the Data
Ready bit in the Line Status Register is not set, despite there
being data available in the FIFO. It stays in this state until the
Receive Buffer is read. Because the 8250 driver does not read the
Receive Buffer without the Data Ready bit being set, the UART is
never read once we reach this point, and thus the Character Timeout
interrupt is never cleared. This makes the driver spin in a loop
causing multiple "too much work for irq" errors and eventually
locking up entirely.

This patch handles the invalid state by setting the Data Ready bit
in the 'status' variable when the invalid state occurs. This allows
the receive buffer to be read, which clears the interrupt
identification register in the UART and brings us back to a correct
state.

After this patch was submitted for internal comment, a similar bug on
the HSUARTs of the Bay Trail and Braswell platforms was pointed out.
On those UARTs, the invalid state mentioned previously is reached for
some amount of time, cauing the same "too much work for irq" messages,
but not permanently locking up the UART. This patch has been confirmed
to solve that issue as well.

We considered solving this by adding a new UART_BUG_ define and
detecting the buggy UART by either identifying the processor or by
adding a new PNP device ID to firmware. However, this solution
would be more complex and have zero performance benefits, as the
ISR would require a similar 'if' condition to detect and handle the
bug.

Our main concern with this fix is whether it having a Character
Timeout with no Data Ready is an invalid state for all UARTs or
just some. If other UARTs have a Character Timeout without
immediately flipping the Data Ready bit in the Line Status Register
for a good reason, setting the Data Ready bit in the 'status'
variable could have unintended consequences.

Signed-off-by: California Sullivan <california.l.sullivan@intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ea1a8da..078b118 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1604,6 +1604,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	DEBUG_INTR("status = %x...", status);
 
+	/*
+	 * Workaround for when there is a character timeout interrupt
+	 * but the data ready bit is not set in the Line Status Register.
+	 */
+	if ((iir & UART_IIR_RX_TIMEOUT) &&
+	    !(status & (UART_LSR_DR | UART_LSR_BI)))
+		status |= UART_LSR_DR;
+
 	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 		if (up->dma)
 			dma_err = up->dma->rx_dma(up, iir);
-- 
2.1.0
