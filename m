From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 2/2] serial: imx: remove null check of sport in suspend/resume function
Date: Tue, 18 Sep 2012 16:14:59 +0800
Message-ID: <1347956099-15257-2-git-send-email-richard.zhao@freescale.com>
References: <1347956099-15257-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:58842
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756645Ab2IRIOV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Sep 2012 04:14:21 -0400
In-Reply-To: <1347956099-15257-1-git-send-email-richard.zhao@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, shawn.guo@linaro.org, kernel@pengutronix.de, Richard Zhao <richard.zhao@freescale.com>

platform_get_drvdata always retrun a valid value after probe succeed.

It also fixed smatch warnings:
drivers/tty/serial/imx.c:1376 serial_imx_suspend() warn: variable dereferenced before check 'sport' (see line 1372)
drivers/tty/serial/imx.c:1392 serial_imx_resume() warn: variable dereferenced before check 'sport' (see line 1388)

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/tty/serial/imx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 49f664f..efeb8be 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1373,8 +1373,7 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 	val |= UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
 
-	if (sport)
-		uart_suspend_port(&imx_reg, &sport->port);
+	uart_suspend_port(&imx_reg, &sport->port);
 
 	return 0;
 }
@@ -1389,8 +1388,7 @@ static int serial_imx_resume(struct platform_device *dev)
 	val &= ~UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
 
-	if (sport)
-		uart_resume_port(&imx_reg, &sport->port);
+	uart_resume_port(&imx_reg, &sport->port);
 
 	return 0;
 }
-- 
1.7.9.5


