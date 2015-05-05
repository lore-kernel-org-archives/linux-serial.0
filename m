From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 8/8] serial: tegra: Correct error handling on DMA setup
Date: Tue, 5 May 2015 15:17:59 +0100
Message-ID: <1430835479-6613-9-git-send-email-jonathanh@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430835479-6613-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Function tegra_uart_dma_channel_allocate() does not check that
dma_map_single() mapped the DMA buffer correctly. Add a check for this
and appropriate error handling.

Furthermore, if dmaengine_slave_config() (called by
tegra_uart_dma_channel_allocate()) fails, then memory allocated/mapped
is not freed/unmapped. Therefore, call tegra_uart_dma_channel_free()
instead of just dma_release_channel() if  dmaengine_slave_config() fails.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 51 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 96378da9aefc..3b63f103f0c9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -949,6 +949,28 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	return 0;
 }
 
+static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
+		bool dma_to_memory)
+{
+	if (dma_to_memory) {
+		dmaengine_terminate_all(tup->rx_dma_chan);
+		dma_release_channel(tup->rx_dma_chan);
+		dma_free_coherent(tup->uport.dev, TEGRA_UART_RX_DMA_BUFFER_SIZE,
+				tup->rx_dma_buf_virt, tup->rx_dma_buf_phys);
+		tup->rx_dma_chan = NULL;
+		tup->rx_dma_buf_phys = 0;
+		tup->rx_dma_buf_virt = NULL;
+	} else {
+		dmaengine_terminate_all(tup->tx_dma_chan);
+		dma_release_channel(tup->tx_dma_chan);
+		dma_unmap_single(tup->uport.dev, tup->tx_dma_buf_phys,
+			UART_XMIT_SIZE, DMA_TO_DEVICE);
+		tup->tx_dma_chan = NULL;
+		tup->tx_dma_buf_phys = 0;
+		tup->tx_dma_buf_virt = NULL;
+	}
+}
+
 static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 			bool dma_to_memory)
 {
@@ -981,6 +1003,11 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 		dma_phys = dma_map_single(tup->uport.dev,
 			tup->uport.state->xmit.buf, UART_XMIT_SIZE,
 			DMA_TO_DEVICE);
+		if (dma_mapping_error(tup->uport.dev, dma_phys)) {
+			dev_err(tup->uport.dev, "dma_map_single tx failed\n");
+			dma_release_channel(dma_chan);
+			return -ENOMEM;
+		}
 		dma_buf = tup->uport.state->xmit.buf;
 	}
 
@@ -1013,32 +1040,10 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 	return 0;
 
 scrub:
-	dma_release_channel(dma_chan);
+	tegra_uart_dma_channel_free(tup, dma_to_memory);
 	return ret;
 }
 
-static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
-		bool dma_to_memory)
-{
-	if (dma_to_memory) {
-		dmaengine_terminate_all(tup->rx_dma_chan);
-		dma_release_channel(tup->rx_dma_chan);
-		dma_free_coherent(tup->uport.dev, TEGRA_UART_RX_DMA_BUFFER_SIZE,
-				tup->rx_dma_buf_virt, tup->rx_dma_buf_phys);
-		tup->rx_dma_chan = NULL;
-		tup->rx_dma_buf_phys = 0;
-		tup->rx_dma_buf_virt = NULL;
-	} else {
-		dmaengine_terminate_all(tup->tx_dma_chan);
-		dma_release_channel(tup->tx_dma_chan);
-		dma_unmap_single(tup->uport.dev, tup->tx_dma_buf_phys,
-			UART_XMIT_SIZE, DMA_TO_DEVICE);
-		tup->tx_dma_chan = NULL;
-		tup->tx_dma_buf_phys = 0;
-		tup->tx_dma_buf_virt = NULL;
-	}
-}
-
 static int tegra_uart_startup(struct uart_port *u)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
-- 
1.9.1
