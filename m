From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v4 1/4] serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
Date: Fri,  3 Feb 2017 11:38:17 +0100
Message-ID: <1486118300-12633-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, gregkh@linuxfoundation.org
Cc: wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Sets reasonable trigger defaults for the various SCIF variants.
Also corrects the FIFO size for SH7705-style ports.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 050d028..520e344 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -148,6 +148,7 @@ struct sci_port {
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
 #endif
+	int				rx_trigger;
 
 	bool has_rtscts;
 	bool autorts;
@@ -450,7 +451,7 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCFCR]		= { 0x18, 16 },
 			[SCFDR]		= { 0x1c, 16 },
 		},
-		.fifosize = 16,
+		.fifosize = 64,
 		.overrun_reg = SCxSR,
 		.overrun_mask = SCIFA_ORER,
 		.sampling_rate_mask = SCI_SR(16),
@@ -2062,6 +2063,7 @@ static void sci_reset(struct uart_port *port)
 {
 	const struct plat_sci_reg *reg;
 	unsigned int status;
+	struct sci_port *s = to_sci_port(port);
 
 	do {
 		status = serial_port_in(port, SCxSR);
@@ -2081,6 +2083,9 @@ static void sci_reset(struct uart_port *port)
 		status &= ~(SCLSR_TO | SCLSR_ORER);
 		serial_port_out(port, SCLSR, status);
 	}
+
+	if (s->rx_trigger > 1)
+		scif_set_rtrg(port, s->rx_trigger);
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
@@ -2615,6 +2620,28 @@ static int sci_init_single(struct platform_device *dev,
 	if (unlikely(sci_port->params == NULL))
 		return -EINVAL;
 
+	switch (p->type) {
+	case PORT_SCIFB:
+		sci_port->rx_trigger = 48;
+		break;
+	case PORT_HSCIF:
+		sci_port->rx_trigger = 64;
+		break;
+	case PORT_SCIFA:
+		sci_port->rx_trigger = 32;
+		break;
+	case PORT_SCIF:
+		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE)
+			/* RX triggering not implemented for this IP */
+			sci_port->rx_trigger = 1;
+		else
+			sci_port->rx_trigger = 8;
+		break;
+	default:
+		sci_port->rx_trigger = 1;
+		break;
+	}
+
 	/* SCIFA on sh7723 and sh7724 need a custom sampling rate that doesn't
 	 * match the SoC datasheet, this should be investigated. Let platform
 	 * data override the sampling rate for now.
-- 
2.7.4
