From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 07/13] serial: sh-sci: Replace hardcoded overrun bit values
Date: Thu, 30 Apr 2015 18:21:31 +0200
Message-ID: <1430410897-12770-8-git-send-email-geert+renesas@glider.be>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add the missing overrun bit definition for (H)SCIF.
Replace overrun_bit by overrun_mask, so we can use the existing
defines instead of hardcoded values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 28 +++++++++++++---------------
 drivers/tty/serial/sh-sci.h |  3 +++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7ee0f686bdf1b216..83c46e1581590401 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -81,7 +81,7 @@ struct sci_port {
 
 	/* Platform configuration */
 	struct plat_sci_port	*cfg;
-	int			overrun_bit;
+	unsigned int		overrun_mask;
 	unsigned int		error_mask;
 	unsigned int		sampling_rate;
 
@@ -803,7 +803,7 @@ static int sci_handle_errors(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 
 	/* Handle overruns */
-	if (status & (1 << s->overrun_bit)) {
+	if (status & s->overrun_mask) {
 		port->icount.overrun++;
 
 		/* overrun error */
@@ -867,7 +867,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 	struct plat_sci_reg *reg;
 	int copied = 0, offset;
-	u16 status, bit;
+	u16 status;
 
 	switch (port->type) {
 	case PORT_SCIF:
@@ -887,10 +887,8 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 		return 0;
 
 	status = serial_port_in(port, offset);
-	bit = 1 << s->overrun_bit;
-
-	if (status & bit) {
-		status &= ~bit;
+	if (status & s->overrun_mask) {
+		status &= ~s->overrun_mask;
 		serial_port_out(port, offset, status);
 
 		port->icount.overrun++;
@@ -1081,7 +1079,7 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 		ret = sci_br_interrupt(irq, ptr);
 
 	/* Overrun Interrupt */
-	if (orer_status & (1 << s->overrun_bit))
+	if (orer_status & s->overrun_mask)
 		sci_handle_fifo_overrun(port);
 
 	return ret;
@@ -2256,32 +2254,32 @@ static int sci_init_single(struct platform_device *dev,
 	switch (p->type) {
 	case PORT_SCIFB:
 		port->fifosize = 256;
-		sci_port->overrun_bit = 9;
+		sci_port->overrun_mask = SCIFA_ORER;
 		sampling_rate = 16;
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
 		sampling_rate = 0;
-		sci_port->overrun_bit = 0;
+		sci_port->overrun_mask = SCLSR_ORER;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
-		sci_port->overrun_bit = 9;
+		sci_port->overrun_mask = SCIFA_ORER;
 		sampling_rate = 16;
 		break;
 	case PORT_SCIF:
 		port->fifosize = 16;
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
-			sci_port->overrun_bit = 9;
+			sci_port->overrun_mask = SCIFA_ORER;
 			sampling_rate = 16;
 		} else {
-			sci_port->overrun_bit = 0;
+			sci_port->overrun_mask = SCLSR_ORER;
 			sampling_rate = 32;
 		}
 		break;
 	default:
 		port->fifosize = 1;
-		sci_port->overrun_bit = 5;
+		sci_port->overrun_mask = SCI_ORER;
 		sampling_rate = 32;
 		break;
 	}
@@ -2335,7 +2333,7 @@ static int sci_init_single(struct platform_device *dev,
 	 * Make the error mask inclusive of overrun detection, if
 	 * supported.
 	 */
-	sci_port->error_mask |= 1 << sci_port->overrun_bit;
+	sci_port->error_mask |= sci_port->overrun_mask;
 
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | p->flags;
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 3939513b04547e7f..3393f67b4e843578 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -87,6 +87,9 @@ enum {
 #define SCFCR_RFRST	BIT(1)	/* Receive FIFO Data Register Reset */
 #define SCFCR_LOOP	BIT(0)	/* Loopback Test */
 
+/* SCLSR (Line Status Register) on (H)SCIF */
+#define SCLSR_ORER	BIT(0)	/* Overrun Error */
+
 /* SCSPTR (Serial Port Register), optional */
 #define SCSPTR_RTSIO	BIT(7)	/* Serial Port RTS Pin Input/Output */
 #define SCSPTR_RTSDT	BIT(6)	/* Serial Port RTS Pin Data */
-- 
1.9.1

