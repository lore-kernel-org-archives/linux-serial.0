From: Darius Augulis <augulis.darius@gmail.com>
Subject: [PATCH] serial: samsung: fix device name
Date: Thu, 05 Aug 2010 23:10:18 +0300
Message-ID: <20100805201000.14030.34703.stgit@darius-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33402 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361Ab0HEUKX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Aug 2010 16:10:23 -0400
Received: by eya25 with SMTP id 25so2553618eya.19
        for <linux-serial@vger.kernel.org>; Thu, 05 Aug 2010 13:10:22 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org, ben-linux@fluff.org

Swap device and driver names in serial/samsung.c

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 drivers/serial/samsung.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index a9d6c56..9d63f24 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
 
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
-	.dev_name	= "s3c2410_serial",
+	.driver_name    = "s3c2410_serial",
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
-	.driver_name	= S3C24XX_SERIAL_NAME,
+	.dev_name       = S3C24XX_SERIAL_NAME,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };

