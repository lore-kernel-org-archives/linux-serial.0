From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH v3 4/6] serial: imx: unmap sg buffers when DMA channel is released
Date: Thu, 21 Sep 2017 17:18:15 +0100
Message-ID: <1506010697-22114-5-git-send-email-martyn.welch@collabora.co.uk>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

This commits unmaps sg buffers when the DMA channel is released. It also
sets to zero `dma_is_rxing` and `dma_is_txing` to state that the
corresponding channels cannot transmit/receive data, as these are
disabled.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2fb3210..ed02783 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -357,6 +357,12 @@ static void imx_stop_tx_dma(struct imx_port *sport)
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
@@ -366,6 +372,12 @@ static void imx_stop_rx_dma(struct imx_port *sport)
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
