From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH v2 1/2] serial: mxs-auart: set the FIFO size to DMA buffer size
Date: Wed, 2 Oct 2013 14:02:43 +0200
Message-ID: <1380715364-8025-2-git-send-email-hector.palacios@digi.com>
References: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.17]:55080 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753985Ab3JBMEI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 08:04:08 -0400
In-Reply-To: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: hector.palacios@digi.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org, b32955@freescale.com, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

When DMA is enabled (with hardware flow control enabled) the FIFO size
must be set to the size of the DMA buffer, as this is the size the tty
subsystem can use.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/tty/serial/mxs-auart.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index f85b8e6..9f046177 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -40,6 +40,7 @@
 #include <asm/cacheflush.h>
 
 #define MXS_AUART_PORTS 5
+#define MXS_AUART_FIFO_SIZE		16
 
 #define AUART_CTRL0			0x00000000
 #define AUART_CTRL0_SET			0x00000004
@@ -549,6 +550,9 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 	s->flags |= MXS_AUART_DMA_ENABLED;
 	dev_dbg(s->dev, "enabled the DMA support.");
 
+	/* The DMA buffer is now the FIFO the TTY subsystem can use */
+	s->port.fifosize = UART_XMIT_SIZE;
+
 	return 0;
 
 err_out:
@@ -741,6 +745,9 @@ static int mxs_auart_startup(struct uart_port *u)
 	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
 			u->membase + AUART_INTR);
 
+	/* Reset FIFO size (it could have changed if DMA was enabled) */
+	u->fifosize = MXS_AUART_FIFO_SIZE;
+
 	/*
 	 * Enable fifo so all four bytes of a DMA word are written to
 	 * output (otherwise, only the LSB is written, ie. 1 in 4 bytes)
@@ -1062,7 +1069,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.membase = ioremap(r->start, resource_size(r));
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
-	s->port.fifosize = 16;
+	s->port.fifosize = MXS_AUART_FIFO_SIZE;
 	s->port.uartclk = clk_get_rate(s->clk);
 	s->port.type = PORT_IMX;
 	s->port.dev = s->dev = &pdev->dev;
-- 
1.8.4

