From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 11/33] serial: sh-sci: Remove bogus sci_handle_fifo_overrun() call on (H)SCIF
Date: Fri, 21 Aug 2015 20:02:35 +0200
Message-ID: <1440180177-6924-12-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Commit 8b6ff84c2d445a47 ("serial: sh-sci: Fix R-Car SCIF and HSCIF
overrun handling") added overrun handling for (H)SCIF using the SCLSR
register, but also accidentally added a bogus call to
sci_handle_fifo_overrun() in the receive interrupt path.

Remove it again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/tty/serial/sh-sci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 59ce9484875b2001..017b33cf5587e809 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1066,11 +1066,8 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	 * DR flags
 	 */
 	if (((ssr_status & SCxSR_RDxF(port)) || s->chan_rx) &&
-	    (scr_status & SCSCR_RIE)) {
-		if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
-			sci_handle_fifo_overrun(port);
+	    (scr_status & SCSCR_RIE))
 		ret = sci_rx_interrupt(irq, ptr);
-	}
 
 	/* Error Interrupt */
 	if ((ssr_status & SCxSR_ERRORS(port)) && err_enabled)
-- 
1.9.1

