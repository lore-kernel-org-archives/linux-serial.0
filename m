From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 07/27] serial: sh-sci: Use existing local variable in sci_parse_dt()
Date: Mon, 14 Dec 2015 19:57:16 +0100
Message-ID: <1450119456-964-8-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5ec1a70cd2f49ada..36077193f11168f0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2635,7 +2635,7 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	if (!IS_ENABLED(CONFIG_OF) || !np)
 		return NULL;
 
-	match = of_match_node(of_sci_match, pdev->dev.of_node);
+	match = of_match_node(of_sci_match, np);
 	if (!match)
 		return NULL;
 
-- 
1.9.1

