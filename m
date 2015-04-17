From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] tty: Remove leftover dependencies on PPC_OF
Date: Thu, 16 Apr 2015 22:20:59 -0700
Message-ID: <1429248059-18461-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Kevin Hao <haokexin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-serial@vger.kernel.org

powerpc qemu runs fail with the current upstream kernel.
Bisect points to commit 52d996270032 ("powerpc: kill PPC_OF").
Unfortunately, that commit did not remove all instances of PPC_OF.
Practical impact is that the serial driver used by powerpc qemu
targets is no longer built into the test kernel.

Fixes: 52d996270032 ("powerpc: kill PPC_OF")
Cc: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2501f01cd03..77471d3db8d3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -835,7 +835,7 @@ config SERIAL_MCF_CONSOLE
 
 config SERIAL_PMACZILOG
 	tristate "Mac or PowerMac z85c30 ESCC support"
-	depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
+	depends on (M68K && MAC) || PPC_PMAC
 	select SERIAL_CORE
 	help
 	  This driver supports the Zilog z85C30 serial ports found on
@@ -1153,7 +1153,7 @@ config SERIAL_OMAP_CONSOLE
 
 config SERIAL_OF_PLATFORM_NWPSERIAL
 	tristate "NWP serial port driver"
-	depends on PPC_OF && PPC_DCR
+	depends on PPC_DCR
 	select SERIAL_OF_PLATFORM
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_CORE
-- 
2.1.0
