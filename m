From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 03/14] serial: tegra: avoid reg access when clk disabled
Date: Mon, 12 Aug 2019 16:58:12 +0530
Message-ID: <1565609303-27000-4-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Ahung Cheng <ahcheng@nvidia.com>, Shardar Mohammed <smohammed@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

From: Ahung Cheng <ahcheng@nvidia.com>

This avoids two race conditions from the UART shutdown sequence both
leading to 'Machine check error in AXI2APB' and kernel oops.

One was that the clock was disabled before the DMA was terminated making
it possible for the DMA callbacks to be called after the clock was
disabled. These callbacks could write to the UART registers causing
timeout.

The second was that the clock was disabled before the UART was
completely flagged as closed. This is done after the shutdown is called
and a new write could be started after the clock was disabled.
tegra_uart_start_pio_tx could be called causing timeout.

Given that the baud rate is reset at the end of shutdown sequence, this
fix is to examine the baud rate to avoid register access from both race
conditions.

Besides, terminate the DMA before disabling the clock.

Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
Signed-off-by: Shardar Mohammed <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 93d299e..d908465 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -126,6 +126,8 @@ struct tegra_uart_port {
 
 static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
 static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup);
+static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
+					bool dma_to_memory);
 
 static inline unsigned long tegra_uart_read(struct tegra_uart_port *tup,
 		unsigned long reg)
@@ -458,6 +460,9 @@ static void tegra_uart_start_next_tx(struct tegra_uart_port *tup)
 	unsigned long count;
 	struct circ_buf *xmit = &tup->uport.state->xmit;
 
+	if (WARN_ON(!tup->current_baud))
+		return;
+
 	tail = (unsigned long)&xmit->buf[xmit->tail];
 	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 	if (!count)
@@ -829,6 +834,12 @@ static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
 	tup->current_baud = 0;
 	spin_unlock_irqrestore(&tup->uport.lock, flags);
 
+	tup->rx_in_progress = 0;
+	tup->tx_in_progress = 0;
+
+	tegra_uart_dma_channel_free(tup, true);
+	tegra_uart_dma_channel_free(tup, false);
+
 	clk_disable_unprepare(tup->uart_clk);
 }
 
@@ -1066,12 +1077,6 @@ static void tegra_uart_shutdown(struct uart_port *u)
 	struct tegra_uart_port *tup = to_tegra_uport(u);
 
 	tegra_uart_hw_deinit(tup);
-
-	tup->rx_in_progress = 0;
-	tup->tx_in_progress = 0;
-
-	tegra_uart_dma_channel_free(tup, true);
-	tegra_uart_dma_channel_free(tup, false);
 	free_irq(u->irq, tup);
 }
 
-- 
2.7.4
