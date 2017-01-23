From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 4/7] serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
Date: Mon, 23 Jan 2017 17:04:15 +0100
Message-ID: <1485187458-8195-5-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 39734cc..c7e2d0d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -141,6 +141,7 @@ struct sci_port {
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
 #endif
+	int				rx_trigger;
 
 	bool autorts;
 };
@@ -2197,6 +2198,7 @@ static void sci_reset(struct uart_port *port)
 {
 	const struct plat_sci_reg *reg;
 	unsigned int status;
+	struct sci_port *s = to_sci_port(port);
 
 	if (serial_port_in(port, SCSCR) & SCSCR_TE) {
 		do {
@@ -2218,6 +2220,9 @@ static void sci_reset(struct uart_port *port)
 		status &= ~(SCLSR_TO | SCLSR_ORER);
 		serial_port_out(port, SCLSR, status);
 	}
+
+	if (s->rx_trigger > 1)
+		scif_set_rtrg(port, s->rx_trigger);
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
@@ -2728,6 +2733,7 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->overrun_reg = SCLSR;
 		sci_port->overrun_mask = SCLSR_ORER;
 		sci_port->sampling_rate_mask = SCI_SR_RANGE(8, 32);
+		sci_port->rx_trigger = 64;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
@@ -2736,15 +2742,19 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->sampling_rate_mask = SCI_SR_SCIFAB;
 		break;
 	case PORT_SCIF:
-		port->fifosize = 16;
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
+			port->fifosize = 64;
 			sci_port->overrun_reg = SCxSR;
 			sci_port->overrun_mask = SCIFA_ORER;
 			sci_port->sampling_rate_mask = SCI_SR(16);
+			/* RX triggering not implemented for this IP */
+			sci_port->rx_trigger = 1;
 		} else {
+			port->fifosize = 16;
 			sci_port->overrun_reg = SCLSR;
 			sci_port->overrun_mask = SCLSR_ORER;
 			sci_port->sampling_rate_mask = SCI_SR(32);
+			sci_port->rx_trigger = 8;
 		}
 		break;
 	default:
@@ -2752,6 +2762,7 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCI_ORER;
 		sci_port->sampling_rate_mask = SCI_SR(32);
+		sci_port->rx_trigger = 1;
 		break;
 	}
 
-- 
2.7.4
