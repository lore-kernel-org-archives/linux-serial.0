From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] serial: SAMSUNG: Fix dev_name and driver_name
Date: Mon, 17 May 2010 21:46:50 +0900
Message-ID: <4BF13ABA.3090504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48859 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab0EQMqw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 May 2010 08:46:52 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L2K003DDE62SZ@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 17 May 2010 21:46:50 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L2K00EDIE629R@mmp2.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 17 May 2010 21:46:50 +0900 (KST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com

Thd dev_name and driver_name should be switched each other.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/serial/samsung.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index a9d6c56..6f3cf70 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
 
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
-	.dev_name	= "s3c2410_serial",
+	.dev_name	= S3C24XX_SERIAL_NAME,
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
-	.driver_name	= S3C24XX_SERIAL_NAME,
+	.driver_name	= "s3c2410_serial",
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
-- 
1.7.0.4
