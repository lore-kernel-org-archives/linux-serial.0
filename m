From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 23/33] serial: sh-sci: Simplify sci_submit_rx() error handling
Date: Fri, 21 Aug 2015 20:02:47 +0200
Message-ID: <1440180177-6924-24-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Simplify the error handling in sci_submit_rx() by
  - Moving it to the end of the function,
  - Just calling dmaengine_terminate_all() instead of calling
    async_tx_ack() for all already submitted descriptors.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1191a6c486640983..9c2bc0f23d3af08c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1398,28 +1398,16 @@ static void sci_submit_rx(struct sci_port *s)
 
 		desc = dmaengine_prep_slave_sg(chan,
 			sg, 1, DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+		if (!desc)
+			goto fail;
 
-		if (desc) {
-			s->desc_rx[i] = desc;
-			desc->callback = sci_dma_rx_complete;
-			desc->callback_param = s;
-			s->cookie_rx[i] = dmaengine_submit(desc);
-		}
+		s->desc_rx[i] = desc;
+		desc->callback = sci_dma_rx_complete;
+		desc->callback_param = s;
+		s->cookie_rx[i] = dmaengine_submit(desc);
+		if (dma_submit_error(s->cookie_rx[i]))
+			goto fail;
 
-		if (!desc || dma_submit_error(s->cookie_rx[i])) {
-			if (i) {
-				async_tx_ack(s->desc_rx[0]);
-				s->cookie_rx[0] = -EINVAL;
-			}
-			if (desc) {
-				async_tx_ack(desc);
-				s->cookie_rx[i] = -EINVAL;
-			}
-			dev_warn(s->port.dev,
-				 "Failed to re-start Rx DMA, using PIO\n");
-			sci_rx_dma_release(s, true);
-			return;
-		}
 		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n", __func__,
 			s->cookie_rx[i], i);
 	}
@@ -1427,6 +1415,18 @@ static void sci_submit_rx(struct sci_port *s)
 	s->active_rx = s->cookie_rx[0];
 
 	dma_async_issue_pending(chan);
+	return;
+
+fail:
+	if (i)
+		dmaengine_terminate_all(chan);
+	for (i = 0; i < 2; i++) {
+		s->desc_rx[i] = NULL;
+		s->cookie_rx[i] = -EINVAL;
+	}
+	s->active_rx = -EINVAL;
+	dev_warn(s->port.dev, "Failed to re-start Rx DMA, using PIO\n");
+	sci_rx_dma_release(s, true);
 }
 
 static void work_fn_rx(struct work_struct *work)
-- 
1.9.1

