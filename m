From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 13/13] serial: sh-sci: Correct FIFO stages on sh7705/sh7720/sh7721
Date: Thu, 30 Apr 2015 18:21:37 +0200
Message-ID: <1430410897-12770-14-git-send-email-geert+renesas@glider.be>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

According to the datasheet, SCIFs on SoCs using SCIx_SH7705_SCIF_REGTYPE
(sh7705, sh7720, and sh7721) have 64-stage FIFO registers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware.
---
 drivers/tty/serial/sh-sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f1591b243bccb2bf..583aa563d4038f8b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2272,12 +2272,13 @@ static int sci_init_single(struct platform_device *dev,
 		sampling_rate = 16;
 		break;
 	case PORT_SCIF:
-		port->fifosize = 16;
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
+			port->fifosize = 64;
 			sci_port->overrun_reg = SCxSR;
 			sci_port->overrun_mask = SCIFA_ORER;
 			sampling_rate = 16;
 		} else {
+			port->fifosize = 16;
 			sci_port->overrun_reg = SCLSR;
 			sci_port->overrun_mask = SCLSR_ORER;
 			sampling_rate = 32;
-- 
1.9.1

