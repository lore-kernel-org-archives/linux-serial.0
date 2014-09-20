From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] tty: serial_mctrl_gpio: Fix COMPILE_TEST build for architectures with custom termios.h
Date: Sat, 20 Sep 2014 09:34:45 +0400
Message-ID: <1411191285-29764-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback1.mail.ru ([94.100.181.184]:47225 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821AbaITFf3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2014 01:35:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Guenter Roeck <linux@roeck-us.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Shiyan <shc_work@mail.ru>

This patch fixes COMPILE_TEST build of serial_mctrl_gpio module for
architectures with custom termios.h header.

sparc64:allmodconfig:

In file included from drivers/tty/serial/serial_mctrl_gpio.c:21:0:
include/uapi/asm-generic/termios.h:22:8: error: redefinition of 'struct termio'
./arch/sparc/include/uapi/asm/termbits.h:16:8: note: originally defined here
make[3]: *** [drivers/tty/serial/serial_mctrl_gpio.o] Error 1

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index bf9560f..a3035f9 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
-#include <uapi/asm-generic/termios.h>
+#include <linux/termios.h>
 
 #include "serial_mctrl_gpio.h"
 
-- 
1.8.5.5

