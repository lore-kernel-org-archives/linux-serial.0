From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/4] sh: fix handling of SCIFB sh-mobile ports
Date: Fri, 21 May 2010 17:49:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005211734200.8450@axis700.grange>
References: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933603Ab0EUPtG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 May 2010 11:49:06 -0400
In-Reply-To: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org

SCIFB ports have a slightly different register layout and a different FIFO
size from SCIFA ports, in DMA mode they have to be treated just like SCIFA.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/serial/sh-sci.c |   42 ++++++++++++++++++++++++++++++++++--------
 drivers/serial/sh-sci.h |   29 +++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 7b273c9..21152ff 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -341,6 +341,27 @@ static int scif_rxfill(struct uart_port *port)
 		return sci_in(port, SCFDR) & SCIF2_RFDC_MASK;
 	}
 }
+#elif defined(CONFIG_ARCH_SH7372)
+static int scif_txfill(struct uart_port *port)
+{
+	if (port->type == PORT_SCIFA)
+		return sci_in(port, SCFDR) >> 8;
+	else
+		return sci_in(port, SCTFDR);
+}
+
+static int scif_txroom(struct uart_port *port)
+{
+	return port->fifosize - scif_txfill(port);
+}
+
+static int scif_rxfill(struct uart_port *port)
+{
+	if (port->type == PORT_SCIFA)
+		return sci_in(port, SCFDR) & SCIF_RFDC_MASK;
+	else
+		return sci_in(port, SCRFDR);
+}
 #else
 static int scif_txfill(struct uart_port *port)
 {
@@ -678,7 +699,7 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 		u16 ssr = sci_in(port, SCxSR);
 
 		/* Disable future Rx interrupts */
-		if (port->type == PORT_SCIFA) {
+		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 			disable_irq_nosync(irq);
 			scr |= 0x4000;
 		} else {
@@ -931,7 +952,7 @@ static void sci_dma_tx_complete(void *arg)
 
 	if (!uart_circ_empty(xmit)) {
 		schedule_work(&s->work_tx);
-	} else if (port->type == PORT_SCIFA) {
+	} else if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		u16 ctrl = sci_in(port, SCSCR);
 		sci_out(port, SCSCR, ctrl & ~SCI_CTRL_FLAGS_TIE);
 	}
@@ -1187,7 +1208,7 @@ static void sci_start_tx(struct uart_port *port)
 	unsigned short ctrl;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	if (port->type == PORT_SCIFA) {
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		u16 new, scr = sci_in(port, SCSCR);
 		if (s->chan_tx)
 			new = scr | 0x8000;
@@ -1200,7 +1221,7 @@ static void sci_start_tx(struct uart_port *port)
 	    s->cookie_tx < 0)
 		schedule_work(&s->work_tx);
 #endif
-	if (!s->chan_tx || port->type == PORT_SCIFA) {
+	if (!s->chan_tx || port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
 		ctrl = sci_in(port, SCSCR);
 		sci_out(port, SCSCR, ctrl | SCI_CTRL_FLAGS_TIE);
@@ -1213,7 +1234,7 @@ static void sci_stop_tx(struct uart_port *port)
 
 	/* Clear TIE (Transmit Interrupt Enable) bit in SCSCR */
 	ctrl = sci_in(port, SCSCR);
-	if (port->type == PORT_SCIFA)
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		ctrl &= ~0x8000;
 	ctrl &= ~SCI_CTRL_FLAGS_TIE;
 	sci_out(port, SCSCR, ctrl);
@@ -1225,7 +1246,7 @@ static void sci_start_rx(struct uart_port *port)
 
 	/* Set RIE (Receive Interrupt Enable) bit in SCSCR */
 	ctrl |= sci_in(port, SCSCR);
-	if (port->type == PORT_SCIFA)
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		ctrl &= ~0x4000;
 	sci_out(port, SCSCR, ctrl);
 }
@@ -1236,7 +1257,7 @@ static void sci_stop_rx(struct uart_port *port)
 
 	/* Clear RIE (Receive Interrupt Enable) bit in SCSCR */
 	ctrl = sci_in(port, SCSCR);
-	if (port->type == PORT_SCIFA)
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		ctrl &= ~0x4000;
 	ctrl &= ~(SCI_CTRL_FLAGS_RIE | SCI_CTRL_FLAGS_REIE);
 	sci_out(port, SCSCR, ctrl);
@@ -1274,7 +1295,7 @@ static void rx_timer_fn(unsigned long arg)
 	struct uart_port *port = &s->port;
 	u16 scr = sci_in(port, SCSCR);
 
-	if (port->type == PORT_SCIFA) {
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		scr &= ~0x4000;
 		enable_irq(s->irqs[1]);
 	}
@@ -1527,6 +1548,8 @@ static const char *sci_type(struct uart_port *port)
 		return "scif";
 	case PORT_SCIFA:
 		return "scifa";
+	case PORT_SCIFB:
+		return "scifb";
 	}
 
 	return NULL;
@@ -1615,6 +1638,9 @@ static void __devinit sci_init_single(struct platform_device *dev,
 	port->line	= index;
 
 	switch (p->type) {
+	case PORT_SCIFB:
+		port->fifosize = 256;
+		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
 		break;
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index f70c49f..9b52f77 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -322,7 +322,7 @@
 #define CPU_SCIx_FNS(name, sci_offset, sci_size, scif_offset, scif_size)\
   static inline unsigned int sci_##name##_in(struct uart_port *port)	\
   {									\
-    if (port->type == PORT_SCIF) {					\
+    if (port->type == PORT_SCIF || port->type == PORT_SCIFB) {		\
       SCI_IN(scif_size, scif_offset)					\
     } else {	/* PORT_SCI or PORT_SCIFA */				\
       SCI_IN(sci_size, sci_offset);					\
@@ -330,7 +330,7 @@
   }									\
   static inline void sci_##name##_out(struct uart_port *port, unsigned int value) \
   {									\
-    if (port->type == PORT_SCIF) {					\
+    if (port->type == PORT_SCIF || port->type == PORT_SCIFB) {		\
       SCI_OUT(scif_size, scif_offset, value)				\
     } else {	/* PORT_SCI or PORT_SCIFA */				\
       SCI_OUT(sci_size, sci_offset, value);				\
@@ -384,8 +384,12 @@
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
       defined(CONFIG_ARCH_SH7367) || \
-      defined(CONFIG_ARCH_SH7377) || \
-      defined(CONFIG_ARCH_SH7372)
+      defined(CONFIG_ARCH_SH7377)
+#define SCIF_FNS(name, scif_offset, scif_size) \
+  CPU_SCIF_FNS(name, scif_offset, scif_size)
+#elif defined(CONFIG_ARCH_SH7372)
+#define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scifb_offset, sh4_scifb_size) \
+  CPU_SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scifb_offset, sh4_scifb_size)
 #define SCIF_FNS(name, scif_offset, scif_size) \
   CPU_SCIF_FNS(name, scif_offset, scif_size)
 #else
@@ -422,8 +426,7 @@
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
     defined(CONFIG_ARCH_SH7367) || \
-    defined(CONFIG_ARCH_SH7377) || \
-    defined(CONFIG_ARCH_SH7372)
+    defined(CONFIG_ARCH_SH7377)
 
 SCIF_FNS(SCSMR,  0x00, 16)
 SCIF_FNS(SCBRR,  0x04,  8)
@@ -436,6 +439,20 @@ SCIF_FNS(SCFDR,  0x1c, 16)
 SCIF_FNS(SCxTDR, 0x20,  8)
 SCIF_FNS(SCxRDR, 0x24,  8)
 SCIF_FNS(SCLSR,  0x00,  0)
+#elif defined(CONFIG_ARCH_SH7372)
+SCIF_FNS(SCSMR,  0x00, 16)
+SCIF_FNS(SCBRR,  0x04,  8)
+SCIF_FNS(SCSCR,  0x08, 16)
+SCIF_FNS(SCTDSR, 0x0c, 16)
+SCIF_FNS(SCFER,  0x10, 16)
+SCIF_FNS(SCxSR,  0x14, 16)
+SCIF_FNS(SCFCR,  0x18, 16)
+SCIF_FNS(SCFDR,  0x1c, 16)
+SCIF_FNS(SCTFDR, 0x38, 16)
+SCIF_FNS(SCRFDR, 0x3c, 16)
+SCIx_FNS(SCxTDR, 0x20,  8, 0x40,  8)
+SCIx_FNS(SCxRDR, 0x24,  8, 0x60,  8)
+SCIF_FNS(SCLSR,  0x00,  0)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
       defined(CONFIG_CPU_SUBTYPE_SH7724)
 SCIx_FNS(SCSMR,  0x00, 16, 0x00, 16)
-- 
1.6.2.4

