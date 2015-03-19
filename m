From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 01/05] serial: sh-sci: Break out default CTS/RTS pin setup
Date: Thu, 19 Mar 2015 10:49:43 +0900
Message-ID: <20150319014943.14235.12896.sendpatchset@little-apple>
References: <20150319014933.14235.44835.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150319014933.14235.44835.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, geert@glider.be, laurent.pinchart@ideasonboard.com, linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Break out CTS/RTS pin setup for the default case. We only
care about those pins in case SCIx_HAVE_RTSCTS is set.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Function name change, thanks Laurent!

 drivers/tty/serial/sh-sci.c |   45 +++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

--- 0001/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2015-03-19 09:07:40.616799151 +0900
@@ -509,10 +509,29 @@ static void sci_poll_put_char(struct uar
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
 
-static void sci_init_pins(struct uart_port *port, unsigned int cflag)
+static void sci_init_ctsrts_default(struct uart_port *port, bool hwflow_enabled)
 {
 	struct sci_port *s = to_sci_port(port);
 	struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
+	unsigned short status;
+
+	/* If no SCSPTR register exists then skip. Same if hardware flow
+	 * control has been enabled, in such case SCFCR.MCE will be set
+	 * and the SCSPTR configuration is assumed to be overridden.
+	 */
+	if (!reg->size || hwflow_enabled)
+		return;
+
+	status = serial_port_in(port, SCSPTR);
+	status &= ~SCSPTR_CTSIO;
+	status |= SCSPTR_RTSIO;
+	serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
+}
+
+static void sci_init_pins(struct uart_port *port, unsigned int cflag)
+{
+	struct sci_port *s = to_sci_port(port);
+	bool hwflow_enabled = cflag & CRTSCTS;
 
 	/*
 	 * Use port-specific handler if provided.
@@ -522,22 +541,20 @@ static void sci_init_pins(struct uart_po
 		return;
 	}
 
-	/*
-	 * For the generic path SCSPTR is necessary. Bail out if that's
-	 * unavailable, too.
+	/* SCIF hardware with RTS/CTS support needs special setup below.
+	 *
+	 * Please note that if RTS/CTS is available for the hardware
+	 * platform depends on the particular SCIF channel on a certain
+	 * SoC, and how this channel has been hooked up on the actual board.
+	 *
+	 * If the RTS/CTS signals will be used or not depends on what user
+	 * space requests. In case RTS/CTS is available but not requested
+	 * by user space we still need to configure the pins somehow.
 	 */
-	if (!reg->size)
+	if (!(s->cfg->capabilities & SCIx_HAVE_RTSCTS))
 		return;
 
-	if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
-	    ((!(cflag & CRTSCTS)))) {
-		unsigned short status;
-
-		status = serial_port_in(port, SCSPTR);
-		status &= ~SCSPTR_CTSIO;
-		status |= SCSPTR_RTSIO;
-		serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
-	}
+	sci_init_ctsrts_default(port, hwflow_enabled);
 }
 
 static int sci_txfill(struct uart_port *port)
