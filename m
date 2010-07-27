From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/4] hsu: add a periodic timer to check dma rx channel
Date: Tue, 27 Jul 2010 08:20:32 +0100
Message-ID: <20100727072030.26058.40032.stgit@localhost.localdomain>
References: <20100727071936.26058.23502.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61313 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab0G0Hx5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jul 2010 03:53:57 -0400
In-Reply-To: <20100727071936.26058.23502.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

A general problem for uart rx dma channel is you never know when
and how much data will be received, so usually preset it a DMA
descriptor with a big size, and rely on DMA RX timeout IRQ to
know there is some data in rx channel.

For a RX data size of multiple of MOTSR, there will be no timeout
IRQ issued, thus OS will never be notified about that.

This is a work around for that, current timer frequency is 5 times
per second, it should vary according to the baud rate

When future silicon version fix the problem, this workaround need
be removed

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/mfd.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 47 insertions(+), 3 deletions(-)


diff --git a/drivers/serial/mfd.c b/drivers/serial/mfd.c
index 3d41d33..83ea831 100644
--- a/drivers/serial/mfd.c
+++ b/drivers/serial/mfd.c
@@ -64,6 +64,8 @@
 #define mfd_readl(obj, offset)		readl(obj->reg + offset)
 #define mfd_writel(obj, offset, val)	writel(val, obj->reg + offset)
 
+#define HSU_DMA_TIMEOUT_CHECK_FREQ	(HZ/10)
+
 struct hsu_dma_buffer {
 	u8		*buf;
 	dma_addr_t	dma_addr;
@@ -75,7 +77,8 @@ struct hsu_dma_chan {
 	u32	id;
 	u32	dirt;	/* to or from device */
 	struct uart_hsu_port	*uport;
-	void __iomem	*reg;
+	void __iomem		*reg;
+	struct timer_list	rx_timer; /* only needed by RX channel */
 };
 
 struct uart_hsu_port {
@@ -377,6 +380,8 @@ void hsu_dma_start_rx_chan(struct hsu_dma_chan *rxc, struct hsu_dma_buffer *dbuf
 					 | (0x1 << 24)	/* timeout bit, see HSU Errata 1 */
 					 );
 	chan_writel(rxc, HSU_CH_CR, 0x3);
+
+	mod_timer(&rxc->rx_timer, jiffies + HSU_DMA_TIMEOUT_CHECK_FREQ);
 }
 
 /* Protected by spin_lock_irqsave(port->lock) */
@@ -437,8 +442,13 @@ void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
 	/* We can use 2 ways to calc the actual transfer len */
 	count = chan_readl(chan, HSU_CH_D0SAR) - dbuf->dma_addr;
 
-	if (!count)
+	if (!count) {
+		/* restart the channel before we leave */
+		chan_writel(chan, HSU_CH_CR, 0x3);
 		return;
+	}
+
+	del_timer(&chan->rx_timer);
 
 	dma_sync_single_for_cpu(port->dev, dbuf->dma_addr,
 			dbuf->dma_size, DMA_FROM_DEVICE);
@@ -463,9 +473,12 @@ void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
 					 | (0x1 << 16)
 					 | (0x1 << 24)	/* timeout bit, see HSU Errata 1 */
 					 );
+	tty_flip_buffer_push(tty);
+
 	chan_writel(chan, HSU_CH_CR, 0x3);
+	chan->rx_timer.expires = jiffies + HSU_DMA_TIMEOUT_CHECK_FREQ;
+	add_timer(&chan->rx_timer);
 
-	tty_flip_buffer_push(tty);
 }
 
 static void serial_hsu_stop_rx(struct uart_port *port)
@@ -893,6 +906,8 @@ static void serial_hsu_shutdown(struct uart_port *port)
 		container_of(port, struct uart_hsu_port, port);
 	unsigned long flags;
 
+	del_timer_sync(&up->rxc->rx_timer);
+
 	/* Disable interrupts from this port */
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
@@ -1348,6 +1363,28 @@ err_disable:
 	return ret;
 }
 
+static void hsu_dma_rx_timeout(unsigned long data)
+{
+	struct hsu_dma_chan *chan = (void *)data;
+	struct uart_hsu_port *up = chan->uport;
+	struct hsu_dma_buffer *dbuf = &up->rxbuf;
+	int count = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	count = chan_readl(chan, HSU_CH_D0SAR) - dbuf->dma_addr;
+
+	if (!count) {
+		mod_timer(&chan->rx_timer, jiffies + HSU_DMA_TIMEOUT_CHECK_FREQ);
+		goto exit;
+	}
+
+	hsu_dma_rx(up, 0);
+exit:
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
 static void hsu_global_init(void)
 {
 	struct hsu_port *hsu;
@@ -1409,6 +1446,13 @@ static void hsu_global_init(void)
 		dchan->uport = &hsu->port[i/2];
 		dchan->reg = hsu->reg + HSU_DMA_CHANS_REG_OFFSET +
 				i * HSU_DMA_CHANS_REG_LENGTH;
+
+		/* Work around for RX */
+		if (dchan->dirt == DMA_FROM_DEVICE) {
+			init_timer(&dchan->rx_timer);
+			dchan->rx_timer.function = hsu_dma_rx_timeout;
+			dchan->rx_timer.data = (unsigned long)dchan;
+		}
 		dchan++;
 	}
 

