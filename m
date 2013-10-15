From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH] serail: imx: optimization: remove the workqueues for DMA
Date: Tue, 15 Oct 2013 15:23:40 +0800
Message-ID: <1381821820-3845-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:12928
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750965Ab3JOHjY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 03:39:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

I worried that the delay of the sdma_run_channel0() maybe too long for
interrupt context, so I added the workqueues for RX/TX DMA.

But tested with bluetooth device, I find that the delay of sdma_run_channel0()
is about 8us (tested in imx6dl sabreauto board). I think the delay
is acceptable.

This patch removes the RX/TX workqueues for DMA, it makes the
code more clear.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
this patch depends on the patch set:
http://marc.info/?l=linux-arm-kernel&m=138148839513375&w=2

---
 drivers/tty/serial/imx.c |   54 ++++++++-------------------------------------
 1 files changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 13c2c2d..bb84f8d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -223,8 +223,7 @@ struct imx_port {
 	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	void			*rx_buf;
-	unsigned int		rx_bytes, tx_bytes;
-	struct work_struct	tsk_dma_rx, tsk_dma_tx;
+	unsigned int		tx_bytes;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
 };
@@ -505,32 +504,23 @@ static void dma_tx_callback(void *data)
 		dev_dbg(sport->port.dev, "exit in %s.\n", __func__);
 		return;
 	}
-
-	schedule_work(&sport->tsk_dma_tx);
 }
 
-static void dma_tx_work(struct work_struct *w)
+static void imx_dma_tx(struct imx_port *sport)
 {
-	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_tx);
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	struct scatterlist *sgl = sport->tx_sgl;
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan	*chan = sport->dma_chan_tx;
 	struct device *dev = sport->port.dev;
 	enum dma_status status;
-	unsigned long flags;
 	int ret;
 
 	status = dmaengine_tx_status(chan, (dma_cookie_t)0, NULL);
 	if (DMA_IN_PROGRESS == status)
 		return;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
 	sport->tx_bytes = uart_circ_chars_pending(xmit);
-	if (sport->tx_bytes == 0) {
-		spin_unlock_irqrestore(&sport->port.lock, flags);
-		return;
-	}
 
 	if (xmit->tail > xmit->head && xmit->head > 0) {
 		sport->dma_tx_nents = 2;
@@ -542,7 +532,6 @@ static void dma_tx_work(struct work_struct *w)
 		sport->dma_tx_nents = 1;
 		sg_init_one(sgl, xmit->buf + xmit->tail, sport->tx_bytes);
 	}
-	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
 	if (ret == 0) {
@@ -609,11 +598,7 @@ static void imx_start_tx(struct uart_port *port)
 	}
 
 	if (sport->dma_is_enabled) {
-		/*
-		 * We may in the interrupt context, so arise a work_struct to
-		 * do the real job.
-		 */
-		schedule_work(&sport->tsk_dma_tx);
+		imx_dma_tx(sport);
 		return;
 	}
 
@@ -732,6 +717,7 @@ out:
 	return IRQ_HANDLED;
 }
 
+static int start_rx_dma(struct imx_port *sport);
 /*
  * If the RXFIFO is filled with some data, and then we
  * arise a DMA operation to receive them.
@@ -750,7 +736,7 @@ static void imx_dma_rxint(struct imx_port *sport)
 		writel(temp, sport->port.membase + UCR1);
 
 		/* tell the DMA to receive the data. */
-		schedule_work(&sport->tsk_dma_rx);
+		start_rx_dma(sport);
 	}
 }
 
@@ -872,22 +858,6 @@ static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
 }
 
 #define RX_BUF_SIZE	(PAGE_SIZE)
-static int start_rx_dma(struct imx_port *sport);
-static void dma_rx_work(struct work_struct *w)
-{
-	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_rx);
-	struct tty_port *port = &sport->port.state->port;
-
-	if (sport->rx_bytes) {
-		tty_insert_flip_string(port, sport->rx_buf, sport->rx_bytes);
-		tty_flip_buffer_push(port);
-		sport->rx_bytes = 0;
-	}
-
-	if (sport->dma_is_rxing)
-		start_rx_dma(sport);
-}
-
 static void imx_rx_dma_done(struct imx_port *sport)
 {
 	unsigned long temp;
@@ -919,6 +889,7 @@ static void dma_rx_callback(void *data)
 	struct imx_port *sport = data;
 	struct dma_chan	*chan = sport->dma_chan_rx;
 	struct scatterlist *sgl = &sport->rx_sgl;
+	struct tty_port *port = &sport->port.state->port;
 	struct dma_tx_state state;
 	enum dma_status status;
 	unsigned int count;
@@ -931,8 +902,10 @@ static void dma_rx_callback(void *data)
 	dev_dbg(sport->port.dev, "We get %d bytes.\n", count);
 
 	if (count) {
-		sport->rx_bytes = count;
-		schedule_work(&sport->tsk_dma_rx);
+		tty_insert_flip_string(port, sport->rx_buf, count);
+		tty_flip_buffer_push(port);
+
+		start_rx_dma(sport);
 	} else
 		imx_rx_dma_done(sport);
 }
@@ -1014,7 +987,6 @@ static int imx_uart_dma_init(struct imx_port *sport)
 		ret = -ENOMEM;
 		goto err;
 	}
-	sport->rx_bytes = 0;
 
 	/* Prepare for TX : */
 	sport->dma_chan_tx = dma_request_slave_channel(dev, "tx");
@@ -1045,11 +1017,7 @@ err:
 static void imx_enable_dma(struct imx_port *sport)
 {
 	unsigned long temp;
-	struct tty_port *port = &sport->port.state->port;
 
-	port->low_latency = 1;
-	INIT_WORK(&sport->tsk_dma_tx, dma_tx_work);
-	INIT_WORK(&sport->tsk_dma_rx, dma_rx_work);
 	init_waitqueue_head(&sport->dma_wait);
 
 	/* set UCR1 */
@@ -1070,7 +1038,6 @@ static void imx_enable_dma(struct imx_port *sport)
 static void imx_disable_dma(struct imx_port *sport)
 {
 	unsigned long temp;
-	struct tty_port *port = &sport->port.state->port;
 
 	/* clear UCR1 */
 	temp = readl(sport->port.membase + UCR1);
@@ -1088,7 +1055,6 @@ static void imx_disable_dma(struct imx_port *sport)
 	writel(temp, sport->port.membase + UCR4);
 
 	sport->dma_is_enabled = 0;
-	port->low_latency = 0;
 }
 
 /* half the RX buffer size */
-- 
1.7.2.rc3


