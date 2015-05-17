From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH v2] serial: sh-sci: Remove schedule_work in sci_dma_rx_complete
Date: Mon, 18 May 2015 00:50:30 +0900
Message-ID: <1431877830-4877-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

This patch calls work_fn_rx() directly so that the driver can avoid
executing of next sci_dma_rx_complete() before work_fn_rx() completes.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

v2 [Yoshihiro Kaneko]
* Move work_fn_rx() up and remove a function prototype accorded

 drivers/tty/serial/sh-sci.c | 225 ++++++++++++++++++++++----------------------
 1 file changed, 113 insertions(+), 112 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e7d6566..5b216ea 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1251,6 +1251,118 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
+static void work_fn_rx(struct work_struct *work)
+{
+	struct sci_port *s = container_of(work, struct sci_port, work_rx);
+	struct uart_port *port = &s->port;
+	struct dma_async_tx_descriptor *desc;
+	int new;
+
+	if (s->active_rx == s->cookie_rx[0]) {
+		new = 0;
+	} else if (s->active_rx == s->cookie_rx[1]) {
+		new = 1;
+	} else {
+		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
+		return;
+	}
+	desc = s->desc_rx[new];
+
+	if (dma_async_is_tx_complete(s->chan_rx, s->active_rx, NULL, NULL) !=
+	    DMA_COMPLETE) {
+		/* Handle incomplete DMA receive */
+		struct dma_chan *chan = s->chan_rx;
+		struct shdma_desc *sh_desc = container_of(desc,
+					struct shdma_desc, async_tx);
+		unsigned long flags;
+		int count;
+
+		dmaengine_terminate_all(chan);
+		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n",
+			sh_desc->partial, sh_desc->cookie);
+
+		spin_lock_irqsave(&port->lock, flags);
+		count = sci_dma_rx_push(s, sh_desc->partial);
+		spin_unlock_irqrestore(&port->lock, flags);
+
+		if (count)
+			tty_flip_buffer_push(&port->state->port);
+
+		sci_submit_rx(s);
+
+		return;
+	}
+
+	s->cookie_rx[new] = desc->tx_submit(desc);
+	if (s->cookie_rx[new] < 0) {
+		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
+		sci_rx_dma_release(s, true);
+		return;
+	}
+
+	s->active_rx = s->cookie_rx[!new];
+
+	dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n",
+		__func__, s->cookie_rx[new], new, s->active_rx);
+}
+
+static void work_fn_tx(struct work_struct *work)
+{
+	struct sci_port *s = container_of(work, struct sci_port, work_tx);
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *chan = s->chan_tx;
+	struct uart_port *port = &s->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	struct scatterlist *sg = &s->sg_tx;
+
+	/*
+	 * DMA is idle now.
+	 * Port xmit buffer is already mapped, and it is one page... Just adjust
+	 * offsets and lengths. Since it is a circular buffer, we have to
+	 * transmit till the end, and then the rest. Take the port lock to get a
+	 * consistent xmit buffer state.
+	 */
+	spin_lock_irq(&port->lock);
+	sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
+	sg_dma_address(sg) = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
+		sg->offset;
+	sg_dma_len(sg) = min_t(int, CIRC_CNT(xmit->head, xmit->tail,
+		UART_XMIT_SIZE), CIRC_CNT_TO_END(xmit->head, xmit->tail,
+		UART_XMIT_SIZE));
+	spin_unlock_irq(&port->lock);
+
+	BUG_ON(!sg_dma_len(sg));
+
+	desc = dmaengine_prep_slave_sg(chan,
+			sg, s->sg_len_tx, DMA_MEM_TO_DEV,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		/* switch to PIO */
+		sci_tx_dma_release(s, true);
+		return;
+	}
+
+	dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
+
+	spin_lock_irq(&port->lock);
+	s->desc_tx = desc;
+	desc->callback = sci_dma_tx_complete;
+	desc->callback_param = s;
+	spin_unlock_irq(&port->lock);
+	s->cookie_tx = desc->tx_submit(desc);
+	if (s->cookie_tx < 0) {
+		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
+		/* switch to PIO */
+		sci_tx_dma_release(s, true);
+		return;
+	}
+
+	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
+		__func__, xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
+
+	dma_async_issue_pending(chan);
+}
+
 static void sci_dma_tx_complete(void *arg)
 {
 	struct sci_port *s = arg;
@@ -1341,7 +1453,7 @@ static void sci_dma_rx_complete(void *arg)
 	if (count)
 		tty_flip_buffer_push(&port->state->port);
 
-	schedule_work(&s->work_rx);
+	work_fn_rx(&s->work_rx);
 }
 
 static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
