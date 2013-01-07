From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/5] serial: imx: Use devm_* APIs
Date: Mon,  7 Jan 2013 10:25:06 +0530
Message-ID: <1357534506-30206-6-git-send-email-sachin.kamat@linaro.org>
References: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55604 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3AGFDe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 00:03:34 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so10393093pad.11
        for <linux-serial@vger.kernel.org>; Sun, 06 Jan 2013 21:03:33 -0800 (PST)
In-Reply-To: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, shawn.guo@linaro.org, s.hauer@pengutronix.de, sachin.kamat@linaro.org, patches@linaro.org

devm_* APIs are device managed and make cleanup and exit code simpler
and easier.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/imx.c |   32 ++++++++++----------------------
 1 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 78f7936..1a24884 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1461,7 +1461,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct pinctrl *pinctrl;
 
-	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
+	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
 		return -ENOMEM;
 
@@ -1469,19 +1469,15 @@ static int serial_imx_probe(struct platform_device *pdev)
 	if (ret > 0)
 		serial_imx_probe_pdata(sport, pdev);
 	else if (ret < 0)
-		goto free;
+		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		goto free;
-	}
+	if (!res)
+		return -ENODEV;
 
-	base = ioremap(res->start, PAGE_SIZE);
-	if (!base) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	base = devm_ioremap(&pdev->dev, res->start, PAGE_SIZE);
+	if (!base)
+		return -ENOMEM;
 
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
@@ -1503,21 +1499,21 @@ static int serial_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(pinctrl)) {
 		ret = PTR_ERR(pinctrl);
 		dev_err(&pdev->dev, "failed to get default pinctrl: %d\n", ret);
-		goto unmap;
+		return ret;
 	}
 
 	sport->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->clk_ipg)) {
 		ret = PTR_ERR(sport->clk_ipg);
 		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
-		goto unmap;
+		return ret;
 	}
 
 	sport->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(sport->clk_per)) {
 		ret = PTR_ERR(sport->clk_per);
 		dev_err(&pdev->dev, "failed to get per clk: %d\n", ret);
-		goto unmap;
+		return ret;
 	}
 
 	clk_prepare_enable(sport->clk_per);
@@ -1546,11 +1542,6 @@ deinit:
 clkput:
 	clk_disable_unprepare(sport->clk_per);
 	clk_disable_unprepare(sport->clk_ipg);
-unmap:
-	iounmap(sport->port.membase);
-free:
-	kfree(sport);
-
 	return ret;
 }
 
@@ -1571,9 +1562,6 @@ static int serial_imx_remove(struct platform_device *pdev)
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 
-	iounmap(sport->port.membase);
-	kfree(sport);
-
 	return 0;
 }
 
-- 
1.7.4.1

