From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Fix length of scatterlist
Date: Fri,  4 Dec 2015 15:21:19 +0100
Message-ID: <1449238879-31169-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch fixes an issue that the "length" of scatterlist should be
set using sg_dma_len(). Otherwise, a dmaengine driver cannot work
correctly if CONFIG_NEED_SG_DMA_LENGTH=y.

Fixes: 7b39d90184 (serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled)
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 960e50a97558cff5..51c7507b0444957b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1437,7 +1437,7 @@ static void sci_request_dma(struct uart_port *port)
 			sg_init_table(sg, 1);
 			s->rx_buf[i] = buf;
 			sg_dma_address(sg) = dma;
-			sg->length = s->buf_len_rx;
+			sg_dma_len(sg) = s->buf_len_rx;
 
 			buf += s->buf_len_rx;
 			dma += s->buf_len_rx;
-- 
1.9.1

