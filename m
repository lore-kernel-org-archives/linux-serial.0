From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [PATCH 1/1] serial: imx: Replace dmaengine old API
Date: Tue, 13 Sep 2016 10:17:05 +0200
Message-ID: <1473754625-7268-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

dmaengine_terminate_all() is deprecated and should be replaced by
dmaengine_terminate_sync() in non-atomic context or dmaengine_terminate_async()
with dmaengine_synchronize().

See commit b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d9a0c87..1ae3c0c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1122,7 +1122,7 @@ static void imx_setup_ufcr(struct imx_port *sport,
 static void imx_uart_dma_exit(struct imx_port *sport)
 {
 	if (sport->dma_chan_rx) {
-		dmaengine_terminate_all(sport->dma_chan_rx);
+		dmaengine_terminate_sync(sport->dma_chan_rx);
 		dma_release_channel(sport->dma_chan_rx);
 		sport->dma_chan_rx = NULL;
 		sport->rx_cookie = -EINVAL;
@@ -1131,7 +1131,7 @@ static void imx_uart_dma_exit(struct imx_port *sport)
 	}
 
 	if (sport->dma_chan_tx) {
-		dmaengine_terminate_all(sport->dma_chan_tx);
+		dmaengine_terminate_sync(sport->dma_chan_tx);
 		dma_release_channel(sport->dma_chan_tx);
 		sport->dma_chan_tx = NULL;
 	}
@@ -1351,8 +1351,8 @@ static void imx_shutdown(struct uart_port *port)
 	if (sport->dma_is_enabled) {
 		sport->dma_is_rxing = 0;
 		sport->dma_is_txing = 0;
-		dmaengine_terminate_all(sport->dma_chan_tx);
-		dmaengine_terminate_all(sport->dma_chan_rx);
+		dmaengine_terminate_sync(sport->dma_chan_tx);
+		dmaengine_terminate_sync(sport->dma_chan_rx);
 
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_stop_tx(port);
-- 
2.1.4
