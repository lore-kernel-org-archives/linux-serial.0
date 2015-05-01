From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] serial: sh-sci: Add R-Car SCIF DMA receive support
Date: Sat,  2 May 2015 02:11:34 +0900
Message-ID: <1430500294-23407-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

This patch is the result of squashing two patches.
One, of the same name, by Koji Matsuoka. And a second small fix by 
Kazuya Mizuguchi. Accordingly I have included both authors signed-off-by
lines above.

 drivers/tty/serial/sh-sci.c | 142 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e7d6566..65cc72a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1,4 +1,8 @@
 /*
+ * drivers/tty/serial/sh-sci.c
+ *
+ *  Copyright (C) 2014 Renesas Electronics Corporation
+ *
  * SuperH on-chip serial module support.  (SCI with no FIFO / with FIFO)
  *
  *  Copyright (C) 2002 - 2011  Paul Mundt
@@ -103,13 +107,13 @@ struct sci_port {
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_async_tx_descriptor	*desc_tx;
-	struct dma_async_tx_descriptor	*desc_rx[2];
+	struct dma_async_tx_descriptor	*desc_rx[3];
 	dma_cookie_t			cookie_tx;
-	dma_cookie_t			cookie_rx[2];
+	dma_cookie_t			cookie_rx[3];
 	dma_cookie_t			active_rx;
 	struct scatterlist		sg_tx;
 	unsigned int			sg_len_tx;
-	struct scatterlist		sg_rx[2];
+	struct scatterlist		sg_rx[3];
 	size_t				buf_len_rx;
 	struct sh_dmae_slave		param_tx;
 	struct sh_dmae_slave		param_rx;
@@ -117,6 +121,8 @@ struct sci_port {
 	struct work_struct		work_rx;
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
+	int				rx_flag;
+	int				rx_release_flag;
 #endif
 
 	struct notifier_block		freq_transition;
@@ -1300,6 +1306,8 @@ static int sci_dma_rx_push(struct sci_port *s, size_t count)
 		active = 0;
 	} else if (s->active_rx == s->cookie_rx[1]) {
 		active = 1;
+	} else if (s->active_rx == s->cookie_rx[2]) {
+		active = 2;
 	} else {
 		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
 		return 0;
@@ -1332,7 +1340,14 @@ static void sci_dma_rx_complete(void *arg)
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	count = sci_dma_rx_push(s, s->buf_len_rx);
+	s->rx_flag = 1;
+
+	if ((port->type == PORT_SCIF || port->type == PORT_HSCIF) &&
+	    s->active_rx == s->cookie_rx[0]) {
+		count = sci_dma_rx_push(s, 1);
+		async_tx_ack(s->desc_rx[0]);
+	} else
+		count = sci_dma_rx_push(s, s->buf_len_rx);
 
 	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
 
@@ -1348,13 +1363,26 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
+	size_t buf_len_rx;
+	int t = 100000;
+
+	s->rx_release_flag = 1;
+	while (t--) {
+		if (!s->rx_flag)
+			break;
+		usleep_range(10, 50);
+	}
 
 	s->chan_rx = NULL;
-	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
+	s->cookie_rx[0] = s->cookie_rx[1] = s->cookie_rx[2] = -EINVAL;
+	if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
+		buf_len_rx = 1 + s->buf_len_rx * 2;
+	else
+		buf_len_rx = s->buf_len_rx * 2;
 	dma_release_channel(chan);
 	if (sg_dma_address(&s->sg_rx[0]))
-		dma_free_coherent(port->dev, s->buf_len_rx * 2,
-				  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
+		dma_free_coherent(port->dev, buf_len_rx, sg_virt(&s->sg_rx[0]),
+				  sg_dma_address(&s->sg_rx[0]));
 	if (enable_pio)
 		sci_start_rx(port);
 }
@@ -1374,9 +1402,15 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
 static void sci_submit_rx(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx;
+	struct uart_port *port = &s->port;
 	int i;
+	int j;
+	int nr_descs = 2;
 
-	for (i = 0; i < 2; i++) {
+	if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
+		nr_descs = 3;
+
+	for (i = 0; i < nr_descs; i++) {
 		struct scatterlist *sg = &s->sg_rx[i];
 		struct dma_async_tx_descriptor *desc;
 
@@ -1392,8 +1426,10 @@ static void sci_submit_rx(struct sci_port *s)
 
 		if (!desc || s->cookie_rx[i] < 0) {
 			if (i) {
-				async_tx_ack(s->desc_rx[0]);
-				s->cookie_rx[0] = -EINVAL;
+				for (j = 0; j < i; j++) {
+					async_tx_ack(s->desc_rx[j]);
+					s->cookie_rx[j] = -EINVAL;
+				}
 			}
 			if (desc) {
 				async_tx_ack(desc);
@@ -1406,11 +1442,13 @@ static void sci_submit_rx(struct sci_port *s)
 		}
 		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n",
 			__func__, s->cookie_rx[i], i);
-	}
 
-	s->active_rx = s->cookie_rx[0];
+		if (i == 0) {
+			s->active_rx = s->cookie_rx[0];
+			dma_async_issue_pending(chan);
+		}
+	}
 
-	dma_async_issue_pending(chan);
 }
 
 static void work_fn_rx(struct work_struct *work)
@@ -1419,11 +1457,19 @@ static void work_fn_rx(struct work_struct *work)
 	struct uart_port *port = &s->port;
 	struct dma_async_tx_descriptor *desc;
 	int new;
+	int next;
+
+	if (s->chan_rx == NULL) {
+		dev_dbg(port->dev, "%s: DMA channel is released.\n", __func__);
+		return;
+	}
 
 	if (s->active_rx == s->cookie_rx[0]) {
 		new = 0;
 	} else if (s->active_rx == s->cookie_rx[1]) {
 		new = 1;
+	} else if (s->active_rx == s->cookie_rx[2]) {
+		new = 2;
 	} else {
 		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
 		return;
@@ -1450,19 +1496,34 @@ static void work_fn_rx(struct work_struct *work)
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
 
-		sci_submit_rx(s);
+		if (!s->rx_release_flag)
+			sci_submit_rx(s);
+		s->rx_flag = 0;
 
 		return;
 	}
 
-	s->cookie_rx[new] = desc->tx_submit(desc);
-	if (s->cookie_rx[new] < 0) {
-		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
-		sci_rx_dma_release(s, true);
-		return;
+	if (port->type == PORT_SCIF || port->type == PORT_HSCIF) {
+		if (new != 0) {
+			s->cookie_rx[new] = desc->tx_submit(desc);
+			if (s->cookie_rx[new] < 0) {
+				dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
+				sci_rx_dma_release(s, true);
+				return;
+			}
+		}
+		next = new % 2 + 1;
+	} else {
+		s->cookie_rx[new] = desc->tx_submit(desc);
+		if (s->cookie_rx[new] < 0) {
+			dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
+			sci_rx_dma_release(s, true);
+			return;
+		}
+		next = !new;
 	}
 
-	s->active_rx = s->cookie_rx[!new];
+	s->active_rx = s->cookie_rx[next];
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
@@ -1666,6 +1727,8 @@ static void sci_request_dma(struct uart_port *port)
 	if (s->cfg->dma_slave_tx <= 0 || s->cfg->dma_slave_rx <= 0)
 		return;
 
+	s->rx_flag = 0;
+	s->rx_release_flag = 0;
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
@@ -1707,14 +1770,22 @@ static void sci_request_dma(struct uart_port *port)
 	chan = dma_request_channel(mask, filter, param);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
 	if (chan) {
-		dma_addr_t dma[2];
-		void *buf[2];
+		dma_addr_t dma[3];
+		void *buf[3];
+		size_t sum_buf_len;
+		int nr_sg = 2;
 		int i;
 
 		s->chan_rx = chan;
 
 		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
-		buf[0] = dma_alloc_coherent(port->dev, s->buf_len_rx * 2,
+		if (port->type == PORT_SCIF || port->type == PORT_HSCIF) {
+			nr_sg = 3;
+			sum_buf_len = 1 + s->buf_len_rx * 2;
+		} else {
+			sum_buf_len = s->buf_len_rx * 2;
+		}
+		buf[0] = dma_alloc_coherent(port->dev, sum_buf_len,
 					    &dma[0], GFP_KERNEL);
 
 		if (!buf[0]) {
@@ -1724,14 +1795,28 @@ static void sci_request_dma(struct uart_port *port)
 			return;
 		}
 
-		buf[1] = buf[0] + s->buf_len_rx;
-		dma[1] = dma[0] + s->buf_len_rx;
+		if (port->type == PORT_SCIF || port->type == PORT_HSCIF) {
+			buf[1] = buf[0] + 1;
+			dma[1] = dma[0] + 1;
+			buf[2] = buf[1] + s->buf_len_rx;
+			dma[2] = dma[1] + s->buf_len_rx;
+		} else {
+			buf[1] = buf[0] + s->buf_len_rx;
+			dma[1] = dma[0] + s->buf_len_rx;
+		}
 
-		for (i = 0; i < 2; i++) {
+		for (i = 0; i < nr_sg; i++) {
 			struct scatterlist *sg = &s->sg_rx[i];
+			unsigned int len;
+
+			if ((port->type == PORT_SCIF ||
+			     port->type == PORT_HSCIF) && i == 0)
+				len = 1;
+			else
+				len = s->buf_len_rx;
 
 			sg_init_table(sg, 1);
-			sg_set_page(sg, virt_to_page(buf[i]), s->buf_len_rx,
+			sg_set_page(sg, virt_to_page(buf[i]), len,
 				    (uintptr_t)buf[i] & ~PAGE_MASK);
 			sg_dma_address(sg) = dma[i];
 		}
@@ -1778,7 +1863,6 @@ static int sci_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 	sci_start_tx(port);
-	sci_start_rx(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 0;
@@ -1796,6 +1880,8 @@ static void sci_shutdown(struct uart_port *port)
 	sci_stop_tx(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 
+	serial_port_out(port, SCSCR, 0x00);
+
 	sci_free_dma(port);
 	sci_free_irq(s);
 }
-- 
1.9.1

