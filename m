From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 2/7] tty/serial: meson_uart: update to stable bindings
Date: Fri,  9 Jun 2017 11:49:11 +0200
Message-ID: <1497001756-942-3-git-send-email-narmstrong@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org, Helmut Klein <hgkr.klein@gmail.com>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Helmut Klein <hgkr.klein@gmail.com>

This patch handle the stable UART bindings but also keeps compatibility
with the legacy non-stable bindings until all boards uses them.

Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 109 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 60f1679..d2c8136 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -579,8 +579,12 @@ static void meson_serial_early_console_write(struct console *co,
 	device->con->write = meson_serial_early_console_write;
 	return 0;
 }
+/* Legacy bindings, should be removed when no more used */
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
 		    meson_serial_early_console_setup);
+/* Stable bindings */
+OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
+		    meson_serial_early_console_setup);
 
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
@@ -595,11 +599,95 @@ static void meson_serial_early_console_write(struct console *co,
 	.cons		= MESON_SERIAL_CONSOLE,
 };
 
+/*
+ * This function gets clocks in the legacy non-stable DT bindings.
+ * This code will be remove once all the platforms switch to the
+ * new DT bindings.
+ */
+static int meson_uart_probe_clocks_legacy(struct platform_device *pdev,
+					  struct uart_port *port)
+{
+	struct clk *clk = NULL;
+	int ret;
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't enable clk\n");
+		return ret;
+	}
+
+	devm_add_action_or_reset(&pdev->dev,
+			(void(*)(void *))clk_disable_unprepare,
+			clk);
+
+	port->uartclk = clk_get_rate(clk);
+
+	return 0;
+}
+
+static int meson_uart_probe_clocks(struct platform_device *pdev,
+				   struct uart_port *port)
+{
+	struct clk *clk_xtal = NULL;
+	struct clk *clk_pclk = NULL;
+	struct clk *clk_baud = NULL;
+	int ret;
+
+	clk_pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(clk_pclk))
+		return PTR_ERR(clk_pclk);
+
+	clk_xtal = devm_clk_get(&pdev->dev, "xtal");
+	if (IS_ERR(clk_xtal))
+		return PTR_ERR(clk_xtal);
+
+	clk_baud = devm_clk_get(&pdev->dev, "baud");
+	if (IS_ERR(clk_xtal))
+		return PTR_ERR(clk_baud);
+
+	ret = clk_prepare_enable(clk_pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't enable pclk\n");
+		return ret;
+	}
+
+	devm_add_action_or_reset(&pdev->dev,
+			(void(*)(void *))clk_disable_unprepare,
+			clk_pclk);
+
+	ret = clk_prepare_enable(clk_xtal);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't enable xtal\n");
+		return ret;
+	}
+
+	devm_add_action_or_reset(&pdev->dev,
+			(void(*)(void *))clk_disable_unprepare,
+			clk_xtal);
+
+	ret = clk_prepare_enable(clk_baud);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't enable baud clk\n");
+		return ret;
+	}
+
+	devm_add_action_or_reset(&pdev->dev,
+			(void(*)(void *))clk_disable_unprepare,
+			clk_baud);
+
+	port->uartclk = clk_get_rate(clk_baud);
+
+	return 0;
+}
+
 static int meson_uart_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
-	struct clk *clk;
 	int ret = 0;
 
 	if (pdev->dev.of_node)
@@ -625,11 +713,15 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	/* Use legacy way until all platforms switch to new bindings */
+	if (of_device_is_compatible(pdev->dev.of_node, "amlogic,meson-uart"))
+		ret = meson_uart_probe_clocks_legacy(pdev, port);
+	else
+		ret = meson_uart_probe_clocks(pdev, port);
+
+	if (ret)
+		return ret;
 
-	port->uartclk = clk_get_rate(clk);
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
 	port->irq = res_irq->start;
@@ -668,9 +760,14 @@ static int meson_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
 static const struct of_device_id meson_uart_dt_match[] = {
+	/* Legacy bindings, should be removed when no more used */
 	{ .compatible = "amlogic,meson-uart" },
+	/* Stable bindings */
+	{ .compatible = "amlogic,meson6-uart" },
+	{ .compatible = "amlogic,meson8-uart" },
+	{ .compatible = "amlogic,meson8b-uart" },
+	{ .compatible = "amlogic,meson-gx-uart" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
-- 
1.9.1
