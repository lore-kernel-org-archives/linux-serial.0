From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] serial/8250: Increase number of serial ports to 32
Date: Wed, 10 Nov 2010 14:54:39 +0100
Message-ID: <4CDAA41F.1060402@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:54328 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0KJOQs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 09:16:48 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg KH <greg@kroah.com>

This will make sure that multiple serial port cards can be
used out of the box. Otherwise the user must pass
nr_uarts parameter, that will be often forgotten and increases
support requests for serial card vendors.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/drivers/serial/Kconfig
===================================================================
--- a/drivers/serial/Kconfig	2010-11-10 03:53:21.000000000 +0100
+++ b/drivers/serial/Kconfig	2010-11-10 14:32:54.000000000 +0100
@@ -119,7 +119,7 @@
 config SERIAL_8250_NR_UARTS
 	int "Maximum number of 8250/16550 serial ports"
 	depends on SERIAL_8250
-	default "4"
+	default "32"
 	help
 	  Set this to the number of serial ports you want the driver
 	  to support.  This includes any ports discovered via ACPI or
@@ -130,7 +130,7 @@
 	int "Number of 8250/16550 serial ports to register at runtime"
 	depends on SERIAL_8250
 	range 0 SERIAL_8250_NR_UARTS
-	default "4"
+	default "32"
 	help
 	  Set this to the maximum number of serial ports you want
 	  the kernel to register at boot time.  This can be overridden

