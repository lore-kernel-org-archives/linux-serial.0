From: Michal Simek <monstr@monstr.eu>
Subject: [RFC 1/2] serial: Add OF alias support for uartlite
Date: Tue,  8 Nov 2011 14:35:06 +0100
Message-ID: <1320759307-24877-2-git-send-email-monstr@monstr.eu>
References: <1320759307-24877-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54860 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab1KHNfO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Nov 2011 08:35:14 -0500
In-Reply-To: <1320759307-24877-1-git-send-email-monstr@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, john.williams@petalogix.com, michal.simek@petalogix.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jacmet@sunsite.dk, arnd@arndb.de

Signed-off-by: John Williams <john.williams@petalogix.com>
Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 drivers/tty/serial/uartlite.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 0aed022..71ba422 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -573,13 +573,31 @@ MODULE_DEVICE_TABLE(of, ulite_of_match);
 static int __devinit ulite_probe(struct platform_device *pdev)
 {
 	struct resource *res, *res2;
+	unsigned int *idp;
 	int id = pdev->id;
+
 #ifdef CONFIG_OF
-	const __be32 *prop;
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0) {
+		dev_warn(&pdev->dev, "failed to get alias id, errno %d\n", id);
+		/* Fall back to old port-number property */
+		idp = of_get_property(pdev->dev.of_node, "port-number", NULL);
+		if (idp < 0) {
+			dev_warn(&pdev->dev,
+				"failed to get port-number, errno %d\n", idp);
+			id = -1;
+		} else
+			id = be32_to_cpup(idp);
+	}
 
-	prop = of_get_property(pdev->dev.of_node, "port-number", NULL);
-	if (prop)
-		id = be32_to_cpup(prop);
+	/* We can't register ids which are greater than number of uartlites */
+	if (id >= ULITE_NR_UARTS) {
+		dev_warn(&op->dev,
+			"Extern number of allocated uartlite entries "
+			"ULITE_NR_UARTS, id %d\n", id);
+		return -ENODEV;
+	}
 #endif
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.5.4

