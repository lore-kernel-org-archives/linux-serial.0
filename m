From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] serial: sh-sci: Fix R-Car SCIF and HSCIF overrun handling
Date: Mon, 15 Dec 2014 23:14:43 +0900
Message-ID: <1418652883-6884-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

When fifo overrun happened, the interrupt status refers to
SCLSR register in R-Car SCIF and HSCIF.
Thus, overrun handling takes SCLSR register into account.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

 drivers/tty/serial/sh-sci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1110523..ff549a8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -793,8 +793,6 @@ static int sci_handle_errors(struct uart_port *port)
 		/* overrun error */
 		if (tty_insert_flip_char(tport, 0, TTY_OVERRUN))
 			copied++;
-
-		dev_notice(port->dev, "overrun error\n");
 	}
 
 	if (status & SCxSR_FER(port)) {
@@ -835,8 +833,6 @@ static int sci_handle_errors(struct uart_port *port)
 
 		if (tty_insert_flip_char(tport, 0, TTY_PARITY))
 			copied++;
-
-		dev_notice(port->dev, "parity error\n");
 	}
 
 	if (copied)
@@ -1002,12 +998,15 @@ static inline unsigned long port_rx_irq_mask(struct uart_port *port)
 static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 {
 	unsigned short ssr_status, scr_status, err_enabled;
+	unsigned short slr_status = 0;
 	struct uart_port *port = ptr;
 	struct sci_port *s = to_sci_port(port);
 	irqreturn_t ret = IRQ_NONE;
 
 	ssr_status = serial_port_in(port, SCxSR);
 	scr_status = serial_port_in(port, SCSCR);
+	if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
+		slr_status = serial_port_in(port, SCLSR);
 	err_enabled = scr_status & port_rx_irq_mask(port);
 
 	/* Tx Interrupt */
@@ -1020,8 +1019,11 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	 * DR flags
 	 */
 	if (((ssr_status & SCxSR_RDxF(port)) || s->chan_rx) &&
-	    (scr_status & SCSCR_RIE))
+	    (scr_status & SCSCR_RIE)) {
+		if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
+			sci_handle_fifo_overrun(port);
 		ret = sci_rx_interrupt(irq, ptr);
+	}
 
 	/* Error Interrupt */
 	if ((ssr_status & SCxSR_ERRORS(port)) && err_enabled)
@@ -1031,6 +1033,12 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	if ((ssr_status & SCxSR_BRK(port)) && err_enabled)
 		ret = sci_br_interrupt(irq, ptr);
 
+	/* Overrun Interrupt */
+	if (port->type == PORT_SCIF || port->type == PORT_HSCIF) {
+		if ((slr_status & 0x01))
+			sci_handle_fifo_overrun(port);
+	}
+
 	return ret;
 }
 
-- 
1.9.1

