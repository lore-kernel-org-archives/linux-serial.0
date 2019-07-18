From: Changqi Hu <changqi.hu@mediatek.com>
Subject: [PATCH v2] serial: 8250-mtk: modify mtk uart power and clock management
Date: Thu, 18 Jul 2019 20:58:36 +0800
Message-ID: <1563454716-8355-1-git-send-email-changqi.hu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Changqi Hu <changqi.hu@mediatek.com>, Peter Shih <pihsun@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

modify mtk uart runtime interface, enable uart clock before register.

Signed-off-by: Changqi Hu <changqi.hu@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b0113d1..a07c8ae 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -389,7 +389,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(data->line);
 
-	/*wait until UART in idle status*/
+	/* wait until UART in idle status */
 	while
 		(serial_in(up, MTK_UART_DEBUG0));
 
@@ -426,23 +426,15 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 static void
 mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	if (!state) {
-		if (!(up->capabilities & UART_CAP_RPM))
-			mtk8250_runtime_resume(port->dev);
-		else
+	if (!state)
+		if (!mtk8250_runtime_resume(port->dev))
 			pm_runtime_get_sync(port->dev);
-	}
 
 	serial8250_do_pm(port, state, old);
 
-	if (state) {
-		if (!(up->capabilities & UART_CAP_RPM))
+	if (state)
+		if (!pm_runtime_put_sync_suspend(port->dev))
 			mtk8250_runtime_suspend(port->dev);
-		else
-			pm_runtime_put_sync_suspend(port->dev);
-	}
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -554,6 +546,9 @@ static int mtk8250_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_enable(&pdev->dev);
+	err = mtk8250_runtime_resume(&pdev->dev);
+	if (err)
+		return err;
 
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
-- 
1.8.1.1.dirty
