From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 01/10] drivers: PL011: avoid potential unregister_driver call
Date: Fri, 19 Sep 2014 13:21:14 +0100
Message-ID: <1411129283-17219-2-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36078 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398AbaISMWJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:09 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Although we care about not unregistering the driver if there are
still ports connected during the .remove callback, we do miss this
check in the pl011_probe function. So if the current port allocation
fails, but there are other ports already registered, we will kill
those.
So factor out the port removal into a separate function and use that
in the probe function, too.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8572f2a..8fab985 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2118,6 +2118,24 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
 	return ret;
 }
 
+/* unregisters the driver also if no more ports are left */
+static void pl011_unregister_port(struct uart_amba_port *uap)
+{
+	int i;
+	bool busy = false;
+
+	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
+		if (amba_ports[i] == uap)
+			amba_ports[i] = NULL;
+		else if (amba_ports[i])
+			busy = true;
+	}
+	pl011_dma_remove(uap);
+	if (!busy)
+		uart_unregister_driver(&amba_reg);
+}
+
+
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
@@ -2183,11 +2201,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	}
 
 	ret = uart_add_one_port(&amba_reg, &uap->port);
-	if (ret) {
-		amba_ports[i] = NULL;
-		uart_unregister_driver(&amba_reg);
-		pl011_dma_remove(uap);
-	}
+	if (ret)
+		pl011_unregister_port(uap);
 
 	return ret;
 }
@@ -2195,20 +2210,9 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 static int pl011_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
-	bool busy = false;
-	int i;
 
 	uart_remove_one_port(&amba_reg, &uap->port);
-
-	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
-		if (amba_ports[i] == uap)
-			amba_ports[i] = NULL;
-		else if (amba_ports[i])
-			busy = true;
-
-	pl011_dma_remove(uap);
-	if (!busy)
-		uart_unregister_driver(&amba_reg);
+	pl011_unregister_port(uap);
 	return 0;
 }
 
-- 
1.7.9.5

