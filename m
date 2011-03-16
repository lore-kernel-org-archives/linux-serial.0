From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/76] serial: mfd: remove the timeout workaround for A0
Date: Wed, 16 Mar 2011 14:11:32 -0700
Message-ID: <1300309966-5745-2-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32781 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab1CPVMu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:12:50 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Feng Tang <feng.tang@intel.com>

This is kind of a revert for commit 669b7a0938e "hsu: add a periodic
timer to check dma rx channel", which is a workaround for a bug in A0
stepping silicon, where a dma rx data timeout is missing for some case.
Since new silicon has fixed it and the old version is phasing out, no
need to carry on it any more.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mfd.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index d40010a..7767774 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -51,8 +51,6 @@
 #define mfd_readl(obj, offset)		readl(obj->reg + offset)
 #define mfd_writel(obj, offset, val)	writel(val, obj->reg + offset)
 
-#define HSU_DMA_TIMEOUT_CHECK_FREQ	(HZ/10)
-
 struct hsu_dma_buffer {
 	u8		*buf;
 	dma_addr_t	dma_addr;
@@ -65,7 +63,6 @@ struct hsu_dma_chan {
 	enum dma_data_direction	dirt;
 	struct uart_hsu_port	*uport;
 	void __iomem		*reg;
-	struct timer_list	rx_timer; /* only needed by RX channel */
 };
 
 struct uart_hsu_port {
@@ -355,8 +352,6 @@ void hsu_dma_start_rx_chan(struct hsu_dma_chan *rxc, struct hsu_dma_buffer *dbuf
 					 | (0x1 << 24)	/* timeout bit, see HSU Errata 1 */
 					 );
 	chan_writel(rxc, HSU_CH_CR, 0x3);
-
-	mod_timer(&rxc->rx_timer, jiffies + HSU_DMA_TIMEOUT_CHECK_FREQ);
 }
 
 /* Protected by spin_lock_irqsave(port->lock) */
@@ -420,7 +415,6 @@ void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
 		chan_writel(chan, HSU_CH_CR, 0x3);
 		return;
 	}
-	del_timer(&chan->rx_timer);
 
 	dma_sync_single_for_cpu(port->dev, dbuf->dma_addr,
 			dbuf->dma_size, DMA_FROM_DEVICE);
@@ -448,8 +442,6 @@ void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
 	tty_flip_buffer_push(tty);
 
 	chan_writel(chan, HSU_CH_CR, 0x3);
-	chan->rx_timer.expires = jiffies + HSU_DMA_TIMEOUT_CHECK_FREQ;
-	add_timer(&chan->rx_timer);
 
 }
 
@@ -870,8 +862,6 @@ static void serial_hsu_shutdown(struct uart_port *port)
 		container_of(port, struct uart_hsu_port, port);
 	unsigned long flags;
 
-	del_timer_sync(&up->rxc->rx_timer);
-
 	/* Disable interrupts from this port */
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
@@ -1343,28 +1333,6 @@ err_disable:
 	return ret;
 }
 
-static void hsu_dma_rx_timeout(unsigned long data)
-{
-	struct hsu_dma_chan *chan = (void *)data;
-	struct uart_hsu_port *up = chan->uport;
-	struct hsu_dma_buffer *dbuf = &up->rxbuf;
-	int count = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);
-
-	count = chan_readl(chan, HSU_CH_D0SAR) - dbuf->dma_addr;
-
-	if (!count) {
-		mod_timer(&chan->rx_timer, jiffies + HSU_DMA_TIMEOUT_CHECK_FREQ);
-		goto exit;
-	}
-
-	hsu_dma_rx(up, 0);
-exit:
-	spin_unlock_irqrestore(&up->port.lock, flags);
-}
-
 static void hsu_global_init(void)
 {
 	struct hsu_port *hsu;
@@ -1427,12 +1395,6 @@ static void hsu_global_init(void)
 		dchan->reg = hsu->reg + HSU_DMA_CHANS_REG_OFFSET +
 				i * HSU_DMA_CHANS_REG_LENGTH;
 
-		/* Work around for RX */
-		if (dchan->dirt == DMA_FROM_DEVICE) {
-			init_timer(&dchan->rx_timer);
-			dchan->rx_timer.function = hsu_dma_rx_timeout;
-			dchan->rx_timer.data = (unsigned long)dchan;
-		}
 		dchan++;
 	}
 
-- 
1.7.4.1

