From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 03/16] sh: Remove sci_ick clock alias
Date: Thu, 19 Nov 2015 19:36:00 +0100
Message-ID: <1447958173-543-4-git-send-email-geert+renesas@glider.be>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh-sci driver falls back to the peripheral clock if the sci_ick
clock doesn't exist. There's thus no need to create an alias for the
peripheral clock named sci_ick.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add Acked-by.
---
 arch/sh/kernel/cpu/clock-cpg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/clock-cpg.c b/arch/sh/kernel/cpu/clock-cpg.c
index 8525a671266fe149..786c0769b4c393b5 100644
--- a/arch/sh/kernel/cpu/clock-cpg.c
+++ b/arch/sh/kernel/cpu/clock-cpg.c
@@ -63,7 +63,6 @@ int __init __deprecated cpg_clk_init(void)
 	clk_add_alias("fck", "sh-mtu2", "peripheral_clk", NULL);
 	clk_add_alias("fck", "sh-cmt-16.0", "peripheral_clk", NULL);
 	clk_add_alias("fck", "sh-cmt-32.0", "peripheral_clk", NULL);
-	clk_add_alias("sci_ick", NULL, "peripheral_clk", NULL);
 
 	return ret;
 }
-- 
1.9.1

