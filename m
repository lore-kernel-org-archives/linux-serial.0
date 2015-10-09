From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 3/4] serial: tegra: Remove redundant code and check in tegra_uart_stop_rx()
Date: Fri, 9 Oct 2015 14:50:01 +0100
Message-ID: <1444398602-24020-4-git-send-email-jonathanh@nvidia.com>
References: <1444398602-24020-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444398602-24020-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-serial@vger.kernel.org

The serial-tegra driver always uses DMA and hence the driver always
allocates DMA channels. Therefore, the test to see if the RX DMA channel
is initialised in tegra_uart_stop_rx() is unnecessary and so remove
the test and the code that corresponds to the case where the RX DMA
channel is not initialised. Please note that the call to
tegra_uart_stop_rx() should always be before the call to
tegra_uart_shutdown() which will uninitialise the RX DMA channel.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 42583484d4b2..11aa5e1e3705 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -777,16 +777,13 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 	tup->ier_shadow = ier;
 	tegra_uart_write(tup, ier, UART_IER);
 	tup->rx_in_progress = 0;
-	if (tup->rx_dma_chan) {
-		dmaengine_terminate_all(tup->rx_dma_chan);
-		dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
-		async_tx_ack(tup->rx_dma_desc);
-		count = tup->rx_bytes_requested - state.residue;
-		tegra_uart_copy_rx_to_tty(tup, port, count);
-		tegra_uart_handle_rx_pio(tup, port);
-	} else {
-		tegra_uart_handle_rx_pio(tup, port);
-	}
+	dmaengine_terminate_all(tup->rx_dma_chan);
+	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+	async_tx_ack(tup->rx_dma_desc);
+	count = tup->rx_bytes_requested - state.residue;
+	tegra_uart_copy_rx_to_tty(tup, port, count);
+	tegra_uart_handle_rx_pio(tup, port);
+
 	if (tty) {
 		tty_flip_buffer_push(port);
 		tty_kref_put(tty);
-- 
2.1.4
