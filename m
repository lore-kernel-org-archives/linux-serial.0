From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC 1/3] serial: sh-sci: consider DR (data ready) bit adequately
Date: Fri, 12 Sep 2014 10:51:46 +0200
Message-ID: <1410511908-9282-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
Cc: horms@verge.net.au, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

To allow operation with a higher RX FIFO interrupt threshold it is
necessary to consider the DR bit ("FIFO not full, but no data received
for 1.5 frames") as an indicator that data can be read. Otherwise the
driver will let data rot in the FIFO until the threshold is reached.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 9 +++++----
 drivers/tty/serial/sh-sci.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3081e46..f0ff8a7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -483,7 +483,7 @@ static int sci_poll_get_char(struct uart_port *port)
 		break;
 	} while (1);
 
-	if (!(status & SCxSR_RDxF(port)))
+	if (!(status & (SCxSR_RDxF(port) | SCxSR_DR(port))))
 		return NO_POLL_CHAR;
 
 	c = serial_port_in(port, SCxRDR);
@@ -572,7 +572,8 @@ static int sci_rxfill(struct uart_port *port)
 	if (reg->size)
 		return serial_port_in(port, SCFDR) & ((port->fifosize << 1) - 1);
 
-	return (serial_port_in(port, SCxSR) & SCxSR_RDxF(port)) != 0;
+	return (serial_port_in(port, SCxSR) &
+	        (SCxSR_RDxF(port) | SCxSR_DR(port))) != 0;
 }
 
 /*
@@ -663,7 +664,7 @@ static void sci_receive_chars(struct uart_port *port)
 	unsigned char flag;
 
 	status = serial_port_in(port, SCxSR);
-	if (!(status & SCxSR_RDxF(port)))
+	if (!(status & (SCxSR_RDxF(port) | SCxSR_DR(port))))
 		return;
 
 	while (1) {
@@ -1014,7 +1015,7 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	 * Rx Interrupt: if we're using DMA, the DMA controller clears RDF /
 	 * DR flags
 	 */
-	if (((ssr_status & SCxSR_RDxF(port)) || s->chan_rx) &&
+	if (((ssr_status & (SCxSR_RDxF(port) | SCxSR_DR(port))) || s->chan_rx) &&
 	    (scr_status & SCSCR_RIE))
 		ret = sci_rx_interrupt(irq, ptr);
 
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index d5db81a..9c4598d 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -8,6 +8,7 @@
 #define SCxSR_FER(port)		(((port)->type == PORT_SCI) ? SCI_FER    : SCIF_FER)
 #define SCxSR_PER(port)		(((port)->type == PORT_SCI) ? SCI_PER    : SCIF_PER)
 #define SCxSR_BRK(port)		(((port)->type == PORT_SCI) ? 0x00       : SCIF_BRK)
+#define SCxSR_DR(port)		(((port)->type == PORT_SCI) ? 0x00       : SCIF_DR)
 
 #define SCxSR_ERRORS(port)	(to_sci_port(port)->error_mask)
 
-- 
1.8.4.5

