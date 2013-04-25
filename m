From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] tty: serial: mpc5xxx: fix error handing in mpc52xx_uart_init()
Date: Thu, 25 Apr 2013 15:34:27 +0800
Message-ID: <CAPgLHd_nFRt_QwQbHwW5U=gWAhrFBg7645NgASW8=CQESDsHKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:64921 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab3DYHe3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Apr 2013 03:34:29 -0400
Received: by mail-bk0-f52.google.com with SMTP id je9so194749bkc.39
        for <linux-serial@vger.kernel.org>; Thu, 25 Apr 2013 00:34:27 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing uart_unregister_driver() and uninit before return
from mpc52xx_uart_init() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/mpc52xx_uart.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 018bad9..43a6c0a 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1497,18 +1497,23 @@ mpc52xx_uart_init(void)
 	if (psc_ops && psc_ops->fifoc_init) {
 		ret = psc_ops->fifoc_init();
 		if (ret)
-			return ret;
+			goto err_init;
 	}
 
 	ret = platform_driver_register(&mpc52xx_uart_of_driver);
 	if (ret) {
 		printk(KERN_ERR "%s: platform_driver_register failed (%i)\n",
 		       __FILE__, ret);
-		uart_unregister_driver(&mpc52xx_uart_driver);
-		return ret;
+		goto err_reg;
 	}
 
 	return 0;
+err_reg:
+	if (psc_ops && psc_ops->fifoc_uninit)
+		psc_ops->fifoc_uninit();
+err_init:
+	uart_unregister_driver(&mpc52xx_uart_driver);
+	return ret;
 }
 
 static void __exit

