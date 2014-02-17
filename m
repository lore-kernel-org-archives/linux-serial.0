From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v3 4/7] tty/serial: at91: use mctrl_gpio helpers
Date: Mon, 17 Feb 2014 17:57:24 +0100
Message-ID: <1392656247-3351-5-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44861 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbaBQQ6H (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 11:58:07 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so2424780wgh.23
        for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2014 08:58:06 -0800 (PST)
In-Reply-To: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

On sam9x5, dedicated CTS (and RTS) pins are unusable together with the
LCDC, the EMAC, or the MMC because they share the same line.

Moreover, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
so we have to control them via GPIO.

This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
signals.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c  |  16 +++--
 arch/arm/mach-at91/at91sam9260_devices.c |   7 ---
 arch/arm/mach-at91/at91sam9261_devices.c |   4 --
 arch/arm/mach-at91/at91sam9263_devices.c |   4 --
 arch/arm/mach-at91/at91sam9g45_devices.c |   5 --
 arch/arm/mach-at91/at91sam9rl_devices.c  |   5 --
 drivers/tty/serial/Kconfig               |   1 +
 drivers/tty/serial/atmel_serial.c        | 100 ++++++++++++++++++++-----------
 include/linux/platform_data/atmel.h      |   1 -
 9 files changed, 76 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 605add05af7e..6dd386e3d9fe 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -15,6 +15,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
@@ -922,7 +923,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -961,7 +961,14 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
+};
+
+struct gpiod_lookup_table uart0_gpios_table = {
+	.dev_id = "atmel_usart",
+	.table = {
+		GPIO_LOOKUP("pioA", 21, "rts", GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -992,7 +999,7 @@ static inline void configure_usart0_pins(unsigned pins)
 		 * We need to drive the pin manually. The serial driver will driver
 		 * this to high when initializing.
 		 */
-		uart0_data.rts_gpio = AT91_PIN_PA21;
+		gpiod_add_lookup_table(&uart0_gpios_table);
 	}
 }
 
@@ -1012,7 +1019,6 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1064,7 +1070,6 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1108,7 +1113,6 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index b52527c78b12..eda8d1679d40 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -819,7 +819,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -858,7 +857,6 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -910,7 +908,6 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -954,7 +951,6 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -998,7 +994,6 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1042,7 +1037,6 @@ static struct resource uart4_resources[] = {
 static struct atmel_uart_data uart4_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1081,7 +1075,6 @@ static struct resource uart5_resources[] = {
 static struct atmel_uart_data uart5_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 6c1a2ecc306f..b2a34740146a 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -880,7 +880,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -919,7 +918,6 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -963,7 +961,6 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1007,7 +1004,6 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 97cc2a0d6f90..4aeadddbc181 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1324,7 +1324,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1363,7 +1362,6 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1407,7 +1405,6 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1451,7 +1448,6 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index c10149588e21..cb36fa872d30 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1587,7 +1587,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1626,7 +1625,6 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1670,7 +1668,6 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1714,7 +1711,6 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1758,7 +1754,6 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 4120af972b61..a698bdab2cce 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -956,7 +956,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -995,7 +994,6 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1047,7 +1045,6 @@ static struct resource uart1_resources[] = {
 static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1091,7 +1088,6 @@ static struct resource uart2_resources[] = {
 static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1135,7 +1131,6 @@ static struct resource uart3_resources[] = {
 static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
-	.rts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4fe8ca16f492..59219318d7c9 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -97,6 +97,7 @@ config SERIAL_ATMEL
 	bool "AT91 / AT32 on-chip serial port support"
 	depends on ARCH_AT91 || AVR32
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
 	  AT91 and AT32 processors.
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a51b3a762948..7ac2d1dfe78f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -43,6 +43,7 @@
 #include <linux/platform_data/atmel.h>
 #include <linux/timer.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -57,6 +58,8 @@
 
 #include <linux/serial_core.h>
 
+#include "serial_mctrl_gpio.h"
+
 static void atmel_start_rx(struct uart_port *port);
 static void atmel_stop_rx(struct uart_port *port);
 
@@ -162,7 +165,7 @@ struct atmel_uart_port {
 	struct circ_buf		rx_ring;
 
 	struct serial_rs485	rs485;		/* rs485 settings */
-	int			rts_gpio;	/* optional RTS GPIO */
+	struct mctrl_gpios	gpios;
 	unsigned int		tx_done_mask;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
@@ -237,6 +240,46 @@ static bool atmel_use_dma_rx(struct uart_port *port)
 	return atmel_port->use_dma_rx;
 }
 
+static unsigned int atmel_get_lines_status(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int status, ret = 0;
+
+	status = UART_GET_CSR(port);
+
+	mctrl_gpio_get(&atmel_port->gpios, &ret);
+
+	if (!IS_ERR_OR_NULL(atmel_port->gpios.gpio[UART_GPIO_CTS])) {
+		if (ret & TIOCM_CTS)
+			status &= ~ATMEL_US_CTS;
+		else
+			status |= ATMEL_US_CTS;
+	}
+
+	if (!IS_ERR_OR_NULL(atmel_port->gpios.gpio[UART_GPIO_DSR])) {
+		if (ret & TIOCM_DSR)
+			status &= ~ATMEL_US_DSR;
+		else
+			status |= ATMEL_US_DSR;
+	}
+
+	if (!IS_ERR_OR_NULL(atmel_port->gpios.gpio[UART_GPIO_RI])) {
+		if (ret & TIOCM_RI)
+			status &= ~ATMEL_US_RI;
+		else
+			status |= ATMEL_US_RI;
+	}
+
+	if (!IS_ERR_OR_NULL(atmel_port->gpios.gpio[UART_GPIO_DCD])) {
+		if (ret & TIOCM_CD)
+			status &= ~ATMEL_US_DCD;
+		else
+			status |= ATMEL_US_DCD;
+	}
+
+	return status;
+}
+
 /* Enable or disable the rs485 support */
 void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 {
@@ -296,17 +339,6 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 	unsigned int mode;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	/*
-	 * AT91RM9200 Errata #39: RTS0 is not internally connected
-	 * to PA21. We need to drive the pin as a GPIO.
-	 */
-	if (gpio_is_valid(atmel_port->rts_gpio)) {
-		if (mctrl & TIOCM_RTS)
-			gpio_set_value(atmel_port->rts_gpio, 0);
-		else
-			gpio_set_value(atmel_port->rts_gpio, 1);
-	}
-
 	if (mctrl & TIOCM_RTS)
 		control |= ATMEL_US_RTSEN;
 	else
@@ -319,6 +351,8 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 
 	UART_PUT_CR(port, control);
 
+	mctrl_gpio_set(&atmel_port->gpios, mctrl);
+
 	/* Local loopback mode? */
 	mode = UART_GET_MR(port) & ~ATMEL_US_CHMODE;
 	if (mctrl & TIOCM_LOOP)
@@ -346,7 +380,8 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
  */
 static u_int atmel_get_mctrl(struct uart_port *port)
 {
-	unsigned int status, ret = 0;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int ret = 0, status;
 
 	status = UART_GET_CSR(port);
 
@@ -362,7 +397,7 @@ static u_int atmel_get_mctrl(struct uart_port *port)
 	if (!(status & ATMEL_US_RI))
 		ret |= TIOCM_RI;
 
-	return ret;
+	return mctrl_gpio_get(&atmel_port->gpios, &ret);
 }
 
 /*
@@ -1042,7 +1077,7 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 	unsigned int status, pending, pass_counter = 0;
 
 	do {
-		status = UART_GET_CSR(port);
+		status = atmel_get_lines_status(port);
 		pending = status & UART_GET_IMR(port);
 		if (!pending)
 			break;
@@ -1568,7 +1603,7 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/* Save current CSR for comparison in atmel_tasklet_func() */
-	atmel_port->irq_status_prev = UART_GET_CSR(port);
+	atmel_port->irq_status_prev = atmel_get_lines_status(port);
 	atmel_port->irq_status = atmel_port->irq_status_prev;
 
 	/*
@@ -2327,6 +2362,15 @@ static int atmel_serial_resume(struct platform_device *pdev)
 #define atmel_serial_resume NULL
 #endif
 
+static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
+{
+	enum mctrl_gpio_idx i;
+	int err;
+
+	err = mctrl_gpio_init(dev, &p->gpios);
+	return err;
+}
+
 static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
@@ -2362,25 +2406,11 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
-	port->rts_gpio = -EINVAL; /* Invalid, zero could be valid */
-	if (pdata)
-		port->rts_gpio = pdata->rts_gpio;
-	else if (np)
-		port->rts_gpio = of_get_named_gpio(np, "rts-gpios", 0);
-
-	if (gpio_is_valid(port->rts_gpio)) {
-		ret = devm_gpio_request(&pdev->dev, port->rts_gpio, "RTS");
-		if (ret) {
-			dev_err(&pdev->dev, "error requesting RTS GPIO\n");
-			goto err;
-		}
-		/* Default to 1 as RTS is active low */
-		ret = gpio_direction_output(port->rts_gpio, 1);
-		if (ret) {
-			dev_err(&pdev->dev, "error setting up RTS GPIO\n");
-			goto err;
-		}
-	}
+
+	ret = atmel_init_gpios(port, &pdev->dev);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Failed to initialize %d GPIOs. The serial port may not work as expected",
+			ret * -1);
 
 	ret = atmel_init_port(port, pdev);
 	if (ret)
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index e26b0c14edea..cea9f70133c5 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -84,7 +84,6 @@ struct atmel_uart_data {
 	short			use_dma_rx;	/* use receive DMA? */
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
-	int			rts_gpio;	/* optional RTS GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.5

