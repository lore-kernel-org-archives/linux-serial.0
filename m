From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] serial: tegra: Convert to devm_ioremap_resource()
Date: Thu, 31 Jan 2013 15:55:39 +0530
Message-ID: <1359627939-2685-3-git-send-email-sachin.kamat@linaro.org>
References: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48697 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab3AaKe7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jan 2013 05:34:59 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1550835pbc.35
        for <linux-serial@vger.kernel.org>; Thu, 31 Jan 2013 02:34:59 -0800 (PST)
In-Reply-To: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, sachin.kamat@linaro.org, Laxman Dewangan <ldewangan@nvidia.com>, linux-serial@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-serial@vger.kernel.org
---
Compile tested with linux-next (20130128).
---
 drivers/tty/serial/serial-tegra.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 4f5e629..80dfec1 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -26,6 +26,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -1302,10 +1303,10 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	}
 
 	u->mapbase = resource->start;
-	u->membase = devm_request_and_ioremap(&pdev->dev, resource);
-	if (!u->membase) {
+	u->membase = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR(u->membase)) {
 		dev_err(&pdev->dev, "memregion/iomap address req failed\n");
-		return -EADDRNOTAVAIL;
+		return PTR_ERR(u->membase);
 	}
 
 	tup->uart_clk = devm_clk_get(&pdev->dev, NULL);
-- 
1.7.4.1

