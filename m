From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 04/33] serial: sh-sci: Use SCIF_DR instead of hardcoded literal 1
Date: Fri, 21 Aug 2015 20:02:28 +0200
Message-ID: <1440180177-6924-5-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fa26be7f9414dfc2..300f641e730d1ac5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -960,7 +960,8 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 		}
 		serial_port_out(port, SCSCR, scr);
 		/* Clear current interrupt */
-		serial_port_out(port, SCxSR, ssr & ~(1 | SCxSR_RDxF(port)));
+		serial_port_out(port, SCxSR,
+				ssr & ~(SCIF_DR | SCxSR_RDxF(port)));
 		dev_dbg(port->dev, "Rx IRQ %lu: setup t-out in %u jiffies\n",
 			jiffies, s->rx_timeout);
 		mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
-- 
1.9.1

