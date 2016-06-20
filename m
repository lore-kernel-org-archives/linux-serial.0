From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v9 06/11] serial: 8250_dma: adjust DMA address of the UART
Date: Mon, 20 Jun 2016 12:17:57 +0300
Message-ID: <1466414282-96691-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Some UARTs, e.g. one is used in Intel Quark, have a different address base for
DMA operations. Introduce an additional field (per RX and TX DMA channels) in
struct uart_8250_dma to cover those cases.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h     | 5 +++++
 drivers/tty/serial/8250/8250_dma.c | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 215a992..664232b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -31,6 +31,11 @@ struct uart_8250_dma {
 	struct dma_chan		*rxchan;
 	struct dma_chan		*txchan;
 
+	/* Device address base for DMA operations */
+	phys_addr_t		rx_dma_addr;
+	phys_addr_t		tx_dma_addr;
+
+	/* DMA address of the buffer in memory */
 	dma_addr_t		rx_addr;
 	dma_addr_t		tx_addr;
 
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index c759242..8ccbf53 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -149,6 +149,10 @@ void serial8250_rx_dma_flush(struct uart_8250_port *p)
 int serial8250_request_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
+	phys_addr_t rx_dma_addr = dma->rx_dma_addr ?
+				  dma->rx_dma_addr : p->port.mapbase;
+	phys_addr_t tx_dma_addr = dma->tx_dma_addr ?
+				  dma->tx_dma_addr : p->port.mapbase;
 	dma_cap_mask_t		mask;
 	struct dma_slave_caps	caps;
 	int			ret;
@@ -156,11 +160,11 @@ int serial8250_request_dma(struct uart_8250_port *p)
 	/* Default slave configuration parameters */
 	dma->rxconf.direction		= DMA_DEV_TO_MEM;
 	dma->rxconf.src_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
-	dma->rxconf.src_addr		= p->port.mapbase + UART_RX;
+	dma->rxconf.src_addr		= rx_dma_addr + UART_RX;
 
 	dma->txconf.direction		= DMA_MEM_TO_DEV;
 	dma->txconf.dst_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
-	dma->txconf.dst_addr		= p->port.mapbase + UART_TX;
+	dma->txconf.dst_addr		= tx_dma_addr + UART_TX;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-- 
2.8.1
