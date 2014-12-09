From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 06/15] serial: imx: unmap scatter gather list in imx_flush_buffer
Date: Tue, 9 Dec 2014 18:11:27 +0900
Message-ID: <1418116296-12082-7-git-send-email-jiada_wang@mentor.com>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

First, reformat the code to exit immediately. This allows us to add
more code in more readable format.

In case the TX DMA was still running, remove and disable it's resources.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/tty/serial/imx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a0bfccf..e53a058 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1302,10 +1302,17 @@ static void imx_shutdown(struct uart_port *port)
 static void imx_flush_buffer(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
+	struct scatterlist *sgl = &sport->tx_sgl[0];
 
-	if (sport->dma_is_enabled) {
-		sport->tx_bytes = 0;
-		dmaengine_terminate_all(sport->dma_chan_tx);
+	if (!sport->dma_chan_tx)
+		return;
+
+	sport->tx_bytes = 0;
+	dmaengine_terminate_all(sport->dma_chan_tx);
+	if (sport->dma_is_txing) {
+		dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents,
+			     DMA_TO_DEVICE);
+		sport->dma_is_txing = false;
 	}
 }
 
-- 
1.9.3
