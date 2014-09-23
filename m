From: Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] serial: of-serial: add PM suspend/resume support
Date: Tue, 23 Sep 2014 16:34:12 +0800
Message-ID: <1411461252-8730-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This adds PM suspend/resume support for the of-serial driver
to provide power management support on devices attatched to it.

Signed-off-by: Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/tty/serial/of_serial.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 27981e2..8bc2563 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -240,6 +240,32 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int of_serial_suspend(struct device *dev)
+{
+	struct of_serial_info *info = dev_get_drvdata(dev);
+
+	serial8250_suspend_port(info->line);
+	if (info->clk)
+		clk_disable_unprepare(info->clk);
+
+	return 0;
+}
+
+static int of_serial_resume(struct device *dev)
+{
+	struct of_serial_info *info = dev_get_drvdata(dev);
+
+	if (info->clk)
+		clk_prepare_enable(info->clk);
+
+	serial8250_resume_port(info->line);
+
+	return 0;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
+
 /*
  * A few common types, add more as needed.
  */
@@ -271,6 +297,7 @@ static struct platform_driver of_platform_serial_driver = {
 		.name = "of_serial",
 		.owner = THIS_MODULE,
 		.of_match_table = of_platform_serial_table,
+		.pm = &of_serial_pm_ops,
 	},
 	.probe = of_platform_serial_probe,
 	.remove = of_platform_serial_remove,
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
