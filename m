From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] serial: tegra: ack the rx dma desc after transfer terminated
Date: Fri, 6 Jun 2014 16:48:09 +0530
Message-ID: <1402053489-21262-2-git-send-email-ldewangan@nvidia.com>
References: <1402053489-21262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402053489-21262-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The Rx dma descriptor allocated without the DMA_ACK flags so that
once after tarnsfer done or terminated, client can ack the descriptor
to free it for later use.

If the Rx DMA is terminated for some reason then rx-dma descriptor
is not getting acked which causes the memory leak and list of usage
desc to grow continuously.

Hence, acknowledge the rx-dma descriptor once transfer is terminated
to avoid memory leak and desc list to grow.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 117d8d1..53d7c31 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -602,6 +602,7 @@ static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup,
 
 	dmaengine_terminate_all(tup->rx_dma_chan);
 	dmaengine_tx_status(tup->rx_dma_chan,  tup->rx_cookie, &state);
+	async_tx_ack(tup->rx_dma_desc);
 	count = tup->rx_bytes_requested - state.residue;
 
 	/* If we are here, DMA is stopped */
-- 
1.8.1.5
