From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 27/27] serial: sh-sci: Drop the sci_fck clock fallback
Date: Mon, 14 Dec 2015 19:57:36 +0100
Message-ID: <1450119456-964-28-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All platforms that used to define an sci_fck clock have now switched to
the fck name. Remove the fallback code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Do NOT apply until "sh: Rename sci_ick and sci_fck clock to fck" has
been applied!

v3:
  - Add Acked-by,
  - Moved after BRG sh-sci patches to remove dependency of BRG patches
    on SH patches,

v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4ff5d0cf812688ff..6571f4d944c26297 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2481,11 +2481,6 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			if (!IS_ERR(clk))
 				goto found;
 
-			/* SH has historically named the clock "sci_fck". */
-			clk = devm_clk_get(dev, "sci_fck");
-			if (!IS_ERR(clk))
-				goto found;
-
 			/*
 			 * Not all SH platforms declare a clock lookup entry
 			 * for SCI devices, in which case we need to get the
-- 
1.9.1

