From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 1/9] serial-uartlite: Move the uart register
Date: Tue, 16 Oct 2018 15:48:00 +0530
Message-ID: <1539685088-13465-2-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Move the uart register. This fixes the error path where the
clock disable is missed out.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f0344ad..77bc9d0 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -763,6 +763,15 @@ static int ulite_probe(struct platform_device *pdev)
 	if (prop)
 		id = be32_to_cpup(prop);
 #endif
+	if (!ulite_uart_driver.state) {
+		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
+		ret = uart_register_driver(&ulite_uart_driver);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return ret;
+		}
+	}
+
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
 			     GFP_KERNEL);
 	if (!pdata)
@@ -794,15 +803,6 @@ static int ulite_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (!ulite_uart_driver.state) {
-		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
-		ret = uart_register_driver(&ulite_uart_driver);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
-			return ret;
-		}
-	}
-
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
 	clk_disable(pdata->clk);
-- 
2.1.1
