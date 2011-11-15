From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] OMAP2+: UART: Make the SERIAL_OMAP depend on ARCH_OMAP2PLUS
Date: Tue, 15 Nov 2011 11:57:40 +0530
Message-ID: <1321338460-1421-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46458 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1KOG1u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Nov 2011 01:27:50 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Making  SERIAL_OMAP depend on ARCH_OMAP2PLUS instead of
oring with ARCH2/3/4.

Acked-by: Felipe Balbi <balbi@ti.com>
Suggested-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5f479da..2b2b971 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1324,7 +1324,7 @@ config SERIAL_OF_PLATFORM
 
 config SERIAL_OMAP
 	tristate "OMAP serial port support"
-	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on ARCH_OMAP2PLUS
 	select SERIAL_CORE
 	help
 	  If you have a machine based on an Texas Instruments OMAP CPU you
-- 
1.7.1

