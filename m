From: Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] serial: 8250: Fix thread unsafe __dma_tx_complete function
Date: Fri, 18 Apr 2014 15:56:04 +0200
Message-ID: <1397829364-13402-1-git-send-email-loic.poulain@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18793 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbaDROBA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 10:01:00 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, yao.jin@intel.com, Loic Poulain <loic.poulain@intel.com>

__dma_tx_complete is not protected against concurrent
call of serial8250_tx_dma. it can lead to circular tail
index corruption or parallel call of serial_tx_dma on the
same data portion.

This patch fixes this issue by taking port lock before
call of serial8250_tx_dma.
Moreover it moves the "dma->tx_running = 0" after updating
tail index to avoid any dma tx with obsolete data.

The best solution should consist in locking the port for
all the function life. however, doing this leads to random
platform freezes. don't know why.

While waiting to get a better fix, this patch does the
job and avoid any perilous concurrent dma tx.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7046769..3a7b89f 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -20,8 +20,7 @@ static void __dma_tx_complete(void *param)
 	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct circ_buf		*xmit = &p->port.state->xmit;
-
-	dma->tx_running = 0;
+	unsigned long	flags;
 
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
@@ -30,11 +29,16 @@ static void __dma_tx_complete(void *param)
 	xmit->tail &= UART_XMIT_SIZE - 1;
 	p->port.icount.tx += dma->tx_size;
 
+	dma->tx_running = 0;
+
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port))
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port)) {
+		spin_lock_irqsave(&p->port.lock, flags);
 		serial8250_tx_dma(p);
+		spin_unlock_irqrestore(&p->port.lock, flags);
+	}
 }
 
 static void __dma_rx_complete(void *param)
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

