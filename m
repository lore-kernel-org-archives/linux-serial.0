From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] serial: tegra: assume CONFIG_OF
Date: Fri, 15 Feb 2013 15:04:45 -0700
Message-ID: <1360965885-19842-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43411 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3BOWEv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Feb 2013 17:04:51 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

Tegra only supports, and always enables, device tree. Remove all ifdefs
for DT support from the driver.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 4f5e629..372de8a 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1269,8 +1269,7 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	const struct tegra_uart_chip_data *cdata;
 	const struct of_device_id *match;
 
-	match = of_match_device(of_match_ptr(tegra_uart_of_match),
-				&pdev->dev);
+	match = of_match_device(tegra_uart_of_match, &pdev->dev);
 	if (!match) {
 		dev_err(&pdev->dev, "Error: No device match found\n");
 		return -ENODEV;
@@ -1361,7 +1360,7 @@ static struct platform_driver tegra_uart_platform_driver = {
 	.remove		= tegra_uart_remove,
 	.driver		= {
 		.name	= "serial-tegra",
-		.of_match_table = of_match_ptr(tegra_uart_of_match),
+		.of_match_table = tegra_uart_of_match,
 		.pm	= &tegra_uart_pm_ops,
 	},
 };
-- 
1.7.10.4

