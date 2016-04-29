From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 09/11] serial: sh-sci: Add pin initialization for SCIFA/SCIFB
Date: Fri, 29 Apr 2016 14:58:32 +0200
Message-ID: <1461934714-18681-10-git-send-email-geert+renesas@glider.be>
References: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Before, the driver relied on initialization by the boot loader, or by
implicit reset state.

Note that unlike on (H)SCIF, the RTS/CTS bits exist only if dedicated
RTS/CTS pins are available, which depends on the SoC and UART instance.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c46999f20917964e..b9d027af0f3e71f6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -712,7 +712,21 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 		return;
 	}
 
-	if (sci_getreg(port, SCSPTR)->size) {
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		u16 ctrl = serial_port_in(port, SCPCR);
+
+		/* Enable RXD and TXD pin functions */
+		ctrl &= ~(SCPCR_RXDC | SCPCR_TXDC);
+		if (to_sci_port(port)->cfg->capabilities & SCIx_HAVE_RTSCTS) {
+			/* RTS# is output, driven 1 */
+			ctrl |= SCPCR_RTSC;
+			serial_port_out(port, SCPDR,
+				serial_port_in(port, SCPDR) | SCPDR_RTSD);
+			/* Enable CTS# pin function */
+			ctrl &= ~SCPCR_CTSC;
+		}
+		serial_port_out(port, SCPCR, ctrl);
+	} else if (sci_getreg(port, SCSPTR)->size) {
 		u16 status = serial_port_in(port, SCSPTR);
 
 		/* RTS# is output, driven 1 */
-- 
1.9.1
