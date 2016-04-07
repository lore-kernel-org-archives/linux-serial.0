From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 07/12] serial: 8250_dma: adjust DMA address of the UART
Date: Thu,  7 Apr 2016 23:37:08 +0300
Message-ID: <1460061433-63750-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Some UARTs, e.g. one is used in Intel Quark, have a different address base for
DMA operations. Introduce an additional field in struct uart_8250_dma to cover
those cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h     | 2 ++
 drivers/tty/serial/8250/8250_dma.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 047a7ba..040deb2 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -31,6 +31,8 @@ struct uart_8250_dma {
 	struct dma_chan		*rxchan;
 	struct dma_chan		*txchan;
 
+	phys_addr_t		dma_addr;
+
 	dma_addr_t		rx_addr;
 	dma_addr_t		tx_addr;
 
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index b134bec..a314492 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -164,16 +164,17 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 int serial8250_request_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
+	phys_addr_t dma_addr = dma->dma_addr ? dma->dma_addr : p->port.mapbase;
 	dma_cap_mask_t		mask;
 
 	/* Default slave configuration parameters */
 	dma->rxconf.direction		= DMA_DEV_TO_MEM;
 	dma->rxconf.src_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
-	dma->rxconf.src_addr		= p->port.mapbase + UART_RX;
+	dma->rxconf.src_addr		= dma_addr + UART_RX;
 
 	dma->txconf.direction		= DMA_MEM_TO_DEV;
 	dma->txconf.dst_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
-	dma->txconf.dst_addr		= p->port.mapbase + UART_TX;
+	dma->txconf.dst_addr		= dma_addr + UART_TX;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-- 
2.8.0.rc3
