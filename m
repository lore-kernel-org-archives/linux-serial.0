From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] drivers/tty/serial: use correct type for dma_map/unmap
Date: Mon, 21 Jul 2014 11:42:04 +0200
Message-ID: <1405935725-10457-3-git-send-email-wsa@the-dreams.de>
References: <1405935725-10457-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405935725-10457-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

dma_{un}map_* uses 'enum dma_data_direction' not 'enum dma_transfer_direction'.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/tty/serial/atmel_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c4f750314100..7b63677475c1 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -706,7 +706,7 @@ static void atmel_release_tx_dma(struct uart_port *port)
 		dmaengine_terminate_all(chan);
 		dma_release_channel(chan);
 		dma_unmap_sg(port->dev, &atmel_port->sg_tx, 1,
-				DMA_MEM_TO_DEV);
+				DMA_TO_DEVICE);
 	}
 
 	atmel_port->desc_tx = NULL;
@@ -804,7 +804,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	nent = dma_map_sg(port->dev,
 				&atmel_port->sg_tx,
 				1,
-				DMA_MEM_TO_DEV);
+				DMA_TO_DEVICE);
 
 	if (!nent) {
 		dev_dbg(port->dev, "need to release resource of dma\n");
@@ -883,7 +883,7 @@ static void atmel_release_rx_dma(struct uart_port *port)
 		dmaengine_terminate_all(chan);
 		dma_release_channel(chan);
 		dma_unmap_sg(port->dev, &atmel_port->sg_rx, 1,
-				DMA_DEV_TO_MEM);
+				DMA_FROM_DEVICE);
 	}
 
 	atmel_port->desc_rx = NULL;
@@ -968,7 +968,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 			nent = dma_map_sg(port->dev,
 					&atmel_port->sg_rx,
 					1,
-					DMA_DEV_TO_MEM);
+					DMA_FROM_DEVICE);
 
 	if (!nent) {
 		dev_dbg(port->dev, "need to release resource of dma\n");
-- 
2.0.0
