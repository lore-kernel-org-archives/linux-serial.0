From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 29/33] serial: sh-sci: Use incrementing pointers instead of stack array
Date: Fri, 21 Aug 2015 20:02:53 +0200
Message-ID: <1440180177-6924-30-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

There's no need to keep all buffer and DMA pointers on the stack.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Extracted from "[PATCH/RFC v2 28/29] serial: sh-sci: Add (H)SCIF DMA
    support".
---
 drivers/tty/serial/sh-sci.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 57b1cc1da67d228a..681e52a087c2e821 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1734,18 +1734,16 @@ static void sci_request_dma(struct uart_port *port)
 	chan = dma_request_channel(mask, filter, param);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
 	if (chan) {
-		dma_addr_t dma[2];
-		void *buf[2];
-		int i;
+		unsigned int i;
+		dma_addr_t dma;
+		void *buf;
 
 		s->chan_rx = chan;
 
 		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
-		buf[0] = dma_alloc_coherent(chan->device->dev,
-					    s->buf_len_rx * 2, &dma[0],
-					    GFP_KERNEL);
-
-		if (!buf[0]) {
+		buf = dma_alloc_coherent(chan->device->dev, s->buf_len_rx * 2,
+					 &dma, GFP_KERNEL);
+		if (!buf) {
 			dev_warn(port->dev,
 				 "Failed to allocate Rx dma buffer, using PIO\n");
 			dma_release_channel(chan);
@@ -1754,16 +1752,16 @@ static void sci_request_dma(struct uart_port *port)
 			return;
 		}
 
-		buf[1] = buf[0] + s->buf_len_rx;
-		dma[1] = dma[0] + s->buf_len_rx;
-
 		for (i = 0; i < 2; i++) {
 			struct scatterlist *sg = &s->sg_rx[i];
 
 			sg_init_table(sg, 1);
-			sg_set_page(sg, virt_to_page(buf[i]), s->buf_len_rx,
-				    (uintptr_t)buf[i] & ~PAGE_MASK);
-			sg_dma_address(sg) = dma[i];
+			sg_set_page(sg, virt_to_page(buf), s->buf_len_rx,
+				    (uintptr_t)buf & ~PAGE_MASK);
+			sg_dma_address(sg) = dma;
+
+			buf += s->buf_len_rx;
+			dma += s->buf_len_rx;
 		}
 
 		INIT_WORK(&s->work_rx, work_fn_rx);
-- 
1.9.1

