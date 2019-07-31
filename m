From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/14] watchdog: pnx4008_wdt: allow compile-testing
Date: Wed, 31 Jul 2019 21:56:45 +0200
Message-ID: <20190731195713.3150463-4-arnd@arndb.de>
References: <20190731195713.3150463-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190731195713.3150463-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-watchdog@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-serial@vger.kernel.org

The only thing that prevents building this driver on other
platforms is the mach/hardware.h include, which is not actually
used here at all, so remove the line and allow CONFIG_COMPILE_TEST.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig       | 2 +-
 drivers/watchdog/pnx4008_wdt.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8188963a405b..a45f9e3e442b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -551,7 +551,7 @@ config OMAP_WATCHDOG
 
 config PNX4008_WATCHDOG
 	tristate "LPC32XX Watchdog"
-	depends on ARCH_LPC32XX
+	depends on ARCH_LPC32XX || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 7b446b696f2b..e0ea133c1690 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -30,7 +30,6 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
-#include <mach/hardware.h>
 
 /* WatchDog Timer - Chapter 23 Page 207 */
 
-- 
2.20.0
