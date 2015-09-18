From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 06/10] serial: sh-sci: Redirect port interrupts to CPU _only_ when DMA stops
Date: Fri, 18 Sep 2015 13:08:29 +0200
Message-ID: <1442574513-20648-7-git-send-email-geert+renesas@glider.be>
References: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Muhammad Hamza Farooq <mfarooq@visteon.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

Since the DMA engine is not stopped everytime rx_timer_fn is called, the
interrupts have to be redirected back to CPU only when incomplete DMA
transaction is handled

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 drivers/tty/serial/sh-sci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 36a11110acf4cab5..5dcd8b382e9053f4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1285,12 +1285,6 @@ static void rx_timer_fn(unsigned long arg)
 	spin_lock_irqsave(&port->lock, flags);
 
 	dev_dbg(port->dev, "DMA Rx timed out\n");
-	scr = serial_port_in(port, SCSCR);
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
-		scr &= ~SCSCR_RDRQE;
-		enable_irq(s->irqs[SCIx_RXI_IRQ]);
-	}
-	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
 
 	active = sci_dma_rx_find_active(s);
 	if (active < 0) {
@@ -1315,10 +1309,18 @@ static void rx_timer_fn(unsigned long arg)
 			tty_flip_buffer_push(&port->state->port);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
-
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		sci_submit_rx(s);
+
+	/* Direct new serial port interrupts back to CPU */
+	scr = serial_port_in(port, SCSCR);
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		scr &= ~SCSCR_RDRQE;
+		enable_irq(s->irqs[SCIx_RXI_IRQ]);
+	}
+	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
+
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void sci_request_dma(struct uart_port *port)
-- 
1.9.1

