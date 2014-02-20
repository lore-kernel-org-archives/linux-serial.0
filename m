From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH tty-next v2 3/4] tty: serial: bcm63xx_uart: add support for DT probing
Date: Thu, 20 Feb 2014 10:15:53 -0800
Message-ID: <1392920154-3642-4-git-send-email-f.fainelli@gmail.com>
References: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:63417 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbaBTSSJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 13:18:09 -0500
In-Reply-To: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, gregory.0xf0@gmail.com, Florian Fainelli <f.fainelli@gmail.com>

Add a matching table for the the bcm63xx_uart driver on the compatible
string "brcm,bcm6345-uart" which covers all BCM63xx implementations and
reflects the fact that this block was first introduced with the BCM6345
SoC.  Also make sure that we convert the id based on the uart aliases
provided by the relevant Device Tree.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- match on the compatible property "brcm,bcm6345-uart" as suggested

 drivers/tty/serial/bcm63xx_uart.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 37e7e33..a47421e 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -31,6 +31,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial_bcm63xx.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #define BCM63XX_NR_UARTS	2
 
@@ -806,6 +807,9 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
+	if (pdev->dev.of_node)
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
+
 	if (pdev->id < 0 || pdev->id >= BCM63XX_NR_UARTS)
 		return -EINVAL;
 
@@ -857,6 +861,12 @@ static int bcm_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id bcm63xx_of_match[] = {
+	{ .compatible = "brcm,bcm6345-uart" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, bcm63xx_of_match);
+
 /*
  * platform driver stuff
  */
@@ -866,6 +876,7 @@ static struct platform_driver bcm_uart_platform_driver = {
 	.driver	= {
 		.owner = THIS_MODULE,
 		.name  = "bcm63xx_uart",
+		.of_match_table = bcm63xx_of_match,
 	},
 };
 
-- 
1.8.3.2

