From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: max310x: Fix build error
Date: Thu, 13 Feb 2014 22:08:28 +0400
Message-ID: <1392314909-30288-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.176.58]:54181 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaBMSMK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 13:12:10 -0500
Received: from smtp31.i.mail.ru (smtp31.i.mail.ru [94.100.177.91])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id D9F5310C26B40
	for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 22:09:01 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

config: make ARCH=alpha allyesconfig

All error/warnings:

 drivers/tty/serial/max310x.c: In function 'max310x_ioctl':
>> drivers/tty/serial/max310x.c:905:7: error: 'TIOCSRS485' undeclared (first use in this function)
 drivers/tty/serial/max310x.c:905:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/max310x.c:906:3: error: implicit declaration of function 'copy_from_user' [-Werror=implicit-function-declaration]
>> drivers/tty/serial/max310x.c:929:7: error: 'TIOCGRS485' undeclared (first use in this function)
>> drivers/tty/serial/max310x.c:938:3: error: implicit declaration of function 'copy_to_user' [-Werror=implicit-function-declaration]
 cc1: some warnings being treated as errors

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8a035d6..e49d88a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -24,9 +24,10 @@
 #include <linux/regmap.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/spi/spi.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/spi/spi.h>
+#include <uapi/asm-generic/ioctls.h>
 
 #define MAX310X_NAME			"max310x"
 #define MAX310X_MAJOR			204
-- 
1.8.3.2

