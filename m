From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 01/13] serial: sh-sci: Move private definitions to private header file
Date: Thu, 30 Apr 2015 18:21:25 +0200
Message-ID: <1430410897-12770-2-git-send-email-geert+renesas@glider.be>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Move private register definitions and enums from the public
<linux/serial_sci.h> header file to the driver private "sh-sci.h" header
file.

The common Serial Control Register definitions are left in the public
header file, as they're needed to fill in plat_sci_port.scscr on legacy
systems not using DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.h | 83 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/serial_sci.h  | 67 +-----------------------------------
 2 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 3507174045070511..238ad0c5584b06f2 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -2,6 +2,82 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
+#define SCI_MAJOR		204
+#define SCI_MINOR_START		8
+
+
+/*
+ * SCI register subset common for all port types.
+ * Not all registers will exist on all parts.
+ */
+enum {
+	SCSMR,				/* Serial Mode Register */
+	SCBRR,				/* Bit Rate Register */
+	SCSCR,				/* Serial Control Register */
+	SCxSR,				/* Serial Status Register */
+	SCFCR,				/* FIFO Control Register */
+	SCFDR,				/* FIFO Data Count Register */
+	SCxTDR,				/* Transmit (FIFO) Data Register */
+	SCxRDR,				/* Receive (FIFO) Data Register */
+	SCLSR,				/* Line Status Register */
+	SCTFDR,				/* Transmit FIFO Data Count Register */
+	SCRFDR,				/* Receive FIFO Data Count Register */
+	SCSPTR,				/* Serial Port Register */
+	HSSRR,				/* Sampling Rate Register */
+
+	SCIx_NR_REGS,
+};
+
+
+/* SCSMR (Serial Mode Register) */
+#define SCSMR_CHR	(1 << 6)	/* 7-bit Character Length */
+#define SCSMR_PE	(1 << 5)	/* Parity Enable */
+#define SCSMR_ODD	(1 << 4)	/* Odd Parity */
+#define SCSMR_STOP	(1 << 3)	/* Stop Bit Length */
+#define SCSMR_CKS	0x0003		/* Clock Select */
+
+/* Serial Control Register, SCIFA/SCIFB only bits */
+#define SCSCR_TDRQE	(1 << 15)	/* Tx Data Transfer Request Enable */
+#define SCSCR_RDRQE	(1 << 14)	/* Rx Data Transfer Request Enable */
+
+/* SCxSR (Serial Status Register) on SCI */
+#define SCI_TDRE  0x80			/* Transmit Data Register Empty */
+#define SCI_RDRF  0x40			/* Receive Data Register Full */
+#define SCI_ORER  0x20			/* Overrun Error */
+#define SCI_FER   0x10			/* Framing Error */
+#define SCI_PER   0x08			/* Parity Error */
+#define SCI_TEND  0x04			/* Transmit End */
+
+#define SCI_DEFAULT_ERROR_MASK (SCI_PER | SCI_FER)
+
+/* SCxSR (Serial Status Register) on SCIF, HSCIF */
+#define SCIF_ER    0x0080		/* Receive Error */
+#define SCIF_TEND  0x0040		/* Transmission End */
+#define SCIF_TDFE  0x0020		/* Transmit FIFO Data Empty */
+#define SCIF_BRK   0x0010		/* Break Detect */
+#define SCIF_FER   0x0008		/* Framing Error */
+#define SCIF_PER   0x0004		/* Parity Error */
+#define SCIF_RDF   0x0002		/* Receive FIFO Data Full */
+#define SCIF_DR    0x0001		/* Receive Data Ready */
+
+#define SCIF_DEFAULT_ERROR_MASK (SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK)
+
+/* SCFCR (FIFO Control Register) */
+#define SCFCR_MCE	0x0008
+#define SCFCR_TFRST	0x0004
+#define SCFCR_RFRST	0x0002
+#define SCFCR_LOOP	(1 << 0)	/* Loopback Test */
+
+/* SCSPTR (Serial Port Register), optional */
+#define SCSPTR_RTSIO	(1 << 7)	/* Serial Port RTS Pin Input/Output */
+#define SCSPTR_CTSIO	(1 << 5)	/* Serial Port CTS Pin Input/Output */
+#define SCSPTR_SPB2IO	(1 << 1)	/* Serial Port Break Input/Output */
+#define SCSPTR_SPB2DT	(1 << 0)	/* Serial Port Break Data */
+
+/* HSSRR HSCIF */
+#define HSCIF_SRE	0x8000		/* Sampling Rate Register Enable */
+
+
 #define SCxSR_TEND(port)	(((port)->type == PORT_SCI) ? SCI_TEND   : SCIF_TEND)
 #define SCxSR_RDxF(port)	(((port)->type == PORT_SCI) ? SCI_RDRF   : SCIF_RDF)
 #define SCxSR_TDxE(port)	(((port)->type == PORT_SCI) ? SCI_TDRE   : SCIF_TDFE)
