From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 27/29] serial: sh-sci: Remove platform data mapbase and irqs fields
Date: Thu, 28 Nov 2013 00:18:37 +0100
Message-ID: <1385594319-5758-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

The fields are not used anymore by board files, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 60 +++++++++++++++++++++++++--------------------
 include/linux/serial_sci.h  | 26 --------------------
 2 files changed, 34 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index aeb04e4..ecd4dc0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -59,6 +59,23 @@
 
 #include "sh-sci.h"
 
+/* Offsets into the sci_port->irqs array */
+enum {
+	SCIx_ERI_IRQ,
+	SCIx_RXI_IRQ,
+	SCIx_TXI_IRQ,
+	SCIx_BRI_IRQ,
+	SCIx_NR_IRQS,
+
+	SCIx_MUX_IRQ = SCIx_NR_IRQS,	/* special case */
+};
+
+#define SCIx_IRQ_IS_MUXED(port)			\
+	((port)->irqs[SCIx_ERI_IRQ] ==	\
+	 (port)->irqs[SCIx_RXI_IRQ]) ||	\
+	((port)->irqs[SCIx_ERI_IRQ] &&	\
+	 ((port)->irqs[SCIx_RXI_IRQ] < 0))
+
 struct sci_port {
 	struct uart_port	port;
 
@@ -2160,36 +2177,27 @@ static int sci_init_single(struct platform_device *dev,
 	port->iotype	= UPIO_MEM;
 	port->line	= index;
 
-	if (dev->num_resources) {
-		/* Device has resources, use them. */
-		res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-		if (res == NULL)
-			return -ENOMEM;
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -ENOMEM;
 
-		port->mapbase = res->start;
+	port->mapbase = res->start;
 
-		for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i)
-			sci_port->irqs[i] = platform_get_irq(dev, i);
+	for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i)
+		sci_port->irqs[i] = platform_get_irq(dev, i);
 
-		/* The SCI generates several interrupts. They can be muxed
-		 * together or connected to different interrupt lines. In the
-		 * muxed case only one interrupt resource is specified. In the
-		 * non-muxed case three or four interrupt resources are
-		 * specified, as the BRI interrupt is optional.
-		 */
-		if (sci_port->irqs[0] < 0)
-			return -ENXIO;
+	/* The SCI generates several interrupts. They can be muxed together or
+	 * connected to different interrupt lines. In the muxed case only one
+	 * interrupt resource is specified. In the non-muxed case three or four
+	 * interrupt resources are specified, as the BRI interrupt is optional.
+	 */
+	if (sci_port->irqs[0] < 0)
+		return -ENXIO;
 
-		if (sci_port->irqs[1] < 0) {
-			sci_port->irqs[1] = sci_port->irqs[0];
-			sci_port->irqs[2] = sci_port->irqs[0];
-			sci_port->irqs[3] = sci_port->irqs[0];
-		}
-	} else {
-		/* No resources, use old-style platform data. */
-		port->mapbase = p->mapbase;
-		for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i)
-			sci_port->irqs[i] = p->irqs[i] ? p->irqs[i] : -ENXIO;
+	if (sci_port->irqs[1] < 0) {
+		sci_port->irqs[1] = sci_port->irqs[0];
+		sci_port->irqs[2] = sci_port->irqs[0];
+		sci_port->irqs[3] = sci_port->irqs[0];
 	}
 
 	switch (p->type) {
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 42620f1..0f6ca22 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -58,17 +58,6 @@ enum {
 /* HSSRR HSCIF */
 #define HSCIF_SRE	0x8000
 
-/* Offsets into the sci_port->irqs array */
-enum {
-	SCIx_ERI_IRQ,
-	SCIx_RXI_IRQ,
-	SCIx_TXI_IRQ,
-	SCIx_BRI_IRQ,
-	SCIx_NR_IRQS,
-
-	SCIx_MUX_IRQ = SCIx_NR_IRQS,	/* special case */
-};
-
 /* Offsets into the sci_port->gpios array */
 enum {
 	SCIx_SCK,
@@ -98,19 +87,6 @@ enum {
 	SCIx_NR_REGTYPES,
 };
 
-#define SCIx_IRQ_MUXED(irq)		\
-{					\
-	[SCIx_ERI_IRQ]	= (irq),	\
-	[SCIx_RXI_IRQ]	= (irq),	\
-	[SCIx_TXI_IRQ]	= (irq),	\
-	[SCIx_BRI_IRQ]	= (irq),	\
-}
-
-#define SCIx_IRQ_IS_MUXED(port)			\
-	((port)->irqs[SCIx_ERI_IRQ] ==	\
-	 (port)->irqs[SCIx_RXI_IRQ]) ||	\
-	((port)->irqs[SCIx_ERI_IRQ] &&	\
-	 ((port)->irqs[SCIx_RXI_IRQ] < 0))
 /*
  * SCI register subset common for all port types.
  * Not all registers will exist on all parts.
@@ -139,8 +115,6 @@ struct plat_sci_port_ops {
  * Platform device specific platform_data struct
  */
 struct plat_sci_port {
-	unsigned long	mapbase;		/* resource base */
-	unsigned int	irqs[SCIx_NR_IRQS];	/* ERI, RXI, TXI, BRI */
 	unsigned int	gpios[SCIx_NR_FNS];	/* SCK, RXD, TXD, CTS, RTS */
 	unsigned int	type;			/* SCI / SCIF / IRDA / HSCIF */
 	upf_t		flags;			/* UPF_* flags */
-- 
1.8.3.2

