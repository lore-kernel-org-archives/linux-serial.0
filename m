From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 09/15] serial: imx: call imx_dma_tx() again in dma_tx_callback
Date: Tue, 9 Dec 2014 18:11:30 +0900
Message-ID: <1418116296-12082-10-git-send-email-jiada_wang@mentor.com>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

Currently in dma_tx_callback(), no matter if there is still
remaining data pending in circle buffer or not, DMA transmit
will be terminated.

This will result in some data never get transmitted.
In order to fix this issue, call imx_dma_tx() again in
dma_tx_callback, when there is pending data and uart hasn't
been stopped.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/tty/serial/imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3d86851..c9e6891 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -495,6 +495,7 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 		imx_stop_tx(&sport->port);
 }
 
+static void imx_dma_tx(struct imx_port *sport);
 static void dma_tx_callback(void *data)
 {
 	struct imx_port *sport = data;
@@ -524,6 +525,11 @@ static void dma_tx_callback(void *data)
 		dev_dbg(sport->port.dev, "exit in %s.\n", __func__);
 		return;
 	}
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
+		imx_dma_tx(sport);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void imx_dma_tx(struct imx_port *sport)
-- 
1.9.3
