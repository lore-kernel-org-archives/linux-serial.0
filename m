From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] tty: serial: omap_serial: line is unsigned, don't check < 0
Date: Wed, 12 Nov 2014 10:28:34 +0100
Message-ID: <1415784514-26649-2-git-send-email-bigeasy@linutronix.de>
References: <20141112084807.GB13955@mwanda>
 <1415784514-26649-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40551 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbaKLJ2q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:28:46 -0500
In-Reply-To: <1415784514-26649-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: dan.carpenter@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Dan Carpenter reported:
|drivers/tty/serial/8250/8250_omap.c:1025 omap8250_probe()
|warn: unsigned 'up.port.line' is never less than zero.
|1025          if (up.port.line < 0) {

Since of_alias_get_id() and pdev->id can get negative I check for the
error via ret variable.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/omap-serial.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6cda5cd8b513..9401d2f9c119 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1682,16 +1682,16 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.ops = &serial_omap_pops;
 
 	if (pdev->dev.of_node)
-		up->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
+		ret = of_alias_get_id(pdev->dev.of_node, "serial");
 	else
-		up->port.line = pdev->id;
+		ret = pdev->id;
 
-	if (up->port.line < 0) {
+	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
-								up->port.line);
-		ret = -ENODEV;
+			ret);
 		goto err_port_line;
 	}
+	up->port.line = ret;
 
 	ret = serial_omap_probe_rs485(up, pdev->dev.of_node);
 	if (ret < 0)
-- 
2.1.3

