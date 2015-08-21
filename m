From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 15/33] serial: sh-sci: Handle DMA init failures inside sci_request_dma()
Date: Fri, 21 Aug 2015 20:02:39 +0200
Message-ID: <1440180177-6924-16-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Let sci_request_dma() handle failures to initialize DMA itself.
This way sci_tx_dma_release() and sci_rx_dma_release() don't have to
consider partial initialization, and thus don't need to reset DMA
addresses to DMA_ERROR_CODE, which is not 100% portable access
architectures.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/tty/serial/sh-sci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cfef543df25271f5..ea6ab6173ce9f239 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1371,9 +1371,8 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 	s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
 	dma_release_channel(chan);
-	if (sg_dma_address(&s->sg_rx[0]))
-		dma_free_coherent(port->dev, s->buf_len_rx * 2,
-				  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
+	dma_free_coherent(port->dev, s->buf_len_rx * 2,
+			  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
 	if (enable_pio)
 		sci_start_rx(port);
 }
@@ -1709,7 +1708,8 @@ static void sci_request_dma(struct uart_port *port)
 		nent = dma_map_sg(port->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
 		if (!nent) {
 			dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
-			sci_tx_dma_release(s, false);
+			dma_release_channel(chan);
+			s->chan_tx = NULL;
 		} else {
 			dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n",
 				__func__,
@@ -1743,7 +1743,9 @@ static void sci_request_dma(struct uart_port *port)
 		if (!buf[0]) {
 			dev_warn(port->dev,
 				 "Failed to allocate Rx dma buffer, using PIO\n");
-			sci_rx_dma_release(s, true);
+			dma_release_channel(chan);
+			s->chan_rx = NULL;
+			sci_start_rx(port);
 			return;
 		}
 
-- 
1.9.1

