From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Date: Tue, 5 Apr 2005 16:04:57 +0200
Message-ID: <20050405140457.GE6885@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56336 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261741AbVDEOFA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Apr 2005 10:05:00 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

This patch fixes the following warning:

<--  snip  -->

...
  CC      drivers/serial/8250_acpi.o
drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
drivers/serial/8250_acpi.c:51: warning: implicit declaration of function 
`acpi_register_gsi'
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old	2005-04-05 15:58:59.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c	2005-04-05 16:01:47.000000000 +0200
@@ -9,6 +9,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/config.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/module.h>

