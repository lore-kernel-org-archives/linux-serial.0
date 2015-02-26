From: Leilei Zhao <leilei.zhao@atmel.com>
Subject: [PATCH 2/5] tty/serial: at91: correct buffer size used in DMA
Date: Thu, 26 Feb 2015 14:55:22 +0800
Message-ID: <1424933725-16242-3-git-send-email-leilei.zhao@atmel.com>
References: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Leilei Zhao <leilei.zhao@atmel.com>
List-Id: linux-serial@vger.kernel.org

The buffer size set in DMA is inconsistent with its allocation.
So keep them consistent here. The structure atmel_uart_char is
used in PIO mode with its meaning. But here in DMA, all of the
buffer is treated as general char.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 460903c..6a4d44d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1030,7 +1030,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	BUG_ON((int)ring->buf & ~PAGE_MASK);
 	sg_set_page(&atmel_port->sg_rx,
 		    virt_to_page(ring->buf),
-		    ATMEL_SERIAL_RINGSIZE,
+		    sizeof(struct atmel_uart_char) * ATMEL_SERIAL_RINGSIZE,
 		    (int)ring->buf & ~PAGE_MASK);
 	nent = dma_map_sg(port->dev,
 			  &atmel_port->sg_rx,
-- 
1.7.9.5
