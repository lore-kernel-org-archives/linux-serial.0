From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v3 4/4] serial: sh-sci: Add DT support to DMA setup
Date: Fri, 21 Aug 2015 20:25:46 +0200
Message-ID: <1440181546-7334-5-git-send-email-geert+renesas@glider.be>
References: <1440181546-7334-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440181546-7334-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add support for obtaining DMA channel information from the device tree.

This requires switching from the legacy sh_dmae_slave structures with
hardcoded channel numbers and the corresponding filter function to:
  1. dma_request_slave_channel_compat(),
       - On legacy platforms, dma_request_slave_channel_compat() uses
	 the passed DMA channel numbers that originate from platform
	 device data,
       - On DT-based platforms, dma_request_slave_channel_compat() will
	 retrieve the information from DT.
  2. and the generic dmaengine_slave_config() configuration method,
     which requires filling in DMA register ports and slave bus widths.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - Moved to end of series, to avoid enabling broken DMA,

v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 78 +++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b18e2e64f163ca48..c8a99be4d0175b23 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -112,8 +112,6 @@ struct sci_port {
 	struct scatterlist		sg_rx[2];
 	void				*rx_buf[2];
 	size_t				buf_len_rx;
-	struct sh_dmae_slave		param_tx;
-	struct sh_dmae_slave		param_rx;
 	struct work_struct		work_tx;
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
@@ -1618,17 +1616,6 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-static bool filter(struct dma_chan *chan, void *slave)
-{
-	struct sh_dmae_slave *param = slave;
-
-	dev_dbg(chan->device->dev, "%s: slave ID %d\n",
-		__func__, param->shdma_slave.slave_id);
-
-	chan->private = &param->shdma_slave;
-	return true;
-}
-
 static void rx_timer_fn(unsigned long arg)
 {
 	struct sci_port *s = (struct sci_port *)arg;
@@ -1679,28 +1666,62 @@ static void rx_timer_fn(unsigned long arg)
 		sci_submit_rx(s);
 }
 
+static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
+					     enum dma_transfer_direction dir,
+					     unsigned int id)
+{
+	dma_cap_mask_t mask;
+	struct dma_chan *chan;
+	struct dma_slave_config cfg;
+	int ret;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+					(void *)(unsigned long)id, port->dev,
+					dir == DMA_MEM_TO_DEV ? "tx" : "rx");
+	if (!chan) {
+		dev_warn(port->dev,
+			 "dma_request_slave_channel_compat failed\n");
+		return NULL;
+	}
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.direction = dir;
+	if (dir == DMA_MEM_TO_DEV) {
+		cfg.dst_addr = port->mapbase +
+			(sci_getreg(port, SCxTDR)->offset << port->regshift);
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	} else {
+		cfg.src_addr = port->mapbase +
+			(sci_getreg(port, SCxRDR)->offset << port->regshift);
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret) {
+		dev_warn(port->dev, "dmaengine_slave_config failed %d\n", ret);
+		dma_release_channel(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
 static void sci_request_dma(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
-	struct sh_dmae_slave *param;
 	struct dma_chan *chan;
-	dma_cap_mask_t mask;
 
 	dev_dbg(port->dev, "%s: port %d\n", __func__, port->line);
 
-	if (s->cfg->dma_slave_tx <= 0 || s->cfg->dma_slave_rx <= 0)
+	if (!port->dev->of_node &&
+	    (s->cfg->dma_slave_tx <= 0 || s->cfg->dma_slave_rx <= 0))
 		return;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	param = &s->param_tx;
-
-	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_TX */
-	param->shdma_slave.slave_id = s->cfg->dma_slave_tx;
-
 	s->cookie_tx = -EINVAL;
-	chan = dma_request_channel(mask, filter, param);
+	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV, s->cfg->dma_slave_tx);
 	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
 	if (chan) {
 		s->chan_tx = chan;
@@ -1722,12 +1743,7 @@ static void sci_request_dma(struct uart_port *port)
 		INIT_WORK(&s->work_tx, work_fn_tx);
 	}
 
-	param = &s->param_rx;
-
-	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_RX */
-	param->shdma_slave.slave_id = s->cfg->dma_slave_rx;
-
-	chan = dma_request_channel(mask, filter, param);
+	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM, s->cfg->dma_slave_rx);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
 	if (chan) {
 		unsigned int i;
-- 
1.9.1

