From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 6/6] serial: imx: Fix imx_shutdown procedure
Date: Wed,  5 Jul 2017 15:07:06 +0200
Message-ID: <20170705130706.10388-7-romain.perier@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705130706.10388-1-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

In some cases, it looks that interrupts can happen after the dma was
disabled and port was not yet shutdown. This will result in interrupts
handled by imx_rxint.

This commits updates the shutdown function to ensure that underlying
components are disabled in the right order. This disables RX and TX
blocks, then it disabled interrupts. In case DMA is enabled, it disables
DMA and free corresponding resources. It disables UART port and stop
clocks.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d35112f..bfe7180 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1396,44 +1396,40 @@ static void imx_shutdown(struct uart_port *port)
 	unsigned long temp;
 	unsigned long flags;
 
-	if (sport->dma_is_enabled) {
-		sport->dma_is_rxing = 0;
-		sport->dma_is_txing = 0;
-		dmaengine_terminate_sync(sport->dma_chan_tx);
-		dmaengine_terminate_sync(sport->dma_chan_rx);
-
+	if (!sport->port.suspended) {
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_stop_tx(port);
 		imx_stop_rx(port);
-		imx_disable_dma(sport);
+
+		if (sport->dma_is_inited && sport->dma_is_enabled)
+			imx_disable_dma(sport);
+
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 		imx_uart_dma_exit(sport);
 	}
 
-	mctrl_gpio_disable_ms(sport->gpios);
-
 	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR2);
-	temp &= ~(UCR2_TXEN);
+	temp &= ~(UCR2_TXEN | UCR2_RXEN);
 	writel(temp, sport->port.membase + UCR2);
+	temp = readl(sport->port.membase + UCR4);
+	temp &= ~UCR4_OREN;
+	writel(temp, sport->port.membase + UCR4);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	/*
-	 * Stop our timer.
-	 */
-	del_timer_sync(&sport->timer);
+	mctrl_gpio_disable_ms(sport->gpios);
 
-	/*
-	 * Disable all interrupts, port and break condition.
-	 */
+	/* Stop our timer. */
+	del_timer_sync(&sport->timer);
 
+	/* Disable port. */
 	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR1);
-	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
-
+	temp &= ~UCR1_UARTEN;
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
+	/* Disable clocks. */
 	clk_disable_unprepare(sport->clk_per);
 	clk_disable_unprepare(sport->clk_ipg);
 }
-- 
1.8.3.1
