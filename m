From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] serial: sh-sci: Add overrun handling of SCIFA and SCIFB
Date: Wed, 25 Mar 2015 16:00:18 +0900
Message-ID: <1427266818-10985-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
List-Id: linux-serial@vger.kernel.org

SCIFA and SCIFB can detect the overrun, but it does not support.
This adds overrun handling of SCIFA and SCIFB.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5b50c79..0a78e1d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -844,14 +844,26 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 	struct sci_port *s = to_sci_port(port);
 	struct plat_sci_reg *reg;
-	int copied = 0;
+	int copied = 0, offset;
+	u16 status, bit;
+
+	if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
+		offset = SCLSR;
+	else if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+		offset = SCxSR;
+	else
+		return 0;
 
-	reg = sci_getreg(port, SCLSR);
+	reg = sci_getreg(port, offset);
 	if (!reg->size)
 		return 0;
 
-	if ((serial_port_in(port, SCLSR) & (1 << s->overrun_bit))) {
-		serial_port_out(port, SCLSR, 0);
+	status = serial_port_in(port, offset);
+	bit = 1 << s->overrun_bit;
+
+	if (status & bit) {
+		status &= ~bit;
+		serial_port_out(port, offset, status);
 
 		port->icount.overrun++;
 
@@ -996,7 +1008,7 @@ static inline unsigned long port_rx_irq_mask(struct uart_port *port)
 
 static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 {
-	unsigned short ssr_status, scr_status, err_enabled;
+	unsigned short ssr_status, scr_status, err_enabled, orer_status = 0;
 	unsigned short slr_status = 0;
 	struct uart_port *port = ptr;
 	struct sci_port *s = to_sci_port(port);
@@ -1005,7 +1017,10 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	ssr_status = serial_port_in(port, SCxSR);
 	scr_status = serial_port_in(port, SCSCR);
 	if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
-		slr_status = serial_port_in(port, SCLSR);
+		orer_status = serial_port_in(port, SCLSR);
+	else if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+		orer_status = ssr_status;
+
 	err_enabled = scr_status & port_rx_irq_mask(port);
 
 	/* Tx Interrupt */
@@ -1033,10 +1048,8 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 		ret = sci_br_interrupt(irq, ptr);
 
 	/* Overrun Interrupt */
-	if (port->type == PORT_SCIF || port->type == PORT_HSCIF) {
-		if (slr_status & 0x01)
-			sci_handle_fifo_overrun(port);
-	}
+	if (orer_status & (1 << s->overrun_bit))
+		sci_handle_fifo_overrun(port);
 
 	return ret;
 }
-- 
2.1.3

