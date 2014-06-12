From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] serial: 8250_dma: sync regions for device before transfer
Date: Thu, 12 Jun 2014 18:51:18 +0300
Message-ID: <1402588278-15109-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12799 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbaFLPvp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jun 2014 11:51:45 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The documentation says that we have to sync DMA regions after CPU access and
before any DMA transfer is going on. The actual DMA for buffer happens when we
call dmaengine_submit() (*). The original code syncs data after this call which
might lead to the corrupted data in actual stream.

(*) Accordingly to the Documentation/dmaengine.txt the dmaengine_submit call
shouldn't do the transfer, but some DMA controller drivers abuse this rule.
Thus, we would like to have this patch until all DMA controller drivers will be
fixed. Even after that it will be harmless.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 148ffe4..f70ee29 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -76,6 +76,8 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
+	dma_sync_single_for_device(dma->txchan->device->dev, dma->tx_addr,
+				   UART_XMIT_SIZE, DMA_TO_DEVICE);
 	desc = dmaengine_prep_slave_single(dma->txchan,
 					   dma->tx_addr + xmit->tail,
 					   dma->tx_size, DMA_MEM_TO_DEV,
@@ -90,9 +92,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	dma->tx_cookie = dmaengine_submit(desc);
 
-	dma_sync_single_for_device(dma->txchan->device->dev, dma->tx_addr,
-				   UART_XMIT_SIZE, DMA_TO_DEVICE);
-
 	dma_async_issue_pending(dma->txchan);
 
 	return 0;
@@ -129,6 +128,8 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 	if (dma_status)
 		return 0;
 
+	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
+				   dma->rx_size, DMA_FROM_DEVICE);
 	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
 					   dma->rx_size, DMA_DEV_TO_MEM,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -140,9 +141,6 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 
 	dma->rx_cookie = dmaengine_submit(desc);
 
-	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
-				   dma->rx_size, DMA_FROM_DEVICE);
-
 	dma_async_issue_pending(dma->rxchan);
 
 	return 0;
-- 
2.0.0

