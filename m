From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 24/33] serial: sh-sci: Do not resubmit DMA descriptors
Date: Fri, 21 Aug 2015 20:02:48 +0200
Message-ID: <1440180177-6924-25-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Resubmission of DMA descriptors is explicitly forbidden by the DMA
engine API.

Hence pass DMA_CTRL_ACK to dmaengine_prep_slave_sg(), and prepare a new
DMA descriptor instead of reusing the old one.
Remove sci_port.desc_rx[], as there's no longer a need to access the
active descriptor.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Resubmission is explicitly forbidden by the DMA engine API, cfr.
    commit 06f10e2f936424496d44e5541c220845c8c55345 ("Documentation:
    dmaengine: fix the DMA_CTRL_ACK documentation"),
  - Drop now unused sci_port.desc_rx[],
  - Drop superfluous return at end of work_fn_rx(),
  - Rebased,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9c2bc0f23d3af08c..e318f002da399e70 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -104,7 +104,6 @@ struct sci_port {
 	struct dma_chan			*chan_rx;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	struct dma_async_tx_descriptor	*desc_rx[2];
 	dma_cookie_t			cookie_tx;
 	dma_cookie_t			cookie_rx[2];
 	dma_cookie_t			active_rx;
@@ -1397,11 +1396,11 @@ static void sci_submit_rx(struct sci_port *s)
 		struct dma_async_tx_descriptor *desc;
 
 		desc = dmaengine_prep_slave_sg(chan,
-			sg, 1, DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+			sg, 1, DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc)
 			goto fail;
 
-		s->desc_rx[i] = desc;
 		desc->callback = sci_dma_rx_complete;
 		desc->callback_param = s;
 		s->cookie_rx[i] = dmaengine_submit(desc);
@@ -1420,10 +1419,8 @@ static void sci_submit_rx(struct sci_port *s)
 fail:
 	if (i)
 		dmaengine_terminate_all(chan);
-	for (i = 0; i < 2; i++) {
-		s->desc_rx[i] = NULL;
+	for (i = 0; i < 2; i++)
 		s->cookie_rx[i] = -EINVAL;
-	}
 	s->active_rx = -EINVAL;
 	dev_warn(s->port.dev, "Failed to re-start Rx DMA, using PIO\n");
 	sci_rx_dma_release(s, true);
@@ -1447,7 +1444,6 @@ static void work_fn_rx(struct work_struct *work)
 			s->active_rx);
 		return;
 	}
-	desc = s->desc_rx[new];
 
 	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
 	if (status != DMA_COMPLETE) {
@@ -1474,17 +1470,27 @@ static void work_fn_rx(struct work_struct *work)
 		return;
 	}
 
+	desc = dmaengine_prep_slave_sg(s->chan_rx, &s->sg_rx[new], 1,
+				       DMA_DEV_TO_MEM,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		goto fail;
+
+	desc->callback = sci_dma_rx_complete;
+	desc->callback_param = s;
 	s->cookie_rx[new] = dmaengine_submit(desc);
-	if (dma_submit_error(s->cookie_rx[new])) {
-		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
-		sci_rx_dma_release(s, true);
-		return;
-	}
+	if (dma_submit_error(s->cookie_rx[new]))
+		goto fail;
 
 	s->active_rx = s->cookie_rx[!new];
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
+	return;
+
+fail:
+	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
+	sci_rx_dma_release(s, true);
 }
 
 static void work_fn_tx(struct work_struct *work)
-- 
1.9.1

