From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: sc26xx: Fix compile breakage
Date: Wed,  1 Aug 2012 12:00:20 +0400
Message-ID: <1343808020-26812-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp14.mail.ru ([94.100.176.91]:47256 "EHLO smtp14.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095Ab2HAIA2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Aug 2012 04:00:28 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This patch fixes the following compile breakage:

  CC      drivers/tty/serial/sc26xx.o
drivers/tty/serial/sc26xx.c: In function 'read_sc_port':
drivers/tty/serial/sc26xx.c:100: error: implicit declaration of function 'readb'
drivers/tty/serial/sc26xx.c: In function 'write_sc_port':
drivers/tty/serial/sc26xx.c:105: error: implicit declaration of function 'writeb'
drivers/tty/serial/sc26xx.c: In function 'sc26xx_probe':
drivers/tty/serial/sc26xx.c:652: error: implicit declaration of function 'ioremap_nocache'
drivers/tty/serial/sc26xx.c:652: warning: assignment makes pointer from integer without a cast
make[3]: *** [drivers/tty/serial/sc26xx.o] Error 1
make[2]: *** [drivers/tty/serial] Error 2
make[1]: *** [drivers/tty] Error 2
make: *** [drivers] Error 2

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sc26xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/sc26xx.c b/drivers/tty/serial/sc26xx.c
index e0b4b0a..3992e48 100644
--- a/drivers/tty/serial/sc26xx.c
+++ b/drivers/tty/serial/sc26xx.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
+#include <linux/io.h>
 
 #if defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
-- 
1.7.3.4

