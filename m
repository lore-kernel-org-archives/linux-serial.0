From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 5/5] tty: serial: altera_jtaguart: Add device tree support
Date: Thu, 17 Feb 2011 21:30:09 +0100
Message-ID: <c28550ba11ed228f4137ced1ab34761c08ad38ad.1297974227.git.tklauser@distanz.ch>
References: <cover.1297974227.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:39330 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884Ab1BQUaK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Feb 2011 15:30:10 -0500
In-Reply-To: <cover.1297974227.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: nios2-dev@sopc.et.ntust.edu.tw

Advertise the possibility to use this driver with device tree if
CONFIG_OF is set.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 .../devicetree/bindings/altera_jtaguart.txt        |    4 ++++
 drivers/tty/serial/altera_jtaguart.c               |   15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/altera_jtaguart.txt

diff --git a/Documentation/devicetree/bindings/altera_jtaguart.txt b/Documentation/devicetree/bindings/altera_jtaguart.txt
new file mode 100644
index 0000000..c152f65
--- /dev/null
+++ b/Documentation/devicetree/bindings/altera_jtaguart.txt
@@ -0,0 +1,4 @@
+Altera JTAG UART
+
+Required properties:
+- compatible : should be "ALTR,juart-1.0"
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 8f014bb..d0f8779 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -466,12 +466,23 @@ static int __devexit altera_jtaguart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id altera_jtaguart_match[] = {
+	{ .compatible = "ALTR,juart-1.0", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
+#else
+#define altera_jtaguart_match NULL
+#endif /* CONFIG_OF */
+
 static struct platform_driver altera_jtaguart_platform_driver = {
 	.probe	= altera_jtaguart_probe,
 	.remove	= __devexit_p(altera_jtaguart_remove),
 	.driver	= {
-		.name	= DRV_NAME,
-		.owner	= THIS_MODULE,
+		.name		= DRV_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= altera_jtaguart_match,
 	},
 };
 
-- 
1.7.0.4

