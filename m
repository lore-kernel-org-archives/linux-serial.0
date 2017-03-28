From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/3] serial: sh-sci: Fix (AUTO)RTS in sci_init_pins()
Date: Tue, 28 Mar 2017 11:13:46 +0200
Message-ID: <1490692426-19252-4-git-send-email-geert+renesas@glider.be>
References: <1490692426-19252-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1490692426-19252-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

If a UART has dedicated RTS/CTS pins, and hardware control flow is
disabled (or AUTORTS is not yet effective), changing any serial port
configuration deasserts RTS, as .set_termios() calls sci_init_pins().

To fix this, consider the current (AUTO)RTS state when (re)initializing
the pins.  Note that for SCIFA/SCIFB, AUTORTS needs explicit
configuration of the RTS# pin function, while (H)SCIF handles this
automatically.

Fixes: d2b9775d795ec05f ("serial: sh-sci: Correct pin initialization on (H)SCIF")
Fixes: e9d7a45a03991349 ("serial: sh-sci: Add pin initialization for SCIFA/SCIFB")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6e405fb5a23f0b4a..71707e8e6e3ffe76 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -683,24 +683,37 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 	}
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		u16 data = serial_port_in(port, SCPDR);
 		u16 ctrl = serial_port_in(port, SCPCR);
 
 		/* Enable RXD and TXD pin functions */
 		ctrl &= ~(SCPCR_RXDC | SCPCR_TXDC);
 		if (to_sci_port(port)->has_rtscts) {
-			/* RTS# is output, driven 1 */
-			ctrl |= SCPCR_RTSC;
-			serial_port_out(port, SCPDR,
-				serial_port_in(port, SCPDR) | SCPDR_RTSD);
+			/* RTS# is output, active low, unless autorts */
+			if (!(port->mctrl & TIOCM_RTS)) {
+				ctrl |= SCPCR_RTSC;
+				data |= SCPDR_RTSD;
+			} else if (!s->autorts) {
+				ctrl |= SCPCR_RTSC;
+				data &= ~SCPDR_RTSD;
+			} else {
+				/* Enable RTS# pin function */
+				ctrl &= ~SCPCR_RTSC;
+			}
 			/* Enable CTS# pin function */
 			ctrl &= ~SCPCR_CTSC;
 		}
+		serial_port_out(port, SCPDR, data);
 		serial_port_out(port, SCPCR, ctrl);
 	} else if (sci_getreg(port, SCSPTR)->size) {
 		u16 status = serial_port_in(port, SCSPTR);
 
-		/* RTS# is output, driven 1 */
-		status |= SCSPTR_RTSIO | SCSPTR_RTSDT;
+		/* RTS# is always output; and active low, unless autorts */
+		status |= SCSPTR_RTSIO;
+		if (!(port->mctrl & TIOCM_RTS))
+			status |= SCSPTR_RTSDT;
+		else if (!s->autorts)
+			status &= ~SCSPTR_RTSDT;
 		/* CTS# and SCK are inputs */
 		status &= ~(SCSPTR_CTSIO | SCSPTR_SCKIO);
 		serial_port_out(port, SCSPTR, status);
-- 
2.7.4
