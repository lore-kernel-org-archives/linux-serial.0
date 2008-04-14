From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] avr32: don't offer SERIAL_8250
Date: Mon, 14 Apr 2008 17:17:21 +0300
Message-ID: <20080414141721.GI6695@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:41218 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760838AbYDNOS0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2008 10:18:26 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: hskinnemoen@atmel.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following build error:

<--  snip  -->

...
  CC [M]  drivers/serial/8250.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/serial/8250.c:95:24: error: asm/serial.h: No such file or directory
make[3]: *** [drivers/serial/8250.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
3cb4ef80d75e118ccfd44f7006aea3db54afb31c diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index b1bbaa0..b0e216d 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -11,7 +11,7 @@ menu "Serial drivers"
 # The new 8250/16550 serial drivers
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
-	depends on (BROKEN || !SPARC)
+	depends on (BROKEN || !SPARC) && !AVR32
 	select SERIAL_CORE
 	---help---
 	  This selects whether you want to include the driver for the standard

