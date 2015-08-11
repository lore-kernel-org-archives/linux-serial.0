From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 5/8] serial: imx: add a flag to indicate we are in the suspend path
Date: Tue, 11 Aug 2015 10:21:24 -0700
Message-ID: <1439313687-28502-6-git-send-email-edubezval@gmail.com>
References: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

This is a simple flag that gets set across prepare and complete
callbacks in the suspend path. We the flag we may avoid
runtime pm idling at the same time.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fe3d41c..50abb60 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -218,6 +218,8 @@ struct imx_port {
 	wait_queue_head_t	dma_wait;
 	unsigned int            saved_reg[10];
 	bool			context_saved;
+
+	bool			is_suspending;
 };
 
 struct imx_port_ucrs {
@@ -2026,6 +2028,22 @@ static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
 	writel(val, sport->port.membase + UCR1);
 }
 
+static int serial_imx_prepare(struct device *dev)
+{
+	struct imx_port *sport = dev_get_drvdata(dev);
+
+	sport->is_suspending = true;
+
+	return 0;
+}
+
+static void serial_imx_complete(struct device *dev)
+{
+	struct imx_port *sport = dev_get_drvdata(dev);
+
+	sport->is_suspending = false;
+}
+
 static int imx_serial_port_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -2091,6 +2109,8 @@ static const struct dev_pm_ops imx_serial_port_pm_ops = {
 	.resume_noirq = imx_serial_port_resume_noirq,
 	.suspend = imx_serial_port_suspend,
 	.resume = imx_serial_port_resume,
+	.prepare = serial_imx_prepare,
+	.complete = serial_imx_complete,
 };
 
 static struct platform_driver serial_imx_driver = {
-- 
2.5.0
