From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] serial: sunsu: add missing platform_driver_unregister() when
 module exit
Date: Sat, 27 Apr 2013 18:13:16 +0800
Message-ID: <CAPgLHd_4TH7Ur2VWtqHD3puc9eCkfHKEP9dA-ZwnxE8MtpGLww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:52908 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab3D0KNS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Apr 2013 06:13:18 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

We have registered platform driver when module init, and
need unregister it when module exit.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
no compile test.
---
 drivers/tty/serial/sunsu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 451687c..0d84657 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1592,6 +1592,7 @@ static int __init sunsu_init(void)
 
 static void __exit sunsu_exit(void)
 {
+	platform_driver_unregister(&su_driver);
 	if (sunsu_reg.nr)
 		sunserial_unregister_minors(&sunsu_reg, sunsu_reg.nr);
 }

