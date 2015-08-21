From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 31/33] serial: sh-sci: Don't call sci_rx_interrupt() on error when using DMA
Date: Fri, 21 Aug 2015 20:02:55 +0200
Message-ID: <1440180177-6924-32-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The error handler calls sci_rx_interrupt() to drain the receive FIFO if
an error condition happens.

However, if DMA is enabled on SCIFA or SCIFB, this will call
disable_irq_nosync() twice. Due to this imbalance, the receive interrupt
will never be re-enabled, and reception stops forever.

To fix this, restrict draining the FIFO to PIO mode, and just call
sci_receive_chars() directly.

Inspired by a patch from Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com>.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/tty/serial/sh-sci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 70e16f402e3108f4..82456fb09138dc2a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -993,6 +993,7 @@ static irqreturn_t sci_tx_interrupt(int irq, void *ptr)
 static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
+	struct sci_port *s = to_sci_port(port);
 
 	/* Handle errors */
 	if (port->type == PORT_SCI) {
@@ -1003,7 +1004,8 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 		}
 	} else {
 		sci_handle_fifo_overrun(port);
-		sci_rx_interrupt(irq, ptr);
+		if (!s->chan_rx)
+			sci_receive_chars(ptr);
 	}
 
 	sci_clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
-- 
1.9.1

