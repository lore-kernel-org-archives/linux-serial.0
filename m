From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 6/8] MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
Date: Wed, 20 Sep 2017 13:14:06 +0200
Message-ID: <20170920111408.29711-7-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920111408.29711-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Split up the HSSPL clock into rate and a gate clock, to more closely
match the actual hardware.

Reviewed-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/mips/bcm63xx/clk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index d8dac1f9a65a..ba5758551c94 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -248,6 +248,10 @@ static struct clk clk_hsspi = {
 	.set	= hsspi_set,
 };
 
+/*
+ * HSSPI PLL
+ */
+static struct clk clk_hsspi_pll;
 
 /*
  * XTM clock
@@ -380,6 +384,7 @@ static struct clk_lookup bcm6328_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -447,6 +452,7 @@ static struct clk_lookup bcm6362_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -481,7 +487,7 @@ static int __init bcm63xx_clk_init(void)
 		clkdev_add_table(bcm3368_clks, ARRAY_SIZE(bcm3368_clks));
 		break;
 	case BCM6328_CPU_ID:
-		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		clk_hsspi_pll.rate = HSSPI_PLL_HZ_6328;
 		clkdev_add_table(bcm6328_clks, ARRAY_SIZE(bcm6328_clks));
 		break;
 	case BCM6338_CPU_ID:
@@ -497,7 +503,7 @@ static int __init bcm63xx_clk_init(void)
 		clkdev_add_table(bcm6358_clks, ARRAY_SIZE(bcm6358_clks));
 		break;
 	case BCM6362_CPU_ID:
-		clk_hsspi.rate = HSSPI_PLL_HZ_6362;
+		clk_hsspi_pll.rate = HSSPI_PLL_HZ_6362;
 		clkdev_add_table(bcm6362_clks, ARRAY_SIZE(bcm6362_clks));
 		break;
 	case BCM6368_CPU_ID:
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
