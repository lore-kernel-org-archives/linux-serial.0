From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/2] PNPACPI: support shareable interrupts
Date: Fri, 30 Jun 2006 12:58:26 -0600
Message-ID: <200606301258.26794.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Russell King <rmk+serial@arm.linux.org.uk>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

ACPI supplies a "shareable" indication, but PNPACPI ignores it.
If a PNP device uses a shared interrupt, request_irq() fails
because the PNP driver can't tell whether to supply SA_SHIRQ.

This patch allows PNP drivers to test
    (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm7/include/linux/ioport.h
===================================================================
--- work-mm7.orig/include/linux/ioport.h	2006-06-30 11:52:21.000000000 -0600
+++ work-mm7/include/linux/ioport.h	2006-06-30 12:18:41.000000000 -0600
@@ -55,6 +55,7 @@
 #define IORESOURCE_IRQ_LOWEDGE		(1<<1)
 #define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
 #define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
+#define IORESOURCE_IRQ_SHAREABLE	(1<<4)
 
 /* ISA PnP DMA specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_DMA_TYPE_MASK	(3<<0)
Index: work-mm7/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm7.orig/drivers/pnp/pnpacpi/rsparser.c	2006-06-30 11:52:18.000000000 -0600
+++ work-mm7/drivers/pnp/pnpacpi/rsparser.c	2006-06-30 12:18:41.000000000 -0600
@@ -74,7 +74,7 @@
 
 static void
 pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res, u32 gsi,
-	int triggering, int polarity)
+	int triggering, int polarity, int shareable)
 {
 	int i = 0;
 	int irq;
@@ -95,6 +95,9 @@
 		return;
 	}
 
+	if (shareable)
+		res->irq_resource[i].flags |= IORESOURCE_IRQ_SHAREABLE;
+
 	res->irq_resource[i].start = irq;
 	res->irq_resource[i].end = irq;
 	pcibios_penalize_isa_irq(irq, 1);
@@ -197,7 +200,8 @@
 			pnpacpi_parse_allocated_irqresource(res_table,
 				res->data.irq.interrupts[i],
 				res->data.irq.triggering,
-				res->data.irq.polarity);
+				res->data.irq.polarity,
+				res->data.irq.sharable);
 		}
 		break;
 
@@ -263,7 +267,8 @@
 			pnpacpi_parse_allocated_irqresource(res_table,
 				res->data.extended_irq.interrupts[i],
 				res->data.extended_irq.triggering,
-				res->data.extended_irq.polarity);
+				res->data.extended_irq.polarity,
+				res->data.extended_irq.sharable);
 		}
 		break;
 
