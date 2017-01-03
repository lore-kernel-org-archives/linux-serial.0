From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 19/19] serial: sh-sci: Compute the regshift value for SCI ports
Date: Wed,  4 Jan 2017 01:06:39 +0200
Message-ID: <20170103230639.19660-20-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

SCI instances found in SH SoCs have different spacing between registers
depending on the SoC. The platform data contains a regshift field that
tells the driver by how many bits to shift the register offset to
compute its address. We can compute the regshift value automatically
based on the memory resource size, there's no need to pass the value
through platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 25 +++++++++++++++----------
 include/linux/serial_sci.h  |  1 -
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5fc2606fc525..fbffe89b493f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -187,19 +187,18 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	},
 
 	/*
-	 * Common definitions for legacy IrDA ports, dependent on
-	 * regshift value.
+	 * Common definitions for legacy IrDA ports.
 	 */
 	[SCIx_IRDA_REGTYPE] = {
 		.regs = {
 			[SCSMR]		= { 0x00,  8 },
-			[SCBRR]		= { 0x01,  8 },
-			[SCSCR]		= { 0x02,  8 },
-			[SCxTDR]	= { 0x03,  8 },
-			[SCxSR]		= { 0x04,  8 },
-			[SCxRDR]	= { 0x05,  8 },
-			[SCFCR]		= { 0x06,  8 },
-			[SCFDR]		= { 0x07, 16 },
+			[SCBRR]		= { 0x02,  8 },
+			[SCSCR]		= { 0x04,  8 },
+			[SCxTDR]	= { 0x06,  8 },
+			[SCxSR]		= { 0x08, 16 },
+			[SCxRDR]	= { 0x0a,  8 },
+			[SCFCR]		= { 0x0c,  8 },
+			[SCFDR]		= { 0x0e, 16 },
 		},
 		.fifosize = 1,
 		.overrun_reg = SCxSR,
@@ -2573,9 +2572,15 @@ static int sci_init_single(struct platform_device *dev,
 
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
-	port->regshift		= p->regshift;
 	port->fifosize		= sci_port->params->fifosize;
 
+	if (port->type == PORT_SCI) {
+		if (sci_port->reg_size >= 0x20)
+			port->regshift = 2;
+		else
+			port->regshift = 1;
+	}
+
 	/*
 	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
 	 * for the multi-IRQ ports, which is where we are primarily
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index f9a4526f4ec5..e598eaef3962 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -56,7 +56,6 @@ struct plat_sci_port {
 	/*
 	 * Platform overrides if necessary, defaults otherwise.
 	 */
-	unsigned char	regshift;
 	unsigned char	regtype;
 
 	struct plat_sci_port_ops	*ops;
-- 
Regards,

Laurent Pinchart
