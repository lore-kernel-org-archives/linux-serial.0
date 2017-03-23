From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 1/2] serial: samsung: Use right device for DMA-mapping calls
Date: Thu, 23 Mar 2017 13:01:52 +0100
Message-ID: <1490270519-4046-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170323120208eucas1p28df58f312314337e9750d23930de733b@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Driver should provide its own struct device for all DMA-mapping calls instead
of extracting device pointer from DMA engine channel.

Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Fixes: 62c37eedb74c8 ("serial: samsung: add dma reqest/release functions")
CC: stable@vger.kernel.org # v4.0+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- fixed commit id in 'fixes' tag, added 'reviewed-by' tag
---
 drivers/tty/serial/samsung.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7a17aedbf902..9f3759bdb44f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -901,14 +901,13 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		return -ENOMEM;
 	}
 
-	dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
+	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	spin_lock_irqsave(&p->port.lock, flags);
 
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
-				p->port.state->xmit.buf,
+	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
@@ -922,7 +921,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->rx_chan) {
 		dmaengine_terminate_all(dma->rx_chan);
-		dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+		dma_unmap_single(p->port.dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 		kfree(dma->rx_buf);
 		dma_release_channel(dma->rx_chan);
@@ -931,7 +930,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->tx_chan) {
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
+		dma_unmap_single(p->port.dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 		dma_release_channel(dma->tx_chan);
 		dma->tx_chan = NULL;
-- 
1.9.1
