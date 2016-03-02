From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] tty: sh-sci: Use ARCH_RENESAS
Date: Wed,  2 Mar 2016 10:35:27 +0900
Message-ID: <1456882527-3859-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on tty/tty-next

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bdbe1c533c6a..de2481cf6e58 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -733,7 +733,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on SUPERH || ARCH_SHMOBILE || H8300 || COMPILE_TEST
+	depends on SUPERH || ARCH_RENESAS || H8300 || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
2.1.4
