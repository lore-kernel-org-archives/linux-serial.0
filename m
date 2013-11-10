From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 07/29] serial: sh-sci: Support resources passed through platform resources
Date: Sun, 10 Nov 2013 04:33:19 +0100
Message-ID: <1384054421-13357-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Memory and IRQ resources are currently passed to the driver through
platform data. Support passing them through the standard platform
resources mechanism instead. This deprecates platform data resources.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 65 ++++++++++++++++++++++++++++++++++-----------
 include/linux/serial_sci.h  |  8 +++---
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b0c9d24..c5abe5c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -74,6 +74,7 @@ struct sci_port {
 	/* Function clock */
 	struct clk		*fclk;
 
+	int			irqs[SCIx_NR_IRQS];
 	char			*irqstr[SCIx_NR_IRQS];
 	char			*gpiostr[SCIx_NR_FNS];
 
@@ -1075,19 +1076,19 @@ static int sci_request_irq(struct sci_port *port)
 
 	for (i = j = 0; i < SCIx_NR_IRQS; i++, j++) {
 		struct sci_irq_desc *desc;
-		unsigned int irq;
+		int irq;
 
 		if (SCIx_IRQ_IS_MUXED(port)) {
 			i = SCIx_MUX_IRQ;
 			irq = up->irq;
 		} else {
-			irq = port->cfg->irqs[i];
+			irq = port->irqs[i];
 
 			/*
 			 * Certain port types won't support all of the
 			 * available interrupt sources.
 			 */
-			if (unlikely(!irq))
+			if (unlikely(irq < 0))
 				continue;
 		}
 
@@ -1112,7 +1113,7 @@ static int sci_request_irq(struct sci_port *port)
 
 out_noirq:
 	while (--i >= 0)
-		free_irq(port->cfg->irqs[i], port);
+		free_irq(port->irqs[i], port);
 
 out_nomem:
 	while (--j >= 0)
@@ -1130,16 +1131,16 @@ static void sci_free_irq(struct sci_port *port)
 	 * IRQ first.
 	 */
 	for (i = 0; i < SCIx_NR_IRQS; i++) {
-		unsigned int irq = port->cfg->irqs[i];
+		int irq = port->irqs[i];
 
 		/*
 		 * Certain port types won't support all of the available
 		 * interrupt sources.
 		 */
-		if (unlikely(!irq))
+		if (unlikely(irq < 0))
 			continue;
 
-		free_irq(port->cfg->irqs[i], port);
+		free_irq(port->irqs[i], port);
 		kfree(port->irqstr[i]);
 
 		if (SCIx_IRQ_IS_MUXED(port)) {
@@ -1655,7 +1656,7 @@ static void rx_timer_fn(unsigned long arg)
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		scr &= ~0x4000;
-		enable_irq(s->cfg->irqs[1]);
+		enable_irq(s->irqs[SCIx_RXI_IRQ]);
 	}
 	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
 	dev_dbg(port->dev, "DMA Rx timed out\n");
@@ -2145,11 +2146,12 @@ static struct uart_ops sci_uart_ops = {
 };
 
 static int sci_init_single(struct platform_device *dev,
-				     struct sci_port *sci_port,
-				     unsigned int index,
-				     struct plat_sci_port *p)
+			   struct sci_port *sci_port, unsigned int index,
+			   struct plat_sci_port *p, bool early)
 {
 	struct uart_port *port = &sci_port->port;
+	const struct resource *res;
+	unsigned int i;
 	int ret;
 
 	sci_port->cfg	= p;
@@ -2158,6 +2160,38 @@ static int sci_init_single(struct platform_device *dev,
 	port->iotype	= UPIO_MEM;
 	port->line	= index;
 
+	if (dev->num_resources) {
+		/* Device has resources, use them. */
+		res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+		if (res == NULL)
+			return -ENOMEM;
+
+		port->mapbase = res->start;
+
+		for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i)
+			sci_port->irqs[i] = platform_get_irq(dev, i);
+
+		/* The SCI generates several interrupts. They can be muxed
+		 * together or connected to different interrupt lines. In the
+		 * muxed case only one interrupt resource is specified. In the
+		 * non-muxed case three or four interrupt resources are
+		 * specified, as the BRI interrupt is optional.
+		 */
+		if (sci_port->irqs[0] < 0)
+			return -ENXIO;
+
+		if (sci_port->irqs[1] < 0) {
+			sci_port->irqs[1] = sci_port->irqs[0];
+			sci_port->irqs[2] = sci_port->irqs[0];
+			sci_port->irqs[3] = sci_port->irqs[0];
+		}
+	} else {
+		/* No resources, use old-style platform data. */
+		port->mapbase = p->mapbase;
+		for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i)
+			sci_port->irqs[i] = p->irqs[i] ? p->irqs[i] : -ENXIO;
+	}
+
 	switch (p->type) {
 	case PORT_SCIFB:
 		port->fifosize = 256;
@@ -2182,7 +2216,7 @@ static int sci_init_single(struct platform_device *dev,
 			return ret;
 	}
 
-	if (dev) {
+	if (!early) {
 		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
 		if (IS_ERR(sci_port->iclk)) {
 			sci_port->iclk = clk_get(&dev->dev, "peripheral_clk");
@@ -2237,7 +2271,6 @@ static int sci_init_single(struct platform_device *dev,
 		p->error_mask |= (1 << p->overrun_bit);
 	}
 
-	port->mapbase		= p->mapbase;
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | p->flags;
 	port->regshift		= p->regshift;
@@ -2249,7 +2282,7 @@ static int sci_init_single(struct platform_device *dev,
 	 *
 	 * For the muxed case there's nothing more to do.
 	 */
-	port->irq		= p->irqs[SCIx_RXI_IRQ];
+	port->irq		= sci_port->irqs[SCIx_RXI_IRQ];
 	port->irqflags		= 0;
 
 	port->serial_in		= sci_serial_in;
@@ -2381,7 +2414,7 @@ static int sci_probe_earlyprintk(struct platform_device *pdev)
 
 	early_serial_console.index = pdev->id;
 
-	sci_init_single(NULL, &sci_ports[pdev->id], pdev->id, cfg);
+	sci_init_single(pdev, &sci_ports[pdev->id], pdev->id, cfg, true);
 
 	serial_console_setup(&early_serial_console, early_serial_buf);
 
@@ -2448,7 +2481,7 @@ static int sci_probe_single(struct platform_device *dev,
 		return -EINVAL;
 	}
 
-	ret = sci_init_single(dev, sciport, index, p);
+	ret = sci_init_single(dev, sciport, index, p, false);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index eb787d4..68cf0bf 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -107,10 +107,10 @@ enum {
 }
 
 #define SCIx_IRQ_IS_MUXED(port)			\
-	((port)->cfg->irqs[SCIx_ERI_IRQ] ==	\
-	 (port)->cfg->irqs[SCIx_RXI_IRQ]) ||	\
-	((port)->cfg->irqs[SCIx_ERI_IRQ] &&	\
-	 !(port)->cfg->irqs[SCIx_RXI_IRQ])
+	((port)->irqs[SCIx_ERI_IRQ] ==	\
+	 (port)->irqs[SCIx_RXI_IRQ]) ||	\
+	((port)->irqs[SCIx_ERI_IRQ] &&	\
+	 ((port)->irqs[SCIx_RXI_IRQ] < 0))
 /*
  * SCI register subset common for all port types.
  * Not all registers will exist on all parts.
-- 
1.8.1.5

