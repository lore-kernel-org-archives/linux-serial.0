From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] serial: samsung: add missing platform_driver_unregister()
 when module exit
Date: Sat, 27 Apr 2013 18:14:29 +0800
Message-ID: <CAPgLHd_TQLodaOpNuU0UWEMd=LNoG3qedqsWCKk-u-Y0mJ2e3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44180 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab3D0KOa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Apr 2013 06:14:30 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so1385347wiv.7
        for <linux-serial@vger.kernel.org>; Sat, 27 Apr 2013 03:14:29 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

We have registered platform driver when module init, and
need unregister it when module exit.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
no compile test.
---
 drivers/tty/serial/samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 074b919..8942941 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1803,6 +1803,7 @@ static int __init s3c24xx_serial_modinit(void)
 
 static void __exit s3c24xx_serial_modexit(void)
 {
+	platform_driver_unregister(&samsung_serial_driver);
 	uart_unregister_driver(&s3c24xx_uart_drv);
 }
 

