From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Update warning message in sci_request_dma_chan()
Date: Mon, 22 May 2017 15:15:02 +0200
Message-ID: <1495458902-11961-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The commit below changed a function call from
dma_request_slave_channel_compat() to dma_request_slave_channel(), but
forgot to update the printed failure message.

Fixes: 219fb0c1436e4893 ("serial: sh-sci: Remove the platform data dma slave rx/tx channel IDs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 21b06cf1f15bc642..d36d735cd0099e83 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1450,8 +1450,7 @@ static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
 	chan = dma_request_slave_channel(port->dev,
 					 dir == DMA_MEM_TO_DEV ? "tx" : "rx");
 	if (!chan) {
-		dev_warn(port->dev,
-			 "dma_request_slave_channel_compat failed\n");
+		dev_warn(port->dev, "dma_request_slave_channel failed\n");
 		return NULL;
 	}
 
-- 
2.7.4
