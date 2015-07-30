From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 2/2] serial: samsung: fix DMA for FIFO smaller than cache line
 size
Date: Thu, 30 Jul 2015 11:14:16 +0200
Message-ID: <1438247656-24695-3-git-send-email-r.baldyga@samsung.com>
References: <1438247656-24695-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438247656-24695-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

So far DMA mode were activated when only number of bytes to send was
equal or greater than min_dma_size. Due to requirement that DMA transaction
buffer should be aligned to cache line size, the excessive bytes were
written to FIFO before starting DMA transaction. The problem occurred
when FIFO size were smaller than cache alignment, because writing all
excessive bytes to FIFO would fail. It happened in DMA mode when PIO
interrupts disabled, which caused driver hung.

The solution is to test if buffer is alligned to cache line size before
activating DMA mode, and if it's not, running PIO mode to align buffer
and then starting DMA transaction. In PIO mode, when interrupts are
enabled, lack of space in FIFO isn't the problem, so buffer aligning
will always finish with success.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 08168f9..5916311 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -295,15 +295,6 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	if (ourport->tx_mode != S3C24XX_TX_DMA)
 		enable_tx_dma(ourport);
 
-	while (xmit->tail & (dma_get_cache_alignment() - 1)) {
-		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)
-			return 0;
-		wr_regb(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		count--;
-	}
-
 	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
 	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
 
@@ -343,7 +334,8 @@ static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
 	}
 
 	if (!ourport->dma || !ourport->dma->tx_chan ||
-	    count < ourport->min_dma_size)
+	    count < ourport->min_dma_size ||
+	    xmit->tail & (dma_get_cache_alignment() - 1))
 		s3c24xx_serial_start_tx_pio(ourport);
 	else
 		s3c24xx_serial_start_tx_dma(ourport, count);
@@ -737,7 +729,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	struct uart_port *port = &ourport->port;
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned long flags;
-	int count;
+	int count, dma_count = 0;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -745,8 +737,12 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	if (ourport->dma && ourport->dma->tx_chan &&
 	    count >= ourport->min_dma_size) {
-		s3c24xx_serial_start_tx_dma(ourport, count);
-		goto out;
+		int align = dma_get_cache_alignment() -
+			(xmit->tail & (dma_get_cache_alignment() - 1));
+		if (count-align >= ourport->min_dma_size) {
+			dma_count = count-align;
+			count = align;
+		}
 	}
 
 	if (port->x_char) {
@@ -767,14 +763,24 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	/* try and drain the buffer... */
 
-	count = port->fifosize;
-	while (!uart_circ_empty(xmit) && count-- > 0) {
+	if (count > port->fifosize) {
+		count = port->fifosize;
+		dma_count = 0;
+	}
+
+	while (!uart_circ_empty(xmit) && count > 0) {
 		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)
 			break;
 
 		wr_regb(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
+		count--;
+	}
+
+	if (!count && dma_count) {
+		s3c24xx_serial_start_tx_dma(ourport, dma_count);
+		goto out;
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
-- 
1.9.1
