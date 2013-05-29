From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] serial: samsung: missing uart_unregister_driver() on error in s3c24xx_serial_modinit()
Date: Wed, 29 May 2013 13:47:09 +0800
Message-ID: <CAPgLHd9ZCxMnYkEVOMtNafY=PsZX7AZ0-+D=9wBOLEc8fF-0_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:64079 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3E2FrL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 May 2013 01:47:11 -0400
Received: by mail-bk0-f52.google.com with SMTP id mz10so4572304bkb.25
        for <linux-serial@vger.kernel.org>; Tue, 28 May 2013 22:47:09 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing uart_unregister_driver() before return from
s3c24xx_serial_modinit() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/samsung.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 8942941..1c2b8c3 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1798,7 +1798,13 @@ static int __init s3c24xx_serial_modinit(void)
 		return ret;
 	}
 
-	return platform_driver_register(&samsung_serial_driver);
+	ret = platform_driver_register(&samsung_serial_driver);
+	if (ret < 0) {
+		pr_err("Failed to register platform driver\n");
+		uart_unregister_driver(&s3c24xx_uart_drv);
+	}
+
+	return ret;
 }
 
 static void __exit s3c24xx_serial_modexit(void)

