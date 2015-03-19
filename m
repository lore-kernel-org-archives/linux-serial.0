From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 03/05] serial: sh-sci: Expose default CTS pin
Date: Thu, 19 Mar 2015 10:50:03 +0900
Message-ID: <20150319015003.14235.67489.sendpatchset@little-apple>
References: <20150319014933.14235.44835.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150319014933.14235.44835.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, geert@glider.be, laurent.pinchart@ideasonboard.com, linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Expose the CTS pin to the ->get_mctrl() callback for the
default case. Without this patch the serial core can not
retrieve the CTS pin state from the SCIF driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Return true to default to asserted state in case modem signals exist

 drivers/tty/serial/sh-sci.c |   20 +++++++++++++++++++-
 include/linux/serial_sci.h  |    1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

--- 0003/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2015-03-19 09:17:37.856797004 +0900
@@ -509,6 +509,17 @@ static void sci_poll_put_char(struct uar
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
 
+static bool sci_cts_asserted_default(struct uart_port *port)
+{
+	struct sci_port *s = to_sci_port(port);
+	struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
+
+	if (reg->size)
+		return !(serial_port_in(port, SCSPTR) & SCSPTR_CTSDT);
+
+	return true;
+}
+
 static void sci_init_ctsrts_default(struct uart_port *port, bool hwflow_enabled)
 {
 	struct sci_port *s = to_sci_port(port);
@@ -1239,11 +1250,18 @@ static void sci_set_mctrl(struct uart_po
 
 static unsigned int sci_get_mctrl(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
+	bool cts_asserted = false;
+
 	/*
 	 * CTS/RTS is handled in hardware when supported, while nothing
 	 * else is wired up. Keep it simple and simply assert DSR/CAR.
 	 */
-	return TIOCM_DSR | TIOCM_CAR;
+
+	if (s->cfg->capabilities & SCIx_HAVE_RTSCTS)
+		cts_asserted = sci_cts_asserted_default(port);
+
+	return TIOCM_DSR | TIOCM_CAR | (cts_asserted ? TIOCM_CTS : 0);
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
--- 0003/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2015-03-19 09:15:59.446797358 +0900
@@ -59,6 +59,7 @@
 #define SCSPTR_RTSIO	(1 << 7)	/* Serial Port RTS Pin Input/Output */
 #define SCSPTR_RTSDT	(1 << 6)	/* Serial Port RTS Pin Data */
 #define SCSPTR_CTSIO	(1 << 5)	/* Serial Port CTS Pin Input/Output */
+#define SCSPTR_CTSDT	(1 << 4)	/* Serial Port CTS Pin Data */
 #define SCSPTR_SPB2IO	(1 << 1)	/* Serial Port Break Input/Output */
 #define SCSPTR_SPB2DT	(1 << 0)	/* Serial Port Break Data */
 