@@ -28,10 +104,3 @@
 # define SCxSR_BREAK_CLEAR(port) (((port)->type == PORT_SCI) ? 0xc4 : 0x00e3)
 #endif
 
-/* SCFCR */
-#define SCFCR_RFRST 0x0002
-#define SCFCR_TFRST 0x0004
-#define SCFCR_MCE   0x0008
-
-#define SCI_MAJOR		204
-#define SCI_MINOR_START		8
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 6c5e3bb282b005b5..395fceb8c0600988 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -10,13 +10,6 @@
 
 #define SCIx_NOT_SUPPORTED	(-1)
 
-/* SCSMR (Serial Mode Register) */
-#define SCSMR_CHR	(1 << 6)	/* 7-bit Character Length */
-#define SCSMR_PE	(1 << 5)	/* Parity Enable */
-#define SCSMR_ODD	(1 << 4)	/* Odd Parity */
-#define SCSMR_STOP	(1 << 3)	/* Stop Bit Length */
-#define SCSMR_CKS	0x0003		/* Clock Select */
-
 /* Serial Control Register (@ = not supported by all parts) */
 #define SCSCR_TIE	(1 << 7)	/* Transmit Interrupt Enable */
 #define SCSCR_RIE	(1 << 6)	/* Receive Interrupt Enable */
@@ -26,43 +19,7 @@
 #define SCSCR_TOIE	(1 << 2)	/* Timeout Interrupt Enable @ */
 #define SCSCR_CKE1	(1 << 1)	/* Clock Enable 1 */
 #define SCSCR_CKE0	(1 << 0)	/* Clock Enable 0 */
-/* SCIFA/SCIFB only */
-#define SCSCR_TDRQE	(1 << 15)	/* Tx Data Transfer Request Enable */
-#define SCSCR_RDRQE	(1 << 14)	/* Rx Data Transfer Request Enable */
-
-/* SCxSR (Serial Status Register) on SCI */
-#define SCI_TDRE  0x80			/* Transmit Data Register Empty */
-#define SCI_RDRF  0x40			/* Receive Data Register Full */
-#define SCI_ORER  0x20			/* Overrun Error */
-#define SCI_FER   0x10			/* Framing Error */
-#define SCI_PER   0x08			/* Parity Error */
-#define SCI_TEND  0x04			/* Transmit End */
-
-#define SCI_DEFAULT_ERROR_MASK (SCI_PER | SCI_FER)
-
-/* SCxSR (Serial Status Register) on SCIF, HSCIF */
-#define SCIF_ER    0x0080		/* Receive Error */
-#define SCIF_TEND  0x0040		/* Transmission End */
-#define SCIF_TDFE  0x0020		/* Transmit FIFO Data Empty */
-#define SCIF_BRK   0x0010		/* Break Detect */
-#define SCIF_FER   0x0008		/* Framing Error */
-#define SCIF_PER   0x0004		/* Parity Error */
-#define SCIF_RDF   0x0002		/* Receive FIFO Data Full */
-#define SCIF_DR    0x0001		/* Receive Data Ready */
-
-#define SCIF_DEFAULT_ERROR_MASK (SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK)
-
-/* SCFCR (FIFO Control Register) */
-#define SCFCR_LOOP	(1 << 0)	/* Loopback Test */
-
-/* SCSPTR (Serial Port Register), optional */
-#define SCSPTR_RTSIO	(1 << 7)	/* Serial Port RTS Pin Input/Output */
-#define SCSPTR_CTSIO	(1 << 5)	/* Serial Port CTS Pin Input/Output */
-#define SCSPTR_SPB2IO	(1 << 1)	/* Serial Port Break Input/Output */
-#define SCSPTR_SPB2DT	(1 << 0)	/* Serial Port Break Data */
-
-/* HSSRR HSCIF */
-#define HSCIF_SRE	0x8000		/* Sampling Rate Register Enable */
+
 
 enum {
 	SCIx_PROBE_REGTYPE,
@@ -82,28 +39,6 @@ enum {
 	SCIx_NR_REGTYPES,
 };
 
-/*
- * SCI register subset common for all port types.
- * Not all registers will exist on all parts.
- */
-enum {
-	SCSMR,				/* Serial Mode Register */
-	SCBRR,				/* Bit Rate Register */
-	SCSCR,				/* Serial Control Register */
-	SCxSR,				/* Serial Status Register */
-	SCFCR,				/* FIFO Control Register */
-	SCFDR,				/* FIFO Data Count Register */
-	SCxTDR,				/* Transmit (FIFO) Data Register */
-	SCxRDR,				/* Receive (FIFO) Data Register */
-	SCLSR,				/* Line Status Register */
-	SCTFDR,				/* Transmit FIFO Data Count Register */
-	SCRFDR,				/* Receive FIFO Data Count Register */
-	SCSPTR,				/* Serial Port Register */
-	HSSRR,				/* Sampling Rate Register */
-
-	SCIx_NR_REGS,
-};
-
 struct device;
 
 struct plat_sci_port_ops {
-- 
1.9.1

