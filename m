From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 6/8] serial: imx: add a flag to indicate we are in the suspend path
Date: Sun,  9 Aug 2015 11:19:07 -0700
Message-ID: <1439144349-10494-7-git-send-email-edubezval@gmail.com>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a simple flag that gets set across prepare and complete
callbacks in the suspend path. We the flag we may avoid
runtime pm idling at the same time.

Cc: Fabio Stevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 494b182..def52e0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -219,6 +219,8 @@ struct imx_port {
 	wait_queue_head_t	dma_wait;
 	unsigned int		saved_reg[8];
 	bool			context_saved;
+
+	bool			is_suspending;
 };
 
 struct imx_port_ucrs {
@@ -1805,6 +1807,22 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };
 
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
 static void serial_imx_restore_context(struct imx_port *sport)
 {
 	if (!sport->context_saved)
@@ -2033,6 +2051,8 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops serial_imx_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(serial_imx_suspend, serial_imx_resume)
+	.prepare        = serial_imx_prepare,
+	.complete       = serial_imx_complete,
 };
 
 static struct platform_driver serial_imx_driver = {
-- 
2.5.0
