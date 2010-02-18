From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] sh: extend .device_terminate_all() to record partial
 transfer
Date: Thu, 18 Feb 2010 17:30:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002181722070.4373@axis700.grange>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757631Ab0BRQ3x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Feb 2010 11:29:53 -0500
In-Reply-To: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org

This patch extends the .device_terminate_all() method of the shdma driver 
to return number of bytes transfered in the current descriptor.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/dmaengine.h
index 9586e4a..bf2f30c 100644
--- a/arch/sh/include/asm/dmaengine.h
+++ b/arch/sh/include/asm/dmaengine.h
@@ -10,6 +10,9 @@
 #ifndef ASM_DMAENGINE_H
 #define ASM_DMAENGINE_H
 
+#include <linux/dmaengine.h>
+#include <linux/list.h>
+
 #include <asm/dma-register.h>
 
 #define SH_DMAC_MAX_CHANNELS	6
@@ -70,4 +73,21 @@ struct sh_dmae_slave {
 	struct sh_dmae_slave_config	*config;  /* Set by the driver */
 };
 
+struct sh_dmae_regs {
+	u32 sar; /* SAR / source address */
+	u32 dar; /* DAR / destination address */
+	u32 tcr; /* TCR / transfer count */
+};
+
+struct sh_desc {
+	struct sh_dmae_regs hw;
+	struct list_head node;
+	struct dma_async_tx_descriptor async_tx;
+	enum dma_data_direction direction;
+	dma_cookie_t cookie;
+	size_t partial;
+	int chunks;
+	int mark;
+};
+
 #endif
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index ea6779f..5d17e09 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -587,6 +587,19 @@ static void sh_dmae_terminate_all(struct dma_chan *chan)
 	if (!chan)
 		return;
 
+	dmae_halt(sh_chan);
+
+	spin_lock_bh(&sh_chan->desc_lock);
+	if (!list_empty(&sh_chan->ld_queue)) {
+		/* Record partial transfer */
+		struct sh_desc *desc = list_entry(sh_chan->ld_queue.next,
+						  struct sh_desc, node);
+		desc->partial = (desc->hw.tcr - sh_dmae_readl(sh_chan, TCR)) <<
+			sh_chan->xmit_shift;
+
+	}
+	spin_unlock_bh(&sh_chan->desc_lock);
+
 	sh_dmae_chan_ld_cleanup(sh_chan, true);
 }
 
@@ -701,6 +714,9 @@ static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
 	/* Find the first not transferred desciptor */
 	list_for_each_entry(desc, &sh_chan->ld_queue, node)
 		if (desc->mark == DESC_SUBMITTED) {
+			dev_dbg(sh_chan->dev, "Queue #%d to %d: %u@%x -> %x\n",
+				desc->async_tx.cookie, sh_chan->id,
+				desc->hw.tcr, desc->hw.sar, desc->hw.dar);
 			/* Get the ld start address from ld_queue */
 			dmae_set_reg(sh_chan, &desc->hw);
 			dmae_start(sh_chan);
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 9f0897f..153609a 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -21,22 +21,6 @@
 
 #define SH_DMA_TCR_MAX 0x00FFFFFF	/* 16MB */
 
-struct sh_dmae_regs {
-	u32 sar; /* SAR / source address */
-	u32 dar; /* DAR / destination address */
-	u32 tcr; /* TCR / transfer count */
-};
-
-struct sh_desc {
-	struct sh_dmae_regs hw;
-	struct list_head node;
-	struct dma_async_tx_descriptor async_tx;
-	enum dma_data_direction direction;
-	dma_cookie_t cookie;
-	int chunks;
-	int mark;
-};
-
 struct device;
 
 struct sh_dmae_chan {
