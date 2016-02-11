From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 5/6] serial: 8250/mediatek: fix building with SERIAL_8250=m
Date: Thu, 11 Feb 2016 16:41:31 +0100
Message-ID: <1455205297-1021302-6-git-send-email-arnd@arndb.de>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mediatek@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The Mediatek 8250 driver has a 'bool' Kconfig symbol, but that
breaks when SERIAL_8250 is a loadable module:

drivers/tty/built-in.o: In function `mtk8250_set_termios':
:(.text+0x1bee8): undefined reference to `serial8250_do_set_termios'
:(.text+0x1bf10): undefined reference to `uart_get_baud_rate'
:(.text+0x1c09c): undefined reference to `uart_get_divisor'
drivers/tty/built-in.o: In function `mtk8250_do_pm':
:(.text+0x1c0d0): undefined reference to `serial8250_do_pm'
drivers/tty/built-in.o: In function `mtk8250_probe':
:(.text+0x1c2e4): undefined reference to `serial8250_register_8250_port'
serial/8250/8250_mtk.c:287:242: error: data definition has no type or storage class [-Werror]
serial/8250/8250_mtk.c:287:122: error: 'mtk8250_platform_driver_init' defined but not used [-Werror=unused-function]

This changes the symbol to a 'tristate', so the dependency on
SERIAL_8250 also works when that is set to 'm'.
To actually build the driver, we also need to include <linux/module.h>.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 3 ++-
 drivers/tty/serial/8250/Kconfig    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 6ecc6e3e82dc..55be90c1d85e 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/serial_8250.h>
@@ -303,7 +304,7 @@ static struct platform_driver mtk8250_platform_driver = {
 };
 module_platform_driver(mtk8250_platform_driver);
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
 static int __init early_mtk8250_setup(struct earlycon_device *device,
 					const char *options)
 {
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
