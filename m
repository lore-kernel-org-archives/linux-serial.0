From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/14] usb: udc: lpc32xx: allow compile-testing
Date: Wed, 31 Jul 2019 21:56:44 +0200
Message-ID: <20190731195713.3150463-3-arnd@arndb.de>
References: <20190731195713.3150463-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731195713.3150463-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The only thing that prevents building this driver on other
platforms is the mach/hardware.h include, which is not actually
used here at all, so remove the line and allow CONFIG_COMPILE_TEST.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig       | 3 ++-
 drivers/usb/gadget/udc/lpc32xx_udc.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index ef0259a950ba..d354036ff6c8 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -45,7 +45,8 @@ config USB_AT91
 
 config USB_LPC32XX
 	tristate "LPC32XX USB Peripheral Controller"
-	depends on ARCH_LPC32XX && I2C
+	depends on ARCH_LPC32XX || COMPILE_TEST
+	depends on I2C
 	select USB_ISP1301
 	help
 	   This option selects the USB device controller in the LPC32xx SoC.
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 5f1b14f3e5a0..4d8847988a50 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -35,8 +35,6 @@
 #include <linux/seq_file.h>
 #endif
 
-#include <mach/hardware.h>
-
 /*
  * USB device configuration structure
  */
-- 
2.20.0
