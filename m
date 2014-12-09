From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH 1/5] tty/serial: at91: use correct type for dma_sync_*_for_cpu() and dma_sync_*_for_device()
Date: Tue, 9 Dec 2014 14:31:32 +0100
Message-ID: <830a2b33ab0226405dc310c8a6d43731bf4ca8f9.1418131298.git.cyrille.pitchen@atmel.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1418131298.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, voice.shen@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

dma_sync_*_for_cpu() and dma_sync_*_for_device() use 'enum dma_data_direction',
not 'enum dma_transfer_direction'

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4d848a2..756f567 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -794,7 +794,7 @@ static void atmel_tx_dma(struct uart_port *port)
 			return;
 		}
 
-		dma_sync_sg_for_device(port->dev, sg, 1, DMA_MEM_TO_DEV);
+		dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
 
 		atmel_port->desc_tx = desc;
 		desc->callback = atmel_complete_tx_dma;
@@ -927,7 +927,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	dma_sync_sg_for_cpu(port->dev,
 			    &atmel_port->sg_rx,
 			    1,
-			    DMA_DEV_TO_MEM);
+			    DMA_FROM_DEVICE);
 
 	/*
 	 * ring->head points to the end of data already written by the DMA.
@@ -974,7 +974,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	dma_sync_sg_for_device(port->dev,
 			       &atmel_port->sg_rx,
 			       1,
-			       DMA_DEV_TO_MEM);
+			       DMA_FROM_DEVICE);
 
 	/*
 	 * Drop the lock here since it might end up calling
-- 
1.8.2.2
