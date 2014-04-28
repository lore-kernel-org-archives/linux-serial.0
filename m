From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] serial: 8250_dma: check the result of TX buffer mapping
Date: Mon, 28 Apr 2014 15:59:56 +0300
Message-ID: <1398689996-17182-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24337 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbaD1NAX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Apr 2014 09:00:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

Using dma_mapping_error() to make sure the mapping did not
fail.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index ab9096d..148ffe4 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -192,21 +192,28 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dma->rx_buf = dma_alloc_coherent(dma->rxchan->device->dev, dma->rx_size,
 					&dma->rx_addr, GFP_KERNEL);
-	if (!dma->rx_buf) {
-		dma_release_channel(dma->rxchan);
-		dma_release_channel(dma->txchan);
-		return -ENOMEM;
-	}
+	if (!dma->rx_buf)
+		goto err;
 
 	/* TX buffer */
 	dma->tx_addr = dma_map_single(dma->txchan->device->dev,
 					p->port.state->xmit.buf,
 					UART_XMIT_SIZE,
 					DMA_TO_DEVICE);
+	if (dma_mapping_error(dma->txchan->device->dev, dma->tx_addr)) {
+		dma_free_coherent(dma->rxchan->device->dev, dma->rx_size,
+				  dma->rx_buf, dma->rx_addr);
+		goto err;
+	}
 
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
 
 	return 0;
+err:
+	dma_release_channel(dma->rxchan);
+	dma_release_channel(dma->txchan);
+
+	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
-- 
2.0.0.rc0

