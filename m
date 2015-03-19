From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 05/05] serial: sh-sci: Expose SCIFA/SCIFB CTS pin
Date: Thu, 19 Mar 2015 10:50:23 +0900
Message-ID: <20150319015023.14235.86850.sendpatchset@little-apple>
References: <20150319014933.14235.44835.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150319014933.14235.44835.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, geert@glider.be, laurent.pinchart@ideasonboard.com, linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Expose CTS pin to serial core for the SCIFA/SCIFB case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Added bit definition for SCPDR_CTSD

drivers/tty/serial/sh-sci.c |   17 +++++++++++++++--
 include/linux/serial_sci.h  |    1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

--- 0005/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2015-03-19 09:57:43.266788360 +0900
@@ -564,6 +564,11 @@ static void sci_init_ctsrts_default(stru
 	serial_port_out(port, SCSPTR, status); /* Set RTS = 0 */
 }
 
+static bool sci_cts_asserted_scifab(struct uart_port *port)
+{
+	return !(serial_port_in(port, SCPDR) & SCPDR_CTSD);
+}
+
 static void sci_init_ctsrts_scifab(struct uart_port *port, bool hwflow_enabled)
 {
 	unsigned short control, data;
@@ -1315,8 +1320,16 @@ static unsigned int sci_get_mctrl(struct
 	 * else is wired up. Keep it simple and simply assert DSR/CAR.
 	 */
 
-	if (s->cfg->capabilities & SCIx_HAVE_RTSCTS)
-		cts_asserted = sci_cts_asserted_default(port);
+	if (s->cfg->capabilities & SCIx_HAVE_RTSCTS) {
+		switch (s->cfg->type) {
+		case PORT_SCIFA:
+		case PORT_SCIFB:
+			cts_asserted = sci_cts_asserted_scifab(port);
+			break;
+		default:
+			cts_asserted = sci_cts_asserted_default(port);
+		}
+	}
 
 	return TIOCM_DSR | TIOCM_CAR | (cts_asserted ? TIOCM_CTS : 0);
 }
--- 0005/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2015-03-19 09:52:14.846789540 +0900
@@ -72,6 +72,7 @@
 
 /* SCPDR (Serial Port Data Register) */
 #define SCPDR_RTSD	(1 << 4)	/* Serial Port RTS Output Pin Data */
+#define SCPDR_CTSD	(1 << 3)	/* Serial Port CTS Input Pin Data */
 
 enum {
 	SCIx_PROBE_REGTYPE,
