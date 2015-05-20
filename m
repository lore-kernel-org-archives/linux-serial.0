From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] serial: tegra: Fix memory leak on DMA setup failure
Date: Wed, 20 May 2015 12:21:04 +0100
Message-ID: <1432120864-23916-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-serial@vger.kernel.org

If the call to dmaengine_slave_config() fails, then the DMA buffer will
not be freed/unmapped. Fix this by moving the code that stores the
address of the buffer in the tegra_uart_port structure to before the
call to dmaengine_slave_config().

Reported-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 3b63f103f0c9..cf0133ae762d 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -999,6 +999,12 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 			dma_release_channel(dma_chan);
 			return -ENOMEM;
 		}
+		dma_sconfig.src_addr = tup->uport.mapbase;
+		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		dma_sconfig.src_maxburst = 4;
+		tup->rx_dma_chan = dma_chan;
+		tup->rx_dma_buf_virt = dma_buf;
+		tup->rx_dma_buf_phys = dma_phys;
 	} else {
 		dma_phys = dma_map_single(tup->uport.dev,
 			tup->uport.state->xmit.buf, UART_XMIT_SIZE,
@@ -1009,39 +1015,23 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 			return -ENOMEM;
 		}
 		dma_buf = tup->uport.state->xmit.buf;
-	}
-
-	if (dma_to_memory) {
-		dma_sconfig.src_addr = tup->uport.mapbase;
-		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		dma_sconfig.src_maxburst = 4;
-	} else {
 		dma_sconfig.dst_addr = tup->uport.mapbase;
 		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 		dma_sconfig.dst_maxburst = 16;
+		tup->tx_dma_chan = dma_chan;
+		tup->tx_dma_buf_virt = dma_buf;
+		tup->tx_dma_buf_phys = dma_phys;
 	}
 
 	ret = dmaengine_slave_config(dma_chan, &dma_sconfig);
 	if (ret < 0) {
 		dev_err(tup->uport.dev,
 			"Dma slave config failed, err = %d\n", ret);
-		goto scrub;
+		tegra_uart_dma_channel_free(tup, dma_to_memory);
+		return ret;
 	}
 
-	if (dma_to_memory) {
-		tup->rx_dma_chan = dma_chan;
-		tup->rx_dma_buf_virt = dma_buf;
-		tup->rx_dma_buf_phys = dma_phys;
-	} else {
-		tup->tx_dma_chan = dma_chan;
-		tup->tx_dma_buf_virt = dma_buf;
-		tup->tx_dma_buf_phys = dma_phys;
-	}
 	return 0;
-
-scrub:
-	tegra_uart_dma_channel_free(tup, dma_to_memory);
-	return ret;
 }
 
 static int tegra_uart_startup(struct uart_port *u)
-- 
1.9.1
