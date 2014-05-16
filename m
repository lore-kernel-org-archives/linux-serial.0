From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] serial: pch_uart: Fix Kconfig dependencies
Date: Fri, 16 May 2014 10:48:50 +0200
Message-ID: <20140516104850.12c30fb4@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34850 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755616AbaEPIsx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 May 2014 04:48:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

The pch_uart driver is for a companion chip to the Intel Atom E600
series processors. These are 32-bit x86 processors so the driver is
only needed on X86_32. Add COMPILE_TEST as an alternative, so that the
driver can still be build-tested elsewhere.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc5.orig/drivers/tty/serial/Kconfig	2014-04-22 14:43:58.025637639 +0200
+++ linux-3.15-rc5/drivers/tty/serial/Kconfig	2014-05-16 10:41:03.629069889 +0200
@@ -1323,7 +1323,7 @@ config SERIAL_IFX6X60
 
 config SERIAL_PCH_UART
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) UART"
-	depends on PCI
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	select SERIAL_CORE
 	help
 	  This driver is for PCH(Platform controller Hub) UART of Intel EG20T


-- 
Jean Delvare
SUSE L3 Support
