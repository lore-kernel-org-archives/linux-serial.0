From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] serial: timberdale: Depend on X86_32
Date: Thu, 3 Apr 2014 11:36:22 +0200
Message-ID: <20140403113622.16d51020@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59591 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbaDCJgY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Apr 2014 05:36:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

As far as I know the Timberdale chip was only used as a companion for
Intel Atom E600 series processors. As such, its drivers are only
useful on X86_32.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-3.14.orig/drivers/tty/serial/Kconfig	2014-03-31 05:40:15.000000000 +0200
+++ linux-3.14/drivers/tty/serial/Kconfig	2014-04-03 10:09:03.356682369 +0200
@@ -1226,6 +1226,7 @@ config SERIAL_BFIN_SPORT3_UART_CTSRTS
 config SERIAL_TIMBERDALE
 	tristate "Support for timberdale UART"
 	select SERIAL_CORE
+	depends on X86_32 || COMPILE_TEST
 	---help---
 	Add support for UART controller on timberdale.
 


-- 
Jean Delvare
SUSE L3 Support
