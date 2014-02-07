From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 7/8] tty/serial: at91: add ring control via gpio
Date: Fri,  7 Feb 2014 15:59:14 +0100
Message-ID: <1391785155-18525-8-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:61335 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaBGPA3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:29 -0500
Received: by mail-wi0-f179.google.com with SMTP id hn9so919193wib.6
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:28 -0800 (PST)
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

On sam9x5, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
so we have to control them via GPIO.

This patch permits to use a GPIO to control the RI signal.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
 arch/arm/mach-at91/at91rm9200_devices.c            |  5 +++
 arch/arm/mach-at91/at91sam9260_devices.c           |  7 +++++
 arch/arm/mach-at91/at91sam9261_devices.c           |  4 +++
 arch/arm/mach-at91/at91sam9263_devices.c           |  4 +++
 arch/arm/mach-at91/at91sam9g45_devices.c           |  5 +++
 arch/arm/mach-at91/at91sam9rl_devices.c            |  5 +++
 drivers/tty/serial/atmel_serial.c                  | 36 +++++++++++++++++++++-
 include/linux/platform_data/atmel.h                |  1 +
 9 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 3b90795ee641..11d033649b19 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -21,6 +21,8 @@ Optional properties:
   function pin for the USART DTR feature. If unsure, don't specify this property.
 - dsr-gpios: specify a GPIO for DSR line. It will use specified PIO instead of the peripheral
   function pin for the USART DSR feature. If unsure, don't specify this property.
+- ri-gpios: specify a GPIO for Ring line. It will use specified PIO instead of the peripheral
+  function pin for the USART Ring feature. If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -45,6 +47,7 @@ Example:
 		cts-gpios = <&pioD 16 0>;
 		dtr-gpios = <&pioD 17 0>;
 		dsr-gpios = <&pioD 18 0>;
+		ri-gpios = <&pioD 19 0>;
 	};
 
 - use DMA:
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 980ea65142b4..11c5c7f5b067 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -926,6 +926,7 @@ static struct atmel_uart_data dbgu_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -968,6 +969,7 @@ static struct atmel_uart_data uart0_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1022,6 +1024,7 @@ static struct atmel_uart_data uart1_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1077,6 +1080,7 @@ static struct atmel_uart_data uart2_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1124,6 +1128,7 @@ static struct atmel_uart_data uart3_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index c11d1225a75c..f8ccdbe2bcbc 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -823,6 +823,7 @@ static struct atmel_uart_data dbgu_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -865,6 +866,7 @@ static struct atmel_uart_data uart0_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -920,6 +922,7 @@ static struct atmel_uart_data uart1_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -967,6 +970,7 @@ static struct atmel_uart_data uart2_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1014,6 +1018,7 @@ static struct atmel_uart_data uart3_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1061,6 +1066,7 @@ static struct atmel_uart_data uart4_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1103,6 +1109,7 @@ static struct atmel_uart_data uart5_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index ea35af48a2e2..c40aa819cfac 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -884,6 +884,7 @@ static struct atmel_uart_data dbgu_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -926,6 +927,7 @@ static struct atmel_uart_data uart0_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -973,6 +975,7 @@ static struct atmel_uart_data uart1_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1020,6 +1023,7 @@ static struct atmel_uart_data uart2_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index c8833ebd4fcb..1da08465d952 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1328,6 +1328,7 @@ static struct atmel_uart_data dbgu_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1370,6 +1371,7 @@ static struct atmel_uart_data uart0_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1417,6 +1419,7 @@ static struct atmel_uart_data uart1_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1464,6 +1467,7 @@ static struct atmel_uart_data uart2_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 76772d12acfd..4520d8f70cff 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1591,6 +1591,7 @@ static struct atmel_uart_data dbgu_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1633,6 +1634,7 @@ static struct atmel_uart_data uart0_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1680,6 +1682,7 @@ static struct atmel_uart_data uart1_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1727,6 +1730,7 @@ static struct atmel_uart_data uart2_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1774,6 +1778,7 @@ static struct atmel_uart_data uart3_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 2aa6f8ddcd53..5916d65b6362 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -960,6 +960,7 @@ static struct atmel_uart_data dbgu_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1002,6 +1003,7 @@ static struct atmel_uart_data uart0_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1057,6 +1059,7 @@ static struct atmel_uart_data uart1_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1104,6 +1107,7 @@ static struct atmel_uart_data uart2_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1151,6 +1155,7 @@ static struct atmel_uart_data uart3_data = {
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 28b3636135cd..9d47497713ab 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -136,6 +136,8 @@ struct gpio_lines {
 	int dtr;	/* optional DTR GPIO */
 	int dsr;	/* optional DSR GPIO */
 	int dsr_irq;
+	int ri;		/* optional Ring GPIO */
+	int ri_irq;
 };
 
 /*
@@ -271,6 +273,13 @@ static unsigned int atmel_get_lines_status(struct uart_port *port)
 			status &= ~ATMEL_US_DSR;
 	}
 
+	if (gpio_is_valid(atmel_port->gpio.ri)) {
+		if (gpio_get_value(atmel_port->gpio.ri))
+			status |= ATMEL_US_RI;
+		else
+			status &= ~ATMEL_US_RI;
+	}
+
 	return status;
 }
 
@@ -504,7 +513,7 @@ static void atmel_enable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = true;
 
-	ier = ATMEL_US_RIIC | ATMEL_US_DCDIC;
+	ier = ATMEL_US_DCDIC;
 
 	if (atmel_port->gpio.cts_irq != INVALID_IRQ)
 		enable_irq(atmel_port->gpio.cts_irq);
@@ -516,6 +525,11 @@ static void atmel_enable_ms(struct uart_port *port)
 	else
 		ier |= ATMEL_US_DSRIC;
 
+	if (atmel_port->gpio.ri_irq != INVALID_IRQ)
+		enable_irq(atmel_port->gpio.ri_irq);
+	else
+		ier |= ATMEL_US_RIIC;
+
 	UART_PUT_IER(port, ier);
 }
 
@@ -1124,6 +1138,10 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 			    (irq == atmel_port->gpio.dsr_irq))
 				pending |= ATMEL_US_DSRIC;
 
+			if ((irq !=  INVALID_IRQ) &&
+			    (irq == atmel_port->gpio.ri_irq))
+				pending |= ATMEL_US_RIIC;
+
 			gpio_handled = true;
 		}
 		if (!pending)
@@ -1662,6 +1680,11 @@ static int atmel_startup(struct uart_port *port)
 	if (retval)
 		goto free_cts_irq;
 
+	retval = atmel_request_gpio_irq(port, atmel_port->gpio.ri_irq,
+					"atmel_ri_irq");
+	if (retval)
+		goto free_dsr_irq;
+
 	/*
 	 * Initialize DMA (if necessary)
 	 */
@@ -1727,6 +1750,9 @@ static int atmel_startup(struct uart_port *port)
 
 	return 0;
 
+free_dsr_irq:
+	free_irq(atmel_port->gpio.dsr_irq, port);
+
 free_cts_irq:
 	free_irq(atmel_port->gpio.cts_irq, port);
 
@@ -1788,6 +1814,8 @@ static void atmel_shutdown(struct uart_port *port)
 		free_irq(atmel_port->gpio.cts_irq, port);
 	if (atmel_port->gpio.dsr_irq != INVALID_IRQ)
 		free_irq(atmel_port->gpio.dsr_irq, port);
+	if (atmel_port->gpio.ri_irq != INVALID_IRQ)
+		free_irq(atmel_port->gpio.ri_irq, port);
 
 	atmel_port->ms_irq_enabled = false;
 }
