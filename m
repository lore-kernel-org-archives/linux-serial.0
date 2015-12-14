From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 06/27] serial: sh-sci: Grammar s/Get ... for/Get ... from/
Date: Mon, 14 Dec 2015 19:57:15 +0100
Message-ID: <1450119456-964-7-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Reviewed-by, Acked-by.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index dfee7a2f51f147d1..5ec1a70cd2f49ada 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2645,7 +2645,7 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	if (!p)
 		return NULL;
 
-	/* Get the line number for the aliases node. */
+	/* Get the line number from the aliases node. */
 	id = of_alias_get_id(np, "serial");
 	if (id < 0) {
 		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
-- 
1.9.1

