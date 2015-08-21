From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 26/33] serial: sh-sci: Fix race condition between RX worker and cleanup
Date: Fri, 21 Aug 2015 20:02:50 +0200
Message-ID: <1440180177-6924-27-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

During serial port shutdown, the DMA receive worker function may still
be called after the receive DMA cleanup function has been called.
Fix this race condition between work_fn_rx() and sci_rx_dma_release() by
acquiring the port's spinlock in sci_rx_dma_release().
This requires releasing the spinlock in work_fn_rx() before calling (any
function that may call) sci_rx_dma_release().

Terminate all active receive DMA descriptors to release them, and to
make sure no more completions come in.

Do the same in sci_tx_dma_release() for symmetry, although the serial
upper layer will no longer submit more data at this point of time.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Move invalidation of cookies inside the lock,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f6ed203dde41bf83..35e24b726fe605d1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1362,9 +1362,13 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
+	unsigned long flags;
 
+	spin_lock_irqsave(&port->lock, flags);
 	s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
+	spin_unlock_irqrestore(&port->lock, flags);
+	dmaengine_terminate_all(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2,
 			  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
@@ -1376,9 +1380,13 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
 {
 	struct dma_chan *chan = s->chan_tx;
 	struct uart_port *port = &s->port;
+	unsigned long flags;
 
+	spin_lock_irqsave(&port->lock, flags);
 	s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
+	spin_unlock_irqrestore(&port->lock, flags);
+	dmaengine_terminate_all(chan);
 	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
 			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
@@ -1444,7 +1452,8 @@ static void work_fn_rx(struct work_struct *work)
 	} else {
 		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
 			s->active_rx);
-		goto out;
+		spin_unlock_irqrestore(&port->lock, flags);
+		return;
 	}
 
 	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
@@ -1464,9 +1473,10 @@ static void work_fn_rx(struct work_struct *work)
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
 
-		sci_submit_rx(s);
+		spin_unlock_irqrestore(&port->lock, flags);
 
-		goto out;
+		sci_submit_rx(s);
+		return;
 	}
 
 	desc = dmaengine_prep_slave_sg(s->chan_rx, &s->sg_rx[new], 1,
@@ -1485,14 +1495,13 @@ static void work_fn_rx(struct work_struct *work)
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
-out:
 	spin_unlock_irqrestore(&port->lock, flags);
 	return;
 
 fail:
+	spin_unlock_irqrestore(&port->lock, flags);
 	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 	sci_rx_dma_release(s, true);
-	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void work_fn_tx(struct work_struct *work)
-- 
1.9.1

