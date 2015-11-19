From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 04/25] serial: sh-sci: Grammar s/Get ... for/Get ... from/
Date: Thu, 19 Nov 2015 19:38:43 +0100
Message-ID: <1447958344-836-5-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ae136a1632e6298d..676f9d1354943a1b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2640,7 +2640,7 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	if (!p)
 		return NULL;
 
-	/* Get the line number for the aliases node. */
+	/* Get the line number from the aliases node. */
 	id = of_alias_get_id(np, "serial");
 	if (id < 0) {
 		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
-- 
1.9.1

