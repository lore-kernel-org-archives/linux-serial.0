From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 20/33] serial: sh-sci: Use DMA submission helpers instead of open-coding
Date: Fri, 21 Aug 2015 20:02:44 +0200
Message-ID: <1440180177-6924-21-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Replace open-coded
  - calls to dma_async_tx_descriptor.tx_submit() by calls to the
    dmaengine_submit() helper,
  - dma_cookie_t comparisons by calls to dma_submit_error().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4345aa422eed43a1..294b283f5c8535c3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1407,10 +1407,10 @@ static void sci_submit_rx(struct sci_port *s)
 			s->desc_rx[i] = desc;
 			desc->callback = sci_dma_rx_complete;
 			desc->callback_param = s;
-			s->cookie_rx[i] = desc->tx_submit(desc);
+			s->cookie_rx[i] = dmaengine_submit(desc);
 		}
 
-		if (!desc || s->cookie_rx[i] < 0) {
+		if (!desc || dma_submit_error(s->cookie_rx[i])) {
 			if (i) {
 				async_tx_ack(s->desc_rx[0]);
 				s->cookie_rx[0] = -EINVAL;
@@ -1476,8 +1476,8 @@ static void work_fn_rx(struct work_struct *work)
 		return;
 	}
 
-	s->cookie_rx[new] = desc->tx_submit(desc);
-	if (s->cookie_rx[new] < 0) {
+	s->cookie_rx[new] = dmaengine_submit(desc);
+	if (dma_submit_error(s->cookie_rx[new])) {
 		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 		sci_rx_dma_release(s, true);
 		return;
@@ -1530,8 +1530,8 @@ static void work_fn_tx(struct work_struct *work)
 	desc->callback = sci_dma_tx_complete;
 	desc->callback_param = s;
 	spin_unlock_irq(&port->lock);
-	s->cookie_tx = desc->tx_submit(desc);
-	if (s->cookie_tx < 0) {
+	s->cookie_tx = dmaengine_submit(desc);
+	if (dma_submit_error(s->cookie_tx)) {
 		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
 		/* switch to PIO */
 		sci_tx_dma_release(s, true);
@@ -1562,7 +1562,7 @@ static void sci_start_tx(struct uart_port *port)
 	}
 
 	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
-	    s->cookie_tx < 0) {
+	    dma_submit_error(s->cookie_tx)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
 	}
-- 
1.9.1

