From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] pmac_zilog iomem annotations
Date: Sun, 28 Nov 2004 00:08:49 +0000
Message-ID: <20041128000848.GQ26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261371AbUK1AIu
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Nov 2004 19:08:50 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-serial@vger.kernel.org

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC10-rc2-bk9-pmac-sound/drivers/serial/pmac_zilog.c RC10-rc2-bk9-pmac_zilog/drivers/serial/pmac_zilog.c
--- RC10-rc2-bk9-pmac-sound/drivers/serial/pmac_zilog.c	Thu Nov 25 23:29:40 2004
+++ RC10-rc2-bk9-pmac_zilog/drivers/serial/pmac_zilog.c	Sat Nov 27 19:06:34 2004
@@ -1439,7 +1439,7 @@
 	uap->port.mapbase = np->addrs[0].address;
 	uap->port.membase = ioremap(uap->port.mapbase, 0x1000);
       
-	uap->control_reg = (volatile u8 *)uap->port.membase;
+	uap->control_reg = uap->port.membase;
 	uap->data_reg = uap->control_reg + 0x10;
 	
 	/*
@@ -1450,16 +1450,14 @@
 		uap->flags |= PMACZILOG_FLAG_HAS_DMA;
 #endif	
 	if (ZS_HAS_DMA(uap)) {
-		uap->tx_dma_regs = (volatile struct dbdma_regs *)
-			ioremap(np->addrs[np->n_addrs - 2].address, 0x1000);
+		uap->tx_dma_regs = ioremap(np->addrs[np->n_addrs - 2].address, 0x1000);
 		if (uap->tx_dma_regs == NULL) {	
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
-		uap->rx_dma_regs = (volatile struct dbdma_regs *)
-			ioremap(np->addrs[np->n_addrs - 1].address, 0x1000);
+		uap->rx_dma_regs = ioremap(np->addrs[np->n_addrs - 1].address, 0x1000);
 		if (uap->rx_dma_regs == NULL) {	
-			iounmap((void *)uap->tx_dma_regs);
+			iounmap(uap->tx_dma_regs);
 			uap->tx_dma_regs = NULL;
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
@@ -1536,9 +1534,9 @@
 	struct device_node *np;
 
 	np = uap->node;
-	iounmap((void *)uap->rx_dma_regs);
-	iounmap((void *)uap->tx_dma_regs);
-	iounmap((void *)uap->control_reg);
+	iounmap(uap->rx_dma_regs);
+	iounmap(uap->tx_dma_regs);
+	iounmap(uap->control_reg);
 	uap->node = NULL;
 	of_node_put(np);
 	memset(uap, 0, sizeof(struct uart_pmac_port));
diff -urN RC10-rc2-bk9-pmac-sound/drivers/serial/pmac_zilog.h RC10-rc2-bk9-pmac_zilog/drivers/serial/pmac_zilog.h
--- RC10-rc2-bk9-pmac-sound/drivers/serial/pmac_zilog.h	Sun Nov 21 10:49:06 2004
+++ RC10-rc2-bk9-pmac_zilog/drivers/serial/pmac_zilog.h	Sat Nov 27 19:06:36 2004
@@ -52,13 +52,13 @@
 	unsigned char			parity_mask;
 	unsigned char			prev_status;
 
-	volatile u8			*control_reg;
-	volatile u8			*data_reg;
+	volatile u8			__iomem *control_reg;
+	volatile u8			__iomem *data_reg;
 
 	unsigned int			tx_dma_irq;
 	unsigned int			rx_dma_irq;
-	volatile struct dbdma_regs	*tx_dma_regs;
-	volatile struct dbdma_regs	*rx_dma_regs;
+	volatile struct dbdma_regs	__iomem *tx_dma_regs;
+	volatile struct dbdma_regs	__iomem *rx_dma_regs;
 
 	struct termios			termios_cache;
 };
