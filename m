From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] serial: Samsung: Use of_match_ptr() macro
Date: Mon,  7 Jan 2013 09:50:42 +0530
Message-ID: <1357532442-5896-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:63574 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab3AGE35 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 Jan 2013 23:29:57 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so10454330pad.32
        for <linux-serial@vger.kernel.org>; Sun, 06 Jan 2013 20:29:56 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, sachin.kamat@linaro.org, patches@linaro.org

This eliminates having an #ifdef returning NULL for the case
when OF is disabled.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/samsung.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 12e5249..e393b0a 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1725,8 +1725,6 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-#else
-#define s3c24xx_uart_dt_match NULL
 #endif
 
 static struct platform_driver samsung_serial_driver = {
@@ -1737,7 +1735,7 @@ static struct platform_driver samsung_serial_driver = {
 		.name	= "samsung-uart",
 		.owner	= THIS_MODULE,
 		.pm	= SERIAL_SAMSUNG_PM_OPS,
-		.of_match_table	= s3c24xx_uart_dt_match,
+		.of_match_table	= of_match_ptr(s3c24xx_uart_dt_match),
 	},
 };
 
-- 
1.7.4.1

