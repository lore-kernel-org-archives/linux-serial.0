From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 42/47] serial: remove m32r_sio driver
Date: Wed, 14 Mar 2018 16:35:55 +0100
Message-ID: <20180314153603.3127932-43-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The m32r architecture is getting removed, so we don't need this
any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig        |   29 -
 drivers/tty/serial/Makefile       |    1 -
 drivers/tty/serial/m32r_sio.c     | 1053 -------------------------------------
 drivers/tty/serial/m32r_sio_reg.h |  150 ------
 4 files changed, 1233 deletions(-)
 delete mode 100644 drivers/tty/serial/m32r_sio.c
 delete mode 100644 drivers/tty/serial/m32r_sio_reg.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 031552eb3f65..1a48ae6abb2c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -905,35 +905,6 @@ config SERIAL_ICOM
 	  This driver can also be built as a module.  If so, the module
 	  will be called icom.
 
-config SERIAL_M32R_SIO
-	bool "M32R SIO I/F"
-	depends on M32R
-	default y
-	select SERIAL_CORE
-	help
-	  Say Y here if you want to use the M32R serial controller.
-
-config SERIAL_M32R_SIO_CONSOLE
-	bool "use SIO console"
-	depends on SERIAL_M32R_SIO=y
-	select SERIAL_CORE_CONSOLE
-	help
-	  Say Y here if you want to support a serial console.
-
-	  If you use an M3T-M32700UT or an OPSPUT platform,
-	  please say also y for SERIAL_M32R_PLDSIO.
-
-config SERIAL_M32R_PLDSIO
-	bool "M32R SIO I/F on a PLD"
-	depends on SERIAL_M32R_SIO=y && (PLAT_OPSPUT || PLAT_USRV || PLAT_M32700UT)
-	default n
-	help
-	  Say Y here if you want to use the M32R serial controller
-	  on a PLD (Programmable Logic Device).
-
-	  If you use an M3T-M32700UT or an OPSPUT platform,
-	  please say Y.
-
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
 	depends on HAS_TXX9_SERIAL
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index a9242484e821..606e746b61f1 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_IMX) += imx.o
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_ICOM) += icom.o
-obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
 obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
 obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
deleted file mode 100644
index 7b83a8aab495..000000000000
diff --git a/drivers/tty/serial/m32r_sio_reg.h b/drivers/tty/serial/m32r_sio_reg.h
deleted file mode 100644
index 6eed48828f94..000000000000
-- 
2.9.0
