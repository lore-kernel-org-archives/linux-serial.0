From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Wed,  6 Nov 2013 10:25:39 +0100
Message-ID: <1383729939-10269-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:59952 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab3KFJZv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Nov 2013 04:25:51 -0500
Received: by mail-we0-f169.google.com with SMTP id q58so4690377wes.14
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2013 01:25:49 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-gpio@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

This passes the errata fix using a GPIO to control the RTS pin
on one of the AT91 chips to use gpiolib instead of the
AT91-specific interfaces. Also remove the reliance on
compile-time #defines and the cpu_* check and rely on the
platform passing down the proper GPIO pin through platform
data.

This is a prerequisite for getting rid of the local GPIO
implementation in the AT91 platform and move toward
multiplatform.

The patch also adds device tree support for getting the
RTS GPIO pin from the device tree on DT boot paths.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Skip check for UART base address from leftover hack,
  if we have an RTS GPIO we just use it.
- Set default error value on GPIO pin to -EINVAL
- Fold in a device tree support patch from Nicolas Ferre
---
 .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
 arch/arm/mach-at91/at91rm9200_devices.c            |  1 +
 drivers/tty/serial/atmel_serial.c                  | 55 +++++++++++++++-------
 include/linux/platform_data/atmel.h                |  1 +
 4 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 2191dcb9f1da..3adc61c2e4ca 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -10,6 +10,8 @@ Required properties:
 Optional properties:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
+- rts-gpios: specify a GPIO for RTS line. It will use specified PIO instead of the peripheral
+  function pin for the USART RTS feature. If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -28,6 +30,7 @@ Example:
 		interrupts = <7>;
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
+		rts-gpios = <&pioD 15 0>;
 	};
 
 - use DMA:
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index c721e9b08066..51d4c08962f6 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -961,6 +961,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= AT91_PIN_PA21,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d067285a2d20..e31f3319be64 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -35,21 +35,18 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/dma-mapping.h>
 #include <linux/atmel_pdc.h>
 #include <linux/atmel_serial.h>
 #include <linux/uaccess.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/timer.h>
+#include <linux/gpio.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
 
-#ifdef CONFIG_ARM
-#include <mach/cpu.h>
-#include <asm/gpio.h>
-#endif
-
 #define PDC_BUFFER_SIZE		512
 /* Revisit: We should calculate this based on the actual port settings */
 #define PDC_RX_TIMEOUT		(3 * 10)		/* 3 bytes */
@@ -167,6 +164,7 @@ struct atmel_uart_port {
 	struct circ_buf		rx_ring;
 
 	struct serial_rs485	rs485;		/* rs485 settings */
+	int			rts_gpio;	/* optional RTS GPIO */
 	unsigned int		tx_done_mask;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
@@ -300,20 +298,16 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 	unsigned int mode;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-#ifdef CONFIG_ARCH_AT91RM9200
-	if (cpu_is_at91rm9200()) {
-		/*
-		 * AT91RM9200 Errata #39: RTS0 is not internally connected
-		 * to PA21. We need to drive the pin manually.
-		 */
-		if (port->mapbase == AT91RM9200_BASE_US0) {
-			if (mctrl & TIOCM_RTS)
-				at91_set_gpio_value(AT91_PIN_PA21, 0);
-			else
-				at91_set_gpio_value(AT91_PIN_PA21, 1);
-		}
+	/*
+	 * AT91RM9200 Errata #39: RTS0 is not internally connected
+	 * to PA21. We need to drive the pin as a GPIO.
+	 */
+	if (gpio_is_valid(atmel_port->rts_gpio)) {
+		if (mctrl & TIOCM_RTS)
+			gpio_set_value(atmel_port->rts_gpio, 0);
+		else
+			gpio_set_value(atmel_port->rts_gpio, 1);
 	}
-#endif
 
 	if (mctrl & TIOCM_RTS)
 		control |= ATMEL_US_RTSEN;
@@ -2365,6 +2359,31 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
+	port->rts_gpio = -EINVAL; /* Invalid, zero could be valid */
+	/*
+	 * In theory the GPIO pin controlling RTS could be zero and
+	 * this would be an improper check, but we know that the only
+	 * existing case is != 0 and it's nice to use the zero-initialized
+	 * structs to indicate "no RTS GPIO" instead of open-coding some
+	 * invalid value everywhere.
+	 */
+	if (pdata && pdata->rts_gpio > 0)
+		port->rts_gpio = pdata->rts_gpio;
+	else if (np)
+		port->rts_gpio = of_get_named_gpio(np, "rts-gpios", 0);
+
+	if (gpio_is_valid(port->rts_gpio)) {
+		ret = devm_gpio_request(&pdev->dev, port->rts_gpio, "RTS");
+		if (ret) {
+			dev_err(&pdev->dev, "error requesting RTS GPIO\n");
+			goto err;
+		}
+		ret = gpio_direction_output(port->rts_gpio, 0);
+		if (ret) {
+			dev_err(&pdev->dev, "error setting up RTS GPIO\n");
+			goto err;
+		}
+	}
 
 	ret = atmel_init_port(port, pdev);
 	if (ret)
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index cea9f70133c5..e26b0c14edea 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -84,6 +84,7 @@ struct atmel_uart_data {
 	short			use_dma_rx;	/* use receive DMA? */
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
+	int			rts_gpio;	/* optional RTS GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.3.1

