From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4/4] serial: tegra: Add helper function for handling RX buffer
Date: Fri, 9 Oct 2015 14:50:02 +0100
Message-ID: <1444398602-24020-5-git-send-email-jonathanh@nvidia.com>
References: <1444398602-24020-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444398602-24020-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-serial@vger.kernel.org

In the tegra UART driver there are three places where the RX DMA buffer
is handled and pushed up to the tty layer. In all three instances the
same functions are called and so instead of duplicating the code in three
places, move this code to a new helper function and use this new function.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 66 ++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 11aa5e1e3705..1d6fc60ed013 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -569,13 +569,30 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_TO_DEVICE);
 }
 
+static void tegra_uart_rx_buffer_push(struct tegra_uart_port *tup,
+				      unsigned int residue)
+{
+	struct tty_port *port = &tup->uport.state->port;
+	struct tty_struct *tty = tty_port_tty_get(port);
+	unsigned int count;
+
+	async_tx_ack(tup->rx_dma_desc);
+	count = tup->rx_bytes_requested - residue;
+
+	/* If we are here, DMA is stopped */
+	tegra_uart_copy_rx_to_tty(tup, port, count);
+
+	tegra_uart_handle_rx_pio(tup, port);
+	if (tty) {
+		tty_flip_buffer_push(port);
+		tty_kref_put(tty);
+	}
+}
+
 static void tegra_uart_rx_dma_complete(void *args)
 {
 	struct tegra_uart_port *tup = args;
 	struct uart_port *u = &tup->uport;
-	unsigned int count = tup->rx_bytes_requested;
-	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
-	struct tty_port *port = &u->state->port;
 	unsigned long flags;
 	struct dma_tx_state state;
 	enum dma_status status;
@@ -589,20 +606,11 @@ static void tegra_uart_rx_dma_complete(void *args)
 		goto done;
 	}
 
-	async_tx_ack(tup->rx_dma_desc);
-
 	/* Deactivate flow control to stop sender */
 	if (tup->rts_active)
 		set_rts(tup, false);
 
-	/* If we are here, DMA is stopped */
-	tegra_uart_copy_rx_to_tty(tup, port, count);
-
-	tegra_uart_handle_rx_pio(tup, port);
-	if (tty) {
-		tty_flip_buffer_push(port);
-		tty_kref_put(tty);
-	}
+	tegra_uart_rx_buffer_push(tup, 0);
 	tegra_uart_start_rx_dma(tup);
 
 	/* Activate flow control to start transfer */
@@ -616,27 +624,14 @@ done:
 static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup)
 {
 	struct dma_tx_state state;
-	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
-	struct tty_port *port = &tup->uport.state->port;
-	unsigned int count;
 
 	/* Deactivate flow control to stop sender */
 	if (tup->rts_active)
 		set_rts(tup, false);
 
 	dmaengine_terminate_all(tup->rx_dma_chan);
-	dmaengine_tx_status(tup->rx_dma_chan,  tup->rx_cookie, &state);
-	async_tx_ack(tup->rx_dma_desc);
-	count = tup->rx_bytes_requested - state.residue;
-
-	/* If we are here, DMA is stopped */
-	tegra_uart_copy_rx_to_tty(tup, port, count);
-
-	tegra_uart_handle_rx_pio(tup, port);
-	if (tty) {
-		tty_flip_buffer_push(port);
-		tty_kref_put(tty);
-	}
+	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+	tegra_uart_rx_buffer_push(tup, state.residue);
 	tegra_uart_start_rx_dma(tup);
 
 	if (tup->rts_active)
@@ -755,11 +750,8 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 static void tegra_uart_stop_rx(struct uart_port *u)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
-	struct tty_struct *tty;
-	struct tty_port *port = &u->state->port;
 	struct dma_tx_state state;
 	unsigned long ier;
-	int count;
 
 	if (tup->rts_active)
 		set_rts(tup, false);
@@ -767,8 +759,6 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 	if (!tup->rx_in_progress)
 		return;
 
-	tty = tty_port_tty_get(&tup->uport.state->port);
-
 	tegra_uart_wait_sym_time(tup, 1); /* wait a character interval */
 
 	ier = tup->ier_shadow;
@@ -779,15 +769,7 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 	tup->rx_in_progress = 0;
 	dmaengine_terminate_all(tup->rx_dma_chan);
 	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
-	async_tx_ack(tup->rx_dma_desc);
-	count = tup->rx_bytes_requested - state.residue;
-	tegra_uart_copy_rx_to_tty(tup, port, count);
-	tegra_uart_handle_rx_pio(tup, port);
-
-	if (tty) {
-		tty_flip_buffer_push(port);
-		tty_kref_put(tty);
-	}
+	tegra_uart_rx_buffer_push(tup, state.residue);
 }
 
 static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
-- 
2.1.4
