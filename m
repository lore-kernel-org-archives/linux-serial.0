From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v7 05/11] serial: 8250_dma: switch to new dmaengine_terminate_* API
Date: Fri, 17 Jun 2016 15:41:05 +0300
Message-ID: <1466167271-11902-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1466167271-11902-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466167271-11902-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Convert dmaengine_terminate_all() calls to synchronous and asynchronous
versions where appropriate.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7f33d1c..c759242 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -142,7 +142,7 @@ void serial8250_rx_dma_flush(struct uart_8250_port *p)
 	if (dma->rx_running) {
 		dmaengine_pause(dma->rxchan);
 		__dma_rx_complete(p);
-		dmaengine_terminate_all(dma->rxchan);
+		dmaengine_terminate_async(dma->rxchan);
 	}
 }
 
@@ -246,14 +246,14 @@ void serial8250_release_dma(struct uart_8250_port *p)
 		return;
 
 	/* Release RX resources */
-	dmaengine_terminate_all(dma->rxchan);
+	dmaengine_terminate_sync(dma->rxchan);
 	dma_free_coherent(dma->rxchan->device->dev, dma->rx_size, dma->rx_buf,
 			  dma->rx_addr);
 	dma_release_channel(dma->rxchan);
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_all(dma->txchan);
+	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dma->txchan->device->dev, dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);
-- 
2.8.1
