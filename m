From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4/9] serial: 8250_dma: Provide default slave configuration parameters
Date: Wed, 10 Apr 2013 16:58:27 +0300
Message-ID: <1365602312-25436-5-git-send-email-heikki.krogerus@linux.intel.com>
References: <1365602312-25436-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365602312-25436-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Some slave channel parameters will be always the same. For
example, direction for the Rx channel will always be
DMA_DEV_TO_MEM and DMA_MEM_TO_DEV for Tx channel.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index fdb6139e..7046769 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -149,8 +149,14 @@ int serial8250_request_dma(struct uart_8250_port *p)
 	struct uart_8250_dma	*dma = p->dma;
 	dma_cap_mask_t		mask;
 
-	dma->rxconf.src_addr = p->port.mapbase + UART_RX;
-	dma->txconf.dst_addr = p->port.mapbase + UART_TX;
+	/* Default slave configuration parameters */
+	dma->rxconf.direction		= DMA_DEV_TO_MEM;
+	dma->rxconf.src_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma->rxconf.src_addr		= p->port.mapbase + UART_RX;
+
+	dma->txconf.direction		= DMA_MEM_TO_DEV;
+	dma->txconf.dst_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma->txconf.dst_addr		= p->port.mapbase + UART_TX;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-- 
1.7.10.4
