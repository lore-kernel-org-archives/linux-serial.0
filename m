From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 1/8] MIPS: BCM63XX: add clkdev lookup support
Date: Wed, 20 Sep 2017 13:14:01 +0200
Message-ID: <20170920111408.29711-2-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920111408.29711-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Enable clkdev lookup support to allow us providing clocks under
different names to devices more easily, so we don't need to care
about clock name clashes anymore.

Reviewed-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/mips/Kconfig       |   1 +
 arch/mips/bcm63xx/clk.c | 150 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 116 insertions(+), 35 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cb7fcc4216fd..8e3f642fb9f9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -275,6 +275,7 @@ config BCM63XX
 	select GPIOLIB
 	select HAVE_CLK
 	select MIPS_L1_CACHE_SHIFT_4
+	select CLKDEV_LOOKUP
 	help
 	 Support for BCM63XX based boards
 
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 19577f771c1f..f712c9558d57 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
@@ -359,44 +360,103 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "enet0"))
-		return &clk_enet0;
-	if (!strcmp(id, "enet1"))
-		return &clk_enet1;
-	if (!strcmp(id, "enetsw"))
-		return &clk_enetsw;
-	if (!strcmp(id, "ephy"))
-		return &clk_ephy;
-	if (!strcmp(id, "usbh"))
-		return &clk_usbh;
-	if (!strcmp(id, "usbd"))
-		return &clk_usbd;
-	if (!strcmp(id, "spi"))
-		return &clk_spi;
-	if (!strcmp(id, "hsspi"))
-		return &clk_hsspi;
-	if (!strcmp(id, "xtm"))
-		return &clk_xtm;
-	if (!strcmp(id, "periph"))
-		return &clk_periph;
-	if ((BCMCPU_IS_3368() || BCMCPU_IS_6358()) && !strcmp(id, "pcm"))
-		return &clk_pcm;
-	if ((BCMCPU_IS_6362() || BCMCPU_IS_6368()) && !strcmp(id, "ipsec"))
-		return &clk_ipsec;
-	if ((BCMCPU_IS_6328() || BCMCPU_IS_6362()) && !strcmp(id, "pcie"))
-		return &clk_pcie;
-	return ERR_PTR(-ENOENT);
-}
+static struct clk_lookup bcm3368_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+};
 
-EXPORT_SYMBOL(clk_get);
+static struct clk_lookup bcm6328_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "hsspi", &clk_hsspi),
+	CLKDEV_INIT(NULL, "pcie", &clk_pcie),
+};
 
-void clk_put(struct clk *clk)
-{
-}
+static struct clk_lookup bcm6338_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+};
+
+static struct clk_lookup bcm6345_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+};
+
+static struct clk_lookup bcm6348_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+};
 
-EXPORT_SYMBOL(clk_put);
+static struct clk_lookup bcm6358_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+};
+
+static struct clk_lookup bcm6362_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "hsspi", &clk_hsspi),
+	CLKDEV_INIT(NULL, "pcie", &clk_pcie),
+	CLKDEV_INIT(NULL, "ipsec", &clk_ipsec),
+};
+
+static struct clk_lookup bcm6368_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "xtm", &clk_xtm),
+	CLKDEV_INIT(NULL, "ipsec", &clk_ipsec),
+};
 
 #define HSSPI_PLL_HZ_6328	133333333
 #define HSSPI_PLL_HZ_6362	400000000
@@ -404,11 +464,31 @@ EXPORT_SYMBOL(clk_put);
 static int __init bcm63xx_clk_init(void)
 {
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM3368_CPU_ID:
+		clkdev_add_table(bcm3368_clks, ARRAY_SIZE(bcm3368_clks));
+		break;
 	case BCM6328_CPU_ID:
 		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		clkdev_add_table(bcm6328_clks, ARRAY_SIZE(bcm6328_clks));
+		break;
+	case BCM6338_CPU_ID:
+		clkdev_add_table(bcm6338_clks, ARRAY_SIZE(bcm6338_clks));
+		break;
+	case BCM6345_CPU_ID:
+		clkdev_add_table(bcm6345_clks, ARRAY_SIZE(bcm6345_clks));
+		break;
+	case BCM6348_CPU_ID:
+		clkdev_add_table(bcm6348_clks, ARRAY_SIZE(bcm6348_clks));
+		break;
+	case BCM6358_CPU_ID:
+		clkdev_add_table(bcm6358_clks, ARRAY_SIZE(bcm6358_clks));
 		break;
 	case BCM6362_CPU_ID:
 		clk_hsspi.rate = HSSPI_PLL_HZ_6362;
+		clkdev_add_table(bcm6362_clks, ARRAY_SIZE(bcm6362_clks));
+		break;
+	case BCM6368_CPU_ID:
+		clkdev_add_table(bcm6368_clks, ARRAY_SIZE(bcm6368_clks));
 		break;
 	}
 
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
