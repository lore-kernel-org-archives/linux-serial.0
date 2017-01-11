From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 15/18] serial: sh-sci: Remove the platform data dma slave rx/tx channel IDs
Date: Wed, 11 Jan 2017 16:43:37 +0200
Message-ID: <20170111144340.29074-16-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Only SH platforms still use platform data for the sh-sci, and none of
them declare DMA channels connected to the SCI. Remove the corresponding
platform data fields and simplify the driver accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 23 ++++++-----------------
 include/linux/serial_sci.h  |  3 ---
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3bbb7b4b2f19..fcedb96fe324 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1387,20 +1387,14 @@ static void rx_timer_fn(unsigned long arg)
 }
 
 static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
-					     enum dma_transfer_direction dir,
-					     unsigned int id)
+					     enum dma_transfer_direction dir)
 {
-	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 	struct dma_slave_config cfg;
 	int ret;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-					(void *)(unsigned long)id, port->dev,
-					dir == DMA_MEM_TO_DEV ? "tx" : "rx");
+	chan = dma_request_slave_channel(port->dev,
+					 dir == DMA_MEM_TO_DEV ? "tx" : "rx");
 	if (!chan) {
 		dev_warn(port->dev,
 			 "dma_request_slave_channel_compat failed\n");
@@ -1436,12 +1430,11 @@ static void sci_request_dma(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s: port %d\n", __func__, port->line);
 
-	if (!port->dev->of_node &&
-	    (s->cfg->dma_slave_tx <= 0 || s->cfg->dma_slave_rx <= 0))
+	if (!port->dev->of_node)
 		return;
 
 	s->cookie_tx = -EINVAL;
-	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV, s->cfg->dma_slave_tx);
+	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV);
 	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
 	if (chan) {
 		s->chan_tx = chan;
@@ -1463,7 +1456,7 @@ static void sci_request_dma(struct uart_port *port)
 		INIT_WORK(&s->work_tx, work_fn_tx);
 	}
 
-	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM, s->cfg->dma_slave_rx);
+	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
 	if (chan) {
 		unsigned int i;
@@ -2704,10 +2697,6 @@ static int sci_init_single(struct platform_device *dev,
 	port->serial_in		= sci_serial_in;
 	port->serial_out	= sci_serial_out;
 
-	if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0)
-		dev_dbg(port->dev, "DMA tx %d, rx %d\n",
-			p->dma_slave_tx, p->dma_slave_rx);
-
 	return 0;
 }
 
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 9f2bfd055742..1a894c47bfc0 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -71,9 +71,6 @@ struct plat_sci_port {
 	unsigned char	regtype;
 
 	struct plat_sci_port_ops	*ops;
-
-	unsigned int	dma_slave_tx;
-	unsigned int	dma_slave_rx;
 };
 
 #endif /* __LINUX_SERIAL_SCI_H */
-- 
Regards,

Laurent Pinchart

