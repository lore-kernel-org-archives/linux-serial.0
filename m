From: Devendra Naga <develkernel412222@gmail.com>
Subject: [PATCH] tty: use module_spi_driver
Date: Fri, 24 Aug 2012 03:34:42 +0530
Message-ID: <1345759482-11838-1-git-send-email-develkernel412222@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33819 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab2HWWEu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Aug 2012 18:04:50 -0400
Received: by pbbrr13 with SMTP id rr13so2259752pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 23 Aug 2012 15:04:49 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Devendra Naga <develkernel412222@gmail.com>

the driver's module init and exit functions can be replaced
with module_spi_driver as they do
only spi_register_driver and spi_unregister_driver in module's init and exit
paths.

Signed-off-by: Devendra Naga <develkernel412222@gmail.com>
---
 drivers/tty/serial/max3100.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index b4902b9..46043c2 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -910,17 +910,7 @@ static struct spi_driver max3100_driver = {
 	.resume		= max3100_resume,
 };
 
-static int __init max3100_init(void)
-{
-	return spi_register_driver(&max3100_driver);
-}
-module_init(max3100_init);
-
-static void __exit max3100_exit(void)
-{
-	spi_unregister_driver(&max3100_driver);
-}
-module_exit(max3100_exit);
+module_spi_driver(max3100_driver);
 
 MODULE_DESCRIPTION("MAX3100 driver");
 MODULE_AUTHOR("Christian Pellegrin <chripell@evolware.org>");
-- 
1.7.9.5

