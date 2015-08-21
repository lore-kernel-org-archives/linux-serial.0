From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 16/33] serial: sh-sci: Use correct device for DMA mapping with IOMMU
Date: Fri, 21 Aug 2015 20:02:40 +0200
Message-ID: <1440180177-6924-17-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

To function correctly in the presence of an IOMMU, the DMA buffers must
be managed using the DMA channel's device instead of the platform
device's device.

Make sure to free the DMA memory before releasing the channel, not
after.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - Fix call to dma_sync_sg_for_device() which I missed before,
  - Rebased on top of "serial: sh-sci: Handle DMA init failures inside
    sci_request_dma()",

v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ea6ab6173ce9f239..9aa9720d7f09d10f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1370,9 +1370,9 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 
 	s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
-	dma_release_channel(chan);
-	dma_free_coherent(port->dev, s->buf_len_rx * 2,
+	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2,
 			  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
+	dma_release_channel(chan);
 	if (enable_pio)
 		sci_start_rx(port);
 }
@@ -1523,7 +1523,7 @@ static void work_fn_tx(struct work_struct *work)
 		return;
 	}
 
-	dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
+	dma_sync_sg_for_device(chan->device->dev, sg, 1, DMA_TO_DEVICE);
 
 	spin_lock_irq(&port->lock);
 	s->desc_tx = desc;
@@ -1705,7 +1705,8 @@ static void sci_request_dma(struct uart_port *port)
 		sg_set_page(&s->sg_tx, virt_to_page(port->state->xmit.buf),
 			    UART_XMIT_SIZE,
 			    (uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
-		nent = dma_map_sg(port->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
+		nent = dma_map_sg(chan->device->dev, &s->sg_tx, 1,
+				  DMA_TO_DEVICE);
 		if (!nent) {
 			dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
 			dma_release_channel(chan);
@@ -1737,8 +1738,9 @@ static void sci_request_dma(struct uart_port *port)
 		s->chan_rx = chan;
 
 		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
-		buf[0] = dma_alloc_coherent(port->dev, s->buf_len_rx * 2,
-					    &dma[0], GFP_KERNEL);
+		buf[0] = dma_alloc_coherent(chan->device->dev,
+					    s->buf_len_rx * 2, &dma[0],
+					    GFP_KERNEL);
 
 		if (!buf[0]) {
 			dev_warn(port->dev,
-- 
1.9.1

