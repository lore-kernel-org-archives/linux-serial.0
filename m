From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 6/8] tty/serial: at91: add dsr control via gpio
Date: Fri,  7 Feb 2014 15:59:13 +0100
Message-ID: <1391785155-18525-7-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:61646 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaBGPAZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:25 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so2352779wes.2
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:24 -0800 (PST)
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

On sam9x5, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
so we have to control them via GPIO.

This patch permits to use a GPIO to control the DSR signal.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
 arch/arm/mach-at91/at91rm9200_devices.c            |  5 +++
 arch/arm/mach-at91/at91sam9260_devices.c           |  7 ++++
 arch/arm/mach-at91/at91sam9261_devices.c           |  4 +++
 arch/arm/mach-at91/at91sam9263_devices.c           |  4 +++
 arch/arm/mach-at91/at91sam9g45_devices.c           |  5 +++
 arch/arm/mach-at91/at91sam9rl_devices.c            |  5 +++
 drivers/tty/serial/atmel_serial.c                  | 37 +++++++++++++++++++++-
 include/linux/platform_data/atmel.h                |  1 +
 9 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 77d45c88b494..3b90795ee641 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -19,6 +19,8 @@ Optional properties:
   function pin for the USART CTS feature. If unsure, don't specify this property.
 - dtr-gpios: specify a GPIO for DTR line. It will use specified PIO instead of the peripheral
   function pin for the USART DTR feature. If unsure, don't specify this property.
+- dsr-gpios: specify a GPIO for DSR line. It will use specified PIO instead of the peripheral
+  function pin for the USART DSR feature. If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -42,6 +44,7 @@ Example:
 		rts-gpios = <&pioD 15 0>;
 		cts-gpios = <&pioD 16 0>;
 		dtr-gpios = <&pioD 17 0>;
+		dsr-gpios = <&pioD 18 0>;
 	};
 
 - use DMA:
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index d8523cc05157..980ea65142b4 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -925,6 +925,7 @@ static struct atmel_uart_data dbgu_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -966,6 +967,7 @@ static struct atmel_uart_data uart0_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1019,6 +1021,7 @@ static struct atmel_uart_data uart1_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1073,6 +1076,7 @@ static struct atmel_uart_data uart2_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1119,6 +1123,7 @@ static struct atmel_uart_data uart3_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index b8e325b00e1a..c11d1225a75c 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -822,6 +822,7 @@ static struct atmel_uart_data dbgu_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -863,6 +864,7 @@ static struct atmel_uart_data uart0_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -917,6 +919,7 @@ static struct atmel_uart_data uart1_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -963,6 +966,7 @@ static struct atmel_uart_data uart2_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1009,6 +1013,7 @@ static struct atmel_uart_data uart3_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1055,6 +1060,7 @@ static struct atmel_uart_data uart4_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1096,6 +1102,7 @@ static struct atmel_uart_data uart5_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 3a05d9f09b0d..ea35af48a2e2 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -883,6 +883,7 @@ static struct atmel_uart_data dbgu_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -924,6 +925,7 @@ static struct atmel_uart_data uart0_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -970,6 +972,7 @@ static struct atmel_uart_data uart1_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1016,6 +1019,7 @@ static struct atmel_uart_data uart2_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index d26255ba3907..c8833ebd4fcb 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1327,6 +1327,7 @@ static struct atmel_uart_data dbgu_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1368,6 +1369,7 @@ static struct atmel_uart_data uart0_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1414,6 +1416,7 @@ static struct atmel_uart_data uart1_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1460,6 +1463,7 @@ static struct atmel_uart_data uart2_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 67e9f7f259e1..76772d12acfd 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1590,6 +1590,7 @@ static struct atmel_uart_data dbgu_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1631,6 +1632,7 @@ static struct atmel_uart_data uart0_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1677,6 +1679,7 @@ static struct atmel_uart_data uart1_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1723,6 +1726,7 @@ static struct atmel_uart_data uart2_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1769,6 +1773,7 @@ static struct atmel_uart_data uart3_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 94fecc40dbba..2aa6f8ddcd53 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -959,6 +959,7 @@ static struct atmel_uart_data dbgu_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1000,6 +1001,7 @@ static struct atmel_uart_data uart0_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1054,6 +1056,7 @@ static struct atmel_uart_data uart1_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1100,6 +1103,7 @@ static struct atmel_uart_data uart2_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1146,6 +1150,7 @@ static struct atmel_uart_data uart3_data = {
 	.rts_gpio	= -EINVAL,
 	.cts_gpio	= -EINVAL,
 	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index f5bdb84aed53..28b3636135cd 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -134,6 +134,8 @@ struct gpio_lines {
 	int cts;	/* optional CTS GPIO */
 	int cts_irq;
 	int dtr;	/* optional DTR GPIO */
+	int dsr;	/* optional DSR GPIO */
+	int dsr_irq;
 };
 
 /*
@@ -262,6 +264,13 @@ static unsigned int atmel_get_lines_status(struct uart_port *port)
 			status &= ~ATMEL_US_CTS;
 	}
 
+	if (gpio_is_valid(atmel_port->gpio.dsr)) {
+		if (gpio_get_value(atmel_port->gpio.dsr))
+			status |= ATMEL_US_DSR;
+		else
+			status &= ~ATMEL_US_DSR;
+	}
+
 	return status;
 }
 
@@ -495,13 +504,18 @@ static void atmel_enable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = true;
 
-	ier = ATMEL_US_RIIC | ATMEL_US_DSRIC | ATMEL_US_DCDIC;
+	ier = ATMEL_US_RIIC | ATMEL_US_DCDIC;
 
 	if (atmel_port->gpio.cts_irq != INVALID_IRQ)
 		enable_irq(atmel_port->gpio.cts_irq);
 	else
 		ier |= ATMEL_US_CTSIC;
 
+	if (atmel_port->gpio.dsr_irq != INVALID_IRQ)
+		enable_irq(atmel_port->gpio.dsr_irq);
+	else
+		ier |= ATMEL_US_DSRIC;
+
 	UART_PUT_IER(port, ier);
 }
 
@@ -1105,6 +1119,11 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 			if ((irq !=  INVALID_IRQ) &&
 			    (irq == atmel_port->gpio.cts_irq))
 				pending |= ATMEL_US_CTSIC;
+
+			if ((irq !=  INVALID_IRQ) &&
+			    (irq == atmel_port->gpio.dsr_irq))
+				pending |= ATMEL_US_DSRIC;
+
 			gpio_handled = true;
 		}
 		if (!pending)
@@ -1638,6 +1657,11 @@ static int atmel_startup(struct uart_port *port)
 	if (retval)
 		goto free_ctrl_irq;
 
+	retval = atmel_request_gpio_irq(port, atmel_port->gpio.dsr_irq,
+					"atmel_dsr_irq");
+	if (retval)
+		goto free_cts_irq;
+
 	/*
 	 * Initialize DMA (if necessary)
 	 */
@@ -1703,6 +1727,9 @@ static int atmel_startup(struct uart_port *port)
 
 	return 0;
 
+free_cts_irq:
+	free_irq(atmel_port->gpio.cts_irq, port);
+
 free_ctrl_irq:
 	free_irq(port->irq, port);
 
@@ -1759,6 +1786,8 @@ static void atmel_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 	if (atmel_port->gpio.cts_irq != INVALID_IRQ)
 		free_irq(atmel_port->gpio.cts_irq, port);
+	if (atmel_port->gpio.dsr_irq != INVALID_IRQ)
+		free_irq(atmel_port->gpio.dsr_irq, port);
 
 	atmel_port->ms_irq_enabled = false;
 }
