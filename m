From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] serial/amba-pl011: move custom pin control to driver
Date: Wed, 23 May 2012 21:18:46 +0200
Message-ID: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:41469 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965474Ab2EWTTP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 May 2012 15:19:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij <linus.walleij@linaro.org>

We had a boot regression in Ux500 in the merge window because
two orthogonal pin control schemes for the PL011 were merged
at the same time:

- One using the .init() and .exit() hooks into the platform
  for Ux500 putting the pins into default vs sleep state
  respectively as the port was started/stopped.
  commit a09806607fd20bed2f8c41fe22793386790a14aa
  "ARM: ux500: switch to using pinctrl for uart0"

- One hogging the default setting at PL011 probe()
  commit 258e055111d3cde2607e0d04eb91da2f7a59b591
  "serial: amba-pl011: adopt pinctrl support"

To get a solution that works for both let's scrap the stuff
in the platform callbacks, instead have the driver itself
select default and sleep states when the port is
started/stopped. Hopefully this works for all clients.
Platform callbacks are bad for device tree migration anyway,
so this rids us of another problem in Ux500.

Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Reported-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   54 +-----------------------------------
 drivers/tty/serial/amba-pl011.c    |   45 +++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4bc0cbc..e7af625 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -540,43 +540,12 @@ static void ux500_uart0_reset(void)
 	udelay(1);
 }
 
-/* This needs to be referenced by callbacks */
-struct pinctrl *u0_p;
-struct pinctrl_state *u0_def;
-struct pinctrl_state *u0_sleep;
-
-static void ux500_uart0_init(void)
-{
-	int ret;
-
-	if (IS_ERR(u0_p) || IS_ERR(u0_def))
-		return;
-
-	ret = pinctrl_select_state(u0_p, u0_def);
-	if (ret)
-		pr_err("could not set UART0 defstate\n");
-}
-
-static void ux500_uart0_exit(void)
-{
-	int ret;
-
-	if (IS_ERR(u0_p) || IS_ERR(u0_sleep))
-		return;
-
-	ret = pinctrl_select_state(u0_p, u0_sleep);
-	if (ret)
-		pr_err("could not set UART0 idlestate\n");
-}
-
 static struct amba_pl011_data uart0_plat = {
 #ifdef CONFIG_STE_DMA40
 	.dma_filter = stedma40_filter,
 	.dma_rx_param = &uart0_dma_cfg_rx,
 	.dma_tx_param = &uart0_dma_cfg_tx,
 #endif
-	.init = ux500_uart0_init,
-	.exit = ux500_uart0_exit,
 	.reset = ux500_uart0_reset,
 };
 
@@ -598,28 +567,7 @@ static struct amba_pl011_data uart2_plat = {
 
 static void __init mop500_uart_init(struct device *parent)
 {
-	struct amba_device *uart0_device;
-
-	uart0_device = db8500_add_uart0(parent, &uart0_plat);
-	if (uart0_device) {
-		u0_p = pinctrl_get(&uart0_device->dev);
-		if (IS_ERR(u0_p))
-			dev_err(&uart0_device->dev,
-				"could not get UART0 pinctrl\n");
-		else {
-			u0_def = pinctrl_lookup_state(u0_p,
-						      PINCTRL_STATE_DEFAULT);
-			if (IS_ERR(u0_def)) {
-				dev_err(&uart0_device->dev,
-					"could not get UART0 defstate\n");
-			}
-			u0_sleep = pinctrl_lookup_state(u0_p,
-							PINCTRL_STATE_SLEEP);
-			if (IS_ERR(u0_sleep))
-				dev_err(&uart0_device->dev,
-					"could not get UART0 idlestate\n");
-		}
-	}
+	db8500_add_uart0(parent, &uart0_plat);
 	db8500_add_uart1(parent, &uart1_plat);
 	db8500_add_uart2(parent, &uart2_plat);
 }
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4ad721f..c17923e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -133,6 +133,10 @@ struct pl011_dmatx_data {
 struct uart_amba_port {
 	struct uart_port	port;
 	struct clk		*clk;
+	/* Two optional pin states - default & sleep */
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pins_default;
+	struct pinctrl_state	*pins_sleep;
 	const struct vendor_data *vendor;
 	unsigned int		dmacr;		/* dma control reg */
 	unsigned int		im;		/* interrupt mask */
@@ -1312,6 +1316,14 @@ static int pl011_startup(struct uart_port *port)
 	unsigned int cr;
 	int retval;
 
+	/* Optionaly enable pins to be muxed in and configured */
+	if (!IS_ERR(uap->pins_default)) {
+		retval = pinctrl_select_state(uap->pinctrl, uap->pins_default);
+		if (retval)
+			dev_err(port->dev,
+				"could not set default pins\n");
+	}
+
 	retval = clk_prepare(uap->clk);
 	if (retval)
 		goto out;
@@ -1420,6 +1432,7 @@ static void pl011_shutdown(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int cr;
+	int retval;
 
 	/*
 	 * disable all interrupts
@@ -1462,6 +1475,14 @@ static void pl011_shutdown(struct uart_port *port)
 	 */
 	clk_disable(uap->clk);
 	clk_unprepare(uap->clk);
+	/* Optionally let pins go into sleep states */
+	if (!IS_ERR(uap->pins_sleep)) {
+		retval = pinctrl_select_state(uap->pinctrl, uap->pins_sleep);
+		if (retval)
+			dev_err(port->dev,
+				"could not set pins to sleep state\n");
+	}
+
 
 	if (uap->port.dev->platform_data) {
 		struct amba_pl011_data *plat;
@@ -1792,6 +1813,14 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	if (!uap)
 		return -ENODEV;
 
+	/* Allow pins to be muxed in and configured */
+	if (!IS_ERR(uap->pins_default)) {
+		ret = pinctrl_select_state(uap->pinctrl, uap->pins_default);
+		if (ret)
+			dev_err(uap->port.dev,
+				"could not set default pins\n");
+	}
+
 	ret = clk_prepare(uap->clk);
 	if (ret)
 		return ret;
@@ -1844,7 +1873,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
-	struct pinctrl *pinctrl;
 	void __iomem *base;
 	int i, ret;
 
@@ -1869,11 +1897,20 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto free;
 	}
 
-	pinctrl = devm_pinctrl_get_select_default(&dev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
+	uap->pinctrl = devm_pinctrl_get(&dev->dev);
+	if (IS_ERR(uap->pinctrl)) {
+		ret = PTR_ERR(uap->pinctrl);
 		goto unmap;
 	}
+	uap->pins_default = pinctrl_lookup_state(uap->pinctrl,
+						 PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(uap->pins_default))
+		dev_err(&dev->dev, "could not get default pinstate\n");
+
+	uap->pins_sleep = pinctrl_lookup_state(uap->pinctrl,
+					       PINCTRL_STATE_SLEEP);
+	if (IS_ERR(uap->pins_sleep))
+		dev_dbg(&dev->dev, "could not get sleep pinstate\n");
 
 	uap->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(uap->clk)) {
-- 
1.7.9.2

