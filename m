From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] [RFC] tty/serial: imx: make use of format specifier %dE
Date: Thu, 29 Aug 2019 06:37:16 +0200
Message-ID: <20190829043716.5223-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jani Nikula <jani.nikula@linux.intel.com>, Enrico Weigelt <lkml@metux.net>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I created a patch that teaches printk et al to emit a symbolic error
name for an error valued integer[1]. With that applied

	dev_err(&pdev->dev, "failed to get ipg clk: %dE\n", ret);

emits

	... failed to get ipg clk: EPROBE_DEFER

if ret is -EPROBE_DEFER. Petr Mladek (i.e. one of the printk
maintainers) had concerns if this would be well received and worth the
effort. He asked to present it to a few subsystems. So for now, this
patch converting the imx UART driver shouldn't be applied yet but it
would be great to get some feedback about if you think that being able
to easily printk (for example) "EIO" instead of "-5" is a good idea.
Would it help you? Do you think it helps your users?

Thanks
Uwe

[1] https://lkml.org/lkml/2019/8/27/1456
---
 drivers/tty/serial/imx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 57d6e6ba556e..a3dbb9378e8b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2143,7 +2143,7 @@ static int imx_uart_probe_dt(struct imx_port *sport,
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		dev_err(&pdev->dev, "failed to get alias id, error %dE\n", ret);
 		return ret;
 	}
 	sport->port.line = ret;
@@ -2236,14 +2236,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->clk_ipg)) {
 		ret = PTR_ERR(sport->clk_ipg);
-		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to get ipg clk: %dE\n", ret);
 		return ret;
 	}
 
 	sport->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(sport->clk_per)) {
 		ret = PTR_ERR(sport->clk_per);
-		dev_err(&pdev->dev, "failed to get per clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to get per clk: %dE\n", ret);
 		return ret;
 	}
 
@@ -2252,7 +2252,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	/* For register access, we only need to enable the ipg clock. */
 	ret = clk_prepare_enable(sport->clk_ipg);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable per clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to enable per clk: %dE\n", ret);
 		return ret;
 	}
 
@@ -2330,7 +2330,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_rxint, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request rx irq: %d\n",
+			dev_err(&pdev->dev, "failed to request rx irq: %dE\n",
 				ret);
 			return ret;
 		}
@@ -2338,7 +2338,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, txirq, imx_uart_txint, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request tx irq: %d\n",
+			dev_err(&pdev->dev, "failed to request tx irq: %dE\n",
 				ret);
 			return ret;
 		}
@@ -2346,7 +2346,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
+			dev_err(&pdev->dev, "failed to request rts irq: %dE\n",
 				ret);
 			return ret;
 		}
@@ -2354,7 +2354,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
+			dev_err(&pdev->dev, "failed to request irq: %dE\n", ret);
 			return ret;
 		}
 	}
-- 
2.23.0
