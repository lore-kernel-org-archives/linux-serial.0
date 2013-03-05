From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] TTY: amiserial, use module_platform_driver_probe()
Date: Tue, 05 Mar 2013 12:29:20 +0900
Message-ID: <005501ce1951$9fd33ef0$df79bcd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43306 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759324Ab3CED3W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 22:29:22 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ600GLK4CC47G0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 05 Mar 2013 12:29:20 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/amiserial.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index fc70034..083710e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1798,19 +1798,7 @@ static struct platform_driver amiga_serial_driver = {
 	},
 };
 
-static int __init amiga_serial_init(void)
-{
-	return platform_driver_probe(&amiga_serial_driver, amiga_serial_probe);
-}
-
-module_init(amiga_serial_init);
-
-static void __exit amiga_serial_exit(void)
-{
-	platform_driver_unregister(&amiga_serial_driver);
-}
-
-module_exit(amiga_serial_exit);
+module_platform_driver_probe(amiga_serial_driver, amiga_serial_probe);
 
 
 #if defined(CONFIG_SERIAL_CONSOLE) && !defined(MODULE)
-- 
1.7.2.5


