From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] tty: serial: fsl_lpuart: terminate DMA on buffer flush
Date: Mon, 26 Jan 2015 01:10:16 +0100
Message-ID: <1422231016-27793-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-serial@vger.kernel.org

On uart buffer flush, serial core resets the circular buffer.
If a DMA transfer is in progress at that time, the callback
lpuart_dma_tx_complete will move buffer's tail unconditionally,
hence tail moves beyond head. Use the flush_buffer hook to
terminate the DMA imeaditely and avoid lpuart_dma_tx_complete
being called in this situation.

This bug often showed up while shutdown and lead to duplicate
serial console output.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/fsl_lpuart.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e95c497..7615b5d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -454,6 +454,15 @@ static int lpuart_dma_rx(struct lpuart_port *sport)
 	return 0;
 }
 
+static void lpuart_flush_buffer(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
+	if (sport->lpuart_dma_tx_use) {
+		dmaengine_terminate_all(sport->dma_tx_chan);
+		sport->dma_tx_in_progress = 0;
+	}
+}
+
 static void lpuart_dma_rx_complete(void *arg)
 {
 	struct lpuart_port *sport = arg;
@@ -1519,6 +1528,7 @@ static struct uart_ops lpuart_pops = {
 	.release_port	= lpuart_release_port,
 	.config_port	= lpuart_config_port,
 	.verify_port	= lpuart_verify_port,
+	.flush_buffer	= lpuart_flush_buffer,
 };
 
 static struct uart_ops lpuart32_pops = {
@@ -1537,6 +1547,7 @@ static struct uart_ops lpuart32_pops = {
 	.release_port	= lpuart_release_port,
 	.config_port	= lpuart_config_port,
 	.verify_port	= lpuart_verify_port,
+	.flush_buffer	= lpuart_flush_buffer,
 };
 
 static struct lpuart_port *lpuart_ports[UART_NR];
-- 
2.2.2
