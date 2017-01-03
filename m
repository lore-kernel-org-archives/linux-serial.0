From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 13/19] serial: sh-sci: Replace regmap array with port parameters
Date: Wed,  4 Jan 2017 01:06:33 +0200
Message-ID: <20170103230639.19660-14-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Turn the regmap two-dimensional array to an array of port parameters and
store a pointer to the port parameters in the sci_port structure. This
will allow handling additional port type dependent parameters.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 278 ++++++++++++++++++++++++--------------------
 1 file changed, 155 insertions(+), 123 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3da00f432c73..be86f78a5c02 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -101,10 +101,19 @@ enum SCI_CLKS {
 	for ((_sr) = max_sr(_port); (_sr) >= min_sr(_port); (_sr)--)	\
 		if ((_port)->sampling_rate_mask & SCI_SR((_sr)))
 
+struct plat_sci_reg {
+	u8 offset, size;
+};
+
+struct sci_port_params {
+	const struct plat_sci_reg regs[SCIx_NR_REGS];
+};
+
 struct sci_port {
 	struct uart_port	port;
 
 	/* Platform configuration */
+	const struct sci_port_params *params;
 	struct plat_sci_port	*cfg;
 	unsigned int		overrun_reg;
 	unsigned int		overrun_mask;
@@ -156,22 +165,20 @@ to_sci_port(struct uart_port *uart)
 	return container_of(uart, struct sci_port, port);
 }
 
-struct plat_sci_reg {
-	u8 offset, size;
-};
-
-static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
+static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	/*
 	 * Common SCI definitions, dependent on the port's regshift
 	 * value.
 	 */
 	[SCIx_SCI_REGTYPE] = {
-		[SCSMR]		= { 0x00,  8 },
-		[SCBRR]		= { 0x01,  8 },
-		[SCSCR]		= { 0x02,  8 },
-		[SCxTDR]	= { 0x03,  8 },
-		[SCxSR]		= { 0x04,  8 },
-		[SCxRDR]	= { 0x05,  8 },
+		.regs = {
+			[SCSMR]		= { 0x00,  8 },
+			[SCBRR]		= { 0x01,  8 },
+			[SCSCR]		= { 0x02,  8 },
+			[SCxTDR]	= { 0x03,  8 },
+			[SCxSR]		= { 0x04,  8 },
+			[SCxRDR]	= { 0x05,  8 },
+		},
 	},
 
 	/*
@@ -179,47 +186,53 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	 * regshift value.
 	 */
 	[SCIx_IRDA_REGTYPE] = {
-		[SCSMR]		= { 0x00,  8 },
-		[SCBRR]		= { 0x01,  8 },
-		[SCSCR]		= { 0x02,  8 },
-		[SCxTDR]	= { 0x03,  8 },
-		[SCxSR]		= { 0x04,  8 },
-		[SCxRDR]	= { 0x05,  8 },
-		[SCFCR]		= { 0x06,  8 },
-		[SCFDR]		= { 0x07, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00,  8 },
+			[SCBRR]		= { 0x01,  8 },
+			[SCSCR]		= { 0x02,  8 },
+			[SCxTDR]	= { 0x03,  8 },
+			[SCxSR]		= { 0x04,  8 },
+			[SCxRDR]	= { 0x05,  8 },
+			[SCFCR]		= { 0x06,  8 },
+			[SCFDR]		= { 0x07, 16 },
+		},
 	},
 
 	/*
 	 * Common SCIFA definitions.
 	 */
 	[SCIx_SCIFA_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x20,  8 },
-		[SCxSR]		= { 0x14, 16 },
-		[SCxRDR]	= { 0x24,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCPCR]		= { 0x30, 16 },
-		[SCPDR]		= { 0x34, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x20,  8 },
+			[SCxSR]		= { 0x14, 16 },
+			[SCxRDR]	= { 0x24,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCPCR]		= { 0x30, 16 },
+			[SCPDR]		= { 0x34, 16 },
+		},
 	},
 
 	/*
 	 * Common SCIFB definitions.
 	 */
 	[SCIx_SCIFB_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x40,  8 },
