From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/3] tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other platforms
Date: Sat, 18 Oct 2014 19:30:16 -0700
Message-ID: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64121 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbaJSCal (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Oct 2014 22:30:41 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so2897005pdi.38
        for <linux-serial@vger.kernel.org>; Sat, 18 Oct 2014 19:30:40 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

This device was originally supported on bcm63xx only, but it shows up on
a wide variety of MIPS and ARM chipsets spanning multiple product lines.
Now that the driver has eliminated dependencies on bcm63xx-specific
header files, we can build it on any non-bcm63xx kernel.

Compile-tested on x86, both statically and as a module.  Tested for
functionality on bcm3384 (a new MIPS platform under active development).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
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

