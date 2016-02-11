From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 6/6] serial: 8250/ingenic: fix building with SERIAL_8250=m
Date: Thu, 11 Feb 2016 16:41:32 +0100
Message-ID: <1455205297-1021302-7-git-send-email-arnd@arndb.de>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

The Ingenic 8250 driver has a 'bool' Kconfig symbol, but that
breaks when SERIAL_8250 is a loadable module:

drivers/tty/built-in.o: In function `ingenic_uart_probe':
8250_ingenic.c:(.text+0x1c1a0): undefined reference to `serial8250_register_8250_port'

This changes the symbol to a 'tristate', plus a dependency on
SERIAL_8250, which makes it work again. Unlike the other
soc-specific backends, this one has no dependency on an
architecture or a platform. I'm adding a dependency on
MIPS || COMPILE_TEST as well here, to avoid showing the driver
on architectures that are not interested in it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_ingenic.c | 2 +-
 drivers/tty/serial/8250/Kconfig        | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 97b78558caed..b0677f610863 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -48,7 +48,7 @@ static const struct of_device_id of_match[];
 #define UART_MCR_MDCE	BIT(7)
 #define UART_MCR_FCM	BIT(6)
 
-#ifdef CONFIG_SERIAL_EARLYCON
+#if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
 static struct earlycon_device *early_device;
 
 static uint8_t __init early_in(struct uart_port *port, int offset)
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6ae0fae4f796..32df7d5a1733 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -384,9 +384,10 @@ config SERIAL_8250_UNIPHIER
 	  serial ports, say Y to this option. If unsure, say N.
 
 config SERIAL_8250_INGENIC
-	bool "Support for Ingenic SoC serial ports"
-	depends on OF_FLATTREE
-	select LIBFDT
+	tristate "Support for Ingenic SoC serial ports"
+	depends on SERIAL_8250
+	depends on (OF_FLATTREE && SERIAL_8250_CONSOLE) || !SERIAL_8250_CONSOLE
+	depends on MIPS || COMPILE_TEST
 	help
 	  If you have a system using an Ingenic SoC and wish to make use of
 	  its UARTs, say Y to this option. If unsure, say N.
-- 
2.7.0