-		[SCxSR]		= { 0x14, 16 },
-		[SCxRDR]	= { 0x60,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCTFDR]	= { 0x38, 16 },
-		[SCRFDR]	= { 0x3c, 16 },
-		[SCPCR]		= { 0x30, 16 },
-		[SCPDR]		= { 0x34, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x40,  8 },
+			[SCxSR]		= { 0x14, 16 },
+			[SCxRDR]	= { 0x60,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCTFDR]	= { 0x38, 16 },
+			[SCRFDR]	= { 0x3c, 16 },
+			[SCPCR]		= { 0x30, 16 },
+			[SCPDR]		= { 0x34, 16 },
+		},
 	},
 
 	/*
@@ -227,46 +240,52 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	 * count registers.
 	 */
 	[SCIx_SH2_SCIF_FIFODATA_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x0c,  8 },
-		[SCxSR]		= { 0x10, 16 },
-		[SCxRDR]	= { 0x14,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCSPTR]	= { 0x20, 16 },
-		[SCLSR]		= { 0x24, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x0c,  8 },
+			[SCxSR]		= { 0x10, 16 },
+			[SCxRDR]	= { 0x14,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCSPTR]	= { 0x20, 16 },
+			[SCLSR]		= { 0x24, 16 },
+		},
 	},
 
 	/*
 	 * Common SH-3 SCIF definitions.
 	 */
 	[SCIx_SH3_SCIF_REGTYPE] = {
-		[SCSMR]		= { 0x00,  8 },
-		[SCBRR]		= { 0x02,  8 },
-		[SCSCR]		= { 0x04,  8 },
-		[SCxTDR]	= { 0x06,  8 },
-		[SCxSR]		= { 0x08, 16 },
-		[SCxRDR]	= { 0x0a,  8 },
-		[SCFCR]		= { 0x0c,  8 },
-		[SCFDR]		= { 0x0e, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00,  8 },
+			[SCBRR]		= { 0x02,  8 },
+			[SCSCR]		= { 0x04,  8 },
+			[SCxTDR]	= { 0x06,  8 },
+			[SCxSR]		= { 0x08, 16 },
+			[SCxRDR]	= { 0x0a,  8 },
+			[SCFCR]		= { 0x0c,  8 },
+			[SCFDR]		= { 0x0e, 16 },
+		},
 	},
 
 	/*
 	 * Common SH-4(A) SCIF(B) definitions.
 	 */
 	[SCIx_SH4_SCIF_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x0c,  8 },
-		[SCxSR]		= { 0x10, 16 },
-		[SCxRDR]	= { 0x14,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCSPTR]	= { 0x20, 16 },
-		[SCLSR]		= { 0x24, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x0c,  8 },
+			[SCxSR]		= { 0x10, 16 },
+			[SCxRDR]	= { 0x14,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCSPTR]	= { 0x20, 16 },
+			[SCLSR]		= { 0x24, 16 },
+		},
 	},
 
 	/*
@@ -274,37 +293,41 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	 * External Clock (BRG).
 	 */
 	[SCIx_SH4_SCIF_BRG_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x0c,  8 },
-		[SCxSR]		= { 0x10, 16 },
-		[SCxRDR]	= { 0x14,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCSPTR]	= { 0x20, 16 },
-		[SCLSR]		= { 0x24, 16 },
-		[SCDL]		= { 0x30, 16 },
-		[SCCKS]		= { 0x34, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x0c,  8 },
+			[SCxSR]		= { 0x10, 16 },
+			[SCxRDR]	= { 0x14,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCSPTR]	= { 0x20, 16 },
+			[SCLSR]		= { 0x24, 16 },
+			[SCDL]		= { 0x30, 16 },
+			[SCCKS]		= { 0x34, 16 },
+		},
 	},
 
 	/*
 	 * Common HSCIF definitions.
 	 */
 	[SCIx_HSCIF_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x0c,  8 },
