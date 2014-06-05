From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: lpc32xx uart module can't do console
Date: Thu, 05 Jun 2014 22:54:27 +0200
Message-ID: <6303174.SjjSrHKhU6@wuerfel>
References: <4618166.h1v6p4h6Yh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62923 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaFEUyy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Jun 2014 16:54:54 -0400
In-Reply-To: <4618166.h1v6p4h6Yh@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Every uart driver that provides a console driver needs to
be built-in for the console code to work, we get a build
error for modular console drivers.

This changes the SERIAL_HS_LPC32XX_CONSOLE symbol to depend
on the SERIAL_HS_LPC32XX driver being built-in, just like
we do for all the other uart drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fb57159..b0ddd6c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -774,7 +774,7 @@ config SERIAL_HS_LPC32XX
 
 config SERIAL_HS_LPC32XX_CONSOLE
 	bool "Enable LPC32XX high speed UART serial console"
-	depends on SERIAL_HS_LPC32XX
+	depends on SERIAL_HS_LPC32XX=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you would like to be able to use one of the high speed serial

