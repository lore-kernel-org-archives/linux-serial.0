From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 2/8] serial: imx: introduce serial_imx_enable_wakeup()
Date: Tue, 11 Aug 2015 10:21:21 -0700
Message-ID: <1439313687-28502-3-git-send-email-edubezval@gmail.com>
References: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

This change is a code reorganization. Here we introduce
serial_imx_enable_wakeup() helper function to do
the job of configuring and preparing wakeup sources
on imx serial device. The idea is to allow other
parts of the code to call this function whenever
the device is known to go to idle.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 arch/arm/boot/dts/Makefile |  1 +
 drivers/tty/serial/imx.c   | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 821e015..d60b28f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -330,6 +330,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-wandboard-revb1.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
+	imx6sl-fox-p1.dtb \
 	imx6sl-warp.dtb
 dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-sabreauto.dtb \
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b27c232..3c2b0ac 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1972,6 +1972,18 @@ static int serial_imx_remove(struct platform_device *pdev)
 	return uart_remove_one_port(&imx_reg, &sport->port);
 }
 
+static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
+{
+	unsigned int val;
+
+	val = readl(sport->port.membase + UCR3);
+	if (on)
+		val |= UCR3_AWAKEN;
+	else
+		val &= ~UCR3_AWAKEN;
+	writel(val, sport->port.membase + UCR3);
+}
+
 static int imx_serial_port_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -2029,12 +2041,9 @@ static int imx_serial_port_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
-	unsigned int val;
 
 	/* enable wakeup from i.MX UART */
-	val = readl(sport->port.membase + UCR3);
-	val |= UCR3_AWAKEN;
-	writel(val, sport->port.membase + UCR3);
+	serial_imx_enable_wakeup(sport, true);
 
 	uart_suspend_port(&imx_reg, &sport->port);
 
@@ -2045,12 +2054,9 @@ static int imx_serial_port_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
-	unsigned int val;
 
 	/* disable wakeup from i.MX UART */
-	val = readl(sport->port.membase + UCR3);
-	val &= ~UCR3_AWAKEN;
-	writel(val, sport->port.membase + UCR3);
+	serial_imx_enable_wakeup(sport, false);
 
 	uart_resume_port(&imx_reg, &sport->port);
 
-- 
2.5.0
