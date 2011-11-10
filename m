From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH 1/1] serial: imx: convert to clk_prepare/clk_unprepare
Date: Thu, 10 Nov 2011 12:59:18 +0800
Message-ID: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:43881
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752319Ab1KJFCf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Nov 2011 00:02:35 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, Richard Zhao <richard.zhao@linaro.org>

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/tty/serial/imx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..22fd9c8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1390,6 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 		ret = PTR_ERR(sport->clk);
 		goto unmap;
 	}
+	clk_prepare(sport->clk);
 	clk_enable(sport->clk);
 
 	sport->port.uartclk = clk_get_rate(sport->clk);
@@ -1415,6 +1416,7 @@ deinit:
 clkput:
 	clk_put(sport->clk);
 	clk_disable(sport->clk);
+	clk_unprepare(sport->clk);
 unmap:
 	iounmap(sport->port.membase);
 free:
@@ -1438,6 +1440,7 @@ static int serial_imx_remove(struct platform_device *pdev)
 	}
 
 	clk_disable(sport->clk);
+	clk_unprepare(sport->clk);
 
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
-- 
1.7.5.4


