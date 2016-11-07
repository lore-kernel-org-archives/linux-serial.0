From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC] serial: sh-sci: Fix deadlock caused by serial output request
Date: Mon,  7 Nov 2016 16:14:41 +0100
Message-ID: <1478531681-1561-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>

While spin is already locked, serial output request causes the deadlock,
because serial output process also tries to lock the spin.
This patch removes serial output with spin locked.

Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
This is a patch from the Gen3 3.3.2 BSP.
Geert, please consider it for mainline.

Two approaches are mixed here: simply removing log messages that would
cause a deadlock; and moving log messages to outside the lock. Some
consideration was given (by Simon) to a more consistent approach of
simply removing all log messages in question. However this was taken as
logging ouside of the lock seems consistent with other logging in
rx_timer_fn() and sci_dma_rx_complete().
---
 drivers/tty/serial/sh-sci.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4b26252c2885..91e7dddbf72c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1142,11 +1142,8 @@ static int sci_dma_rx_push(struct sci_port *s, void *buf, size_t count)
 	int copied;
 
 	copied = tty_insert_flip_string(tport, buf, count);
-	if (copied < count) {
-		dev_warn(port->dev, "Rx overrun: dropping %zu bytes\n",
-			 count - copied);
+	if (copied < count)
 		port->icount.buf_overrun++;
-	}
 
 	port->icount.rx += copied;
 
@@ -1161,8 +1158,6 @@ static int sci_dma_rx_find_active(struct sci_port *s)
 		if (s->active_rx == s->cookie_rx[i])
 			return i;
 
-	dev_err(s->port.dev, "%s: Rx cookie %d not found!\n", __func__,
-		s->active_rx);
 	return -1;
 }
 
@@ -1223,9 +1218,9 @@ static void sci_dma_rx_complete(void *arg)
 
 	dma_async_issue_pending(chan);
 
+	spin_unlock_irqrestore(&port->lock, flags);
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[active], active, s->active_rx);
-	spin_unlock_irqrestore(&port->lock, flags);
 	return;
 
 fail:
@@ -1273,8 +1268,6 @@ static void sci_submit_rx(struct sci_port *s)
 		if (dma_submit_error(s->cookie_rx[i]))
 			goto fail;
 
-		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n", __func__,
-			s->cookie_rx[i], i);
 	}
 
 	s->active_rx = s->cookie_rx[0];
@@ -1288,7 +1281,6 @@ static void sci_submit_rx(struct sci_port *s)
 	for (i = 0; i < 2; i++)
 		s->cookie_rx[i] = -EINVAL;
 	s->active_rx = -EINVAL;
-	dev_warn(s->port.dev, "Failed to re-start Rx DMA, using PIO\n");
 	sci_rx_dma_release(s, true);
 }
 
@@ -1358,10 +1350,10 @@ static void rx_timer_fn(unsigned long arg)
 	int active, count;
 	u16 scr;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	dev_dbg(port->dev, "DMA Rx timed out\n");
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	active = sci_dma_rx_find_active(s);
 	if (active < 0) {
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -1370,9 +1362,9 @@ static void rx_timer_fn(unsigned long arg)
 
 	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
 	if (status == DMA_COMPLETE) {
+		spin_unlock_irqrestore(&port->lock, flags);
 		dev_dbg(port->dev, "Cookie %d #%d has already completed\n",
 			s->active_rx, active);
-		spin_unlock_irqrestore(&port->lock, flags);
 
 		/* Let packet complete handler take care of the packet */
 		return;
@@ -1396,8 +1388,6 @@ static void rx_timer_fn(unsigned long arg)
 	/* Handle incomplete DMA receive */
 	dmaengine_terminate_all(s->chan_rx);
 	read = sg_dma_len(&s->sg_rx[active]) - state.residue;
-	dev_dbg(port->dev, "Read %u bytes with cookie %d\n", read,
-		s->active_rx);
 
 	if (read) {
 		count = sci_dma_rx_push(s, s->rx_buf[active], read);
-- 
2.7.0.rc3.207.g0ac5344