@@ -2495,6 +2523,8 @@ static int atmel_init_gpios(struct atmel_uart_port *atmel_port,
 				  "DTR", NULL);
 	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.dsr,
 				  "DSR", &atmel_port->gpio.dsr_irq);
+	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.ri,
+				  "RI", &atmel_port->gpio.ri_irq);
 	return ret;
 }
 
@@ -2537,18 +2567,22 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->gpio.cts = -EINVAL;
 	port->gpio.dtr = -EINVAL;
 	port->gpio.dsr = -EINVAL;
+	port->gpio.ri = -EINVAL;
 	port->gpio.cts_irq = INVALID_IRQ;
 	port->gpio.dsr_irq = INVALID_IRQ;
+	port->gpio.ri_irq = INVALID_IRQ;
 	if (pdata) {
 		port->gpio.rts = pdata->rts_gpio;
 		port->gpio.cts = pdata->cts_gpio;
 		port->gpio.dtr = pdata->dtr_gpio;
 		port->gpio.dsr = pdata->dsr_gpio;
+		port->gpio.ri = pdata->ri_gpio;
 	} else if (np) {
 		port->gpio.rts = of_get_named_gpio(np, "rts-gpios", 0);
 		port->gpio.cts = of_get_named_gpio(np, "cts-gpios", 0);
 		port->gpio.dtr = of_get_named_gpio(np, "dtr-gpios", 0);
 		port->gpio.dsr = of_get_named_gpio(np, "dsr-gpios", 0);
+		port->gpio.ri = of_get_named_gpio(np, "ri-gpios", 0);
 	}
 
 	ret = atmel_init_gpios(port, pdev);
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 81f2c658c996..ce6ca1b8aef3 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -88,6 +88,7 @@ struct atmel_uart_data {
 	int			cts_gpio;	/* optional CTS GPIO */
 	int			dtr_gpio;	/* optional DTR GPIO */
 	int			dsr_gpio;	/* optional DSR GPIO */
+	int			ri_gpio;	/* optional Ring GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.5

