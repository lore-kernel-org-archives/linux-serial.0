From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH v2] serial: sh-sci: Add overrun handling of SCIFA and SCIFB
Date: Tue, 17 Mar 2015 01:19:19 +0900
Message-ID: <1426522759-25802-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

SCIFA and SCIFB can detect the overrun, but it does not support.
This adds overrun handling of SCIFA and SCIFB.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

v2 [Yoshihiro Kaneko]
* use the switch statement instead of a verbose if statement.

 drivers/tty/serial/sh-sci.c | 48 +++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5b50c79..5bf9972 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -844,14 +844,32 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 	struct sci_port *s = to_sci_port(port);
 	struct plat_sci_reg *reg;
-	int copied = 0;
+	int copied = 0, offset;
+	u16 status, bit;
 
-	reg = sci_getreg(port, SCLSR);
+	switch (port->type) {
+	case PORT_SCIF:
+	case PORT_HSCIF:
+		offset = SCLSR;
+		break;
+	case PORT_SCIFA:
+	case PORT_SCIFB:
+		offset = SCxSR;
+		break;
+	default:
+		return 0;
+	}
+
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
 
@@ -996,16 +1014,24 @@ static inline unsigned long port_rx_irq_mask(struct uart_port *port)
 
 static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 {
-	unsigned short ssr_status, scr_status, err_enabled;
-	unsigned short slr_status = 0;
+	unsigned short ssr_status, scr_status, err_enabled, orer_status = 0;
 	struct uart_port *port = ptr;
 	struct sci_port *s = to_sci_port(port);
 	irqreturn_t ret = IRQ_NONE;
 
 	ssr_status = serial_port_in(port, SCxSR);
 	scr_status = serial_port_in(port, SCSCR);
-	if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
-		slr_status = serial_port_in(port, SCLSR);
+	switch (port->type) {
+	case PORT_SCIF:
+	case PORT_HSCIF:
+		orer_status = serial_port_in(port, SCLSR);
+		break;
+	case PORT_SCIFA:
+	case PORT_SCIFB:
+		orer_status = ssr_status;
+		break;
+	}
+
 	err_enabled = scr_status & port_rx_irq_mask(port);
 
 	/* Tx Interrupt */
@@ -1033,10 +1059,8 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
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
1.9.1

