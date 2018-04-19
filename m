From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 53/61] tty: serial: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:23 +0200
Message-ID: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Patrice Chotard <patrice.chotard@st.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/tty/serial/imx.c              | 18 ++++++------------
 drivers/tty/serial/qcom_geni_serial.c |  6 ++----
 drivers/tty/serial/st-asc.c           |  6 ++----
 drivers/tty/serial/xilinx_uartps.c    |  6 ++----
 4 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..f370c1cf4f27 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2408,8 +2408,7 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 
 static int imx_uart_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	imx_uart_save_context(sport);
 
@@ -2420,8 +2419,7 @@ static int imx_uart_suspend_noirq(struct device *dev)
 
 static int imx_uart_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_enable(sport->clk_ipg);
@@ -2435,8 +2433,7 @@ static int imx_uart_resume_noirq(struct device *dev)
 
 static int imx_uart_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
 	uart_suspend_port(&imx_uart_uart_driver, &sport->port);
@@ -2454,8 +2451,7 @@ static int imx_uart_suspend(struct device *dev)
 
 static int imx_uart_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	/* disable wakeup from i.MX UART */
 	imx_uart_enable_wakeup(sport, false);
@@ -2470,8 +2466,7 @@ static int imx_uart_resume(struct device *dev)
 
 static int imx_uart_freeze(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	uart_suspend_port(&imx_uart_uart_driver, &sport->port);
 
@@ -2480,8 +2475,7 @@ static int imx_uart_freeze(struct device *dev)
 
 static int imx_uart_thaw(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	uart_resume_port(&imx_uart_uart_driver, &sport->port);
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 65ff669373d4..66558d42d980 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1085,8 +1085,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 
 static int __maybe_unused qcom_geni_serial_sys_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
 	uart_suspend_port(uport->private_data, uport);
@@ -1095,8 +1094,7 @@ static int __maybe_unused qcom_geni_serial_sys_suspend_noirq(struct device *dev)
 
 static int __maybe_unused qcom_geni_serial_sys_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
 	if (console_suspend_enabled && uport->suspended) {
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 5f9f01fac6dd..7971997cdead 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -842,16 +842,14 @@ static int asc_serial_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int asc_serial_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 
 	return uart_suspend_port(&asc_uart_driver, port);
 }
 
 static int asc_serial_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 
 	return uart_resume_port(&asc_uart_driver, port);
 }
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index abcb4d09a2d8..3ec4efbf25a9 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1430,8 +1430,7 @@ static int cdns_uart_resume(struct device *device)
 #endif /* ! CONFIG_PM_SLEEP */
 static int __maybe_unused cdns_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 	struct cdns_uart *cdns_uart = port->private_data;
 
 	clk_disable(cdns_uart->uartclk);
@@ -1441,8 +1440,7 @@ static int __maybe_unused cdns_runtime_suspend(struct device *dev)
 
 static int __maybe_unused cdns_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 	struct cdns_uart *cdns_uart = port->private_data;
 
 	clk_enable(cdns_uart->pclk);
-- 
2.11.0
