From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] serial: tegra: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 09:59:00 +0530
Message-ID: <1362371340-22746-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 372de8a..9799d04 100644
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
@@ -1301,11 +1302,9 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	}
 
 	u->mapbase = resource->start;
-	u->membase = devm_request_and_ioremap(&pdev->dev, resource);
-	if (!u->membase) {
-		dev_err(&pdev->dev, "memregion/iomap address req failed\n");
-		return -EADDRNOTAVAIL;
-	}
+	u->membase = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR(u->membase))
+		return PTR_ERR(u->membase);
 
 	tup->uart_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(tup->uart_clk)) {
-- 
1.7.4.1
