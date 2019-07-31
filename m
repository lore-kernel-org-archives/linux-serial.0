From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/14] net: lpc-enet: move phy setup into platform code
Date: Wed, 31 Jul 2019 21:56:49 +0200
Message-ID: <20190731195713.3150463-8-arnd@arndb.de>
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
To: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-watchdog@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-serial@vger.kernel.org

Setting the phy mode requires touching a platform specific
register, which prevents us from building the driver without
its header files.

Move it into a separate function in arch/arm/mach/lpc32xx
to hide the core registers from the network driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-lpc32xx/common.c       | 12 ++++++++++++
 drivers/net/ethernet/nxp/lpc_eth.c   | 12 +-----------
 include/linux/soc/nxp/lpc32xx-misc.h |  5 +++++
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index f648324d5fb4..a475339333c1 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -63,6 +63,18 @@ u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
 }
 EXPORT_SYMBOL_GPL(lpc32xx_return_iram);
 
+void lpc32xx_set_phy_interface_mode(phy_interface_t mode)
+{
+	u32 tmp = __raw_readl(LPC32XX_CLKPWR_MACCLK_CTRL);
+	tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
+	if (mode == PHY_INTERFACE_MODE_MII)
+		tmp |= LPC32XX_CLKPWR_MACCTRL_USE_MII_PINS;
+	else
+		tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
+	__raw_writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL);
+}
+EXPORT_SYMBOL_GPL(lpc32xx_set_phy_interface_mode);
+
 static struct map_desc lpc32xx_io_desc[] __initdata = {
 	{
 		.virtual	= (unsigned long)IO_ADDRESS(LPC32XX_AHB0_START),
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index bcdd0adcfb0c..0893b77c385d 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -20,9 +20,6 @@
 #include <linux/spinlock.h>
 #include <linux/soc/nxp/lpc32xx-misc.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
 #define MODNAME "lpc-eth"
 #define DRV_VERSION "1.00"
 
@@ -1237,16 +1234,9 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	dma_addr_t dma_handle;
 	struct resource *res;
 	int irq, ret;
-	u32 tmp;
 
 	/* Setup network interface for RMII or MII mode */
-	tmp = __raw_readl(LPC32XX_CLKPWR_MACCLK_CTRL);
-	tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
-	if (lpc_phy_interface_mode(dev) == PHY_INTERFACE_MODE_MII)
-		tmp |= LPC32XX_CLKPWR_MACCTRL_USE_MII_PINS;
-	else
-		tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
-	__raw_writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL);
+	lpc32xx_set_phy_interface_mode(lpc_phy_interface_mode(dev));
 
 	/* Get platform resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/include/linux/soc/nxp/lpc32xx-misc.h b/include/linux/soc/nxp/lpc32xx-misc.h
index f232e1a1bcdc..af4f82f6cf3b 100644
--- a/include/linux/soc/nxp/lpc32xx-misc.h
+++ b/include/linux/soc/nxp/lpc32xx-misc.h
@@ -9,9 +9,11 @@
 #define __SOC_LPC32XX_MISC_H
 
 #include <linux/types.h>
+#include <linux/phy.h>
 
 #ifdef CONFIG_ARCH_LPC32XX
 extern u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr);
+extern void lpc32xx_set_phy_interface_mode(phy_interface_t mode);
 #else
 static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
 {
@@ -19,6 +21,9 @@ static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaadd
 	*dmaaddr = 0;
 	return 0;
 }
+static inline void lpc32xx_set_phy_interface_mode(phy_interface_t mode)
+{
+}
 #endif
 
 #endif  /* __SOC_LPC32XX_MISC_H */
-- 
2.20.0
