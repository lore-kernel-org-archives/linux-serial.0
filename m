From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] serial: sh_sci: remove HAVE_CLK build dependecy
Date: Wed,  5 Feb 2014 21:28:38 +0200
Message-ID: <2f1dd25b19bf588948fbebc734eebe5d61ca7007.1391628518.git.baruch@tkos.co.il>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:45856 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbaBET3Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Feb 2014 14:29:16 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>

Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
like this driver needs not depend on HAVE_CLK.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3815eaed421..ce6fd1dd0864 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -708,7 +708,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
+	depends on SUPERH || ARM || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
1.8.5.3

