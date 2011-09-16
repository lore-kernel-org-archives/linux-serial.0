From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] serial: SERIAL_MRST_MAX3110 should depend on X86_MRST
Date: Fri, 16 Sep 2011 22:40:16 +0200
Message-ID: <201109162240.16874.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36868 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab1IPUkT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Sep 2011 16:40:19 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

As I understand it, driver mrst_max3110 is only useful on Moorestown
systems, so it should depend on X86_MRST.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Alan Cox <alan@linux.intel.com>
---
There are a few other drivers in a similar situation
(i2c/busses/i2c-intel-mid, gpio/langwell_gpio, tty/serial/mfd,
staging/sep) for which I suspect the same should be done,
assuming that X86_MRST is for both Moorestown and Medfield.

 drivers/tty/serial/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.1-rc4.orig/drivers/tty/serial/Kconfig	2011-08-16 11:49:57.000000000 +0200
+++ linux-3.1-rc4/drivers/tty/serial/Kconfig	2011-09-16 22:03:32.000000000 +0200
@@ -695,7 +695,7 @@ config SERIAL_SA1100_CONSOLE
 
 config SERIAL_MRST_MAX3110
 	tristate "SPI UART driver for Max3110"
-	depends on SPI_DW_PCI
+	depends on X86_MRST && SPI_DW_PCI
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	help

-- 
Jean Delvare
Suse L3
