From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: samsung: only use earlycon for console
Date: Tue, 19 May 2015 22:26:04 +0200
Message-ID: <3397068.2Doeo7zeZ1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peter@hurleysoftware.com, tfiga@google.com, Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-serial@vger.kernel.org

A configuration that enables earlycon but not the core console
code causes a link error:

  drivers/built-in.o: In function `setup_earlycon':
  drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'

That error can be triggered by the newly added samsung earlycon support,
which is missing a 'select' statement.

As suggested by Peter Hurley, solves the problem by moving the
'select SERIAL_EARLYCON' statement to the samsung console driver
option, as it is done by all other console drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b94ba0328d3b3 ("serial: samsung: Add support for early console")

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 43b61f8e3e74..9adfd0997865 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -241,7 +241,6 @@ config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
 	depends on PLAT_SAMSUNG || ARCH_EXYNOS
 	select SERIAL_CORE
-	select SERIAL_EARLYCON
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
 	  providing /dev/ttySAC0, 1 and 2 (note, some machines may not
@@ -277,6 +276,7 @@ config SERIAL_SAMSUNG_CONSOLE
 	bool "Support for console on Samsung SoC serial port"
 	depends on SERIAL_SAMSUNG=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Allow selection of the S3C24XX on-board serial ports for use as
 	  an virtual console.
