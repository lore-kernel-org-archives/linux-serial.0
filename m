From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 43/47] serial: remove tile uart driver
Date: Wed, 14 Mar 2018 16:35:56 +0100
Message-ID: <20180314153603.3127932-44-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The tile architecture is getting removed, and this driver is
useless without it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig  |   9 -
 drivers/tty/serial/Makefile |   1 -
 drivers/tty/serial/tilegx.c | 689 --------------------------------------------
 3 files changed, 699 deletions(-)
 delete mode 100644 drivers/tty/serial/tilegx.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1a48ae6abb2c..736720a8d84f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1330,15 +1330,6 @@ config SERIAL_EFM32_UART_CONSOLE
 	depends on SERIAL_EFM32_UART=y
 	select SERIAL_CORE_CONSOLE
 
-config SERIAL_TILEGX
-	tristate "TILE-Gx on-chip serial port support"
-	depends on TILEGX
-	select TILE_GXIO_UART
-	select SERIAL_CORE
-	---help---
-	  This device provides access to the on-chip UARTs on the TILE-Gx
-	  processor.
-
 config SERIAL_ARC
 	tristate "ARC UART driver support"
 	select SERIAL_CORE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 606e746b61f1..b30ee2e5d518 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -63,7 +63,6 @@ obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
 obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
 obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_SERIAL_ST_ASC) += st-asc.o
-obj-$(CONFIG_SERIAL_TILEGX) += tilegx.o
 obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
 obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
 obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
diff --git a/drivers/tty/serial/tilegx.c b/drivers/tty/serial/tilegx.c
deleted file mode 100644
index f0a3ae57f881..000000000000
-- 
2.9.0
