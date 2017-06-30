From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 5/7] serial: imx: umap sg buffers when DMA channel is released
Date: Fri, 30 Jun 2017 14:04:44 +0200
Message-ID: <20170630120446.13994-6-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630120446.13994-1-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

This commits unmaps sg buffers when the DMA channel is released

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e8cf7cf..58d6b1c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1215,6 +1215,12 @@ static void imx_stop_tx_dma(struct imx_port *sport)
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~UCR1_TDMAEN;
 	writel(temp, sport->port.membase + UCR1);
+
+	if (sport->dma_is_txing) {
+		dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
+		sport->dma_tx_nents, DMA_TO_DEVICE);
+		sport->dma_is_txing = 0;
+	}
 }
 
 static void imx_stop_rx_dma(struct imx_port *sport)
@@ -1224,6 +1230,12 @@ static void imx_stop_rx_dma(struct imx_port *sport)
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~(UCR1_RDMAEN | UCR1_ATDMAEN);
 	writel(temp, sport->port.membase + UCR1);
+
+	if (sport->dma_is_rxing) {
+		dma_unmap_sg(sport->port.dev, &sport->rx_sgl, 1,
+			DMA_FROM_DEVICE);
+		sport->dma_is_rxing = 0;
+	}
 }
 
 static void imx_enable_dma(struct imx_port *sport)
-- 
1.8.3.1
