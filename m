From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v1.1 08/19] serial: sh-sci: Fix register offsets for the IRDA serial port
Date: Fri,  6 Jan 2017 13:52:35 +0200
Message-ID: <20170106115235.3919-1-laurent.pinchart+renesas@ideasonboard.com>
References: <CAMuHMdVzm4D=Pdd6PoGzXUoO8Va4g1Y5KncaRS19PnSeGUn9Gw@mail.gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVzm4D=Pdd6PoGzXUoO8Va4g1Y5KncaRS19PnSeGUn9Gw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Even though most of its registers are 8-bit wide, the IRDA has two
16-bit registers that make it a 16-bit peripheral and not a 8-bit
peripheral with addresses shifted by one. Fix the registers offset in
the driver and the platform data regshift value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |  1 -
 drivers/tty/serial/sh-sci.c           | 17 ++++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index e1e54258b822..592cd9ab30c4 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -157,7 +157,6 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.type		= PORT_IRDA,
 	.ops		= &sh770x_sci_port_ops,
-	.regshift	= 1,
 };
 
 static struct resource scif2_resources[] = {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8c58c43fc85d..1eb91ba43b2e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -193,18 +193,17 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	},
 
 	/*
-	 * Common definitions for legacy IrDA ports, dependent on
-	 * regshift value.
+	 * Common definitions for legacy IrDA ports.
 	 */
 	[SCIx_IRDA_REGTYPE] = {
 		[SCSMR]		= { 0x00,  8 },
-		[SCBRR]		= { 0x01,  8 },
-		[SCSCR]		= { 0x02,  8 },
-		[SCxTDR]	= { 0x03,  8 },
-		[SCxSR]		= { 0x04,  8 },
-		[SCxRDR]	= { 0x05,  8 },
-		[SCFCR]		= { 0x06,  8 },
-		[SCFDR]		= { 0x07, 16 },
+		[SCBRR]		= { 0x02,  8 },
+		[SCSCR]		= { 0x04,  8 },
+		[SCxTDR]	= { 0x06,  8 },
+		[SCxSR]		= { 0x08,  8 },
+		[SCxRDR]	= { 0x0a,  8 },
+		[SCFCR]		= { 0x0c,  8 },
+		[SCFDR]		= { 0x0e, 16 },
 		[SCTFDR]	= sci_reg_invalid,
 		[SCRFDR]	= sci_reg_invalid,
 		[SCSPTR]	= sci_reg_invalid,
-- 
Regards,

Laurent Pinchart
