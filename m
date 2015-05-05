From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/8] serial: tegra: handle race condition on uart rx side
Date: Tue, 5 May 2015 15:17:55 +0100
Message-ID: <1430835479-6613-5-git-send-email-jonathanh@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430835479-6613-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shardar Shariff Md <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Shardar Shariff Md <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The tegra serial driver has two paths through which receive data is
copied up to the tty layer. These are:
1. DMA completion callback
2. UART RX interrupt

A UART RX interrupt occurs for either RX_TIMEOUT (data has been sitting
in the Rx FIFO for more than 4 character times without being read
because there is not enough data to reach the trigger level), End of
Receive Data event (receiver detects that data stops coming in for more
than 4 character times) or a receive error.

In the RX interrupt path, the following happens ...
- All RX DMA transfers are stopped
- Any data in the DMA buffer and RX FIFO are copied up to the tty layer.
- DMA is restarted/primed for the RX path

In the DMA completion callback, the DMA buffer is copied up to the tty
layer but there is no check to see if the RX interrupt could have
occurred between the DMA interrupt firing the the DMA callback running.
Hence, if a RX interrupt was to occur shortly after the DMA completion
interrupt, it is possible that the RX interrupt path has already copied
the DMA buffer before the DMA callback has been called. Therefore, when
the DMA callback is called, if the DMA is already in-progress, then this
indicates that the UART RX interrupt has already occurred and there is
nothing to do in the DMA callback. This race condition can cause
duplicated data to be received.

Signed-off-by: Shardar Shariff Md <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
[jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org: Moved async_tx_ack() call to after check to see
 if DMA has completed because if the DMA is in progress we do not need
 to ACK yet. Changed the print from dev_info to dev_debug. Updated
 changelog to add more commentary on the race condition based upon
 feedback from author.]
Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index a53899c47e60..17d8a08b047b 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -583,10 +583,20 @@ static void tegra_uart_rx_dma_complete(void *args)
 	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
 	struct tty_port *port = &u->state->port;
 	unsigned long flags;
+	struct dma_tx_state state;
+	enum dma_status status;
 
-	async_tx_ack(tup->rx_dma_desc);
 	spin_lock_irqsave(&u->lock, flags);
 
+	status = dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+
+	if (status == DMA_IN_PROGRESS) {
+		dev_dbg(tup->uport.dev, "RX DMA is in progress\n");
+		goto done;
+	}
+
+	async_tx_ack(tup->rx_dma_desc);
+
 	/* Deactivate flow control to stop sender */
 	if (tup->rts_active)
 		set_rts(tup, false);
@@ -607,6 +617,7 @@ static void tegra_uart_rx_dma_complete(void *args)
 	if (tup->rts_active)
 		set_rts(tup, true);
 
+done:
 	spin_unlock_irqrestore(&u->lock, flags);
 }
 
-- 
1.9.1
