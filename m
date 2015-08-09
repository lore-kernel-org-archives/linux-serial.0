From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/8] serial: imx: introduce serial_imx_enable_wakeup()
Date: Sun,  9 Aug 2015 11:19:03 -0700
Message-ID: <1439144349-10494-3-git-send-email-edubezval@gmail.com>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This change is a code reorganization. Here we introduce
serial_imx_enable_wakeup() helper function to do
the job of configuring and preparing wakeup sources
on imx serial device. The idea is to allow other
parts of the code to call this function whenever
the device is known to go to idle.

Cc: Fabio Stevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b53455d..6c6da8c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1802,15 +1802,24 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };
 
-static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
+static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
 {
-	struct imx_port *sport = platform_get_drvdata(dev);
 	unsigned int val;
 
-	/* enable wakeup from i.MX UART */
 	val = readl(sport->port.membase + UCR3);
-	val |= UCR3_AWAKEN;
+	if (on)
+		val |= UCR3_AWAKEN;
+	else
+		val &= ~UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
+}
+
+static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct imx_port *sport = platform_get_drvdata(dev);
+
+	/* enable wakeup from i.MX UART */
+	serial_imx_enable_wakeup(sport, true);
 
 	uart_suspend_port(&imx_reg, &sport->port);
 
@@ -1820,12 +1829,9 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 static int serial_imx_resume(struct platform_device *dev)
 {
 	struct imx_port *sport = platform_get_drvdata(dev);
-	unsigned int val;
 
 	/* disable wakeup from i.MX UART */
-	val = readl(sport->port.membase + UCR3);
-	val &= ~UCR3_AWAKEN;
-	writel(val, sport->port.membase + UCR3);
+	serial_imx_enable_wakeup(sport, false);
 
 	uart_resume_port(&imx_reg, &sport->port);
 
-- 
2.5.0
