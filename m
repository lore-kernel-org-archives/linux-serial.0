From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] serial: bfin_uart: Remove redundant testing for ifdef
 CONFIG_SERIAL_BFIN_MODULE
Date: Mon, 15 Jul 2013 13:36:03 +0800
Message-ID: <1373866563.24773.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:39444 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab3GOFgK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Jul 2013 01:36:10 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so10847013pbc.31
        for <linux-serial@vger.kernel.org>; Sun, 14 Jul 2013 22:36:09 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sonic Zhang <sonic.zhang@analog.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-serial@vger.kernel.org

No idea why we have redundant testing for ifdef CONFIG_SERIAL_BFIN_MODULE,
check it once is enough.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/tty/serial/bfin_uart.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 26a3be7..72031d7 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -41,10 +41,6 @@
 # undef CONFIG_EARLY_PRINTK
 #endif
 
-#ifdef CONFIG_SERIAL_BFIN_MODULE
-# undef CONFIG_EARLY_PRINTK
-#endif
-
 /* UART name and device definitions */
 #define BFIN_SERIAL_DEV_NAME	"ttyBF"
 #define BFIN_SERIAL_MAJOR	204
-- 
1.8.1.2



