From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] serial: Samsung: Fix return value
Date: Wed, 12 Sep 2012 12:00:01 +0530
Message-ID: <1347431401-3306-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39132 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab2ILGdF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Sep 2012 02:33:05 -0400
Received: by pbbrr13 with SMTP id rr13so1815541pbb.19
        for <linux-serial@vger.kernel.org>; Tue, 11 Sep 2012 23:33:05 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, sachin.kamat@linaro.org, patches@linaro.org

Return the value returned by the failing function instead
of -1 (which does not convey the right error information).

Fixes the following smatch warning:
drivers/tty/serial/samsung.c:1687 s3c24xx_serial_modinit() info:
why not propagate 'ret' from uart_register_driver() instead of -1?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/samsung.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index bdaa06f..8eef114 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1684,7 +1684,7 @@ static int __init s3c24xx_serial_modinit(void)
 	ret = uart_register_driver(&s3c24xx_uart_drv);
 	if (ret < 0) {
 		pr_err("Failed to register Samsung UART driver\n");
-		return -1;
+		return ret;
 	}
 
 	return platform_driver_register(&samsung_serial_driver);
-- 
1.7.4.1

