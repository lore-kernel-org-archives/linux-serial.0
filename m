From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/5] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"
Date: Wed, 17 Feb 2016 16:02:31 +0100
Message-ID: <1455721357-4008289-2-git-send-email-arnd@arndb.de>
References: <1455721357-4008289-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455721357-4008289-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, linux-mediatek@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This reverts commit d72d391c126e ("drivers/tty/serial: make
8250/8250_mtk.c explicitly non-modular"), which intended to remove dead
code but did not have the desired effect when the main 8250 driver was
a module itself.

This would normally result in a link error, but as the entire
drivers/tty/serial/8250/ directory is only entered when CONFIG_SERIAL_8250
is set, we never notice that the driver does not get built in this
configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 9038843cadc7..6ecc6e3e82dc 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -16,7 +16,7 @@
  */
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -245,6 +245,23 @@ static int mtk8250_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int mtk8250_remove(struct platform_device *pdev)
+{
+	struct mtk8250_data *data = platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	serial8250_unregister_port(data->line);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mtk8250_runtime_suspend(&pdev->dev);
+
+	return 0;
+}
+
 static int __maybe_unused mtk8250_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
@@ -273,18 +290,18 @@ static const struct of_device_id mtk8250_of_match[] = {
 	{ .compatible = "mediatek,mt6577-uart" },
 	{ /* Sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, mtk8250_of_match);
 
 static struct platform_driver mtk8250_platform_driver = {
 	.driver = {
-		.name			= "mt6577-uart",
-		.pm			= &mtk8250_pm_ops,
-		.of_match_table		= mtk8250_of_match,
-		.suppress_bind_attrs	= true,
-
+		.name		= "mt6577-uart",
+		.pm		= &mtk8250_pm_ops,
+		.of_match_table	= mtk8250_of_match,
 	},
 	.probe			= mtk8250_probe,
+	.remove			= mtk8250_remove,
 };
-builtin_platform_driver(mtk8250_platform_driver);
+module_platform_driver(mtk8250_platform_driver);
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init early_mtk8250_setup(struct earlycon_device *device,
@@ -300,3 +317,7 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 
 OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
 #endif
+
+MODULE_AUTHOR("Matthias Brugger");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Mediatek 8250 serial port driver");
-- 
2.7.0
