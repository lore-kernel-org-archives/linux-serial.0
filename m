From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/4] tty: serial: 8250_mtk: Use devm_clk_get
Date: Mon, 27 Apr 2015 08:49:55 +0200
Message-ID: <1430117397-13517-3-git-send-email-s.hauer@pengutronix.de>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

When a struct device * is present clk_get should be used rather
than of_clk_get. Use the devm variant of this function to be able to
drop the clk_put in the error and remove pathes. While at it fix
a wrong error message.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 1297827..bcfaa8dc 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -131,18 +131,16 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 			   struct mtk8250_data *data)
 {
 	int err;
-	struct device_node *np = pdev->dev.of_node;
 
-	data->uart_clk = of_clk_get(np, 0);
+	data->uart_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->uart_clk)) {
-		dev_warn(&pdev->dev, "Can't get timer clock\n");
+		dev_warn(&pdev->dev, "Can't get uart clock\n");
 		return PTR_ERR(data->uart_clk);
 	}
 
 	err = clk_prepare_enable(data->uart_clk);
 	if (err) {
 		dev_warn(&pdev->dev, "Can't prepare clock\n");
-		clk_put(data->uart_clk);
 		return err;
 	}
 	p->uartclk = clk_get_rate(data->uart_clk);
@@ -215,7 +213,6 @@ static int mtk8250_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->line);
 	clk_disable_unprepare(data->uart_clk);
-	clk_put(data->uart_clk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.1.4
