From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/8] serial: tegra: Correct shutdown of UARTs
Date: Tue, 5 May 2015 15:17:58 +0100
Message-ID: <1430835479-6613-8-git-send-email-jonathanh@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430835479-6613-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

There are two issues in the shutdown path of the UARTs which are:
1. The function tegra_uart_shutdown() calls tegra_uart_flush_buffer()
   to stop DMA TX transfers. However, tegra_uart_flush_buffer() is
   called after the DMA channels have already been freed and so actually
   does nothing.
2. The function that frees the DMA channels
   (tegra_uart_dma_channel_free()), unmaps the dma buffer before
   freeing the DMA channel and does not ensure the DMA has been
   stopped.

Resolve this by fixing the code in tegra_uart_dma_channel_free() to
ensure the DMA is stopped, free the DMA channel and then unmap the DMA
buffer. Finally, remove the unnecessary call to tegra_uart_flush_buffer().

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 987c05665e62..96378da9aefc 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1020,24 +1020,23 @@ scrub:
 static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
 		bool dma_to_memory)
 {
-	struct dma_chan *dma_chan;
-
 	if (dma_to_memory) {
+		dmaengine_terminate_all(tup->rx_dma_chan);
+		dma_release_channel(tup->rx_dma_chan);
 		dma_free_coherent(tup->uport.dev, TEGRA_UART_RX_DMA_BUFFER_SIZE,
 				tup->rx_dma_buf_virt, tup->rx_dma_buf_phys);
-		dma_chan = tup->rx_dma_chan;
 		tup->rx_dma_chan = NULL;
 		tup->rx_dma_buf_phys = 0;
 		tup->rx_dma_buf_virt = NULL;
 	} else {
+		dmaengine_terminate_all(tup->tx_dma_chan);
+		dma_release_channel(tup->tx_dma_chan);
 		dma_unmap_single(tup->uport.dev, tup->tx_dma_buf_phys,
 			UART_XMIT_SIZE, DMA_TO_DEVICE);
-		dma_chan = tup->tx_dma_chan;
 		tup->tx_dma_chan = NULL;
 		tup->tx_dma_buf_phys = 0;
 		tup->tx_dma_buf_virt = NULL;
 	}
-	dma_release_channel(dma_chan);
 }
 
 static int tegra_uart_startup(struct uart_port *u)
@@ -1104,8 +1103,6 @@ static void tegra_uart_shutdown(struct uart_port *u)
 	tegra_uart_dma_channel_free(tup, true);
 	tegra_uart_dma_channel_free(tup, false);
 	free_irq(u->irq, tup);
-
-	tegra_uart_flush_buffer(u);
 }
 
 static void tegra_uart_enable_ms(struct uart_port *u)
-- 
1.9.1
