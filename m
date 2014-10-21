From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 01/10] tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other platforms
Date: Tue, 21 Oct 2014 15:22:57 -0700
Message-ID: <1413930186-23168-2-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:65233 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933387AbaJUWXY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 18:23:24 -0400
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

This device was originally supported on bcm63xx only, but it shows up on
a wide variety of MIPS and ARM chipsets spanning multiple product lines.
Now that the driver has eliminated dependencies on bcm63xx-specific
header files, we can build it on any non-bcm63xx kernel.

Compile-tested on x86, both statically and as a module.  Tested for
functionality on bcm3384 (a new MIPS platform under active development).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 649b784..4a5c0c8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1283,7 +1283,7 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "bcm63xx serial port support"
 	select SERIAL_CORE
-	depends on BCM63XX
+	depends on MIPS || ARM || COMPILE_TEST
 	help
 	  If you have a bcm63xx CPU, you can enable its onboard
 	  serial port by enabling this options.
-- 
2.1.1

