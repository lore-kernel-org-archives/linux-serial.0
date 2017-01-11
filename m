From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 11/18] serial: sh-sci: Remove initialization of zero fields in sci_port_params
Date: Wed, 11 Jan 2017 16:43:33 +0200
Message-ID: <20170111144340.29074-12-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The compiler zeros uninitialized fields, don't zero them manually.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 94 ---------------------------------------------
 1 file changed, 94 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 56ad899973d6..b99664046263 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -160,14 +160,7 @@ struct plat_sci_reg {
 	u8 offset, size;
 };
 
-/* Helper for invalidating specific entries of an inherited map. */
-#define sci_reg_invalid	{ .offset = 0, .size = 0 }
-
 static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
-	[SCIx_PROBE_REGTYPE] = {
-		[0 ... SCIx_NR_REGS - 1] = sci_reg_invalid,
-	},
-
 	/*
 	 * Common SCI definitions, dependent on the port's regshift
 	 * value.
@@ -179,17 +172,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxTDR]	= { 0x03,  8 },
 		[SCxSR]		= { 0x04,  8 },
 		[SCxRDR]	= { 0x05,  8 },
-		[SCFCR]		= sci_reg_invalid,
-		[SCFDR]		= sci_reg_invalid,
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
-		[SCSPTR]	= sci_reg_invalid,
-		[SCLSR]		= sci_reg_invalid,
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -204,15 +186,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x0a,  8 },
 		[SCFCR]		= { 0x0c,  8 },
 		[SCFDR]		= { 0x0e, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
-		[SCSPTR]	= sci_reg_invalid,
-		[SCLSR]		= sci_reg_invalid,
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -227,15 +200,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x24,  8 },
 		[SCFCR]		= { 0x18, 16 },
 		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
-		[SCSPTR]	= sci_reg_invalid,
-		[SCLSR]		= sci_reg_invalid,
-		[HSSRR]		= sci_reg_invalid,
 		[SCPCR]		= { 0x30, 16 },
 		[SCPDR]		= { 0x34, 16 },
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -249,16 +215,10 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxSR]		= { 0x14, 16 },
 		[SCxRDR]	= { 0x60,  8 },
 		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= sci_reg_invalid,
 		[SCTFDR]	= { 0x38, 16 },
 		[SCRFDR]	= { 0x3c, 16 },
-		[SCSPTR]	= sci_reg_invalid,
-		[SCLSR]		= sci_reg_invalid,
-		[HSSRR]		= sci_reg_invalid,
 		[SCPCR]		= { 0x30, 16 },
 		[SCPDR]		= { 0x34, 16 },
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -274,15 +234,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x14,  8 },
 		[SCFCR]		= { 0x18, 16 },
 		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -297,15 +250,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x0a,  8 },
 		[SCFCR]		= { 0x0c,  8 },
 		[SCFDR]		= { 0x0e, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
-		[SCSPTR]	= sci_reg_invalid,
-		[SCLSR]		= sci_reg_invalid,
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -320,15 +264,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x14,  8 },
 		[SCFCR]		= { 0x18, 16 },
 		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -344,13 +281,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x14,  8 },
 		[SCFCR]		= { 0x18, 16 },
 		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
 		[SCDL]		= { 0x30, 16 },
 		[SCCKS]		= { 0x34, 16 },
 	},
@@ -367,13 +299,9 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x14,  8 },
 		[SCFCR]		= { 0x18, 16 },
 		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
 		[HSSRR]		= { 0x40, 16 },
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
 		[SCDL]		= { 0x30, 16 },
 		[SCCKS]		= { 0x34, 16 },
 	},
@@ -391,15 +319,7 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x14,  8 },
 		[SCFCR]		= { 0x18, 16 },
 		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
-		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= { 0x24, 16 },
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -419,11 +339,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCRFDR]	= { 0x20, 16 },
 		[SCSPTR]	= { 0x24, 16 },
 		[SCLSR]		= { 0x28, 16 },
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 
 	/*
@@ -439,15 +354,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x24,  8 },
 		[SCFCR]		= { 0x18, 16 },
 		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
-		[SCSPTR]	= sci_reg_invalid,
-		[SCLSR]		= sci_reg_invalid,
-		[HSSRR]		= sci_reg_invalid,
-		[SCPCR]		= sci_reg_invalid,
-		[SCPDR]		= sci_reg_invalid,
-		[SCDL]		= sci_reg_invalid,
-		[SCCKS]		= sci_reg_invalid,
 	},
 };
 
-- 
Regards,

Laurent Pinchart
