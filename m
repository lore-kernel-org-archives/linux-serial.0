From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] serial: arc_uart: Fix module alias
Date: Sun, 21 Jul 2013 10:14:15 +0800
Message-ID: <1374372855.5167.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51588 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab3GUCOV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Jul 2013 22:14:21 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so5732314pab.20
        for <linux-serial@vger.kernel.org>; Sat, 20 Jul 2013 19:14:20 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

Platform drivers use "platform:" prefix in module alias.
Also use DRIVER_NAME in MODULE_ALIAS to make module autoloading work.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/tty/serial/arc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index cbf1d15..22f280a 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -773,6 +773,6 @@ module_init(arc_serial_init);
 module_exit(arc_serial_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("plat-arcfpga/uart");
+MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Vineet Gupta");
 MODULE_DESCRIPTION("ARC(Synopsys) On-Chip(fpga) serial driver");
-- 
1.8.1.2



