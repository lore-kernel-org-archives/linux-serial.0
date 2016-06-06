From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: 8250_uniphier: add COMPILE_TEST option
Date: Mon,  6 Jun 2016 13:30:25 +0900
Message-ID: <1465187425-11036-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Add COMPILE_TEST for the compilation test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index e46761d..b5a0f2e 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -387,7 +387,8 @@ config SERIAL_8250_MT6577
 
 config SERIAL_8250_UNIPHIER
 	tristate "Support for UniPhier on-chip UART"
-	depends on SERIAL_8250 && ARCH_UNIPHIER
+	depends on SERIAL_8250
+	depends on ARCH_UNIPHIER || COMPILE_TEST
 	help
 	  If you have a UniPhier based board and want to use the on-chip
 	  serial ports, say Y to this option. If unsure, say N.
-- 
1.9.1
