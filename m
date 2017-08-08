From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] serial: 8250_uniphier: add suspend/resume support
Date: Tue,  8 Aug 2017 22:48:43 +0900
Message-ID: <1502200123-2558-4-git-send-email-yamada.masahiro@socionext.com>
References: <1502200123-2558-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502200123-2558-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Add suspend/resume support for UniPhier serial driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 97a45b798fcd..8a10b10e27aa 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -281,6 +281,40 @@ static int uniphier_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused uniphier_uart_suspend(struct device *dev)
+{
+	struct uniphier8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
+
+	serial8250_suspend_port(priv->line);
+
+	if (!uart_console(&up->port) || console_suspend_enabled)
+		clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused uniphier_uart_resume(struct device *dev)
+{
+	struct uniphier8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	int ret;
+
+	if (!uart_console(&up->port) || console_suspend_enabled) {
+		ret = clk_prepare_enable(priv->clk);
+		if (ret)
+			return ret;
+	}
+
+	serial8250_resume_port(priv->line);
+
+	return 0;
+}
+
+static const struct dev_pm_ops uniphier_uart_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(uniphier_uart_suspend, uniphier_uart_resume)
+};
+
 static const struct of_device_id uniphier_uart_match[] = {
 	{ .compatible = "socionext,uniphier-uart" },
 	{ /* sentinel */ }
@@ -293,6 +327,7 @@ static struct platform_driver uniphier_uart_platform_driver = {
 	.driver = {
 		.name	= "uniphier-uart",
 		.of_match_table = uniphier_uart_match,
+		.pm = &uniphier_uart_pm_ops,
 	},
 };
 module_platform_driver(uniphier_uart_platform_driver);
-- 
2.7.4
