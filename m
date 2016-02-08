From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] serial: 8250: fix building mediatek with SERIAL_8250=m
Date: Mon,  8 Feb 2016 13:51:42 +0100
Message-ID: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Eddie Huang <eddie.huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Mediatek 8250 driver has a 'bool' Kconfig symbol, but that
breaks when SERIAL_8250 is a loadable module:

drivers/tty/built-in.o: In function `mtk8250_set_termios':
8250_ingenic.c:(.text+0x1bee8): undefined reference to `serial8250_do_set_termios'
8250_ingenic.c:(.text+0x1bf10): undefined reference to `uart_get_baud_rate'
8250_ingenic.c:(.text+0x1c09c): undefined reference to `uart_get_divisor'
drivers/tty/built-in.o: In function `mtk8250_do_pm':
8250_ingenic.c:(.text+0x1c0d0): undefined reference to `serial8250_do_pm'
drivers/tty/built-in.o: In function `mtk8250_probe':
8250_ingenic.c:(.text+0x1c2e4): undefined reference to `serial8250_register_8250_port'
serial/8250/8250_mtk.c:287:242: error: data definition has no type or storage class [-Werror]
serial/8250/8250_mtk.c:287:122: error: 'mtk8250_platform_driver_init' defined but not used [-Werror=unused-function]

This changes the symbol to a 'tristate', so the dependency on
SERIAL_8250 also works when that is set to 'm'.
To actually build the driver, we also need to include <linux/module.h>.

Note that the driver uses builtin_platform_driver() and implements
no .remove() callback, so unloading the module is not possible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 1 +
 drivers/tty/serial/8250/Kconfig    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 9038843cadc7..7e9242a5ddfe 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/serial_8250.h>
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 67ad6b0d595b..6ae0fae4f796 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -370,7 +370,7 @@ config SERIAL_8250_LPC18XX
 	  serial port, say Y to this option. If unsure, say Y.
 
 config SERIAL_8250_MT6577
-	bool "Mediatek serial port support"
+	tristate "Mediatek serial port support"
 	depends on SERIAL_8250 && ARCH_MEDIATEK
 	help
 	  If you have a Mediatek based board and want to use the
-- 
2.7.0
