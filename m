From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/4] tty: serial: 8250_mtk: Add support for bus clock
Date: Thu, 23 Apr 2015 10:51:06 +0200
Message-ID: <1429779066-21406-5-git-send-email-s.hauer@pengutronix.de>
References: <1429779066-21406-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429779066-21406-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

The mtk 8250 needs two clocks, one for providing the baudrate and
one that needs to be enabled for register accesses. The latter has
not been supported, this patch adds support for it. It is optional
for now since not all SoCs provide a bus clock.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/serial/mtk-uart.txt |  9 +++++++--
 drivers/tty/serial/8250/8250_mtk.c                    | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 4415226..369b5c3 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -14,7 +14,11 @@ Required properties:
 
 - interrupts: A single interrupt specifier.
 
-- clocks: Clock driving the hardware.
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names:
+  - "baud": The clock the baudrate is derived from
+  - "bus": The bus clock for register accesses (optional)
 
 Example:
 
@@ -22,5 +26,6 @@ Example:
 		compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
 		reg = <0x11006000 0x400>;
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
+		clocks = <&uart_clk>, <&bus_clk>;
+		clock-names = "baud", "bus";
 	};
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 2f28bd0..20c27f0 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -34,6 +34,7 @@
 struct mtk8250_data {
 	int			line;
 	struct clk		*uart_clk;
+	struct clk		*bus_clk;
 };
 
 static void
@@ -120,6 +121,7 @@ static int mtk8250_runtime_suspend(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(data->uart_clk);
+	clk_disable_unprepare(data->bus_clk);
 
 	return 0;
 }
@@ -135,6 +137,12 @@ static int mtk8250_runtime_resume(struct device *dev)
 		return err;
 	}
 
+	err = clk_prepare_enable(data->bus_clk);
+	if (err) {
+		dev_warn(dev, "Can't enable bus clock\n");
+		return err;
+	}
+
 	return 0;
 }
 
@@ -153,7 +161,7 @@ mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 			   struct mtk8250_data *data)
 {
-	data->uart_clk = devm_clk_get(&pdev->dev, NULL);
+	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
 	if (IS_ERR(data->uart_clk)) {
 		dev_warn(&pdev->dev, "Can't get uart clock\n");
 		return PTR_ERR(data->uart_clk);
@@ -161,6 +169,10 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 
 	p->uartclk = clk_get_rate(data->uart_clk);
 
+	data->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(data->bus_clk))
+		data->bus_clk = NULL;
+
 	return 0;
 }
 
-- 
2.1.4
