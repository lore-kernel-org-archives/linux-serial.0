From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] tty: 8250_dw: fix build error for CONFIG_SERIAL_8250=m
Date: Wed, 24 Aug 2011 08:11:46 +0100
Message-ID: <1314169906-12958-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49351 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab1HXHLx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 03:11:53 -0400
Received: by wwf5 with SMTP id 5so895305wwf.1
        for <linux-serial@vger.kernel.org>; Wed, 24 Aug 2011 00:11:52 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>

Allow 8250_dw to be built as a module and export serial8250_handle_irq
so that 8250 can still be built as a module.  This prevents the
following build failure:

drivers/built-in.o: In function `dw8250_handle_irq':
8250_dw.c:(.text+0xcad9c): undefined reference to `serial8250_handle_irq'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/tty/serial/8250.c    |    1 +
 drivers/tty/serial/8250_dw.c |    5 +++++
 drivers/tty/serial/Kconfig   |    2 +-
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 6f594d2..435ce14 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1588,6 +1588,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
 static int serial8250_default_handle_irq(struct uart_port *port)
 {
diff --git a/drivers/tty/serial/8250_dw.c b/drivers/tty/serial/8250_dw.c
index e25782a..844d3a8 100644
--- a/drivers/tty/serial/8250_dw.c
+++ b/drivers/tty/serial/8250_dw.c
@@ -13,6 +13,7 @@
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
@@ -97,3 +98,7 @@ int serial8250_use_designware_io(struct uart_port *up)
 
 	return 0;
 }
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jamie Iles");
+MODULE_DESCRIPTION("Synopsys DesignWare 8250 UART support");
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2d1cc2..1002e2e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -268,7 +268,7 @@ config SERIAL_8250_RM9K
 	  If unsure, say N.
 
 config SERIAL_8250_DW
-	bool "Support for Synopsys DesignWare 8250 quirks"
+	tristate "Support for Synopsys DesignWare 8250 quirks"
 	depends on SERIAL_8250
 	help
 	  Selecting this option will enable handling of the extra features
-- 
1.7.4.4

