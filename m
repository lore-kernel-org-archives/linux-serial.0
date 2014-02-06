From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2] serial: sh_sci: remove HAVE_CLK build dependecy
Date: Thu,  6 Feb 2014 10:52:52 +0200
Message-ID: <72da63d627f18c6b5907e7d9ef342242a8f985e6.1391676772.git.baruch@tkos.co.il>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
List-Id: linux-serial@vger.kernel.org

Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
like this driver needs not depend on HAVE_CLK.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: rebase on Laurent's patch
---
 drivers/tty/serial/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 923d3dea77cb..ec7f3a6d5764 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -708,7 +708,6 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on HAVE_CLK
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	select SERIAL_CORE
 
-- 
1.8.5.3

