From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] serial: imx: add hibernation support
Date: Wed,  1 Nov 2017 13:51:41 +0100
Message-ID: <20171101125141.18770-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

During hibernation, freeze/thaw/restore dev_pm_ops are called instead of
suspend/resume. Hook up the hibernation ops. The _noirq parts are
identical, but suspend/resume are replaced with variants that do not
enable wakeup from i.MX UART. There is no need to restore register
contents in thaw_noirq.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/tty/serial/imx.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dfeff3951f934..6bbe7dd58ac62 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2346,11 +2346,39 @@ static int imx_serial_port_resume(struct device *dev)
 	return 0;
 }
 
+static int imx_serial_port_freeze(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_port *sport = platform_get_drvdata(pdev);
+
+	uart_suspend_port(&imx_reg, &sport->port);
+
+	/* Needed to enable clock in suspend_noirq */
+	return clk_prepare(sport->clk_ipg);
+}
+
+static int imx_serial_port_thaw(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_port *sport = platform_get_drvdata(pdev);
+
+	uart_resume_port(&imx_reg, &sport->port);
+
+	clk_unprepare(sport->clk_ipg);
+
+	return 0;
+}
+
 static const struct dev_pm_ops imx_serial_port_pm_ops = {
 	.suspend_noirq = imx_serial_port_suspend_noirq,
 	.resume_noirq = imx_serial_port_resume_noirq,
+	.freeze_noirq = imx_serial_port_suspend_noirq,
+	.restore_noirq = imx_serial_port_resume_noirq,
 	.suspend = imx_serial_port_suspend,
 	.resume = imx_serial_port_resume,
+	.freeze = imx_serial_port_freeze,
+	.thaw = imx_serial_port_thaw,
+	.restore = imx_serial_port_thaw,
 };
 
 static struct platform_driver serial_imx_driver = {
-- 
2.11.0