@@ -1412,117 +1524,6 @@ static void sci_submit_rx(struct sci_port *s)
 
 	dma_async_issue_pending(chan);
 }
-
-static void work_fn_rx(struct work_struct *work)
-{
-	struct sci_port *s = container_of(work, struct sci_port, work_rx);
-	struct uart_port *port = &s->port;
-	struct dma_async_tx_descriptor *desc;
-	int new;
-
-	if (s->active_rx == s->cookie_rx[0]) {
-		new = 0;
-	} else if (s->active_rx == s->cookie_rx[1]) {
-		new = 1;
-	} else {
-		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
-		return;
-	}
-	desc = s->desc_rx[new];
-
-	if (dma_async_is_tx_complete(s->chan_rx, s->active_rx, NULL, NULL) !=
-	    DMA_COMPLETE) {
-		/* Handle incomplete DMA receive */
-		struct dma_chan *chan = s->chan_rx;
-		struct shdma_desc *sh_desc = container_of(desc,
-					struct shdma_desc, async_tx);
-		unsigned long flags;
-		int count;
-
-		dmaengine_terminate_all(chan);
-		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n",
-			sh_desc->partial, sh_desc->cookie);
-
-		spin_lock_irqsave(&port->lock, flags);
-		count = sci_dma_rx_push(s, sh_desc->partial);
-		spin_unlock_irqrestore(&port->lock, flags);
-
-		if (count)
-			tty_flip_buffer_push(&port->state->port);
-
-		sci_submit_rx(s);
-
-		return;
-	}
-
-	s->cookie_rx[new] = desc->tx_submit(desc);
-	if (s->cookie_rx[new] < 0) {
-		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
-		sci_rx_dma_release(s, true);
-		return;
-	}
-
-	s->active_rx = s->cookie_rx[!new];
-
-	dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n",
-		__func__, s->cookie_rx[new], new, s->active_rx);
-}
-
-static void work_fn_tx(struct work_struct *work)
-{
-	struct sci_port *s = container_of(work, struct sci_port, work_tx);
-	struct dma_async_tx_descriptor *desc;
-	struct dma_chan *chan = s->chan_tx;
-	struct uart_port *port = &s->port;
-	struct circ_buf *xmit = &port->state->xmit;
-	struct scatterlist *sg = &s->sg_tx;
-
-	/*
-	 * DMA is idle now.
-	 * Port xmit buffer is already mapped, and it is one page... Just adjust
-	 * offsets and lengths. Since it is a circular buffer, we have to
-	 * transmit till the end, and then the rest. Take the port lock to get a
-	 * consistent xmit buffer state.
-	 */
-	spin_lock_irq(&port->lock);
-	sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
-	sg_dma_address(sg) = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
-		sg->offset;
-	sg_dma_len(sg) = min((int)CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
-		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
-	spin_unlock_irq(&port->lock);
-
-	BUG_ON(!sg_dma_len(sg));
-
-	desc = dmaengine_prep_slave_sg(chan,
-			sg, s->sg_len_tx, DMA_MEM_TO_DEV,
-			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc) {
-		/* switch to PIO */
-		sci_tx_dma_release(s, true);
-		return;
-	}
-
-	dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
-
-	spin_lock_irq(&port->lock);
-	s->desc_tx = desc;
-	desc->callback = sci_dma_tx_complete;
-	desc->callback_param = s;
-	spin_unlock_irq(&port->lock);
-	s->cookie_tx = desc->tx_submit(desc);
-	if (s->cookie_tx < 0) {
-		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
-		/* switch to PIO */
-		sci_tx_dma_release(s, true);
-		return;
-	}
-
-	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
-		__func__, xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
-
-	dma_async_issue_pending(chan);
-}
 #endif
 
 static void sci_start_tx(struct uart_port *port)
-- 
1.9.1