@@ -2464,6 +2493,8 @@ static int atmel_init_gpios(struct atmel_uart_port *atmel_port,
 				  "CTS", &atmel_port->gpio.cts_irq);
 	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.dtr,
 				  "DTR", NULL);
+	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.dsr,
+				  "DSR", &atmel_port->gpio.dsr_irq);
 	return ret;
 }
 
@@ -2505,15 +2536,19 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->gpio.rts = -EINVAL; /* Invalid, zero could be valid */
 	port->gpio.cts = -EINVAL;
 	port->gpio.dtr = -EINVAL;
+	port->gpio.dsr = -EINVAL;
 	port->gpio.cts_irq = INVALID_IRQ;
+	port->gpio.dsr_irq = INVALID_IRQ;
 	if (pdata) {
 		port->gpio.rts = pdata->rts_gpio;
 		port->gpio.cts = pdata->cts_gpio;
 		port->gpio.dtr = pdata->dtr_gpio;
+		port->gpio.dsr = pdata->dsr_gpio;
 	} else if (np) {
 		port->gpio.rts = of_get_named_gpio(np, "rts-gpios", 0);
 		port->gpio.cts = of_get_named_gpio(np, "cts-gpios", 0);
 		port->gpio.dtr = of_get_named_gpio(np, "dtr-gpios", 0);
+		port->gpio.dsr = of_get_named_gpio(np, "dsr-gpios", 0);
 	}
 
 	ret = atmel_init_gpios(port, pdev);
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 8472b6f3c618..81f2c658c996 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -87,6 +87,7 @@ struct atmel_uart_data {
 	int			rts_gpio;	/* optional RTS GPIO */
 	int			cts_gpio;	/* optional CTS GPIO */
 	int			dtr_gpio;	/* optional DTR GPIO */
+	int			dsr_gpio;	/* optional DSR GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.5

