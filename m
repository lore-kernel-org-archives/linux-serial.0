From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/2] serial: samsung: Add missing checks for dma_map_single
 failure
Date: Thu, 23 Mar 2017 08:45:22 +0100
Message-ID: <1490255131-9597-2-git-send-email-m.szyprowski@samsung.com>
References: <1490255131-9597-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323074553eucas1p110829c4ad1570104297df39c02cc59e5@eucas1p1.samsung.com>
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1490255131-9597-1-git-send-email-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch adds missing checks for dma_map_single() failure and proper error
reporting. While touching this part of the code, it also removes unnecessary
spinlock calls around dma_map_single() for TX buffer. This finally solves all
the issues reported by DMA API debug framework.

Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Fixes: 2c37eedb74c8 ("serial: samsung: add dma reqest/release functions")
CC: stable@vger.kernel.org # v4.10+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This issue was there since adding DMA support, but this patch applies cleanly
only to v4.10+ kernels due to other changes in the surrounding code.
---
 drivers/tty/serial/samsung.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 9f3759bdb44f..8aca18c4cdea 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -859,7 +859,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 {
 	struct s3c24xx_uart_dma	*dma = p->dma;
-	unsigned long flags;
+	int ret;
 
 	/* Default slave configuration parameters */
 	dma->rx_conf.direction		= DMA_DEV_TO_MEM;
@@ -884,8 +884,8 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 
 	dma->tx_chan = dma_request_chan(p->port.dev, "tx");
 	if (IS_ERR(dma->tx_chan)) {
-		dma_release_channel(dma->rx_chan);
-		return PTR_ERR(dma->tx_chan);
+		ret = PTR_ERR(dma->tx_chan);
+		goto err_release_rx;
 	}
 
 	dmaengine_slave_config(dma->tx_chan, &dma->tx_conf);
@@ -894,25 +894,38 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	dma->rx_size = PAGE_SIZE;
 
 	dma->rx_buf = kmalloc(dma->rx_size, GFP_KERNEL);
-
 	if (!dma->rx_buf) {
-		dma_release_channel(dma->rx_chan);
-		dma_release_channel(dma->tx_chan);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_release_tx;
 	}
 
 	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
 				dma->rx_size, DMA_FROM_DEVICE);
-
-	spin_lock_irqsave(&p->port.lock, flags);
+	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
+		ret = -EIO;
+		goto err_free_rx;
+	}
 
 	/* TX buffer */
 	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
-
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
+		ret = -EIO;
+		goto err_unmap_rx;
+	}
 
 	return 0;
+
+err_unmap_rx:
+	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
+			 DMA_FROM_DEVICE);
+err_free_rx:
+	kfree(dma->rx_buf);
+err_release_tx:
+	dma_release_channel(dma->tx_chan);
+err_release_rx:
+	dma_release_channel(dma->rx_chan);
+	return ret;
 }
 
 static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
-- 
1.9.1
