From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 2/8] MIPS: BCM63XX: provide periph clock as refclk for uart
Date: Wed, 20 Sep 2017 13:14:02 +0200
Message-ID: <20170920111408.29711-3-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920111408.29711-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add a lookup as "refclk" to describe its function for the uarts.

Reviewed-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/mips/bcm63xx/clk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index f712c9558d57..d8dac1f9a65a 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -363,6 +363,8 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
 static struct clk_lookup bcm3368_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -376,6 +378,8 @@ static struct clk_lookup bcm3368_clks[] = {
 static struct clk_lookup bcm6328_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -387,6 +391,7 @@ static struct clk_lookup bcm6328_clks[] = {
 static struct clk_lookup bcm6338_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -399,6 +404,7 @@ static struct clk_lookup bcm6338_clks[] = {
 static struct clk_lookup bcm6345_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -411,6 +417,7 @@ static struct clk_lookup bcm6345_clks[] = {
 static struct clk_lookup bcm6348_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -423,6 +430,8 @@ static struct clk_lookup bcm6348_clks[] = {
 static struct clk_lookup bcm6358_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -436,6 +445,8 @@ static struct clk_lookup bcm6358_clks[] = {
 static struct clk_lookup bcm6362_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -449,6 +460,8 @@ static struct clk_lookup bcm6362_clks[] = {
 static struct clk_lookup bcm6368_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
