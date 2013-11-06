From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Wed,  6 Nov 2013 15:54:58 +0100
Message-ID: <1383749698-26523-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

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
ChangeLog v2->v3:
- Instead of disallowing GPIO 0 to be used for the RTS
  signal to allow null-initialized platform data to mean
  "no RTS GPIO", be more generic and actually allow it,
  and patch every instance of atmel_uart_data to set
  .rts_gpio to -EINVAL except for the one case where we
  actually use pin 21 for RTS over GPIO.
ChangeLog v1->v2:
- Skip check for UART base address from leftover hack,
  if we have an RTS GPIO we just use it.
- Set default error value on GPIO pin to -EINVAL
- Fold in a device tree support patch from Nicolas Ferre
---
 .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
 arch/arm/mach-at91/at91rm9200_devices.c            |  5 ++
 arch/arm/mach-at91/at91sam9260_devices.c           |  7 +++
 arch/arm/mach-at91/at91sam9261_devices.c           |  4 ++
 arch/arm/mach-at91/at91sam9263_devices.c           |  4 ++
 arch/arm/mach-at91/at91sam9g45_devices.c           |  5 ++
 arch/arm/mach-at91/at91sam9rl_devices.c            |  5 ++
 drivers/tty/serial/atmel_serial.c                  | 55 +++++++++++++++-------
 include/linux/platform_data/atmel.h                |  1 +
 9 files changed, 71 insertions(+), 18 deletions(-)

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
index c721e9b08066..f46d0e92b2b6 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -923,6 +923,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -961,6 +962,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= AT91_PIN_PA21,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1010,6 +1012,7 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1061,6 +1064,7 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1104,6 +1108,7 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 428abfc14848..bcf4a161a3d8 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -819,6 +819,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -857,6 +858,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -908,6 +910,7 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -951,6 +954,7 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -994,6 +998,7 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1037,6 +1042,7 @@ static struct resource uart4_resources[] = {
 static struct atmel_uart_data uart4_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1075,6 +1081,7 @@ static struct resource uart5_resources[] = {
 static struct atmel_uart_data uart5_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 4e02e9271ac9..d5b08ef9e848 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -880,6 +880,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -918,6 +919,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -961,6 +963,7 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1004,6 +1007,7 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 3a384ef27cf6..22b13c6226cb 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1325,6 +1325,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1363,6 +1364,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1406,6 +1408,7 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1449,6 +1452,7 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 6b8effbffc28..89f95ed711c6 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1588,6 +1588,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1626,6 +1627,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1669,6 +1671,7 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1712,6 +1715,7 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1755,6 +1759,7 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 6cf441cadf94..3c2462b15b8b 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -957,6 +957,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -995,6 +996,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1046,6 +1048,7 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1089,6 +1092,7 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1132,6 +1136,7 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d067285a2d20..507297124731 100644
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
+	if (pdata && gpio_is_valid(pdata->rts_gpio))
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

