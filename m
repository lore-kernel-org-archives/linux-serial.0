From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/4] tty: serial: 8250_mtk: remove unnecessary test
Date: Mon, 27 Apr 2015 08:49:54 +0200
Message-ID: <1430117397-13517-2-git-send-email-s.hauer@pengutronix.de>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

When the driver has probed successfully the clk pointer is always valid,
so no need to test for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 7a11fac..1297827 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -214,10 +214,8 @@ static int mtk8250_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
-	if (!IS_ERR(data->uart_clk)) {
-		clk_disable_unprepare(data->uart_clk);
-		clk_put(data->uart_clk);
-	}
+	clk_disable_unprepare(data->uart_clk);
+	clk_put(data->uart_clk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -249,8 +247,7 @@ static int mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->uart_clk))
-		clk_disable_unprepare(data->uart_clk);
+	clk_disable_unprepare(data->uart_clk);
 
 	return 0;
 }
@@ -259,8 +256,7 @@ static int mtk8250_runtime_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->uart_clk))
-		clk_prepare_enable(data->uart_clk);
+	clk_prepare_enable(data->uart_clk);
 
 	return 0;
 }
-- 
2.1.4
