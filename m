From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Date: Mon,  7 May 2018 23:36:10 +0200
Message-ID: <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

This properly unmaps DMA SG on device shutdown.

Reported-by: Nandor Han <nandor.han@ge.com>
Suggested-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3ca767b1162a..6c53e74244ec 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
 	u32 ucr1, ucr2;
 
 	if (sport->dma_is_enabled) {
-		sport->dma_is_rxing = 0;
-		sport->dma_is_txing = 0;
 		dmaengine_terminate_sync(sport->dma_chan_tx);
+		if (sport->dma_is_txing) {
+			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
+				     sport->dma_tx_nents, DMA_TO_DEVICE);
+			sport->dma_is_txing = 0;
+		}
 		dmaengine_terminate_sync(sport->dma_chan_rx);
+		if (sport->dma_is_rxing) {
+			dma_unmap_sg(sport->port.dev, &sport->rx_sgl,
+				     1, DMA_FROM_DEVICE);
+			sport->dma_is_rxing = 0;
+		}
 
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_uart_stop_tx(port);
-- 
2.17.0
