From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 04/05] serial: sh-sci: Add SCIFA/SCIFB CTS/RTS pin setup
Date: Thu, 19 Mar 2015 10:50:13 +0900
Message-ID: <20150319015013.14235.74159.sendpatchset@little-apple>
References: <20150319014933.14235.44835.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150319014933.14235.44835.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, geert@glider.be, laurent.pinchart@ideasonboard.com, linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add SCIFA/SCIFB pin setup code for CTS/RTS pins to handle
both cases of hardware flow control enabled or disabled.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Adjusted function name to match with suggestion from Laurent
 - Added bit definitions for SCPCR and SCPDR
 - When modem control is disabled, set RTS to zero to keep it asserted.

 drivers/tty/serial/sh-sci.c |   59 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/serial_sci.h  |    9 ++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

--- 0004/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2015-03-19 09:39:11.836792354 +0900
@@ -168,6 +168,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= sci_reg_invalid,
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -188,6 +190,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= sci_reg_invalid,
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -207,6 +211,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= sci_reg_invalid,
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= { 0x30, 16 },
+		[SCPDR]		= { 0x34, 16 },
 	},
 
 	/*
@@ -226,6 +232,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= sci_reg_invalid,
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= { 0x30, 16 },
+		[SCPDR]		= { 0x34, 16 },
 	},
 
 	/*
@@ -246,6 +254,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -265,6 +275,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= sci_reg_invalid,
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -284,6 +296,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -303,6 +317,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
 		[HSSRR]		= { 0x40, 16 },
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -323,6 +339,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= { 0x24, 16 },
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -343,6 +361,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= { 0x24, 16 },
 		[SCLSR]		= { 0x28, 16 },
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 
 	/*
@@ -363,6 +383,8 @@ static struct plat_sci_reg sci_regmap[SC
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= sci_reg_invalid,
 		[HSSRR]		= sci_reg_invalid,
+		[SCPCR]		= sci_reg_invalid,
+		[SCPDR]		= sci_reg_invalid,
 	},
 };
 
@@ -542,6 +564,34 @@ static void sci_init_ctsrts_default(stru
 	serial_port_out(port, SCSPTR, status); /* Set RTS = 0 */
 }
 
+static void sci_init_ctsrts_scifab(struct uart_port *port, bool hwflow_enabled)
+{
+	unsigned short control, data;
+
+	/* SCIFA/SCIFB CTS/RTS pin configuration depends on user space.
+	 *
+	 * In case of CTS - (SCPDR.CTSD is always accessible):
+	 * - Hardware flow control enabled: "CTS pin function"
+	 * - Hardware flow control disabled: "Input port"
+	 *
+	 * In case of RTS:
+	 * - Hardware flow control enabled: "RTS pin function"
+	 * - Hardware flow control disabled: "Output port" with value 0
+	 */
+	control = serial_port_in(port, SCPCR);
+	data = serial_port_in(port, SCPDR);
+
+	if (hwflow_enabled) {
+		control &= ~(SCPCR_RTSC | SCPCR_CTSC);
+	} else {
+		control |= SCPCR_RTSC | SCPCR_CTSC;
+		data &= ~SCPDR_RTSD;
+	}
+
+	serial_port_out(port, SCPDR, data);
+	serial_port_out(port, SCPCR, control);
+}
+
 static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 {
 	struct sci_port *s = to_sci_port(port);
@@ -568,7 +618,14 @@ static void sci_init_pins(struct uart_po
 	if (!(s->cfg->capabilities & SCIx_HAVE_RTSCTS))
 		return;
 
-	sci_init_ctsrts_default(port, hwflow_enabled);
+	switch (s->cfg->type) {
+	case PORT_SCIFA:
+	case PORT_SCIFB:
+		sci_init_ctsrts_scifab(port, hwflow_enabled);
+		break;
+	default:
+		sci_init_ctsrts_default(port, hwflow_enabled);
+	}
 }
 
 static int sci_txfill(struct uart_port *port)
--- 0004/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2015-03-19 09:41:09.116791933 +0900
@@ -66,6 +66,13 @@
 /* HSSRR HSCIF */
 #define HSCIF_SRE	0x8000		/* Sampling Rate Register Enable */
 
+/* SCPCR (Serial Port Control Register) */
+#define SCPCR_RTSC	(1 << 4)	/* Serial Port RTS Pin / Output Pin */
+#define SCPCR_CTSC	(1 << 3)	/* Serial Port CTS Pin / Input Pin */
+
+/* SCPDR (Serial Port Data Register) */
+#define SCPDR_RTSD	(1 << 4)	/* Serial Port RTS Output Pin Data */
+
 enum {
 	SCIx_PROBE_REGTYPE,
 
@@ -102,6 +109,8 @@ enum {
 	SCRFDR,				/* Receive FIFO Data Count Register */
 	SCSPTR,				/* Serial Port Register */
 	HSSRR,				/* Sampling Rate Register */
+	SCPCR,				/* Serial Port Control Register */
+	SCPDR,				/* Serial Port Data Register */
 
 	SCIx_NR_REGS,
 };
