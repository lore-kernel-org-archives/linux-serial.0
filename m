From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] serial: samsung: Simplify DMA engine initialization code
Date: Fri, 16 Dec 2016 10:56:53 +0100
Message-ID: <1481882213-10856-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

dma_request_slave_channel_compat() requires filter function and mask, which
are not needed on device tree based platforms, so simplify the code by
calling the more appropriate dma_request_chan() function. This additionally
gives us proper error handling, because the new function returns error
codes instead of NULL on failure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 17 ++++++-----------
 drivers/tty/serial/samsung.h |  4 ----
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f44615fa474d..a9b309ba24a4 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -859,7 +859,6 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 {
 	struct s3c24xx_uart_dma	*dma = p->dma;
-	dma_cap_mask_t mask;
 	unsigned long flags;
 
 	/* Default slave configuration parameters */
@@ -876,21 +875,17 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	else
 		dma->tx_conf.dst_maxburst = 1;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	dma->rx_chan = dma_request_chan(p->port.dev, "rx");
 
-	dma->rx_chan = dma_request_slave_channel_compat(mask, dma->fn,
-					dma->rx_param, p->port.dev, "rx");
-	if (!dma->rx_chan)
-		return -ENODEV;
+	if (IS_ERR(dma->rx_chan))
+		return PTR_ERR(dma->rx_chan);
 
 	dmaengine_slave_config(dma->rx_chan, &dma->rx_conf);
 
-	dma->tx_chan = dma_request_slave_channel_compat(mask, dma->fn,
-					dma->tx_param, p->port.dev, "tx");
-	if (!dma->tx_chan) {
+	dma->tx_chan = dma_request_chan(p->port.dev, "tx");
+	if (IS_ERR(dma->tx_chan)) {
 		dma_release_channel(dma->rx_chan);
-		return -ENODEV;
+		return PTR_ERR(dma->tx_chan);
 	}
 
 	dmaengine_slave_config(dma->tx_chan, &dma->tx_conf);
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index a04acef1cb20..965199b6c16f 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -44,10 +44,6 @@ struct s3c24xx_serial_drv_data {
 };
 
 struct s3c24xx_uart_dma {
-	dma_filter_fn			fn;
-	void				*rx_param;
-	void				*tx_param;
-
 	unsigned int			rx_chan_id;
 	unsigned int			tx_chan_id;
 
-- 
1.9.1
