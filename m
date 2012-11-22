From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 1/2] serial: mxs-auart: disable the Receive Timeout Interrupt when DMA is enabled
Date: Thu, 22 Nov 2012 15:06:29 +0800
Message-ID: <1353567990-19907-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, lauri.hintsala@bluegiga.com, Huang Shijie <b32955@freescale.com>
List-Id: linux-serial@vger.kernel.org

When the DMA is enabled, the Receive Timeout interrupt is very easy to be arised
in the 3M baud rate.  The interrupt handler (aka mxs_auart_irq_handle) will call
mxs_auart_rx_chars() to handle the received data. This is not right, we can not
get the correct data from the RXFIFO now, the data have been moved to the
DMA buffer by the DMA engine.

This patch
  (1) disables the Receive Timeout Interrupt when the DMA is enabled,
  (2) and invoke the mxs_auart_rx_chars() only when the DMA is not enabled.

Signed-off-by: Huang Shijie <b32955@freescale.com>
Tested-by: Lauri Hintsala <lauri.hintsala@bluegiga.com> 
---
 drivers/tty/serial/mxs-auart.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d5b9e30..2342b0d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -695,7 +695,8 @@ static void mxs_auart_settermios(struct uart_port *u,
 		!test_and_set_bit(MXS_AUART_DMA_RX_READY, &s->flags)) {
 		if (!mxs_auart_dma_prep_rx(s)) {
 			/* Disable the normal RX interrupt. */
-			writel(AUART_INTR_RXIEN, u->membase + AUART_INTR_CLR);
+			writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN,
+					u->membase + AUART_INTR_CLR);
 		} else {
 			mxs_auart_dma_exit(s);
 			dev_err(s->dev, "We can not start up the DMA.\n");
@@ -719,7 +720,8 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 	}
 
 	if (istat & (AUART_INTR_RTIS | AUART_INTR_RXIS)) {
-		mxs_auart_rx_chars(s);
+		if (!auart_dma_enabled(s))
+			mxs_auart_rx_chars(s);
 		istat &= ~(AUART_INTR_RTIS | AUART_INTR_RXIS);
 	}
 
-- 
1.7.0.4
