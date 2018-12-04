From: Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] tty: xilinx_uartps: Correct return value in probe
Date: Tue, 4 Dec 2018 04:51:22 -0800
Message-ID: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, michal.simek@xilinx.com
Cc: linux-serial@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>, linux-kernel@vger.kernel.org, jollys@xilinx.com, anirudh@xilinx.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Existing driver checks for alternate clock if devm_clk_get() fails
and returns error code for last clock failure. If xilinx_uartps is
called before clock driver, devm_clk_get() returns -EPROBE_DEFER.
In this case, probe should not check for alternate clock as main
clock is already present in DTS and return -EPROBE_DEFER only.

This patch fixes it by not checking for alternate clock when main
clock get returns -EPROBE_DEFER.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 57c66d2..a23baa4 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1545,27 +1545,25 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER)
+		return PTR_ERR(cdns_uart_data->pclk);
+
 	if (IS_ERR(cdns_uart_data->pclk)) {
 		cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "aper_clk");
-		if (!IS_ERR(cdns_uart_data->pclk))
-			dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
-	}
-	if (IS_ERR(cdns_uart_data->pclk)) {
-		dev_err(&pdev->dev, "pclk clock not found.\n");
-		rc = PTR_ERR(cdns_uart_data->pclk);
-		goto err_out_unregister_driver;
+		if (IS_ERR(cdns_uart_data->pclk))
+			return PTR_ERR(cdns_uart_data->pclk);
+		dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
 	}
 
 	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
+	if (PTR_ERR(cdns_uart_data->uartclk) == -EPROBE_DEFER)
+		return PTR_ERR(cdns_uart_data->uartclk);
+
 	if (IS_ERR(cdns_uart_data->uartclk)) {
 		cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "ref_clk");
-		if (!IS_ERR(cdns_uart_data->uartclk))
-			dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
-	}
-	if (IS_ERR(cdns_uart_data->uartclk)) {
-		dev_err(&pdev->dev, "uart_clk clock not found.\n");
-		rc = PTR_ERR(cdns_uart_data->uartclk);
-		goto err_out_unregister_driver;
+		if (IS_ERR(cdns_uart_data->uartclk))
+			return PTR_ERR(cdns_uart_data->uartclk);
+		dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
 	}
 
 	rc = clk_prepare_enable(cdns_uart_data->pclk);
-- 
2.7.4
