From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH v2] serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO
Date: Fri, 15 Feb 2019 18:45:08 +0200
Message-ID: <20190215164508.27237-1-anssi.hannula@bitwise.fi>
References: <BL0PR02MB491508D8FDFECD3211BF1943AA670@BL0PR02MB4915.namprd02.prod.outlook.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <BL0PR02MB491508D8FDFECD3211BF1943AA670@BL0PR02MB4915.namprd02.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhraj@xilinx.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If RX is disabled while there are still unprocessed bytes in RX FIFO,
cdns_uart_handle_rx() called from interrupt handler will get stuck in
the receive loop as read bytes will not get removed from the RX FIFO
and CDNS_UART_SR_RXEMPTY bit will never get set.

Avoid the stuck handler by checking first if RX is disabled. port->lock
protects against race with RX-disabling functions.

This HW behavior was mentioned by Nathan Rossi in 43e98facc4a3 ("tty:
xuartps: Fix RX hang, and TX corruption in termios call") which fixed a
similar issue in cdns_uart_set_termios().
The behavior can also be easily verified by e.g. setting
CDNS_UART_CR_RX_DIS at the beginning of cdns_uart_handle_rx() - the
following loop will then get stuck.

Resetting the FIFO using RXRST would not set RXEMPTY either so simply
issuing a reset after RX-disable would not work.

I observe this frequently on a ZynqMP board during heavy RX load at 1M
baudrate when the reader process exits and thus RX gets disabled.

Fixes: 61ec9016988f ("tty/serial: add support for Xilinx PS UART")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: stable@vger.kernel.org
---

Shubhrajyoti Datta wrote:
> Minor nit below.
> The call to the cdns_uart_handle_rx could be prevented in  cdns_uart_isr 

OK, changed, thanks.

Personally I liked it slightly better in handle_rx() closer to the
problematic loop (and RX being disabled here should be rare), but I'm
fine with either.

v2: Moved check from cdns_uart_handle_rx() to caller.

 drivers/tty/serial/xilinx_uartps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 094f2958cb2b..ee9f18c52d29 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -364,7 +364,13 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_RXMASK)
+
+	/*
+	 * Skip RX processing if RX is disabled as RXEMPTY will never be set
+	 * as read bytes will not be removed from the FIFO.
+	 */
+	if (isrstatus & CDNS_UART_IXR_RXMASK &&
+	    !(readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS))
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);
-- 
2.17.2
