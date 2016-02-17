From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 5/5] serial: 8250/mediatek: fix building with SERIAL_8250=m
Date: Wed, 17 Feb 2016 16:02:35 +0100
Message-ID: <1455721357-4008289-6-git-send-email-arnd@arndb.de>
References: <1455721357-4008289-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455721357-4008289-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Martin Sperl <kernel@martin.sperl.org>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Scott Wood <scottwood@freescale.com>, linux-mediatek@lists.infradead.org
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
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 2 +-
 drivers/tty/serial/8250/Kconfig    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 6ecc6e3e82dc..a0294f3de4f8 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -303,7 +303,7 @@ static struct platform_driver mtk8250_platform_driver = {
 };
 module_platform_driver(mtk8250_platform_driver);
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
 static int __init early_mtk8250_setup(struct earlycon_device *device,
 					const char *options)
 {
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 1b0638511ac1..c45a02a7f9e2 100644
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
