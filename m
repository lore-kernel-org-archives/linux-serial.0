From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 4/6] serial: imx: unmap sg buffers when DMA channel is released
Date: Wed,  5 Jul 2017 15:07:04 +0200
Message-ID: <20170705130706.10388-5-romain.perier@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705130706.10388-1-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

This commits unmaps sg buffers when the DMA channel is released. It also
sets to zero `dma_is_rxing` and `dma_is_txing` to state that the
corresponding channels cannot transmit/receive data, as these are
disabled.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dd3ebb4..3112d88 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -367,6 +367,12 @@ static void imx_stop_tx_dma(struct imx_port *sport)
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
@@ -376,6 +382,12 @@ static void imx_stop_rx_dma(struct imx_port *sport)
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
 
 /*
-- 
1.8.3.1
