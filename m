From: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] serial: imx: edd a .freeze_noirq function
Date: Wed, 27 Dec 2017 18:27:11 +0100
Message-ID: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
List-Id: linux-serial@vger.kernel.org

Define a .freeze_noirq function. For now, this is an identical copy of
.suspend_noirq. (We'll move the wakeup settings to .suspend_noirq
shortly.)

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/tty/serial/imx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 145ed61..250aa26 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2269,6 +2269,23 @@ static int imx_serial_port_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int imx_serial_port_freeze_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_enable(sport->clk_ipg);
+	if (ret)
+		return ret;
+
+	serial_imx_save_context(sport);
+
+	clk_disable(sport->clk_ipg);
+
+	return 0;
+}
+
 static int imx_serial_port_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -2326,7 +2343,7 @@ static int imx_serial_port_thaw(struct device *dev)
 static const struct dev_pm_ops imx_serial_port_pm_ops = {
 	.suspend_noirq = imx_serial_port_suspend_noirq,
 	.resume_noirq = imx_serial_port_resume_noirq,
-	.freeze_noirq = imx_serial_port_suspend_noirq,
+	.freeze_noirq = imx_serial_port_freeze_noirq,
 	.restore_noirq = imx_serial_port_resume_noirq,
 	.suspend = imx_serial_port_suspend,
 	.resume = imx_serial_port_resume,
-- 
2.1.4
