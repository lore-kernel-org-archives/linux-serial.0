From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v3 3/4] serial: sh-sci: Submit RX DMA from RX interrupt on (H)SCIF
Date: Fri, 21 Aug 2015 20:25:45 +0200
Message-ID: <1440181546-7334-4-git-send-email-geert+renesas@glider.be>
References: <1440181546-7334-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440181546-7334-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

For DMA receive requests, the driver is only notified by DMA completion
after the whole DMA request has been transferred.  If less data is
received, it will stay stuck until more data arrives.  The driver
handles this by setting up a timer handler from the receive interrupt,
after reception of the first character.

Unlike SCIFA and SCIFB, SCIF and HSCIF don't issue receive interrupts on
reception of individual characters if a receive DMA request is in
progress, so the timer is never set up.

To fix receive DMA on SCIF and HSCIF, submit the receive DMA request
from the receive interrupt handler instead.
In some sense this is similar to the SCIFA/SCIFB behavior, where the
RDRQE (Rx Data Transfer Request Enable) bit is also set from the receive
interrupt handler.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New, this replaces the one-byte DMA transfer from "[PATCH/RFC v2
    28/29] serial: sh-sci: Add (H)SCIF DMA support".
---
 drivers/tty/serial/sh-sci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0b6a367ac343221c..b18e2e64f163ca48 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -939,6 +939,8 @@ static int sci_handle_breaks(struct uart_port *port)
 	return copied;
 }
 
+static void sci_submit_rx(struct sci_port *s);
+
 static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 {
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
@@ -955,6 +957,7 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 			scr |= SCSCR_RDRQE;
 		} else {
 			scr &= ~SCSCR_RIE;
+			sci_submit_rx(s);
 		}
 		serial_port_out(port, SCSCR, scr);
 		/* Clear current interrupt */
@@ -1672,7 +1675,8 @@ static void rx_timer_fn(unsigned long arg)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	sci_submit_rx(s);
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+		sci_submit_rx(s);
 }
 
 static void sci_request_dma(struct uart_port *port)
@@ -1758,7 +1762,8 @@ static void sci_request_dma(struct uart_port *port)
 
 		setup_timer(&s->rx_timer, rx_timer_fn, (unsigned long)s);
 
-		sci_submit_rx(s);
+		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+			sci_submit_rx(s);
 	}
 }
 
-- 
1.9.1

