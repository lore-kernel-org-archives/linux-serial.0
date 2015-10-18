From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH 5/5] drivers/tty/serial: make 8250/8250_mtk.c explicitly
 non-modular
Date: Sun, 18 Oct 2015 18:21:18 -0400
Message-ID: <1445206878-12455-6-git-send-email-paul.gortmaker@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/8250/Kconfig:config SERIAL_8250_MT6577
drivers/tty/serial/8250/Kconfig:        bool "Mediatek serial port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Signed-off-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 78883ca64ddd..0e590b233f03 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -16,7 +16,7 @@
  */
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -245,23 +245,6 @@ static int mtk8250_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk8250_remove(struct platform_device *pdev)
-{
-	struct mtk8250_data *data = platform_get_drvdata(pdev);
-
-	pm_runtime_get_sync(&pdev->dev);
-
-	serial8250_unregister_port(data->line);
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
-
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		mtk8250_runtime_suspend(&pdev->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mtk8250_suspend(struct device *dev)
 {
@@ -292,18 +275,18 @@ static const struct of_device_id mtk8250_of_match[] = {
 	{ .compatible = "mediatek,mt6577-uart" },
 	{ /* Sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, mtk8250_of_match);
 
 static struct platform_driver mtk8250_platform_driver = {
 	.driver = {
-		.name		= "mt6577-uart",
-		.pm		= &mtk8250_pm_ops,
-		.of_match_table	= mtk8250_of_match,
+		.name			= "mt6577-uart",
+		.pm			= &mtk8250_pm_ops,
+		.of_match_table		= mtk8250_of_match,
+		.suppress_bind_attrs	= true,
+
 	},
 	.probe			= mtk8250_probe,
-	.remove			= mtk8250_remove,
 };
-module_platform_driver(mtk8250_platform_driver);
+builtin_platform_driver(mtk8250_platform_driver);
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init early_mtk8250_setup(struct earlycon_device *device,
@@ -319,7 +302,3 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 
 OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
 #endif
-
-MODULE_AUTHOR("Matthias Brugger");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Mediatek 8250 serial port driver");
-- 
2.6.1
