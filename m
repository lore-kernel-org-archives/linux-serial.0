From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 1/7] serial: imx: only set DMA rx-ing when DMA starts
Date: Fri, 30 Jun 2017 14:04:40 +0200
Message-ID: <20170630120446.13994-2-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630120446.13994-1-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

Avoid the situation when `dma_is_rxing` could incorrectly signal that
DMA RX channel is receiving data in case DMA preparation or sg mapping
fails.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5437b34..1d35293 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -725,11 +725,11 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void imx_disable_rx_int(struct imx_port *sport)
+static void imx_disable_rx_int(struct imx_port *sport, bool is_rxing)
 {
 	unsigned long temp;
 
-	sport->dma_is_rxing = 1;
+	sport->dma_is_rxing = is_rxing;
 
 	/* disable the receiver ready and aging timer interrupts */
 	temp = readl(sport->port.membase + UCR1);
@@ -762,7 +762,7 @@ static void imx_dma_rxint(struct imx_port *sport)
 	temp = readl(sport->port.membase + USR2);
 	if ((temp & USR2_RDR) && !sport->dma_is_rxing) {
 
-		imx_disable_rx_int(sport);
+		imx_disable_rx_int(sport, false);
 
 		/* tell the DMA to receive the data. */
 		start_rx_dma(sport);
@@ -1083,6 +1083,7 @@ static int start_rx_dma(struct imx_port *sport)
 	desc->callback_param = sport;
 
 	dev_dbg(dev, "RX: prepare for the DMA.\n");
+	sport->dma_is_rxing = 1;
 	sport->rx_cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
 	return 0;
@@ -1362,7 +1363,7 @@ static int imx_startup(struct uart_port *port)
 		spin_unlock(&tty->files_lock);
 
 		if (readcnt > 0) {
-			imx_disable_rx_int(sport);
+			imx_disable_rx_int(sport, true);
 			start_rx_dma(sport);
 		}
 	}
-- 
1.8.3.1
