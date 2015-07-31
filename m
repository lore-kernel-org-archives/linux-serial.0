From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 1/2] serial: samsung: fix DMA mode enter condition for small
 FIFO sizes
Date: Fri, 31 Jul 2015 10:58:27 +0200
Message-ID: <1438333108-25822-2-git-send-email-r.baldyga@samsung.com>
References: <1438333108-25822-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438333108-25822-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, kmpark@infradead.org, stable@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Due to some of serial ports can have FIFO size smaller than cache line
size, and because of need to align DMA buffer address to cache line size,
it's necessary to calculate minimum number of bytes for which we want
to start DMA transaction to be at least cache line size. The simplest
way to meet this requirement is to get maximum of cache line size and
FIFO size.

Cc: <stable@vger.kernel.org> # v3.18+
Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 13 +++++++++++--
 drivers/tty/serial/samsung.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 67d0c21..08168f9 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -342,7 +342,8 @@ static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
 		return;
 	}
 
-	if (!ourport->dma || !ourport->dma->tx_chan || count < port->fifosize)
+	if (!ourport->dma || !ourport->dma->tx_chan ||
+	    count < ourport->min_dma_size)
 		s3c24xx_serial_start_tx_pio(ourport);
 	else
 		s3c24xx_serial_start_tx_dma(ourport, count);
@@ -742,7 +743,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
-	if (ourport->dma && ourport->dma->tx_chan && count >= port->fifosize) {
+	if (ourport->dma && ourport->dma->tx_chan &&
+	    count >= ourport->min_dma_size) {
 		s3c24xx_serial_start_tx_dma(ourport, count);
 		goto out;
 	}
@@ -1838,6 +1840,13 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	else if (ourport->info->fifosize)
 		ourport->port.fifosize = ourport->info->fifosize;
 
+	/*
+	 * DMA transfers must be aligned at least to cache line size,
+	 * so find minimal transfer size suitable for DMA mode
+	 */
+	ourport->min_dma_size = max_t(int, ourport->port.fifosize,
+				    dma_get_cache_alignment());
+
 	probe_index++;
 
 	dbg("%s: initialising port %p...\n", __func__, ourport);
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index d275032..fc5deaa 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -82,6 +82,7 @@ struct s3c24xx_uart_port {
 	unsigned char			tx_claimed;
 	unsigned int			pm_level;
 	unsigned long			baudclk_rate;
+	unsigned int			min_dma_size;
 
 	unsigned int			rx_irq;
 	unsigned int			tx_irq;
-- 
1.9.1
