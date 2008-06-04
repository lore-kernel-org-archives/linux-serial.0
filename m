From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Fwd: [patch 01/18] PNP: add pnp_possible_config() -- can a device could be configured this way?
Date: Wed, 4 Jun 2008 16:21:17 -0600
Message-ID: <200806041621.18966.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:36488 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYFDWVP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jun 2008 18:21:15 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk+lkml@arm.linux.org.uk>

FYI, this patch touches 8250_pnp.c.  My intent is to make no
functional change, so let me know if it looks like this would
break anything.

The whole patch series is here: http://lkml.org/lkml/2008/6/4/450

Bjorn


----------  Forwarded Message  ----------

Subject: [patch 01/18] PNP: add pnp_possible_config() -- can a device could be configured this way?
Date: Wednesday 04 June 2008
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <lenb@kernel.org>

As part of a heuristic to identify modem devices, 8250_pnp.c
checks to see whether a device can be configured at any of the
legacy COM port addresses.

This patch moves the code that traverses the PNP "possible resource
options" from 8250_pnp.c to the PNP subsystem.  This encapsulation
is important because a future patch will change the implementation
of those resource options.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

---
 drivers/pnp/resource.c    |   61 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/serial/8250_pnp.c |   24 +++++-------------
 include/linux/pnp.h       |    3 ++
 3 files changed, 71 insertions(+), 17 deletions(-)

Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-06-04 13:46:55.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-06-04 15:30:51.000000000 -0600
@@ -624,6 +624,67 @@ struct pnp_resource *pnp_add_mem_resourc
 	return pnp_res;
 }
 
+static int pnp_possible_option(struct pnp_option *option, int type,
+			       resource_size_t start, resource_size_t size)
+{
+	struct pnp_option *tmp;
+	struct pnp_port *port;
+	struct pnp_mem *mem;
+	struct pnp_irq *irq;
+	struct pnp_dma *dma;
+
+	if (!option)
+		return 0;
+
+	for (tmp = option; tmp; tmp = tmp->next) {
+		switch (type) {
+		case IORESOURCE_IO:
+			for (port = tmp->port; port; port = port->next) {
+				if (port->min == start && port->size == size)
+					return 1;
+			}
+			break;
+		case IORESOURCE_MEM:
+			for (mem = tmp->mem; mem; mem = mem->next) {
+				if (mem->min == start && mem->size == size)
+					return 1;
+			}
+			break;
+		case IORESOURCE_IRQ:
+			for (irq = tmp->irq; irq; irq = irq->next) {
+				if (start < PNP_IRQ_NR &&
+				    test_bit(start, irq->map))
+					return 1;
+			}
+			break;
+		case IORESOURCE_DMA:
+			for (dma = tmp->dma; dma; dma = dma->next) {
+				if (dma->map & (1 << start))
+					return 1;
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Determine whether the specified resource is a possible configuration
+ * for this device.
+ */
+int pnp_possible_config(struct pnp_dev *dev, int type, resource_size_t start,
+			resource_size_t size)
+{
+	if (pnp_possible_option(dev->independent, type, start, size))
+		return 1;
+
+	if (pnp_possible_option(dev->dependent, type, start, size))
+		return 1;
+
+	return 0;
+}
+
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
 static int __init pnp_setup_reserve_irq(char *str)
 {
Index: work10/drivers/serial/8250_pnp.c
===================================================================
--- work10.orig/drivers/serial/8250_pnp.c	2008-06-04 13:44:39.000000000 -0600
+++ work10/drivers/serial/8250_pnp.c	2008-06-04 15:31:24.000000000 -0600
@@ -383,21 +383,14 @@ static int __devinit check_name(char *na
 	return 0;
 }
 
-static int __devinit check_resources(struct pnp_option *option)
+static int __devinit check_resources(struct pnp_dev *dev)
 {
-	struct pnp_option *tmp;
-	if (!option)
-		return 0;
+	resource_size_t base[] = {0x2f8, 0x3f8, 0x2e8, 0x3e8};
+	int i;
 
-	for (tmp = option; tmp; tmp = tmp->next) {
-		struct pnp_port *port;
-		for (port = tmp->port; port; port = port->next)
-			if ((port->size == 8) &&
-			    ((port->min == 0x2f8) ||
-			     (port->min == 0x3f8) ||
-			     (port->min == 0x2e8) ||
-			     (port->min == 0x3e8)))
-				return 1;
+	for (i = 0; i < ARRAY_SIZE(base); i++) {
+		if (pnp_possible_config(dev, IORESOURCE_IO, base[i], 8))
+			return 1;
 	}
 
 	return 0;
@@ -420,10 +413,7 @@ static int __devinit serial_pnp_guess_bo
 		(dev->card && check_name(dev->card->name))))
 			return -ENODEV;
 
-	if (check_resources(dev->independent))
-		return 0;
-
-	if (check_resources(dev->dependent))
+	if (check_resources(dev))
 		return 0;
 
 	return -ENODEV;
Index: work10/include/linux/pnp.h
===================================================================
--- work10.orig/include/linux/pnp.h	2008-06-04 13:46:52.000000000 -0600
+++ work10/include/linux/pnp.h	2008-06-04 15:29:19.000000000 -0600
@@ -472,6 +472,8 @@ void pnp_unregister_card_driver(struct p
 extern struct list_head pnp_cards;
 
 /* resource management */
+int pnp_possible_config(struct pnp_dev *dev, int type, resource_size_t base,
+			resource_size_t size);
 int pnp_auto_config_dev(struct pnp_dev *dev);
 int pnp_start_dev(struct pnp_dev *dev);
 int pnp_stop_dev(struct pnp_dev *dev);
@@ -499,6 +501,7 @@ static inline int pnp_register_card_driv
 static inline void pnp_unregister_card_driver(struct pnp_card_driver *drv) { }
 
 /* resource management */
+static inline int pnp_possible_config(struct pnp_dev *dev, int type, resource_size_t base, resource_size_t size) { return 0; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_start_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }

-- 

-------------------------------------------------------
