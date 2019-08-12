From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 09/14] serial: tegra: set maximum num of uart ports to 8
Date: Mon, 12 Aug 2019 16:58:18 +0530
Message-ID: <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

Set maximum number of UART ports to 8 as older chips have 7 ports and
Tergra194 and later chips will have 8 ports. Add this info to chip data
and register uart driver in platform driver probe.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index e0379d9..329923c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -62,7 +62,7 @@
 #define TEGRA_UART_TX_TRIG_4B			0x20
 #define TEGRA_UART_TX_TRIG_1B			0x30
 
-#define TEGRA_UART_MAXIMUM			5
+#define TEGRA_UART_MAXIMUM			8
 
 /* Default UART setting when started: 115200 no parity, stop, 8 data bits */
 #define TEGRA_UART_DEFAULT_BAUD			115200
@@ -87,6 +87,7 @@ struct tegra_uart_chip_data {
 	bool	allow_txfifo_reset_fifo_mode;
 	bool	support_clk_src_div;
 	bool	fifo_mode_enable_status;
+	int	uart_max_port;
 };
 
 struct tegra_uart_port {
@@ -1323,6 +1324,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.allow_txfifo_reset_fifo_mode	= true,
 	.support_clk_src_div		= false,
 	.fifo_mode_enable_status	= false,
+	.uart_max_port			= 5,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
@@ -1330,6 +1332,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.allow_txfifo_reset_fifo_mode	= false,
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= false,
+	.uart_max_port			= 5,
 };
 
 static struct tegra_uart_chip_data tegra186_uart_chip_data = {
@@ -1337,6 +1340,7 @@ static struct tegra_uart_chip_data tegra186_uart_chip_data = {
 	.allow_txfifo_reset_fifo_mode	= false,
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= true,
+	.uart_max_port			= 5,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
@@ -1386,6 +1390,7 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	u->type = PORT_TEGRA;
 	u->fifosize = 32;
 	tup->cdata = cdata;
+	tegra_uart_driver.nr = cdata->uart_max_port;
 
 	platform_set_drvdata(pdev, tup);
 	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1411,6 +1416,13 @@ static int tegra_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(tup->rst);
 	}
 
+	ret = uart_register_driver(&tegra_uart_driver);
+	if (ret < 0) {
+		pr_err("Could not register %s driver\n",
+		       tegra_uart_driver.driver_name);
+		return ret;
+	}
+
 	u->iotype = UPIO_MEM32;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
@@ -1472,13 +1484,6 @@ static int __init tegra_uart_init(void)
 {
 	int ret;
 
-	ret = uart_register_driver(&tegra_uart_driver);
-	if (ret < 0) {
-		pr_err("Could not register %s driver\n",
-			tegra_uart_driver.driver_name);
-		return ret;
-	}
-
 	ret = platform_driver_register(&tegra_uart_platform_driver);
 	if (ret < 0) {
 		pr_err("Uart platform driver register failed, e = %d\n", ret);
-- 
2.7.4
