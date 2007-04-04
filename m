From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 3/5] smsc-ircc2: tidy up module parameter checking
Date: Wed, 04 Apr 2007 16:45:39 -0600
Message-ID: <20070404224608.828386000@ldl.fc.hp.com>
References: <20070404224536.337573000@ldl.fc.hp.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:37954 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbXDDWqY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Apr 2007 18:46:24 -0400
Content-Disposition: inline; filename=smsc-ircc2-tidy-module-param-checking.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Keith Owens <kaos@ocs.com.au>, Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, Matthieu CASTET <castet.matthieu@free.fr>, Jean Tourrilhes <jt@hpl.hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ville Syrjala <syrjala@sci.fi>, Russell King <rmk+serial@arm.linux.org.uk>, linux-serial@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org

To determine whether the user specified a module parameter, use some #defines
instead of checking for bare magic numbers.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/net/irda/smsc-ircc2.c
===================================================================
--- w.orig/drivers/net/irda/smsc-ircc2.c	2007-04-04 13:38:30.000000000 -0600
+++ w/drivers/net/irda/smsc-ircc2.c	2007-04-04 13:45:18.000000000 -0600
@@ -79,11 +79,13 @@
 MODULE_DESCRIPTION("SMC IrCC SIR/FIR controller driver");
 MODULE_LICENSE("GPL");
 
-static int ircc_dma = 255;
+#define DMA_INVAL 255
+static int ircc_dma = DMA_INVAL;
 module_param(ircc_dma, int, 0);
 MODULE_PARM_DESC(ircc_dma, "DMA channel");
 
-static int ircc_irq = 255;
+#define IRQ_INVAL 255
+static int ircc_irq = IRQ_INVAL;
 module_param(ircc_irq, int, 0);
 MODULE_PARM_DESC(ircc_irq, "IRQ line");
 
@@ -646,7 +648,7 @@
 	self->io.fifo_size = SMSC_IRCC2_FIFO_SIZE;
 	self->io.speed = SMSC_IRCC2_C_IRDA_FALLBACK_SPEED;
 
-	if (irq < 255) {
+	if (irq != IRQ_INVAL) {
 		if (irq != chip_irq)
 			IRDA_MESSAGE("%s, Overriding IRQ - chip says %d, using %d\n",
 				     driver_name, chip_irq, irq);
@@ -654,7 +656,7 @@
 	} else
 		self->io.irq = chip_irq;
 
-	if (dma < 255) {
+	if (dma != DMA_INVAL) {
 		if (dma != chip_dma)
 			IRDA_MESSAGE("%s, Overriding DMA - chip says %d, using %d\n",
 				     driver_name, chip_dma, dma);
@@ -2836,9 +2838,9 @@
 					tmpconf.fir_io = ircc_fir;
 				if (ircc_sir != 0)
 					tmpconf.sir_io = ircc_sir;
-				if (ircc_dma != 0xff)
+				if (ircc_dma != DMA_INVAL)
 					tmpconf.fir_dma = ircc_dma;
-				if (ircc_irq != 0xff)
+				if (ircc_irq != IRQ_INVAL)
 					tmpconf.fir_irq = ircc_irq;
 
 				IRDA_MESSAGE("Detected unconfigured %s SMSC IrDA chip, pre-configuring device.\n", conf->name);

--
