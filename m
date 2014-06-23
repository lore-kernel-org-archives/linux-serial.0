From: Tushar Behera <tushar.b@samsung.com>
Subject: [PATCH] serial: samsung: Remove redundant label
Date: Mon, 23 Jun 2014 11:32:14 +0530
Message-ID: <1403503334-4816-1-git-send-email-tushar.b@samsung.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39045 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaFWGFY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Jun 2014 02:05:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: jslaby@suse.cz, gregkh@linuxfoundation.org

probe_err label only returns the error code. This label can be removed
and the error code can be returned directly.

Signed-off-by: Tushar Behera <tushar.b@samsung.com>
---
 drivers/tty/serial/samsung.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c1d3ebd..bf93010 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1303,7 +1303,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	ret = s3c24xx_serial_init_port(ourport, pdev);
 	if (ret < 0)
-		goto probe_err;
+		return ret;
 
 	if (!s3c24xx_uart_drv.state) {
 		ret = uart_register_driver(&s3c24xx_uart_drv);
@@ -1335,9 +1335,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to add cpufreq notifier\n");
 
 	return 0;
-
- probe_err:
-	return ret;
 }
 
 static int s3c24xx_serial_remove(struct platform_device *dev)
-- 
1.7.9.5

