From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [RESEND] serial: of-serial: add PM suspend/resume support
Date: Tue, 11 Nov 2014 15:09:05 +0800
Message-ID: <1415689745-28572-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:39217
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751745AbaKKIBB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Nov 2014 03:01:01 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, josephl@nvidia.com, peter@hurleysoftware.com, f.fainelli@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jingchang Lu <jingchang.lu@freescale.com>

This adds suspend/resume support for the of-serial driver
to provide power management support on devices attatched.

The handling may vary since not every of_serial device is
an 8250 port. Currently only 8250 port handling is added
in the suspend/resume function based on the type switch.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Joseph Lo <josephl@nvidia.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Tested-by: Florina Fainelli <f.fainelli@gmail.com>
---
This patch merges the two pervious accepted patches into one
to make things clearly:
	commit	2dea53bf57783f243c892e99c10c6921e956aa7e
	serial: of-serial: add PM suspend/resume support

	commit	513e438581020334e0345561adeeeaefa36701be
	serial: of-serial: fix up PM ops on no_console_suspend and port type

The first has a bug that causes a hardware hang on register
access if no_console_suspend command line option used, also
lack of disnguishing the port type. Then there is the second
one.

The first has entered 3.18-rc but the second not, and both
have entered linux-next tree, so please drop them first to
apply this one. Thanks.

 drivers/tty/serial/of_serial.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e60b59f..f66d814 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -9,6 +9,7 @@
  *  2 of the License, or (at your option) any later version.
  *
  */
+#include <linux/console.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -251,6 +252,70 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_SERIAL_8250
+static void of_serial_suspend_8250(struct of_serial_info *info)
+{
+	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
+	struct uart_port *port = &port8250->port;
+
+	serial8250_suspend_port(info->line);
+	if (info->clk && (!uart_console(port) || console_suspend_enabled))
+		clk_disable_unprepare(info->clk);
+}
+
+static void of_serial_resume_8250(struct of_serial_info *info)
+{
+	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
+	struct uart_port *port = &port8250->port;
+
+	if (info->clk && (!uart_console(port) || console_suspend_enabled))
+		clk_prepare_enable(info->clk);
+
+	serial8250_resume_port(info->line);
+}
+#else
+static inline void of_serial_suspend_8250(struct of_serial_info *info)
+{
+}
+
+static inline void of_serial_resume_8250(struct of_serial_info *info)
+{
+}
+#endif
+
+static int of_serial_suspend(struct device *dev)
+{
+	struct of_serial_info *info = dev_get_drvdata(dev);
+
+	switch (info->type) {
+	case PORT_8250 ... PORT_MAX_8250:
+		of_serial_suspend_8250(info);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int of_serial_resume(struct device *dev)
+{
+	struct of_serial_info *info = dev_get_drvdata(dev);
+
+	switch (info->type) {
+	case PORT_8250 ... PORT_MAX_8250:
+		of_serial_resume_8250(info);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
+
 /*
  * A few common types, add more as needed.
  */
@@ -282,6 +347,7 @@ static struct platform_driver of_platform_serial_driver = {
 	.driver = {
 		.name = "of_serial",
 		.of_match_table = of_platform_serial_table,
+		.pm = &of_serial_pm_ops,
 	},
 	.probe = of_platform_serial_probe,
 	.remove = of_platform_serial_remove,
-- 
1.8.0

