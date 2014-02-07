From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 8/8] tty/serial: at91: add dcd control via gpio
Date: Fri,  7 Feb 2014 15:59:15 +0100
Message-ID: <1391785155-18525-9-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:51820 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaBGPAc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:32 -0500
Received: by mail-wi0-f170.google.com with SMTP id hi5so895717wib.5
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:29 -0800 (PST)
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

On sam9x5, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
so we have to control them via GPIO.

This patch permits to use a GPIO to control the DCD signal.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
 arch/arm/mach-at91/at91rm9200_devices.c            |  5 +++
 arch/arm/mach-at91/at91sam9260_devices.c           |  7 ++++
 arch/arm/mach-at91/at91sam9261_devices.c           |  4 +++
 arch/arm/mach-at91/at91sam9263_devices.c           |  4 +++
 arch/arm/mach-at91/at91sam9g45_devices.c           |  5 +++
 arch/arm/mach-at91/at91sam9rl_devices.c            |  5 +++
 drivers/tty/serial/atmel_serial.c                  | 38 ++++++++++++++++++++--
 include/linux/platform_data/atmel.h                |  1 +
 9 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 11d033649b19..4ff660e1487f 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -23,6 +23,8 @@ Optional properties:
   function pin for the USART DSR feature. If unsure, don't specify this property.
 - ri-gpios: specify a GPIO for Ring line. It will use specified PIO instead of the peripheral
   function pin for the USART Ring feature. If unsure, don't specify this property.
+- dcd-gpios: specify a GPIO for DCD line. It will use specified PIO instead of the peripheral
+  function pin for the USART DCD feature. If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -48,6 +50,7 @@ Example:
 		dtr-gpios = <&pioD 17 0>;
 		dsr-gpios = <&pioD 18 0>;
 		ri-gpios = <&pioD 19 0>;
+		dcd-gpios = <&pioD 20 0>;
 	};
 
 - use DMA:
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 11c5c7f5b067..288421f38b42 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -927,6 +927,7 @@ static struct atmel_uart_data dbgu_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -970,6 +971,7 @@ static struct atmel_uart_data uart0_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1025,6 +1027,7 @@ static struct atmel_uart_data uart1_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1081,6 +1084,7 @@ static struct atmel_uart_data uart2_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1129,6 +1133,7 @@ static struct atmel_uart_data uart3_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index f8ccdbe2bcbc..0e20ba04d43f 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -824,6 +824,7 @@ static struct atmel_uart_data dbgu_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -867,6 +868,7 @@ static struct atmel_uart_data uart0_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -923,6 +925,7 @@ static struct atmel_uart_data uart1_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -971,6 +974,7 @@ static struct atmel_uart_data uart2_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1019,6 +1023,7 @@ static struct atmel_uart_data uart3_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1067,6 +1072,7 @@ static struct atmel_uart_data uart4_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1110,6 +1116,7 @@ static struct atmel_uart_data uart5_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index c40aa819cfac..d3d7a546db9b 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -885,6 +885,7 @@ static struct atmel_uart_data dbgu_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -928,6 +929,7 @@ static struct atmel_uart_data uart0_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -976,6 +978,7 @@ static struct atmel_uart_data uart1_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1024,6 +1027,7 @@ static struct atmel_uart_data uart2_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 1da08465d952..5fcb2a0383d1 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1329,6 +1329,7 @@ static struct atmel_uart_data dbgu_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1372,6 +1373,7 @@ static struct atmel_uart_data uart0_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1420,6 +1422,7 @@ static struct atmel_uart_data uart1_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1468,6 +1471,7 @@ static struct atmel_uart_data uart2_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 4520d8f70cff..bd44970403e5 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1592,6 +1592,7 @@ static struct atmel_uart_data dbgu_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1635,6 +1636,7 @@ static struct atmel_uart_data uart0_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1683,6 +1685,7 @@ static struct atmel_uart_data uart1_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1731,6 +1734,7 @@ static struct atmel_uart_data uart2_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1779,6 +1783,7 @@ static struct atmel_uart_data uart3_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 5916d65b6362..e43623dc1c9e 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -961,6 +961,7 @@ static struct atmel_uart_data dbgu_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1004,6 +1005,7 @@ static struct atmel_uart_data uart0_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1060,6 +1062,7 @@ static struct atmel_uart_data uart1_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1108,6 +1111,7 @@ static struct atmel_uart_data uart2_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1156,6 +1160,7 @@ static struct atmel_uart_data uart3_data = {
 	.dtr_gpio	= -EINVAL,
 	.dsr_gpio	= -EINVAL,
 	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 9d47497713ab..926f77e6bde5 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -138,6 +138,8 @@ struct gpio_lines {
 	int dsr_irq;
 	int ri;		/* optional Ring GPIO */
 	int ri_irq;
+	int dcd;	/* optional DCD GPIO */
+	int dcd_irq;
 };
 
 /*
@@ -280,6 +282,13 @@ static unsigned int atmel_get_lines_status(struct uart_port *port)
 			status &= ~ATMEL_US_RI;
 	}
 
+	if (gpio_is_valid(atmel_port->gpio.dcd)) {
+		if (gpio_get_value(atmel_port->gpio.dcd))
+			status |= ATMEL_US_DCD;
+		else
+			status &= ~ATMEL_US_DCD;
+	}
+
 	return status;
 }
 
@@ -503,7 +512,7 @@ static void atmel_stop_rx(struct uart_port *port)
 static void atmel_enable_ms(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	uint32_t ier;
+	uint32_t ier = 0;
 
 	/*
 	 * Interrupt should not be enabled twice
@@ -513,8 +522,6 @@ static void atmel_enable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = true;
 
-	ier = ATMEL_US_DCDIC;
-
 	if (atmel_port->gpio.cts_irq != INVALID_IRQ)
 		enable_irq(atmel_port->gpio.cts_irq);
 	else
@@ -530,6 +537,11 @@ static void atmel_enable_ms(struct uart_port *port)
 	else
 		ier |= ATMEL_US_RIIC;
 
+	if (atmel_port->gpio.dcd_irq != INVALID_IRQ)
+		enable_irq(atmel_port->gpio.dcd_irq);
+	else
+		ier |= ATMEL_US_DCDIC;
+
 	UART_PUT_IER(port, ier);
 }
 
@@ -1142,6 +1154,10 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 			    (irq == atmel_port->gpio.ri_irq))
 				pending |= ATMEL_US_RIIC;
 
+			if ((irq !=  INVALID_IRQ) &&
+			    (irq == atmel_port->gpio.dcd_irq))
+				pending |= ATMEL_US_DCDIC;
+
 			gpio_handled = true;
 		}
 		if (!pending)
@@ -1685,6 +1701,11 @@ static int atmel_startup(struct uart_port *port)
 	if (retval)
 		goto free_dsr_irq;
 
+	retval = atmel_request_gpio_irq(port, atmel_port->gpio.dcd_irq,
+					"atmel_dcd_irq");
+	if (retval)
+		goto free_ri_irq;
+
 	/*
 	 * Initialize DMA (if necessary)
 	 */
@@ -1750,6 +1771,9 @@ static int atmel_startup(struct uart_port *port)
 
 	return 0;
 
+free_ri_irq:
+	free_irq(atmel_port->gpio.ri_irq, port);
+
 free_dsr_irq:
 	free_irq(atmel_port->gpio.dsr_irq, port);
 
@@ -1816,6 +1840,8 @@ static void atmel_shutdown(struct uart_port *port)
 		free_irq(atmel_port->gpio.dsr_irq, port);
 	if (atmel_port->gpio.ri_irq != INVALID_IRQ)
 		free_irq(atmel_port->gpio.ri_irq, port);
+	if (atmel_port->gpio.dcd_irq != INVALID_IRQ)
+		free_irq(atmel_port->gpio.dcd_irq, port);
 
 	atmel_port->ms_irq_enabled = false;
 }
