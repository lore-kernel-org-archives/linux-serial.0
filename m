From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Fix of_serial section mismatch warnings
Date: Wed, 5 Mar 2008 04:17:21 +0100
Message-ID: <200803050417.21735.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52825 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYCEDRb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Mar 2008 22:17:31 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>

From: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Fix the following section mismatches:

WARNING: drivers/built-in.o(.exit.text+0x5a): Section mismatch in reference from the function of_platform_serial_exit() to the variable .devinit.data:of_platform_serial_driver
The function __exit of_platform_serial_exit() references
a variable __devinitdata of_platform_serial_driver.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
 drivers/serial/of_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/serial/of_serial.c
+++ linux-2.6/drivers/serial/of_serial.c
@@ -138,7 +138,7 @@ static struct of_device_id __devinitdata
 	{ /* end of list */ },
 };
 
-static struct of_platform_driver __devinitdata of_platform_serial_driver = {
+static struct of_platform_driver of_platform_serial_driver = {
 	.owner = THIS_MODULE,
 	.name = "of_serial",
 	.probe = of_platform_serial_probe,
