From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/4] tty: serial: 8250_mtk: use pm_runtime callbacks for
 enabling
Date: Mon, 27 Apr 2015 08:49:56 +0200
Message-ID: <1430117397-13517-4-git-send-email-s.hauer@pengutronix.de>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

The pm_runtime callbacks already enable and disable the device.
Use them in probe() and remove() instead of duplicating the
code. This allows us to concentrate more code for enabling/disabling
the UART in a single place.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 69 ++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index bcfaa8dc..2f28bd0 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -115,6 +115,29 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		tty_termios_encode_baud_rate(termios, baud, baud);
 }
 
+static int mtk8250_runtime_suspend(struct device *dev)
+{
+	struct mtk8250_data *data = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(data->uart_clk);
+
+	return 0;
+}
+
+static int mtk8250_runtime_resume(struct device *dev)
+{
+	struct mtk8250_data *data = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(data->uart_clk);
+	if (err) {
+		dev_warn(dev, "Can't enable clock\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static void
 mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
@@ -130,19 +153,12 @@ mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 			   struct mtk8250_data *data)
 {
-	int err;
-
 	data->uart_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->uart_clk)) {
 		dev_warn(&pdev->dev, "Can't get uart clock\n");
 		return PTR_ERR(data->uart_clk);
 	}
 
-	err = clk_prepare_enable(data->uart_clk);
-	if (err) {
-		dev_warn(&pdev->dev, "Can't prepare clock\n");
-		return err;
-	}
 	p->uartclk = clk_get_rate(data->uart_clk);
 
 	return 0;
@@ -193,14 +209,18 @@ static int mtk8250_probe(struct platform_device *pdev)
 	writel(0x0, uart.port.membase +
 			(MTK_UART_RATE_FIX << uart.port.regshift));
 
-	data->line = serial8250_register_8250_port(&uart);
-	if (data->line < 0)
-		return data->line;
-
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		err = mtk8250_runtime_resume(&pdev->dev);
+		if (err)
+			return err;
+	}
+
+	data->line = serial8250_register_8250_port(&uart);
+	if (data->line < 0)
+		return data->line;
 
 	return 0;
 }
@@ -212,10 +232,13 @@ static int mtk8250_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
-	clk_disable_unprepare(data->uart_clk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mtk8250_runtime_suspend(&pdev->dev);
+
 	return 0;
 }
 
@@ -239,26 +262,6 @@ static int mtk8250_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
-static int mtk8250_runtime_suspend(struct device *dev)
-{
-	struct mtk8250_data *data = dev_get_drvdata(dev);
-
-	clk_disable_unprepare(data->uart_clk);
-
-	return 0;
-}
-
-static int mtk8250_runtime_resume(struct device *dev)
-{
-	struct mtk8250_data *data = dev_get_drvdata(dev);
-
-	clk_prepare_enable(data->uart_clk);
-
-	return 0;
-}
-#endif
-
 static const struct dev_pm_ops mtk8250_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mtk8250_suspend, mtk8250_resume)
 	SET_RUNTIME_PM_OPS(mtk8250_runtime_suspend, mtk8250_runtime_resume,
-- 
2.1.4
