From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: max310x: Fix build warning
Date: Thu, 13 Feb 2014 22:08:29 +0400
Message-ID: <1392314909-30288-2-git-send-email-shc_work@mail.ru>
References: <1392314909-30288-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:56026 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaBMSMt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 13:12:49 -0500
Received: from smtp31.i.mail.ru (smtp31.i.mail.ru [94.100.177.91])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 21BF65089263
	for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 22:09:01 +0400 (MSK)
In-Reply-To: <1392314909-30288-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

config: x86_64-randconfig-x006 (attached as .config)

All warnings:

 drivers/tty/serial/max310x.c: In function 'max310x_probe':
>> drivers/tty/serial/max310x.c:1240:1: warning: label 'out_uart' defined but not used [-Wunused-label]

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e49d88a..ef01d37 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1250,9 +1250,9 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 
 #ifdef CONFIG_GPIOLIB
 	WARN_ON(gpiochip_remove(&s->gpio));
-#endif
 
 out_uart:
+#endif
 	uart_unregister_driver(&s->uart);
 
 out_clk:
-- 
1.8.3.2

