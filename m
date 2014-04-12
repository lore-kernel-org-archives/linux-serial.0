From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] serial: pl011: change Rx burst size to half of trigger level
Date: Sat, 12 Apr 2014 19:47:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1404121945120.8725@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaDLRrT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Apr 2014 13:47:19 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>

The amba-pl011.c driver sets DMA burst size equal to FIFO trigger level.
If now exactly DMA burst size bytes are received, the DMAC will retrieve
them all and no Rx timeout interrupt will be generated. To fix that set
the burst size to half the FIFO trigger level.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 07325f2..dacf0a0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -318,7 +318,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 			.src_addr = uap->port.mapbase + UART01x_DR,
 			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 			.direction = DMA_DEV_TO_MEM,
-			.src_maxburst = uap->fifosize >> 1,
+			.src_maxburst = uap->fifosize >> 2,
 			.device_fc = false,
 		};
 
-- 
1.9.1

