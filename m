From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 2/4] serial: sprd: Add power management for the Spreadtrum serial controller
Date: Mon,  4 Mar 2019 16:58:22 +0800
Message-ID: <904abaadecc22f8cbcfe0370ca30dc5c9ac52c11.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds power management for the Spreadtrum serial controller.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |   61 +++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1891a45..8f45b66 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -100,10 +100,12 @@
 #define SPRD_IMSR_TX_FIFO_EMPTY	BIT(1)
 #define SPRD_IMSR_BREAK_DETECT	BIT(7)
 #define SPRD_IMSR_TIMEOUT	BIT(13)
+#define SPRD_DEFAULT_SOURCE_CLK	26000000
 
 struct sprd_uart_port {
 	struct uart_port port;
 	char name[16];
+	struct clk *clk;
 };
 
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
@@ -491,6 +493,22 @@ static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
+static void sprd_pm(struct uart_port *port, unsigned int state,
+		unsigned int oldstate)
+{
+	struct sprd_uart_port *sup =
+		container_of(port, struct sprd_uart_port, port);
+
+	switch (state) {
+	case UART_PM_STATE_ON:
+		clk_prepare_enable(sup->clk);
+		break;
+	case UART_PM_STATE_OFF:
+		clk_disable_unprepare(sup->clk);
+		break;
+	}
+}
+
 static const struct uart_ops serial_sprd_ops = {
 	.tx_empty = sprd_tx_empty,
 	.get_mctrl = sprd_get_mctrl,
@@ -507,6 +525,7 @@ static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 	.request_port = sprd_request_port,
 	.config_port = sprd_config_port,
 	.verify_port = sprd_verify_port,
+	.pm = sprd_pm,
 };
 
 #ifdef CONFIG_SERIAL_SPRD_CONSOLE
@@ -671,11 +690,45 @@ static int sprd_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sprd_clk_init(struct uart_port *uport)
+{
+	struct clk *clk_uart, *clk_parent;
+	struct sprd_uart_port *u = sprd_port[uport->line];
+
+	clk_uart = devm_clk_get(uport->dev, "uart");
+	if (IS_ERR(clk_uart)) {
+		dev_warn(uport->dev, "uart%d can't get uart clock\n",
+			 uport->line);
+		clk_uart = NULL;
+	}
+
+	clk_parent = devm_clk_get(uport->dev, "source");
+	if (IS_ERR(clk_parent)) {
+		dev_warn(uport->dev, "uart%d can't get source clock\n",
+			 uport->line);
+		clk_parent = NULL;
+	}
+
+	if (!clk_uart || clk_set_parent(clk_uart, clk_parent))
+		uport->uartclk = SPRD_DEFAULT_SOURCE_CLK;
+	else
+		uport->uartclk = clk_get_rate(clk_uart);
+
+	u->clk = devm_clk_get(uport->dev, "enable");
+	if (IS_ERR(u->clk)) {
+		if (PTR_ERR(u->clk) != -EPROBE_DEFER)
+			dev_err(uport->dev, "uart%d can't get enable clock\n",
+				uport->line);
+		return PTR_ERR(u->clk);
+	}
+
+	return 0;
+}
+
 static int sprd_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct uart_port *up;
-	struct clk *clk;
 	int irq;
 	int index;
 	int ret;
@@ -704,9 +757,9 @@ static int sprd_probe(struct platform_device *pdev)
 	up->ops = &serial_sprd_ops;
 	up->flags = UPF_BOOT_AUTOCONF;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR_OR_NULL(clk))
-		up->uartclk = clk_get_rate(clk);
+	ret = sprd_clk_init(up);
+	if (ret)
+		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
1.7.9.5
