From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 5/8] tty/serial: at91: add dtr control via gpio
Date: Fri,  7 Feb 2014 15:59:12 +0100
Message-ID: <1391785155-18525-6-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:45343 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaBGPAW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:22 -0500
Received: by mail-we0-f169.google.com with SMTP id t61so2414994wes.0
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:21 -0800 (PST)
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

On sam9x5, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
so we have to control them via GPIO.

This patch permits to use a GPIO to control the DTR signal.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt |  3 +++
 arch/arm/mach-at91/at91rm9200_devices.c                  |  5 +++++
 arch/arm/mach-at91/at91sam9260_devices.c                 |  7 +++++++
 arch/arm/mach-at91/at91sam9261_devices.c                 |  4 ++++
 arch/arm/mach-at91/at91sam9263_devices.c                 |  4 ++++
 arch/arm/mach-at91/at91sam9g45_devices.c                 |  5 +++++
 arch/arm/mach-at91/at91sam9rl_devices.c                  |  5 +++++
 drivers/tty/serial/atmel_serial.c                        | 13 +++++++++++++
 include/linux/platform_data/atmel.h                      |  1 +
 9 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 6c0898e4b58e..77d45c88b494 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -17,6 +17,8 @@ Optional properties:
   function pin for the USART RTS feature. If unsure, don't specify this property.
 - cts-gpios: specify a GPIO for CTS line. It will use specified PIO instead of the peripheral
   function pin for the USART CTS feature. If unsure, don't specify this property.
+- dtr-gpios: specify a GPIO for DTR line. It will use specified PIO instead of the peripheral
+  function pin for the USART DTR feature. If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -39,6 +41,7 @@ Example:
 		atmel,use-dma-tx;
 		rts-gpios = <&pioD 15 0>;
 		cts-gpios = <&pioD 16 0>;
+		dtr-gpios = <&pioD 17 0>;
 	};
 
 - use DMA:
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 4688a85cabc4..d8523cc05157 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -924,6 +924,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -964,6 +965,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1016,6 +1018,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1069,6 +1072,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1114,6 +1118,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 5e8f0d1add1d..b8e325b00e1a 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -821,6 +821,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -861,6 +862,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -914,6 +916,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -959,6 +962,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1004,6 +1008,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1049,6 +1054,7 @@ static struct atmel_uart_data uart4_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1089,6 +1095,7 @@ static struct atmel_uart_data uart5_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index f0ccc835e331..3a05d9f09b0d 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -882,6 +882,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -922,6 +923,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -967,6 +969,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1012,6 +1015,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 1e696ceacfaf..d26255ba3907 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1326,6 +1326,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1366,6 +1367,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1411,6 +1413,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1456,6 +1459,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index b75eb826b803..67e9f7f259e1 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1589,6 +1589,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_rx	= 0,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1629,6 +1630,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1674,6 +1676,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1719,6 +1722,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1764,6 +1768,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 67bf5811b38f..94fecc40dbba 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -958,6 +958,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -998,6 +999,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1051,6 +1053,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1096,6 +1099,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1141,6 +1145,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7a6b0506c050..f5bdb84aed53 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -133,6 +133,7 @@ struct gpio_lines {
 	int rts;	/* optional RTS GPIO */
 	int cts;	/* optional CTS GPIO */
 	int cts_irq;
+	int dtr;	/* optional DTR GPIO */
 };
 
 /*
@@ -339,6 +340,13 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 	else
 		control |= ATMEL_US_RTSDIS;
 
+	if (gpio_is_valid(atmel_port->gpio.dtr)) {
+		if (mctrl & TIOCM_DTR)
+			gpio_set_value(atmel_port->gpio.dtr, 0);
+		else
+			gpio_set_value(atmel_port->gpio.dtr, 1);
+	}
+
 	if (mctrl & TIOCM_DTR)
 		control |= ATMEL_US_DTREN;
 	else
@@ -2454,6 +2462,8 @@ static int atmel_init_gpios(struct atmel_uart_port *atmel_port,
 				 "RTS", NULL);
 	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.cts,
 				  "CTS", &atmel_port->gpio.cts_irq);
+	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.dtr,
+				  "DTR", NULL);
 	return ret;
 }
 
@@ -2494,13 +2504,16 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->uart.line = ret;
 	port->gpio.rts = -EINVAL; /* Invalid, zero could be valid */
 	port->gpio.cts = -EINVAL;
+	port->gpio.dtr = -EINVAL;
 	port->gpio.cts_irq = INVALID_IRQ;
 	if (pdata) {
 		port->gpio.rts = pdata->rts_gpio;
 		port->gpio.cts = pdata->cts_gpio;
+		port->gpio.dtr = pdata->dtr_gpio;
 	} else if (np) {
 		port->gpio.rts = of_get_named_gpio(np, "rts-gpios", 0);
 		port->gpio.cts = of_get_named_gpio(np, "cts-gpios", 0);
+		port->gpio.dtr = of_get_named_gpio(np, "dtr-gpios", 0);
 	}
 
 	ret = atmel_init_gpios(port, pdev);
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 166a99ca911f..8472b6f3c618 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -86,6 +86,7 @@ struct atmel_uart_data {
 	struct serial_rs485	rs485;		/* rs485 settings */
 	int			rts_gpio;	/* optional RTS GPIO */
 	int			cts_gpio;	/* optional CTS GPIO */
+	int			dtr_gpio;	/* optional DTR GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.5

