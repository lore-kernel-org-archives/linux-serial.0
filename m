From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] serial: sirf: Simplify a test
Date: Tue,  1 Nov 2016 08:03:33 +0100
Message-ID: <20161101070333.12255-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, baohua@kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-serial@vger.kernel.org

'dmaengine_prep_dma_cyclic()' does not return an error pointer, so the test
can be simplified to be more consistent.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index b186c9c4f850..666ca3156961 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -609,7 +609,7 @@ static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
 		sirfport->rx_dma_items.dma_addr, SIRFSOC_RX_DMA_BUF_SIZE,
 		SIRFSOC_RX_DMA_BUF_SIZE / 2,
 		DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
-	if (IS_ERR_OR_NULL(sirfport->rx_dma_items.desc)) {
+	if (!sirfport->rx_dma_items.desc) {
 		dev_err(port->dev, "DMA slave single fail\n");
 		return;
 	}
-- 
2.9.3