-		[SCxSR]		= { 0x10, 16 },
-		[SCxRDR]	= { 0x14,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCSPTR]	= { 0x20, 16 },
-		[SCLSR]		= { 0x24, 16 },
-		[HSSRR]		= { 0x40, 16 },
-		[SCDL]		= { 0x30, 16 },
-		[SCCKS]		= { 0x34, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x0c,  8 },
+			[SCxSR]		= { 0x10, 16 },
+			[SCxRDR]	= { 0x14,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCSPTR]	= { 0x20, 16 },
+			[SCLSR]		= { 0x24, 16 },
+			[HSSRR]		= { 0x40, 16 },
+			[SCDL]		= { 0x30, 16 },
+			[SCCKS]		= { 0x34, 16 },
+		},
 	},
 
 	/*
@@ -312,15 +335,17 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	 * register.
 	 */
 	[SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x0c,  8 },
-		[SCxSR]		= { 0x10, 16 },
-		[SCxRDR]	= { 0x14,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCLSR]		= { 0x24, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x0c,  8 },
+			[SCxSR]		= { 0x10, 16 },
+			[SCxRDR]	= { 0x14,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCLSR]		= { 0x24, 16 },
+		},
 	},
 
 	/*
@@ -328,18 +353,20 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	 * count registers.
 	 */
 	[SCIx_SH4_SCIF_FIFODATA_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x0c,  8 },
-		[SCxSR]		= { 0x10, 16 },
-		[SCxRDR]	= { 0x14,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= { 0x1c, 16 },	/* aliased to SCFDR */
-		[SCRFDR]	= { 0x20, 16 },
-		[SCSPTR]	= { 0x24, 16 },
-		[SCLSR]		= { 0x28, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x0c,  8 },
+			[SCxSR]		= { 0x10, 16 },
+			[SCxRDR]	= { 0x14,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+			[SCTFDR]	= { 0x1c, 16 },	/* aliased to SCFDR */
+			[SCRFDR]	= { 0x20, 16 },
+			[SCSPTR]	= { 0x24, 16 },
+			[SCLSR]		= { 0x28, 16 },
+		},
 	},
 
 	/*
@@ -347,18 +374,20 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	 * registers.
 	 */
 	[SCIx_SH7705_SCIF_REGTYPE] = {
-		[SCSMR]		= { 0x00, 16 },
-		[SCBRR]		= { 0x04,  8 },
-		[SCSCR]		= { 0x08, 16 },
-		[SCxTDR]	= { 0x20,  8 },
-		[SCxSR]		= { 0x14, 16 },
-		[SCxRDR]	= { 0x24,  8 },
-		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x04,  8 },
+			[SCSCR]		= { 0x08, 16 },
+			[SCxTDR]	= { 0x20,  8 },
+			[SCxSR]		= { 0x14, 16 },
+			[SCxRDR]	= { 0x24,  8 },
+			[SCFCR]		= { 0x18, 16 },
+			[SCFDR]		= { 0x1c, 16 },
+		},
 	},
 };
 
-#define sci_getreg(up, offset)		(sci_regmap[to_sci_port(up)->cfg->regtype] + offset)
+#define sci_getreg(up, offset)		(&to_sci_port(up)->params->regs[offset])
 
 /*
  * The "offset" here is rather misleading, in that it refers to an enum
@@ -2556,6 +2585,8 @@ static int sci_init_single(struct platform_device *dev,
 			return ret;
 	}
 
+	sci_port->params = &sci_port_params[p->regtype];
+
 	switch (p->type) {
 	case PORT_SCIFB:
 		port->fifosize = 256;
@@ -3068,6 +3099,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].cfg->type = type;
 	sci_probe_regmap(sci_ports[0].cfg);
+	sci_ports[0].params = &sci_port_params[sci_ports[0].cfg->regtype];
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
-- 
Regards,

Laurent Pinchart
