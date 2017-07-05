From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 1/6] serial: imx: only set DMA rx-ing when DMA starts
Date: Wed,  5 Jul 2017 15:07:01 +0200
Message-ID: <20170705130706.10388-2-romain.perier@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705130706.10388-1-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

Avoid the situation when `dma_is_rxing` could incorrectly signal that
DMA RX channel is receiving data in case DMA preparation or sg mapping
fails.

This commit fixes the issues by moving the assignment of dma_is_rxing
out of imx_disable_rx_int(), then the variable is set to 1 from
start_rx_dma() only when the preparation is correctly done.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3bae4ea..01df430 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -729,8 +729,6 @@ static void imx_disable_rx_int(struct imx_port *sport)
 {
 	unsigned long temp;
 
-	sport->dma_is_rxing = 1;
-
 	/* disable the receiver ready and aging timer interrupts */
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~(UCR1_RRDYEN);
@@ -1083,6 +1081,7 @@ static int start_rx_dma(struct imx_port *sport)
 	desc->callback_param = sport;
 
 	dev_dbg(dev, "RX: prepare for the DMA.\n");
+	sport->dma_is_rxing = 1;
 	sport->rx_cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
 	return 0;
-- 
1.8.3.1
