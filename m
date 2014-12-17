From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/05] serial: sh-sci: Expose default CTS pin
Date: Wed, 17 Dec 2014 21:53:05 +0900
Message-ID: <20141217125305.14480.3038.sendpatchset@w520>
References: <20141217125236.14480.78833.sendpatchset@w520>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141217125236.14480.78833.sendpatchset@w520>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Expose the CTS pin to the ->get_mctrl() callback for the
default case. Without this patch the serial core can not
retrieve the CTS pin state from the SCIF driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/tty/serial/sh-sci.c |   20 +++++++++++++++++++-
 include/linux/serial_sci.h  |    1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

--- 0021/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2014-12-17 18:44:31.000000000 +0900
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
+	return false;
+}
+
 static void sci_init_pins_default(struct uart_port *port, bool hwflow_enabled)
 {
 	struct sci_port *s = to_sci_port(port);
@@ -1227,11 +1238,18 @@ static void sci_set_mctrl(struct uart_po
 
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
--- 0021/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2014-12-17 17:52:55.000000000 +0900
@@ -59,6 +59,7 @@
 #define SCSPTR_RTSIO	(1 << 7)	/* Serial Port RTS Pin Input/Output */
 #define SCSPTR_RTSDT	(1 << 6)	/* Serial Port RTS Pin Data */
 #define SCSPTR_CTSIO	(1 << 5)	/* Serial Port CTS Pin Input/Output */
+#define SCSPTR_CTSDT	(1 << 4)	/* Serial Port CTS Pin Data */
 #define SCSPTR_SPB2IO	(1 << 1)	/* Serial Port Break Input/Output */
 #define SCSPTR_SPB2DT	(1 << 0)	/* Serial Port Break Data */
 
