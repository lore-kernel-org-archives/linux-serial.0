From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 41/47] serial: remove blackfin drivers
Date: Wed, 14 Mar 2018 16:35:54 +0100
Message-ID: <20180314153603.3127932-42-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The blackfin architecture is getting removed, so both the bfin_uart
and bfin_sport_uart can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig           |  149 ----
 drivers/tty/serial/Makefile          |    2 -
 drivers/tty/serial/bfin_sport_uart.c |  937 --------------------
 drivers/tty/serial/bfin_sport_uart.h |   86 --
 drivers/tty/serial/bfin_uart.c       | 1551 ----------------------------------
 5 files changed, 2725 deletions(-)
 delete mode 100644 drivers/tty/serial/bfin_sport_uart.c
 delete mode 100644 drivers/tty/serial/bfin_sport_uart.h
 delete mode 100644 drivers/tty/serial/bfin_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f6e09326042d..031552eb3f65 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -498,92 +498,6 @@ config SERIAL_SA1100_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
-config SERIAL_BFIN
-	tristate "Blackfin serial port support"
-	depends on BLACKFIN
-	select SERIAL_CORE
-	select SERIAL_BFIN_UART0 if (BF531 || BF532 || BF533 || BF561)
-	help
-	  Add support for the built-in UARTs on the Blackfin.
-
-	  To compile this driver as a module, choose M here: the
-	  module is named bfin_uart.ko.
-
-config SERIAL_BFIN_CONSOLE
-	bool "Console on Blackfin serial port"
-	depends on SERIAL_BFIN=y
-	select SERIAL_CORE_CONSOLE
-
-choice
-	prompt "UART Mode"
-	depends on SERIAL_BFIN
-	default SERIAL_BFIN_DMA
-	help
-	  This driver supports the built-in serial ports of the Blackfin family
-	  of CPUs
-
-config SERIAL_BFIN_DMA
-	bool "DMA mode"
-	depends on !DMA_UNCACHED_NONE && KGDB_SERIAL_CONSOLE=n
-	help
-	  This driver works under DMA mode. If this option is selected, the
-	  blackfin simple dma driver is also enabled.
-
-config SERIAL_BFIN_PIO
-	bool "PIO mode"
-	help
-	  This driver works under PIO mode.
-
-endchoice
-
-config SERIAL_BFIN_UART0
-	bool "Enable UART0"
-	depends on SERIAL_BFIN
-	help
-	  Enable UART0
-
-config BFIN_UART0_CTSRTS
-	bool "Enable UART0 hardware flow control"
-	depends on SERIAL_BFIN_UART0
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_UART1
-	bool "Enable UART1"
-	depends on SERIAL_BFIN && (!BF531 && !BF532 && !BF533 && !BF561)
-	help
-	  Enable UART1
-
-config BFIN_UART1_CTSRTS
-	bool "Enable UART1 hardware flow control"
-	depends on SERIAL_BFIN_UART1
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_UART2
-	bool "Enable UART2"
-	depends on SERIAL_BFIN && (BF54x || BF538 || BF539)
-	help
-	  Enable UART2
-
-config BFIN_UART2_CTSRTS
-	bool "Enable UART2 hardware flow control"
-	depends on SERIAL_BFIN_UART2
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_UART3
-	bool "Enable UART3"
-	depends on SERIAL_BFIN && (BF54x)
-	help
-	  Enable UART3
-
-config BFIN_UART3_CTSRTS
-	bool "Enable UART3 hardware flow control"
-	depends on SERIAL_BFIN_UART3
-	help
-	  Enable hardware flow control in the driver.
-
 config SERIAL_IMX
 	tristate "IMX serial port support"
 	depends on HAS_DMA
@@ -1231,69 +1145,6 @@ config SERIAL_SC16IS7XX_SPI
           This is additional support to exsisting driver.
           You must select at least one bus for the driver to be built.
 
-config SERIAL_BFIN_SPORT
-	tristate "Blackfin SPORT emulate UART"
-	depends on BLACKFIN
-	select SERIAL_CORE
-	help
-	  Enable SPORT emulate UART on Blackfin series.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_sport_uart.
-
-config SERIAL_BFIN_SPORT_CONSOLE
-	bool "Console on Blackfin sport emulated uart"
-	depends on SERIAL_BFIN_SPORT=y
-	select SERIAL_CORE_CONSOLE
-
-config SERIAL_BFIN_SPORT0_UART
-	bool "Enable UART over SPORT0"
-	depends on SERIAL_BFIN_SPORT && !(BF542 || BF544)
-	help
-	  Enable UART over SPORT0
-
-config SERIAL_BFIN_SPORT0_UART_CTSRTS
-	bool "Enable UART over SPORT0 hardware flow control"
-	depends on SERIAL_BFIN_SPORT0_UART
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_SPORT1_UART
-	bool "Enable UART over SPORT1"
-	depends on SERIAL_BFIN_SPORT
-	help
-	  Enable UART over SPORT1
-
-config SERIAL_BFIN_SPORT1_UART_CTSRTS
-	bool "Enable UART over SPORT1 hardware flow control"
-	depends on SERIAL_BFIN_SPORT1_UART
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_SPORT2_UART
-	bool "Enable UART over SPORT2"
-	depends on SERIAL_BFIN_SPORT && (BF54x || BF538 || BF539)
-	help
-	  Enable UART over SPORT2
-
-config SERIAL_BFIN_SPORT2_UART_CTSRTS
-	bool "Enable UART over SPORT2 hardware flow control"
-	depends on SERIAL_BFIN_SPORT2_UART
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_SPORT3_UART
-	bool "Enable UART over SPORT3"
-	depends on SERIAL_BFIN_SPORT && (BF54x || BF538 || BF539)
-	help
-	  Enable UART over SPORT3
-
-config SERIAL_BFIN_SPORT3_UART_CTSRTS
-	bool "Enable UART over SPORT3 hardware flow control"
-	depends on SERIAL_BFIN_SPORT3_UART
-	help
-	  Enable hardware flow control in the driver.
-
 config SERIAL_TIMBERDALE
 	tristate "Support for timberdale UART"
 	select SERIAL_CORE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index c21835dc16b2..a9242484e821 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -29,8 +29,6 @@ obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
-obj-$(CONFIG_SERIAL_BFIN) += bfin_uart.o
-obj-$(CONFIG_SERIAL_BFIN_SPORT) += bfin_sport_uart.o
 obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_MAX310X) += max310x.o
diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
deleted file mode 100644
index 4ccca5d22f4f..000000000000
diff --git a/drivers/tty/serial/bfin_sport_uart.h b/drivers/tty/serial/bfin_sport_uart.h
deleted file mode 100644
index 4b12f45d6580..000000000000
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
deleted file mode 100644
index 4755fa696321..000000000000
-- 
2.9.0
