From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 12/33] serial: sh-sci: Return IRQ_HANDLED when overrun if detected
Date: Fri, 21 Aug 2015 20:02:36 +0200
Message-ID: <1440180177-6924-13-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch fix an issue that the driver may cause "nobody cared" IRQ
when this driver detects the overrun flag only.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Assimilated into my series.
---
 drivers/tty/serial/sh-sci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 017b33cf5587e809..c4cb7a5a2b110753 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1078,8 +1078,10 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 		ret = sci_br_interrupt(irq, ptr);
 
 	/* Overrun Interrupt */
-	if (orer_status & s->overrun_mask)
+	if (orer_status & s->overrun_mask) {
 		sci_handle_fifo_overrun(port);
+		ret = IRQ_HANDLED;
+	}
 
 	return ret;
 }
-- 
1.9.1

