From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/2] serial: fsl_lpuart: update RX timer on successful DMA transfer
Date: Sat, 10 Jan 2015 09:33:46 +0100
Message-ID: <1420878826-10214-3-git-send-email-stefan@agner.ch>
References: <1420878826-10214-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420878826-10214-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-serial@vger.kernel.org

To end a DMA transfer which did not consume a whole buffer (e.g. one
character only), a RX timer is used. When lots of data are received
the DMA transfer will complete and setup another DMA transfer, which
in turn might complete again. In this cases, it is not necessary to
abort the DMA transfers using the RX timer. This change pushes the
RX timer timeout into the future each time a DMA transfer completed.

Aborting the DMA was not very harmful, since the next received
character lead to setup of another RX DMA.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0ea0af7..914f9a2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -462,6 +462,7 @@ static void lpuart_dma_rx_complete(void *arg)
 	unsigned long flags;
 
 	async_tx_ack(sport->dma_rx_desc);
+	mod_timer(&sport->lpuart_timer, jiffies + sport->dma_rx_timeout);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.2.1