@@ -2525,6 +2551,8 @@ static int atmel_init_gpios(struct atmel_uart_port *atmel_port,
 				  "DSR", &atmel_port->gpio.dsr_irq);
 	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.ri,
 				  "RI", &atmel_port->gpio.ri_irq);
+	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.dcd,
+				  "DCD", &atmel_port->gpio.dcd_irq);
 	return ret;
 }
 
@@ -2568,21 +2596,25 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->gpio.dtr = -EINVAL;
 	port->gpio.dsr = -EINVAL;
 	port->gpio.ri = -EINVAL;
+	port->gpio.dcd = -EINVAL;
 	port->gpio.cts_irq = INVALID_IRQ;
 	port->gpio.dsr_irq = INVALID_IRQ;
 	port->gpio.ri_irq = INVALID_IRQ;
+	port->gpio.dcd_irq = INVALID_IRQ;
 	if (pdata) {
 		port->gpio.rts = pdata->rts_gpio;
 		port->gpio.cts = pdata->cts_gpio;
 		port->gpio.dtr = pdata->dtr_gpio;
 		port->gpio.dsr = pdata->dsr_gpio;
 		port->gpio.ri = pdata->ri_gpio;
+		port->gpio.dcd = pdata->dcd_gpio;
 	} else if (np) {
 		port->gpio.rts = of_get_named_gpio(np, "rts-gpios", 0);
 		port->gpio.cts = of_get_named_gpio(np, "cts-gpios", 0);
 		port->gpio.dtr = of_get_named_gpio(np, "dtr-gpios", 0);
 		port->gpio.dsr = of_get_named_gpio(np, "dsr-gpios", 0);
 		port->gpio.ri = of_get_named_gpio(np, "ri-gpios", 0);
+		port->gpio.dcd = of_get_named_gpio(np, "dcd-gpios", 0);
 	}
 
 	ret = atmel_init_gpios(port, pdev);
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index ce6ca1b8aef3..565c5c693c7f 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -88,6 +88,7 @@ struct atmel_uart_data {
 	int			cts_gpio;	/* optional CTS GPIO */
 	int			dtr_gpio;	/* optional DTR GPIO */
 	int			dsr_gpio;	/* optional DSR GPIO */
+	int			dcd_gpio;	/* optional DCD GPIO */
 	int			ri_gpio;	/* optional Ring GPIO */
 };
 
-- 
1.8.5

