From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] tty: serial: 8250: omap: line is unsigned, don't check < 0
Date: Wed, 12 Nov 2014 10:28:33 +0100
Message-ID: <1415784514-26649-1-git-send-email-bigeasy@linutronix.de>
References: <20141112084807.GB13955@mwanda>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40550 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbaKLJ2q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:28:46 -0500
In-Reply-To: <20141112084807.GB13955@mwanda>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: dan.carpenter@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Dan Carpenter reported:
|drivers/tty/serial/8250/8250_omap.c:1025 omap8250_probe()
|warn: unsigned 'up.port.line' is never less than zero.
|1025          if (up.port.line < 0) {

I (wrongly) assumed that line is an int and compiler didn't complain nor
did sparse. Since of_alias_get_id() and pdev->id can get negative I
check for the error via ret variable.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 1681875f2996..907100eb8030 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1014,19 +1014,20 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.unthrottle = omap_8250_unthrottle;
 
 	if (pdev->dev.of_node) {
-		up.port.line = of_alias_get_id(pdev->dev.of_node, "serial");
+		ret = of_alias_get_id(pdev->dev.of_node, "serial");
+
 		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				     &up.port.uartclk);
 		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
 	} else {
-		up.port.line = pdev->id;
+		ret = pdev->id;
 	}
-
-	if (up.port.line < 0) {
-		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
-			up.port.line);
-		return -ENODEV;
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias/pdev id\n");
+		return ret;
 	}
+	up.port.line = ret;
+
 	if (!up.port.uartclk) {
 		up.port.uartclk = DEFAULT_CLK_SPEED;
 		dev_warn(&pdev->dev,
-- 
2.1.3

