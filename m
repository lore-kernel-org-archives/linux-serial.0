From: Christian Gut <cycloon@is-root.org>
Subject: [PATCH] 8250.ko documentation fix
Date: Fri, 26 Mar 2004 21:36:49 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040326203649.GC32569@is-root.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from is-root.org ([217.160.132.177]:39557 "EHLO gentex.is-root.org")
	by vger.kernel.org with ESMTP id S261206AbUCZUhR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Mar 2004 15:37:17 -0500
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi,

today i noticed a small bug in the help text of the 8250 driver. Module
isnt called serial, but 8250 instead.

patch is attached.

Greets,

	Christian Gut


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="linux-8250-doku.patch"

--- Kconfig~	2004-02-08 18:48:46.000000000 +0100
+++ Kconfig	2004-03-26 21:28:59.883780472 +0100
@@ -22,7 +22,7 @@
 	  work.)
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called serial.
+	  module will be called 8250.
 	  [WARNING: Do not compile this driver as a module if you are using
 	  non-standard serial ports, since the configuration information will
 	  be lost when the driver is unloaded.  This limitation may be lifted

--sm4nu43k4a2Rpi4c--
