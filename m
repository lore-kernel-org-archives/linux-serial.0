From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/9] serial: 8250_dma: Use dmaengine helpers to get the slave channels
Date: Wed, 10 Apr 2013 16:58:26 +0300
Message-ID: <1365602312-25436-4-git-send-email-heikki.krogerus@linux.intel.com>
References: <1365602312-25436-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365602312-25436-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The helper functions in dmaengine API allow the drivers to
request slave channels without the filter parameters. They
will attempt to extract the needed DMA client information
from DT or ACPI, but if such information is not available
the filter parameters can still be used.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 6643061..fdb6139e 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -156,14 +156,18 @@ int serial8250_request_dma(struct uart_8250_port *p)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	/* Get a channel for RX */
-	dma->rxchan = dma_request_channel(mask, dma->fn, dma->rx_param);
+	dma->rxchan = dma_request_slave_channel_compat(mask,
+						       dma->fn, dma->rx_param,
+						       p->port.dev, "rx");
 	if (!dma->rxchan)
 		return -ENODEV;
 
 	dmaengine_slave_config(dma->rxchan, &dma->rxconf);
 
 	/* Get a channel for TX */
-	dma->txchan = dma_request_channel(mask, dma->fn, dma->tx_param);
+	dma->txchan = dma_request_slave_channel_compat(mask,
+						       dma->fn, dma->tx_param,
+						       p->port.dev, "tx");
 	if (!dma->txchan) {
 		dma_release_channel(dma->rxchan);
 		return -ENODEV;
-- 
1.7.10.4
