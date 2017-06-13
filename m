From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: Kconfig: remove AVR32
Date: Tue, 13 Jun 2017 22:35:09 +0200
Message-ID: <20170613203509.32026-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

AVR32 is now removed from the kernel, removed the config symbol that
doesn't exist anymore. Also take the opportunity to reword the help to
include sama5.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5c8850f7a2a0..063c71e8de41 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -114,14 +114,14 @@ config SERIAL_SB1250_DUART_CONSOLE
 	  If unsure, say Y.
 
 config SERIAL_ATMEL
-	bool "AT91 / AT32 on-chip serial port support"
+	bool "Atmel on-chip serial port support"
 	depends on HAS_DMA
-	depends on ARCH_AT91 || AVR32 || COMPILE_TEST
+	depends on ARCH_AT91 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
-	  AT91 and AT32 processors.
+	  ARM processors.
 
 config SERIAL_ATMEL_CONSOLE
 	bool "Support for console on AT91 / AT32 serial port"
-- 
2.11.0
