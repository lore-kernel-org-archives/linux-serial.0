From: mathieu.poirier@linaro.org
Subject: [PATCH 5/9] tty/serial/omap: console can only be built-in
Date: Mon,  2 Apr 2012 16:32:17 -0600
Message-ID: <1333405937-655-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:48555 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab2DBWcX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Apr 2012 18:32:23 -0400
Received: by dake40 with SMTP id e40so2957322dak.11
        for <linux-serial@vger.kernel.org>; Mon, 02 Apr 2012 15:32:22 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: arnd@arndb.de, tony@atomide.com

From: Arnd Bergmann <arnd@arndb.de>

When the omap serial driver is built as a module, we must
not allow the console driver to be selected, because consoles
can not be loadable modules.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2de9924..bcf7e24 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1041,7 +1041,7 @@ config SERIAL_OMAP
 
 config SERIAL_OMAP_CONSOLE
 	bool "Console on OMAP serial port"
-	depends on SERIAL_OMAP
+	depends on SERIAL_OMAP=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Select this option if you would like to use omap serial port as
-- 
1.7.5.4

