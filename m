From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] serial: 8250: Fix serial port driver for OF platform devices
Date: Wed,  6 Jan 2016 16:23:41 -0800
Message-ID: <1452126221-1253-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

Commit afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
moved the serial port driver for Open Firmware platform devices from one
directory to another, but a mixup in Kconfig options resulted in the driver
never being built. This results in runtime failures for some xtensa,
openrisc, and powerpc configurations.

Fixes: afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
It might make sense to merge this patch with the commit introducing the problem.

 drivers/tty/serial/8250/8250_of.c | 3 +--
 drivers/tty/serial/8250/Kconfig   | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index d66fd24f87cf..33021c1f7d55 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -18,10 +18,9 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/nwpserial.h>
 #include <linux/clk.h>
 
-#include "8250/8250.h"
+#include "8250.h"
 
 struct of_serial_info {
 	struct clk *clk;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index b03cb5175113..e5ab94e381fb 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,9 +378,14 @@ config SERIAL_8250_MID
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
 
+config SERIAL_8250_OF
+	tristate
+	depends on SERIAL_8250 && OF
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
+	select SERIAL_8250_OF
 	help
 	  This option is used for all 8250 compatible serial ports that
 	  are probed through devicetree, including Open Firmware based
-- 
2.1.4
