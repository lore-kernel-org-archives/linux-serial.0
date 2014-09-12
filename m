From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC 2/3] serial: sh-sci: exploit RX FIFOs better
Date: Fri, 12 Sep 2014 10:51:47 +0200
Message-ID: <1410511908-9282-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
Cc: horms@verge.net.au, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Trigger interrupts at higher FIFO fill levels to reduce load.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/sh-sci.h |  4 +++
 include/linux/serial_sci.h  |  2 ++
 3 files changed, 74 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f0ff8a7..78aeec1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -120,6 +120,7 @@ struct sci_port {
 #endif
 
 	struct notifier_block		freq_transition;
+	int				rx_trigger;
 };
 
 /* Function prototypes */
@@ -303,6 +304,8 @@ static struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCSPTR]	= { 0x20, 16 },
 		[SCLSR]		= { 0x24, 16 },
 		[HSSRR]		= { 0x40, 16 },
+		[HSRTRGR]	= { 0x54, 16 },
+		[HSTTRGR]	= { 0x58, 16 },
 	},
 
 	/*
@@ -1854,6 +1857,62 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
 	}
 }
 
+/* Set Rx FIFO interrupt trigger level after clamping it to a supported
+ * value.
+ */
+static void scif_set_rtrg(struct uart_port *port)
+{
+	unsigned int bits;
+	struct sci_port *sci = to_sci_port(port);
+
+	if (sci->rx_trigger < 1)
+		sci->rx_trigger = 1;
+	if (sci->rx_trigger >= port->fifosize)
+		sci->rx_trigger = port->fifosize;
+
+	/* HSCIF can be set to an arbitrary level. */
+	if (sci_getreg(port, HSRTRGR)->size) {
+		serial_port_out(port, HSRTRGR, sci->rx_trigger);
+		return;
+	}
+
+	if (port->fifosize == 16) {
+		/* SCIF */
+		if (sci->rx_trigger < 4) {
+			bits = 0;
+			sci->rx_trigger = 1;
+		} else if (sci->rx_trigger < 8) {
+			bits = SCFCR_RTRG0;
+			sci->rx_trigger = 4;
+		} else if (sci->rx_trigger < 14) {
+			bits = SCFCR_RTRG1;
+			sci->rx_trigger = 8;
+		} else {
+			bits = SCFCR_RTRG0 | SCFCR_RTRG1;
+			sci->rx_trigger = 14;
+		}
+	} else if (port->fifosize == 64 || port->fifosize == 256) {
+		/* SCIFA/B */
+		if (sci->rx_trigger < 16) {
+			bits = 0;
+			sci->rx_trigger = 1;
+		} else if (sci->rx_trigger < 32) {
+			bits = SCFCR_RTRG0;
+			sci->rx_trigger = 16;
+		} else if (sci->rx_trigger < 48) {
+			bits = SCFCR_RTRG1;
+			sci->rx_trigger = 32;
+		} else {
+			bits = SCFCR_RTRG0 | SCFCR_RTRG1;
+			sci->rx_trigger = 48;
+		}
+	} else {
+		BUG();
+	}
+
+	serial_port_out(port, SCFCR, serial_port_in(port, SCFCR) | bits);
+}
+
 static void sci_reset(struct uart_port *port)
 {
 	struct plat_sci_reg *reg;
@@ -1868,6 +1927,10 @@ static void sci_reset(struct uart_port *port)
 	reg = sci_getreg(port, SCFCR);
 	if (reg->size)
 		serial_port_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
+
+	if (port->fifosize > 1) {
+		scif_set_rtrg(port);
+	}
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
@@ -2180,21 +2243,25 @@ static int sci_init_single(struct platform_device *dev,
 	switch (p->type) {
 	case PORT_SCIFB:
 		port->fifosize = 256;
+		sci_port->rx_trigger = 48;
 		sci_port->overrun_bit = 9;
 		sampling_rate = 16;
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
 		sampling_rate = 0;
+		sci_port->rx_trigger = 64;
 		sci_port->overrun_bit = 0;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
+		sci_port->rx_trigger = 32;
 		sci_port->overrun_bit = 9;
 		sampling_rate = 16;
 		break;
 	case PORT_SCIF:
 		port->fifosize = 16;
+		sci_port->rx_trigger = 8;
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
 			sci_port->overrun_bit = 9;
 			sampling_rate = 16;
@@ -2205,6 +2272,7 @@ static int sci_init_single(struct platform_device *dev,
 		break;
 	default:
 		port->fifosize = 1;
+		sci_port->rx_trigger = 1;
 		sci_port->overrun_bit = 5;
 		sampling_rate = 32;
 		break;
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 9c4598d..db89635 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -34,6 +34,10 @@
 #define SCFCR_RFRST 0x0002
 #define SCFCR_TFRST 0x0004
 #define SCFCR_MCE   0x0008
+#define SCFCR_TTRG0 0x0010
+#define SCFCR_TTRG1 0x0020
+#define SCFCR_RTRG0 0x0040
+#define SCFCR_RTRG1 0x0080
 
 #define SCI_MAJOR		204
 #define SCI_MINOR_START		8
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 6c5e3bb..95f3a04 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -100,6 +100,8 @@ enum {
 	SCRFDR,				/* Receive FIFO Data Count Register */
 	SCSPTR,				/* Serial Port Register */
 	HSSRR,				/* Sampling Rate Register */
+	HSRTRGR,			/* Receive FIFO data count trigger */
+	HSTTRGR,			/* Transmit FIFO data count trigger */
 
 	SCIx_NR_REGS,
 };
-- 
1.8.4.5

