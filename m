From: Adam Hunt <kinema@myrealbox.com>
Subject: [PATCH] trivial typo in drivers/serial/Kconfig
Date: Wed, 21 May 2003 22:55:18 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200305212255.18769.kinema@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-send.myrealbox.com ([192.108.102.143]:24889 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262341AbTEVFmT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 May 2003 01:42:19 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch fixes 2.5's menuconfig help references to the modules "serial" and 
"serial_cs".  These modules are now called "8250" and "8250_cs".

--adam





--- drivers/serial/Kconfig      2003-05-12 04:18:08.000000000 -0700
+++ drivers/serial/Kconfig      2003-05-20 01:45:38.000000000 -0700
@@ -23,7 +23,7 @@

          If you want to compile this driver as a module, say M here and read
          <file:Documentation/modules.txt>.  The module will be called
-         serial.
+         8250.
          [WARNING: Do not compile this driver as a module if you are using
          non-standard serial ports, since the configuration information will
          be lost when the driver is unloaded.  This limitation may be lifted
@@ -73,7 +73,7 @@

          This driver is also available as a module ( = code which can be
          inserted in and removed from the running kernel whenever you want).
-         The module will be called serial_cs.  If you want to compile it as
+         The module will be called 8250_cs.  If you want to compile it as
          a module, say M here and read <file:Documentation/modules.txt>.
          If unsure, say N.

