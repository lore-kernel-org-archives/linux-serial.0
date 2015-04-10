From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: earlycon requires console support
Date: Sat, 11 Apr 2015 00:01:32 +0200
Message-ID: <5009638.HyplLv73fU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, tfiga@google.com, Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

A configuration that enables earlycon but not the core console
code causes a link error:

drivers/built-in.o: In function `setup_earlycon':
drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'

That error can be triggered by the newly added samsung earlycon support,
which is missing a 'select' statement. This patch adds the 'select'
to make serial-samsung behave like the other drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b94ba0328d3b3 ("serial: samsung: Add support for early console")

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1bde14..5cd8f38a36de 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -241,6 +241,7 @@ config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
 	depends on PLAT_SAMSUNG || ARCH_EXYNOS
 	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
