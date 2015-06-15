From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] serial/uartlite: Let it build on any arch with IOMEM
Date: Mon, 15 Jun 2015 16:36:07 +0200
Message-ID: <1434378967-32486-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

Being a soft core, it can be located not only on PPC or Microblaze
platforms.

Since the driver already does endianness detection we only need to
change the Kconfig to use it in other arches.

This is also done in other softcores as xilinx-spi.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 76e65b714471..10a5f0a503e3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -594,7 +594,7 @@ config SERIAL_IMX_CONSOLE
 
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
-	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE || ARCH_ZYNQ
+	depends on HAS_IOMEM
 	select SERIAL_CORE
 	help
 	  Say Y here if you want to use the Xilinx uartlite serial controller.
-- 
2.1.4
