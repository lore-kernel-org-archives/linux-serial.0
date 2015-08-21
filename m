From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 17/33] serial: sh-sci: Use min_t()/max_t() instead of casts
Date: Fri, 21 Aug 2015 20:02:41 +0200
Message-ID: <1440180177-6924-18-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

When comparing differently sized types, it's better to use
min_t()/max_t() than adding casts.

Also use "unsigned int" instead of "int", as that's the right type for
the length of an SG entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9aa9720d7f09d10f..cb35c88645bb5784 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1507,7 +1507,8 @@ static void work_fn_tx(struct work_struct *work)
 	sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
 	sg_dma_address(sg) = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
 		sg->offset;
-	sg_dma_len(sg) = min((int)CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
+	sg_dma_len(sg) = min_t(unsigned int,
+		CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
 		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
 	spin_unlock_irq(&port->lock);
 
@@ -1737,7 +1738,7 @@ static void sci_request_dma(struct uart_port *port)
 
 		s->chan_rx = chan;
 
-		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
+		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
 		buf[0] = dma_alloc_coherent(chan->device->dev,
 					    s->buf_len_rx * 2, &dma[0],
 					    GFP_KERNEL);
-- 
1.9.1

