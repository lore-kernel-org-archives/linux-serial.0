From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] serial: sh-sci: Fix length of scatterlist
Date: Thu, 22 Oct 2015 15:41:26 +0900
Message-ID: <1445496086-5972-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-serial@vger.kernel.org

This patch fixes an issue that the "length" of scatterlist should be
set using sg_dma_len(). Otherwise, a dmaengine driver cannot work
correctly if CONFIG_NEED_SG_DMA_LENGTH=y.

Fixes: 7b39d90184 (serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled)
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v1:
  - Fix using implicit declaration of function "sg_dma_length".

 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 960e50a..51c7507 100644
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

