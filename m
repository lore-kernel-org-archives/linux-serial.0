From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/6] serial: max310x: Allow driver to be compiled as module
Date: Fri,  7 Feb 2014 18:16:03 +0400
Message-ID: <1391782568-19442-2-git-send-email-shc_work@mail.ru>
References: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:40166 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbaBGOU1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 09:20:27 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 15836FDD91E4
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2014 18:16:27 +0400 (MSK)
In-Reply-To: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3815ea..d261d76 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -289,7 +289,7 @@ config SERIAL_MAX3100
 	  MAX3100 chip support
 
 config SERIAL_MAX310X
-	bool "MAX310X support"
+	tristate "MAX310X support"
 	depends on SPI_MASTER
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
-- 
1.8.3.2

