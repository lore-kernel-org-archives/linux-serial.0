From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 08/11] serial: sh-sci: Correct pin initialization on (H)SCIF
Date: Fri,  3 Jun 2016 12:00:08 +0200
Message-ID: <1464948011-377-9-git-send-email-geert+renesas@glider.be>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Correct pin initialization on (H)SCIF:
  - RTS must be deasserted (it's active low),
  - SCK must be an input, as it may be used as the optional external
    clock input.

Initial pin configuration must always be done:
  - Regardless of the presence of dedicated RTS and CTS pins: if the
    register exists, the RTS/CTS bits exist, too,
  - Regardless of hardware flow control being enabled or not: RTS must
    be deasserted.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ce7bd165929ea078..c46999f20917964e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -712,21 +712,14 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 		return;
 	}
 
-	/*
-	 * For the generic path SCSPTR is necessary. Bail out if that's
-	 * unavailable, too.
-	 */
-	if (!sci_getreg(port, SCSPTR)->size)
-		return;
-
-	if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
-	    ((!(cflag & CRTSCTS)))) {
-		unsigned short status;
-
-		status = serial_port_in(port, SCSPTR);
-		status &= ~SCSPTR_CTSIO;
-		status |= SCSPTR_RTSIO;
-		serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
+	if (sci_getreg(port, SCSPTR)->size) {
+		u16 status = serial_port_in(port, SCSPTR);
+
+		/* RTS# is output, driven 1 */
+		status |= SCSPTR_RTSIO | SCSPTR_RTSDT;
+		/* CTS# and SCK are inputs */
+		status &= ~(SCSPTR_CTSIO | SCSPTR_SCKIO);
+		serial_port_out(port, SCSPTR, status);
 	}
 }
 
-- 
1.9.1
