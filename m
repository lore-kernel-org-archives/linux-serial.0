From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 03/16] serial: sh-sci: Compute overrun_bit without using baud rate algo
Date: Thu, 28 Nov 2013 22:43:17 +0100
Message-ID: <1385675010-26904-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35261 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3K1Vn3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 16:43:29 -0500
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org

The overrun bit index is a property of the hardware. It's currently
computed based on a different and unrelated hardware property, the baud
rate calculation algorithm. Compute it using hardware identification
information only.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e75ead0..d9b14d0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2137,30 +2137,38 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->irqs[3] = sci_port->irqs[0];
 	}
 
+	if (p->regtype == SCIx_PROBE_REGTYPE) {
+		ret = sci_probe_regmap(p);
+		if (unlikely(ret))
+			return ret;
+	}
+
 	switch (p->type) {
 	case PORT_SCIFB:
 		port->fifosize = 256;
+		sci_port->overrun_bit = 9;
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
+		sci_port->overrun_bit = 0;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
+		sci_port->overrun_bit = 9;
 		break;
 	case PORT_SCIF:
 		port->fifosize = 16;
+		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE)
+			sci_port->overrun_bit = 9;
+		else
+			sci_port->overrun_bit = 0;
 		break;
 	default:
 		port->fifosize = 1;
+		sci_port->overrun_bit = 5;
 		break;
 	}
 
-	if (p->regtype == SCIx_PROBE_REGTYPE) {
-		ret = sci_probe_regmap(p);
-		if (unlikely(ret))
-			return ret;
-	}
-
 	if (!early) {
 		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
 		if (IS_ERR(sci_port->iclk)) {
@@ -2198,12 +2206,6 @@ static int sci_init_single(struct platform_device *dev,
 	 * Establish sensible defaults for the overrun detection, unless
 	 * the part has explicitly disabled support for it.
 	 */
-	if (p->type == PORT_SCI)
-		sci_port->overrun_bit = 5;
-	else if (p->scbrr_algo_id == SCBRR_ALGO_4)
-		sci_port->overrun_bit = 9;
-	else
-		sci_port->overrun_bit = 0;
 
 	/*
 	 * Make the error mask inclusive of overrun detection, if
-- 
1.8.3.2

