From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 07/33] serial: sh-sci: Improve readability of sampling rate configuration
Date: Fri, 21 Aug 2015 20:02:31 +0200
Message-ID: <1440180177-6924-8-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Reorder sampling_rate assignment for consistency in all cases of the
switch statement.
Avoid using the ternary conditional operator to make it more clear that
the value is overridden by platform data.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Reworded one-line summary,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index dbb4bbdac37ce0d8..9502f52d4b55808a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2205,7 +2205,6 @@ static int sci_init_single(struct platform_device *dev,
 {
 	struct uart_port *port = &sci_port->port;
 	const struct resource *res;
-	unsigned int sampling_rate;
 	unsigned int i;
 	int ret;
 
@@ -2250,37 +2249,37 @@ static int sci_init_single(struct platform_device *dev,
 		port->fifosize = 256;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
-		sampling_rate = 16;
+		sci_port->sampling_rate = 16;
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
-		sampling_rate = 0;
 		sci_port->overrun_reg = SCLSR;
 		sci_port->overrun_mask = SCLSR_ORER;
+		sci_port->sampling_rate = 0;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
-		sampling_rate = 16;
+		sci_port->sampling_rate = 16;
 		break;
 	case PORT_SCIF:
 		port->fifosize = 16;
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
 			sci_port->overrun_reg = SCxSR;
 			sci_port->overrun_mask = SCIFA_ORER;
-			sampling_rate = 16;
+			sci_port->sampling_rate = 16;
 		} else {
 			sci_port->overrun_reg = SCLSR;
 			sci_port->overrun_mask = SCLSR_ORER;
-			sampling_rate = 32;
+			sci_port->sampling_rate = 32;
 		}
 		break;
 	default:
 		port->fifosize = 1;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCI_ORER;
-		sampling_rate = 32;
+		sci_port->sampling_rate = 32;
 		break;
 	}
 
@@ -2288,8 +2287,8 @@ static int sci_init_single(struct platform_device *dev,
 	 * match the SoC datasheet, this should be investigated. Let platform
 	 * data override the sampling rate for now.
 	 */
-	sci_port->sampling_rate = p->sampling_rate ? p->sampling_rate
-				: sampling_rate;
+	if (p->sampling_rate)
+		sci_port->sampling_rate = p->sampling_rate;
 
 	if (!early) {
 		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
-- 
1.9.1

