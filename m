From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 25/33] serial: sh-sci: Fix exclusion of work_fn_rx and sci_dma_rx_complete
Date: Fri, 21 Aug 2015 20:02:49 +0200
Message-ID: <1440180177-6924-26-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

There is a problem when the sci_dma_rx_complete() is processed
before cancel process of work_fn_rx() completes by rx_timer_fn().
This patch locks work_fn_rx().

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Rebased,

v2:
  - Assimilated into my series.
---
 drivers/tty/serial/sh-sci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e318f002da399e70..f6ed203dde41bf83 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1433,8 +1433,10 @@ static void work_fn_rx(struct work_struct *work)
 	struct dma_async_tx_descriptor *desc;
 	struct dma_tx_state state;
 	enum dma_status status;
+	unsigned long flags;
 	int new;
 
+	spin_lock_irqsave(&port->lock, flags);
 	if (s->active_rx == s->cookie_rx[0]) {
 		new = 0;
 	} else if (s->active_rx == s->cookie_rx[1]) {
@@ -1442,14 +1444,13 @@ static void work_fn_rx(struct work_struct *work)
 	} else {
 		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
 			s->active_rx);
-		return;
+		goto out;
 	}
 
 	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
 	if (status != DMA_COMPLETE) {
 		/* Handle incomplete DMA receive */
 		struct dma_chan *chan = s->chan_rx;
-		unsigned long flags;
 		unsigned int read;
 		int count;
 
@@ -1458,16 +1459,14 @@ static void work_fn_rx(struct work_struct *work)
 		dev_dbg(port->dev, "Read %u bytes with cookie %d\n", read,
 			s->active_rx);
 
-		spin_lock_irqsave(&port->lock, flags);
 		count = sci_dma_rx_push(s, read);
-		spin_unlock_irqrestore(&port->lock, flags);
 
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
 
 		sci_submit_rx(s);
 
-		return;
+		goto out;
 	}
 
 	desc = dmaengine_prep_slave_sg(s->chan_rx, &s->sg_rx[new], 1,
@@ -1486,11 +1485,14 @@ static void work_fn_rx(struct work_struct *work)
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
+out:
+	spin_unlock_irqrestore(&port->lock, flags);
 	return;
 
 fail:
 	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 	sci_rx_dma_release(s, true);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void work_fn_tx(struct work_struct *work)
-- 
1.9.1

