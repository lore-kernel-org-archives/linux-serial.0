From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 5/6] serial: imx: update the stop rx,tx procedures
Date: Wed,  5 Jul 2017 15:07:05 +0200
Message-ID: <20170705130706.10388-6-romain.perier@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705130706.10388-1-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

According to "Documentation/serial/driver" both procedures should stop
receiving or sending data. Based on this the procedures should stop the
activity regardless if DMA is enabled or not.

This commit updates both imx_stop_{rx|tx} procedures to stop the
activity and disable the interrupts related to that.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3112d88..d35112f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -398,15 +398,14 @@ static void imx_stop_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	/*
-	 * We are maybe in the SMP context, so if the DMA TX thread is running
-	 * on other cpu, we have to wait for it to finish.
-	 */
-	if (sport->dma_is_enabled && sport->dma_is_txing)
-		return;
+	sport->tx_bytes = 0;
+
+	if (sport->dma_is_enabled)
+		imx_stop_tx_dma(sport);
 
 	temp = readl(port->membase + UCR1);
-	writel(temp & ~UCR1_TXMPTYEN, port->membase + UCR1);
+	temp &= ~(UCR1_TXMPTYEN | UCR1_TRDYEN | UCR1_RTSDEN);
+	writel(temp, port->membase + UCR1);
 
 	/* in rs485 mode disable transmitter if shifter is empty */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
@@ -433,21 +432,20 @@ static void imx_stop_rx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	if (sport->dma_is_enabled && sport->dma_is_rxing) {
-		if (sport->port.suspended) {
-			dmaengine_terminate_all(sport->dma_chan_rx);
-			sport->dma_is_rxing = 0;
-		} else {
-			return;
-		}
-	}
+	if (sport->dma_is_enabled)
+		imx_stop_rx_dma(sport);
+
+	temp = readl(sport->port.membase + UCR1);
+	temp &= ~UCR1_RRDYEN;
+	writel(temp, sport->port.membase + UCR1);
 
 	temp = readl(sport->port.membase + UCR2);
-	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
+	temp &= ~UCR2_ATEN;
+	writel(temp, sport->port.membase + UCR2);
 
-	/* disable the `Receiver Ready Interrrupt` */
-	temp = readl(sport->port.membase + UCR1);
-	writel(temp & ~UCR1_RRDYEN, sport->port.membase + UCR1);
+	temp = readl(sport->port.membase + UCR3);
+	temp &= ~UCR3_AWAKEN;
+	writel(temp, sport->port.membase + UCR3);
 }
 
 /*
-- 
1.8.3.1
