From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 12/19] serial: sh-sci: Remove initialization of zero fields in sci_port_params
Date: Wed,  4 Jan 2017 01:06:32 +0200
Message-ID: <20170103230639.19660-13-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The compiler zeros uninitialized fields, don't zero them manually.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 94 ---------------------------------------------
 1 file changed, 94 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8c58c43fc85d..3da00f432c73 100644
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
@@ -205,15 +187,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxRDR]	= { 0x05,  8 },
 		[SCFCR]		= { 0x06,  8 },
 		[SCFDR]		= { 0x07, 16 },
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
@@ -228,15 +201,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -250,16 +216,10 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -275,15 +235,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -298,15 +251,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -321,15 +265,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -345,13 +282,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -368,13 +300,9 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -392,15 +320,7 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -420,11 +340,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
@@ -440,15 +355,6 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
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
