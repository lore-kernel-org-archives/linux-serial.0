From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 10/33] serial: sh-sci: Remove useless memory allocation failure printks
Date: Fri, 21 Aug 2015 20:02:34 +0200
Message-ID: <1440180177-6924-11-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Printing an error on memory allocation failures is unnecessary.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 383f6df3815a1747..59ce9484875b2001 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1172,11 +1172,8 @@ static int sci_request_irq(struct sci_port *port)
 		desc = sci_irq_desc + i;
 		port->irqstr[j] = kasprintf(GFP_KERNEL, "%s:%s",
 					    dev_name(up->dev), desc->desc);
-		if (!port->irqstr[j]) {
-			dev_err(up->dev, "Failed to allocate %s IRQ string\n",
-				desc->desc);
+		if (!port->irqstr[j])
 			goto out_nomem;
-		}
 
 		ret = request_irq(irq, desc->handler, up->irqflags,
 				  port->irqstr[j], port);
@@ -2588,10 +2585,8 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	info = match->data;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
-	if (!p) {
-		dev_err(&pdev->dev, "failed to allocate DT config data\n");
+	if (!p)
 		return NULL;
-	}
 
 	/* Get the line number for the aliases node. */
 	id = of_alias_get_id(np, "serial");
-- 
1.9.1

