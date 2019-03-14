From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] tty: atmel_serial: fix a NULL pointer dereference
Date: Thu, 14 Mar 2019 02:17:59 -0500
Message-ID: <20190314071759.18845-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In case dmaengine_prep_dma_cyclic fails, the fix return a proper
error code to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/serial/atmel_serial.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..cf560d05008c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1237,8 +1237,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	dma_cap_set(DMA_CYCLIC, mask);
 
 	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
-	if (atmel_port->chan_rx == NULL)
+	if (atmel_port->chan_rx == NULL) {
+		ret = -EINVAL;
 		goto chan_err;
+	}
 	dev_info(port->dev, "using %s for rx DMA transfers\n",
 		dma_chan_name(atmel_port->chan_rx));
 
@@ -1257,6 +1259,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 
 	if (!nent) {
 		dev_dbg(port->dev, "need to release resource of dma\n");
+		ret = -EINVAL;
 		goto chan_err;
 	} else {
 		dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
@@ -1288,6 +1291,11 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 					 sg_dma_len(&atmel_port->sg_rx)/2,
 					 DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(port->dev, "Preparing DMA cyclic failed\n");
+		ret = -ENOMEM;
+		goto chan_err;
+	}
 	desc->callback = atmel_complete_rx_dma;
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;
@@ -1300,7 +1308,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	atmel_port->use_dma_rx = 0;
 	if (atmel_port->chan_rx)
 		atmel_release_rx_dma(port);
-	return -EINVAL;
+	return ret;
 }
 
 static void atmel_uart_timer_callback(struct timer_list *t)
-- 
2.17.1
