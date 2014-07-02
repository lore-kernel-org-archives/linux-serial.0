From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] serial: fsl_lpuart: calculate DMA burst
Date: Wed,  2 Jul 2014 18:02:57 +0200
Message-ID: <5d0e45bcd38d9030fcd2b32fb5f09fd26c25f0a6.1404314964.git.stefan@agner.ch>
References: <54df28cb5dccf71b17523896da17ce2f155855fd.1404314964.git.stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54df28cb5dccf71b17523896da17ce2f155855fd.1404314964.git.stefan@agner.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@lists.infradead.org, stefan@agner.ch, yao.yuan@freescale.com, linux-serial@vger.kernel.org, jingchang.lu@freescale.com, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The DMA burst size must match the transmit FIFO depth in order
to make sure all character are transmitted. This patch calculates
DMA burst size by using FIFO depth rather than use the hardcoded
16 bytes. This is required since some UARTs (e.g. UART2 on Vybrid)
have a FIFO depth of 8 bytes.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/fsl_lpuart.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6b462a9..f973456 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -117,8 +117,6 @@
 #define UARTSFIFO_TXOF		0x02
 #define UARTSFIFO_RXUF		0x01
 
-#define DMA_MAXBURST		16
-#define DMA_MAXBURST_MASK	(DMA_MAXBURST - 1)
 #define FSL_UART_RX_DMA_BUFFER_SIZE	64
 
 #define DRIVER_NAME	"fsl-lpuart"
@@ -240,7 +238,7 @@ static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count)
 
 	dma_sync_single_for_device(sport->port.dev, sport->dma_tx_buf_bus,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
-	sport->dma_tx_bytes = count & ~(DMA_MAXBURST_MASK);
+	sport->dma_tx_bytes = count & ~(sport->txfifo_size - 1);
 	tx_bus_addr = sport->dma_tx_buf_bus + xmit->tail;
 	sport->dma_tx_desc = dmaengine_prep_slave_single(sport->dma_tx_chan,
 					tx_bus_addr, sport->dma_tx_bytes,
@@ -269,7 +267,7 @@ static void lpuart_prepare_tx(struct lpuart_port *sport)
 	if (!count)
 		return;
 
-	if (count < DMA_MAXBURST)
+	if (count < sport->txfifo_size)
 		writeb(readb(sport->port.membase + UARTCR5) & ~UARTCR5_TDMAS,
 				sport->port.membase + UARTCR5);
 	else {
@@ -599,15 +597,7 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 			UARTCR2_RIE | UARTCR2_RE);
 	writeb(cr2, sport->port.membase + UARTCR2);
 
-	/* determine FIFO size and enable FIFO mode */
 	val = readb(sport->port.membase + UARTPFIFO);
-
-	sport->txfifo_size = 0x1 << (((val >> UARTPFIFO_TXSIZE_OFF) &
-		UARTPFIFO_FIFOSIZE_MASK) + 1);
-
-	sport->rxfifo_size = 0x1 << (((val >> UARTPFIFO_RXSIZE_OFF) &
-		UARTPFIFO_FIFOSIZE_MASK) + 1);
-
 	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
 			sport->port.membase + UARTPFIFO);
 
@@ -652,7 +642,7 @@ static int lpuart_dma_tx_request(struct uart_port *port)
 	dma_buf = sport->port.state->xmit.buf;
 	dma_tx_sconfig.dst_addr = sport->port.mapbase + UARTDR;
 	dma_tx_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	dma_tx_sconfig.dst_maxburst = DMA_MAXBURST;
+	dma_tx_sconfig.dst_maxburst = sport->txfifo_size;
 	dma_tx_sconfig.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(tx_chan, &dma_tx_sconfig);
 
@@ -765,7 +755,16 @@ static int lpuart_startup(struct uart_port *port)
 	unsigned long flags;
 	unsigned char temp;
 
-	/*whether use dma support by dma request results*/
+	/* determine FIFO size and enable FIFO mode */
+	temp = readb(sport->port.membase + UARTPFIFO);
+
+	sport->txfifo_size = 0x1 << (((temp >> UARTPFIFO_TXSIZE_OFF) &
+		UARTPFIFO_FIFOSIZE_MASK) + 1);
+
+	sport->rxfifo_size = 0x1 << (((temp >> UARTPFIFO_RXSIZE_OFF) &
+		UARTPFIFO_FIFOSIZE_MASK) + 1);
+
+	/* Whether use dma support by dma request results */
 	if (lpuart_dma_tx_request(port) || lpuart_dma_rx_request(port)) {
 		sport->lpuart_dma_use = false;
 	} else {
-- 
2.0.1
