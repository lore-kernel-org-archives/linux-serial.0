From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/7] serial: sh-sci: prepare for conversion to simple DMA
Date: Wed, 18 Jan 2012 11:22:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201181118550.28782@axis700.grange>
References: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/sh-sci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index aff9d61..2a8ffda 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1463,9 +1463,9 @@ static bool filter(struct dma_chan *chan, void *slave)
 	struct sh_dmae_slave *param = slave;
 
 	dev_dbg(chan->device->dev, "%s: slave ID %d\n", __func__,
-		param->slave_id);
+		param->simple_slave.slave_id);
 
-	chan->private = param;
+	chan->private = &param->simple_slave;
 	return true;
 }
 
@@ -1504,7 +1504,7 @@ static void sci_request_dma(struct uart_port *port)
 	param = &s->param_tx;
 
 	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_TX */
-	param->slave_id = s->cfg->dma_slave_tx;
+	param->simple_slave.slave_id = s->cfg->dma_slave_tx;
 
 	s->cookie_tx = -EINVAL;
 	chan = dma_request_channel(mask, filter, param);
@@ -1532,7 +1532,7 @@ static void sci_request_dma(struct uart_port *port)
 	param = &s->param_rx;
 
 	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_RX */
-	param->slave_id = s->cfg->dma_slave_rx;
+	param->simple_slave.slave_id = s->cfg->dma_slave_rx;
 
 	chan = dma_request_channel(mask, filter, param);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
-- 
1.7.2.5
