From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 1/2] serial: imx: set sport as drvdata, like it's used elsewhere
Date: Tue, 18 Sep 2012 16:14:58 +0800
Message-ID: <1347956099-15257-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:46227
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755411Ab2IRIOU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Sep 2012 04:14:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, shawn.guo@linaro.org, kernel@pengutronix.de, Richard Zhao <richard.zhao@freescale.com>

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/tty/serial/imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5952b25..49f664f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1540,7 +1540,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	ret = uart_add_one_port(&imx_reg, &sport->port);
 	if (ret)
 		goto deinit;
-	platform_set_drvdata(pdev, &sport->port);
+	platform_set_drvdata(pdev, sport);
 
 	return 0;
 deinit:
-- 
1.7.9.5


