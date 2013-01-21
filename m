From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: xilinx_uartps: Get clock rate info from dts
Date: Mon, 21 Jan 2013 19:57:41 +0100
Message-ID: <1358794661-328-1-git-send-email-michal.simek@xilinx.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:42593 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3AUS5r (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jan 2013 13:57:47 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so5224905wib.9
        for <linux-serial@vger.kernel.org>; Mon, 21 Jan 2013 10:57:46 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Josh Cartwright <josh.cartwright@ni.com>

From: Josh Cartwright <josh.cartwright@ni.com>

Add support for specifying clock information for the uart clk via the
device tree. This eliminates the need to hardcode rates in the device
tree.

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/zynq-7000.dtsi   |    4 ++--
 drivers/tty/serial/xilinx_uartps.c |   34 +++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 401c126..5914b56 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -44,14 +44,14 @@
 			compatible = "xlnx,xuartps";
 			reg = <0xE0000000 0x1000>;
 			interrupts = <0 27 4>;
-			clock = <50000000>;
+			clocks = <&uart_clk 0>;
 		};
 
 		uart1: uart@e0001000 {
 			compatible = "xlnx,xuartps";
 			reg = <0xE0001000 0x1000>;
 			interrupts = <0 50 4>;
-			clock = <50000000>;
+			clocks = <&uart_clk 1>;
 		};
 
 		slcr: slcr@f8000000 {
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9ab9103..1eb4657 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -17,6 +17,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/console.h>
+#include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -944,16 +945,18 @@ static int xuartps_probe(struct platform_device *pdev)
 	int rc;
 	struct uart_port *port;
 	struct resource *res, *res2;
-	int clk = 0;
+	struct clk *clk;
 
-	const unsigned int *prop;
-
-	prop = of_get_property(pdev->dev.of_node, "clock", NULL);
-	if (prop)
-		clk = be32_to_cpup(prop);
-	if (!clk) {
+	clk = of_clk_get(pdev->dev.of_node, 0);
+	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "no clock specified\n");
-		return -ENODEV;
+		return PTR_ERR(clk);
+	}
+
+	rc = clk_prepare_enable(clk);
+	if (rc) {
+		dev_err(&pdev->dev, "could not enable clock\n");
+		return -EBUSY;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -978,7 +981,8 @@ static int xuartps_probe(struct platform_device *pdev)
 		port->mapbase = res->start;
 		port->irq = res2->start;
 		port->dev = &pdev->dev;
-		port->uartclk = clk;
+		port->uartclk = clk_get_rate(clk);
+		port->private_data = clk;
 		dev_set_drvdata(&pdev->dev, port);
 		rc = uart_add_one_port(&xuartps_uart_driver, port);
 		if (rc) {
@@ -1000,14 +1004,14 @@ static int xuartps_probe(struct platform_device *pdev)
 static int xuartps_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
-	int rc = 0;
+	struct clk *clk = port->private_data;
+	int rc;
 
 	/* Remove the xuartps port from the serial core */
-	if (port) {
-		rc = uart_remove_one_port(&xuartps_uart_driver, port);
-		dev_set_drvdata(&pdev->dev, NULL);
-		port->mapbase = 0;
-	}
+	rc = uart_remove_one_port(&xuartps_uart_driver, port);
+	dev_set_drvdata(&pdev->dev, NULL);
+	port->mapbase = 0;
+	clk_disable_unprepare(clk);
 	return rc;
 }
 
-- 
1.7.0.4

