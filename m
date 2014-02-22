From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/3] serial: imx: Remove init() and exit() platform callbacks
Date: Sat, 22 Feb 2014 16:01:35 +0400
Message-ID: <1393070495-11220-3-git-send-email-shc_work@mail.ru>
References: <1393070495-11220-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp40.i.mail.ru ([94.100.177.100]:49749 "EHLO smtp40.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbaBVMBs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 22 Feb 2014 07:01:48 -0500
In-Reply-To: <1393070495-11220-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/mach-mx31moboard.c     | 21 +++++----------------
 drivers/tty/serial/imx.c                 | 27 ++-------------------------
 include/linux/platform_data/serial-imx.h |  2 --
 3 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index b3738e6..8f45afe 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -128,27 +128,15 @@ static struct platform_device mx31moboard_flash = {
 	.num_resources = 1,
 };
 
-static int moboard_uart0_init(struct platform_device *pdev)
+static void __init moboard_uart0_init(void)
 {
-	int ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_CTS1), "uart0-cts-hack");
-	if (ret)
-		return ret;
-
-	ret = gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CTS1), 0);
-	if (ret)
+	if (!gpio_request(IOMUX_TO_GPIO(MX31_PIN_CTS1), "uart0-cts-hack")) {
+		gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CTS1), 0);
 		gpio_free(IOMUX_TO_GPIO(MX31_PIN_CTS1));
-
-	return ret;
-}
-
-static void moboard_uart0_exit(struct platform_device *pdev)
-{
-	gpio_free(IOMUX_TO_GPIO(MX31_PIN_CTS1));
+	}
 }
 
 static const struct imxuart_platform_data uart0_pdata __initconst = {
-	.init = moboard_uart0_init,
-	.exit = moboard_uart0_exit,
 };
 
 static const struct imxuart_platform_data uart4_pdata __initconst = {
@@ -543,6 +531,7 @@ static void __init mx31moboard_init(void)
 
 	imx31_add_imx2_wdt();
 
+	moboard_uart0_init();
 	imx31_add_imx_uart0(&uart0_pdata);
 	imx31_add_imx_uart4(&uart4_pdata);
 
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 37c3939..3b6c1a2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1901,7 +1901,6 @@ static void serial_imx_probe_pdata(struct imx_port *sport,
 static int serial_imx_probe(struct platform_device *pdev)
 {
 	struct imx_port *sport;
-	struct imxuart_platform_data *pdata;
 	void __iomem *base;
 	int ret = 0;
 	struct resource *res;
@@ -1955,38 +1954,16 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	imx_ports[sport->port.line] = sport;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (pdata && pdata->init) {
-		ret = pdata->init(pdev);
-		if (ret)
-			return ret;
-	}
-
-	ret = uart_add_one_port(&imx_reg, &sport->port);
-	if (ret)
-		goto deinit;
 	platform_set_drvdata(pdev, sport);
 
-	return 0;
-deinit:
-	if (pdata && pdata->exit)
-		pdata->exit(pdev);
-	return ret;
+	return uart_add_one_port(&imx_reg, &sport->port);
 }
 
 static int serial_imx_remove(struct platform_device *pdev)
 {
-	struct imxuart_platform_data *pdata;
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	pdata = dev_get_platdata(&pdev->dev);
-
-	uart_remove_one_port(&imx_reg, &sport->port);
-
-	if (pdata && pdata->exit)
-		pdata->exit(pdev);
-
-	return 0;
+	return uart_remove_one_port(&imx_reg, &sport->port);
 }
 
 static struct platform_driver serial_imx_driver = {
diff --git a/include/linux/platform_data/serial-imx.h b/include/linux/platform_data/serial-imx.h
index 4adec9b..3cc2e3c 100644
--- a/include/linux/platform_data/serial-imx.h
+++ b/include/linux/platform_data/serial-imx.h
@@ -23,8 +23,6 @@
 #define IMXUART_IRDA        (1<<1)
 
 struct imxuart_platform_data {
-	int (*init)(struct platform_device *pdev);
-	void (*exit)(struct platform_device *pdev);
 	unsigned int flags;
 	void (*irda_enable)(int enable);
 	unsigned int irda_inv_rx:1;
-- 
1.8.3.2

