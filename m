From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/2] serial: ralink: adds Mediatek MT7620 serial
Date: Thu, 16 Oct 2014 21:48:22 +0200
Message-ID: <1413488902-51635-2-git-send-email-blogic@openwrt.org>
References: <1413488902-51635-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:51563
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752884AbaJPTsa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 15:48:30 -0400
In-Reply-To: <1413488902-51635-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

Add the config symbol for Mediatek MT7620 SoC to the SERIAL_8250_RT288X
dependencies.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/8250/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 349ee59..13e1ccb 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -293,7 +293,7 @@ config SERIAL_8250_EM
 
 config SERIAL_8250_RT288X
 	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
-	depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883)
+	depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883 || SOC_MT7620)
 	help
 	  If you have a Ralink RT288x/RT305x SoC based board and want to use the
 	  serial port, say Y to this option. The driver can handle up to 2 serial
-- 
1.7.10.4

