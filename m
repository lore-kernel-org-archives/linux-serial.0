From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 16/16] serial: sh-sci: Drop the sci_fck clock fallback
Date: Thu, 19 Nov 2015 19:36:13 +0100
Message-ID: <1447958173-543-17-git-send-email-geert+renesas@glider.be>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All platforms that used to define an sci_fck clock have now switched to
the fck name. Remove the fallback code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3c908804cab1c88c..bee5b7025adf45a2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2256,11 +2256,6 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	if (!IS_ERR(sci_port->fclk))
 		return 0;
 
-	/* SH has historically named the clock "sci_fck". */
-	sci_port->fclk = clk_get(dev, "sci_fck");
-	if (!IS_ERR(sci_port->fclk))
-		return 0;
-
 	/*
 	 * Not all SH platforms declare a clock lookup entry for SCI devices,
 	 * in which case we need to get the global "peripheral_clk" clock.
-- 
1.9.1

