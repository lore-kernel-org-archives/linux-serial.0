From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/14] usb: ohci-nxp: enable compile-testing
Date: Wed, 31 Jul 2019 21:56:43 +0200
Message-ID: <20190731195713.3150463-2-arnd@arndb.de>
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
To: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-watchdog@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-serial@vger.kernel.org

The driver hardcodes a hardware I/O address the way one should
generally not do, and this prevents both compile-testing, and
moving the platform to CONFIG_ARCH_MULTIPLATFORM.

Change the code to be independent of the machine headers
to allow those two. Removing the hardcoded address would
be hard and is not necessary, so leave that in place for now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/Kconfig    |  3 ++-
 drivers/usb/host/ohci-nxp.c | 25 ++++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 40b5de597112..73d233d3bf4d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -441,7 +441,8 @@ config USB_OHCI_HCD_S3C2410
 
 config USB_OHCI_HCD_LPC32XX
 	tristate "Support for LPC on-chip OHCI USB controller"
-	depends on USB_OHCI_HCD && ARCH_LPC32XX
+	depends on USB_OHCI_HCD
+	depends on ARCH_LPC32XX || COMPILE_TEST
 	depends on USB_ISP1301
 	default y
 	---help---
diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index f5f532601092..c561881d0e79 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -29,10 +29,7 @@
 
 #include "ohci.h"
 
-#include <mach/hardware.h>
-
 #define USB_CONFIG_BASE		0x31020000
-#define USB_OTG_STAT_CONTROL	IO_ADDRESS(USB_CONFIG_BASE + 0x110)
 
 /* USB_OTG_STAT_CONTROL bit defines */
 #define TRANSPARENT_I2C_EN	(1 << 7)
@@ -122,19 +119,33 @@ static inline void isp1301_vbus_off(void)
 
 static void ohci_nxp_start_hc(void)
 {
-	unsigned long tmp = __raw_readl(USB_OTG_STAT_CONTROL) | HOST_EN;
+	void __iomem *usb_otg_stat_control = ioremap(USB_CONFIG_BASE + 0x110, 4);
+	unsigned long tmp;
+
+	if (WARN_ON(!usb_otg_stat_control))
+		return;
+
+	tmp = __raw_readl(usb_otg_stat_control) | HOST_EN;
 
-	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
+	__raw_writel(tmp, usb_otg_stat_control);
 	isp1301_vbus_on();
+
+	iounmap(usb_otg_stat_control);
 }
 
 static void ohci_nxp_stop_hc(void)
 {
+	void __iomem *usb_otg_stat_control = ioremap(USB_CONFIG_BASE + 0x110, 4);
 	unsigned long tmp;
 
+	if (WARN_ON(!usb_otg_stat_control))
+		return;
+
 	isp1301_vbus_off();
-	tmp = __raw_readl(USB_OTG_STAT_CONTROL) & ~HOST_EN;
-	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
+	tmp = __raw_readl(usb_otg_stat_control) & ~HOST_EN;
+	__raw_writel(tmp, usb_otg_stat_control);
+
+	iounmap(usb_otg_stat_control);
 }
 
 static int ohci_hcd_nxp_probe(struct platform_device *pdev)
-- 
2.20.0
