From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] tty/serial: at91: maxburst was missing for dma transfers
Date: Thu, 16 Apr 2015 16:58:12 +0200
Message-ID: <1429196292-8134-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, Ludovic Desroches <ludovic.desroches@atmel.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Maxburst was not set when doing the dma slave configuration. This value
is checked by the recently introduced xdmac. It causes an error when
doing the slave configuration and so prevents from using dma.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: <stable@vger.kernel.org> # 3.12 and later
---
 drivers/tty/serial/atmel_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4e959c4..6afce7e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -880,6 +880,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	config.dst_addr = port->mapbase + ATMEL_US_THR;
+	config.dst_maxburst = 1;
 
 	ret = dmaengine_slave_config(atmel_port->chan_tx,
 				     &config);
@@ -1059,6 +1060,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	config.src_addr = port->mapbase + ATMEL_US_RHR;
+	config.src_maxburst = 1;
 
 	ret = dmaengine_slave_config(atmel_port->chan_rx,
 				     &config);
-- 
2.2.0
