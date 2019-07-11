From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: [PATCH] tty: amba-pl011: Make TX optimisation conditional
Date: Thu, 11 Jul 2019 14:45:32 +0100
Message-ID: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

pl011_tx_chars takes a "from_irq" parameter to reduce the number of
register accesses. When from_irq is true the function assumes that the
FIFO is half empty and writes up to half a FIFO's worth of bytes
without polling the FIFO status register, the reasoning being that
the function is being called as a result of the TX interrupt being
raised. This logic would work were it not for the fact that
pl011_rx_chars, called from pl011_int before pl011_tx_chars, releases
the spinlock before calling tty_flip_buffer_push.

A user thread writing to the UART claims the spinlock and ultimately
calls pl011_tx_chars with from_irq set to false. This reverts to the
older logic that polls the FIFO status register before sending every
byte. If this happen on an SMP system during the section of the IRQ
handler where the spinlock has been released, then by the time the TX
interrupt handler is called, the FIFO may already be full, and any
further writes are likely to be lost.

The fix involves adding a per-port flag that is true iff running from
within the interrupt handler and the spinlock has not yet been released.
This flag is then used as the value for the from_irq parameter of
pl011_tx_chars, causing polling to be used in the unsafe case.

Fixes: 1e84d22322ce ("serial/amba-pl011: Refactor and simplify TX FIFO handling")

Signed-off-by: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
---
 drivers/tty/serial/amba-pl011.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33..70c1dc9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -270,6 +270,7 @@ struct uart_amba_port {
 	unsigned int		old_cr;		/* state during shutdown */
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
+	bool			irq_locked;	/* in irq, unreleased lock */
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	bool			using_tx_dma;
@@ -814,6 +815,7 @@ __acquires(&uap->port.lock)
 		return;
 
 	/* Avoid deadlock with the DMA engine callback */
+	uap->irq_locked = 0;
 	spin_unlock(&uap->port.lock);
 	dmaengine_terminate_all(uap->dmatx.chan);
 	spin_lock(&uap->port.lock);
@@ -941,6 +943,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 		fifotaken = pl011_fifo_to_tty(uap);
 	}
 
+	uap->irq_locked = 0;
 	spin_unlock(&uap->port.lock);
 	dev_vdbg(uap->port.dev,
 		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
@@ -1349,6 +1352,7 @@ __acquires(&uap->port.lock)
 {
 	pl011_fifo_to_tty(uap);
 
+	uap->irq_locked = 0;
 	spin_unlock(&uap->port.lock);
 	tty_flip_buffer_push(&uap->port.state->port);
 	/*
@@ -1483,6 +1487,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	int handled = 0;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
+	uap->irq_locked = 1;
 	status = pl011_read(uap, REG_RIS) & uap->im;
 	if (status) {
 		do {
@@ -1502,7 +1507,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 				      UART011_CTSMIS|UART011_RIMIS))
 				pl011_modem_status(uap);
 			if (status & UART011_TXIS)
-				pl011_tx_chars(uap, true);
+				pl011_tx_chars(uap, uap->irq_locked);
 
 			if (pass_counter-- == 0)
 				break;
-- 
2.7.4
