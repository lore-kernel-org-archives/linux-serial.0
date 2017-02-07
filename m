From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: sh-sci: Temporarily Revert "implement FIFO threshold register setting"
Date: Tue,  7 Feb 2017 14:00:54 +0100
Message-ID: <20170207130109.502274-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Peter Hurley <peter@hurleysoftware.com>, Simon Horman <horms+renesas@verge.net.au>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Patch the first three patches out of seven were applied, up to commit
a380ed461f66 ("serial: sh-sci: implement FIFO threshold register setting"),
which introduces a new helper function. This is not called until the next
following patch, so we now get a build warning:

drivers/tty/serial/sh-sci.c:977:12: error: 'scif_set_rtrg' defined but not used [-Werror=unused-function]

The patch is good, but I think we should either apply the following patches
as well, or revert this one to get a clean build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is mainly a notification that I've applied the revert to my randconfig
test tree, if you plan to merge the following patches for 4.11, we won't
need this one.
---
 drivers/tty/serial/sh-sci.c | 59 ---------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 050d028cf2a1..5044a5e5d340 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -974,65 +974,6 @@ static int sci_handle_breaks(struct uart_port *port)
 	return copied;
 }
 
-static int scif_set_rtrg(struct uart_port *port, int rx_trig)
-{
-	unsigned int bits;
-
-	if (rx_trig < 1)
-		rx_trig = 1;
-	if (rx_trig >= port->fifosize)
-		rx_trig = port->fifosize;
-
-	/* HSCIF can be set to an arbitrary level. */
-	if (sci_getreg(port, HSRTRGR)->size) {
-		serial_port_out(port, HSRTRGR, rx_trig);
-		return rx_trig;
-	}
-
-	switch (port->type) {
-	case PORT_SCIF:
-		if (rx_trig < 4) {
-			bits = 0;
-			rx_trig = 1;
-		} else if (rx_trig < 8) {
-			bits = SCFCR_RTRG0;
-			rx_trig = 4;
-		} else if (rx_trig < 14) {
-			bits = SCFCR_RTRG1;
-			rx_trig = 8;
-		} else {
-			bits = SCFCR_RTRG0 | SCFCR_RTRG1;
-			rx_trig = 14;
-		}
-		break;
-	case PORT_SCIFA:
-	case PORT_SCIFB:
-		if (rx_trig < 16) {
-			bits = 0;
-			rx_trig = 1;
-		} else if (rx_trig < 32) {
-			bits = SCFCR_RTRG0;
-			rx_trig = 16;
-		} else if (rx_trig < 48) {
-			bits = SCFCR_RTRG1;
-			rx_trig = 32;
-		} else {
-			bits = SCFCR_RTRG0 | SCFCR_RTRG1;
-			rx_trig = 48;
-		}
-		break;
-	default:
-		WARN(1, "unknown FIFO configuration");
-		return 1;
-	}
-
-	serial_port_out(port, SCFCR,
-		(serial_port_in(port, SCFCR) &
-		~(SCFCR_RTRG1 | SCFCR_RTRG0)) | bits);
-
-	return rx_trig;
-}
-
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 static void sci_dma_tx_complete(void *arg)
 {
-- 
2.9.0
