From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4/8] tty/serial: at91: add cts control via gpio
Date: Fri,  7 Feb 2014 15:59:11 +0100
Message-ID: <1391785155-18525-5-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:52170 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaBGPAT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:19 -0500
Received: by mail-wi0-f171.google.com with SMTP id cc10so923560wib.4
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:18 -0800 (PST)
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

On sam9x5, dedicated CTS (and RTS) pins are unusable together with the
LCDC, the EMAC, or the MMC because they share the same line.

This patch permits to use a GPIO to control the CTS line.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/serial/atmel-usart.txt     |   3 +
 arch/arm/mach-at91/at91rm9200_devices.c            |   5 +
 arch/arm/mach-at91/at91sam9260_devices.c           |   7 ++
 arch/arm/mach-at91/at91sam9261_devices.c           |   4 +
 arch/arm/mach-at91/at91sam9263_devices.c           |   4 +
 arch/arm/mach-at91/at91sam9g45_devices.c           |   5 +
 arch/arm/mach-at91/at91sam9rl_devices.c            |   5 +
 drivers/tty/serial/atmel_serial.c                  | 112 +++++++++++++++++++--
 include/linux/platform_data/atmel.h                |   1 +
 9 files changed, 136 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 17c1042b2df8..6c0898e4b58e 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -15,6 +15,8 @@ Optional properties:
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - rts-gpios: specify a GPIO for RTS line. It will use specified PIO instead of the peripheral
   function pin for the USART RTS feature. If unsure, don't specify this property.
+- cts-gpios: specify a GPIO for CTS line. It will use specified PIO instead of the peripheral
+  function pin for the USART CTS feature. If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -36,6 +38,7 @@ Example:
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
 		rts-gpios = <&pioD 15 0>;
+		cts-gpios = <&pioD 16 0>;
 	};
 
 - use DMA:
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 605add05af7e..4688a85cabc4 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -923,6 +923,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -962,6 +963,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1013,6 +1015,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1065,6 +1068,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1109,6 +1113,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index b52527c78b12..5e8f0d1add1d 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -820,6 +820,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -859,6 +860,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -911,6 +913,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -955,6 +958,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -999,6 +1003,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1043,6 +1048,7 @@ static struct atmel_uart_data uart4_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1082,6 +1088,7 @@ static struct atmel_uart_data uart5_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 6c1a2ecc306f..f0ccc835e331 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -881,6 +881,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -920,6 +921,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -964,6 +966,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1008,6 +1011,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 97cc2a0d6f90..1e696ceacfaf 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1325,6 +1325,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1364,6 +1365,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1408,6 +1410,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1452,6 +1455,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index c10149588e21..b75eb826b803 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1588,6 +1588,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1627,6 +1628,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1671,6 +1673,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1715,6 +1718,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1759,6 +1763,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 4120af972b61..67bf5811b38f 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -957,6 +957,7 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -996,6 +997,7 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1048,6 +1050,7 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1092,6 +1095,7 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1136,6 +1140,7 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7ef99d7e070b..7a6b0506c050 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -43,6 +43,7 @@
 #include <linux/platform_data/atmel.h>
 #include <linux/timer.h>
 #include <linux/gpio.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -55,6 +56,8 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#define INVALID_IRQ  ((unsigned)-1)
+
 #include <linux/serial_core.h>
 
 static void atmel_start_rx(struct uart_port *port);
@@ -128,6 +131,8 @@ struct atmel_uart_char {
 
 struct gpio_lines {
 	int rts;	/* optional RTS GPIO */
+	int cts;	/* optional CTS GPIO */
+	int cts_irq;
 };
 
 /*
@@ -168,6 +173,7 @@ struct atmel_uart_port {
 	struct serial_rs485	rs485;		/* rs485 settings */
 	struct gpio_lines	gpio;
 	unsigned int		tx_done_mask;
+	bool			ms_irq_enabled;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
 	int (*prepare_rx)(struct uart_port *port);
@@ -241,6 +247,23 @@ static bool atmel_use_dma_rx(struct uart_port *port)
 	return atmel_port->use_dma_rx;
 }
 
+static unsigned int atmel_get_lines_status(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int status = 0;
+
+	status = UART_GET_CSR(port);
+
+	if (gpio_is_valid(atmel_port->gpio.cts)) {
+		if (gpio_get_value(atmel_port->gpio.cts))
+			status |= ATMEL_US_CTS;
+		else
+			status &= ~ATMEL_US_CTS;
+	}
+
+	return status;
+}
+
 /* Enable or disable the rs485 support */
 void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 {
@@ -352,7 +375,7 @@ static u_int atmel_get_mctrl(struct uart_port *port)
 {
 	unsigned int status, ret = 0;
 
-	status = UART_GET_CSR(port);
+	status = atmel_get_lines_status(port);
 
 	/*
 	 * The control signals are active low.
@@ -453,8 +476,25 @@ static void atmel_stop_rx(struct uart_port *port)
  */
 static void atmel_enable_ms(struct uart_port *port)
 {
-	UART_PUT_IER(port, ATMEL_US_RIIC | ATMEL_US_DSRIC
-			| ATMEL_US_DCDIC | ATMEL_US_CTSIC);
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	uint32_t ier;
+
+	/*
+	 * Interrupt should not be enabled twice
+	 */
+	if (atmel_port->ms_irq_enabled)
+		return;
+
+	atmel_port->ms_irq_enabled = true;
+
+	ier = ATMEL_US_RIIC | ATMEL_US_DSRIC | ATMEL_US_DCDIC;
+
+	if (atmel_port->gpio.cts_irq != INVALID_IRQ)
+		enable_irq(atmel_port->gpio.cts_irq);
+	else
+		ier |= ATMEL_US_CTSIC;
+
+	UART_PUT_IER(port, ier);
 }
 
 /*
@@ -522,7 +562,7 @@ static void atmel_rx_chars(struct uart_port *port)
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int status, ch;
 
-	status = UART_GET_CSR(port);
+	status = atmel_get_lines_status(port);
 	while (status & ATMEL_US_RXRDY) {
 		ch = UART_GET_CHAR(port);
 
@@ -556,7 +596,7 @@ static void atmel_rx_chars(struct uart_port *port)
 		}
 
 		atmel_buffer_rx_char(port, status, ch);
-		status = UART_GET_CSR(port);
+		status = atmel_get_lines_status(port);
 	}
 
 	tasklet_schedule(&atmel_port->tasklet);
@@ -1043,11 +1083,22 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int status, pending, pass_counter = 0;
+	bool gpio_handled = false;
 
 	do {
-		status = UART_GET_CSR(port);
+		status = atmel_get_lines_status(port);
 		pending = status & UART_GET_IMR(port);
+		if (!gpio_handled) {
+			/*
+			 * Dealing with GPIO interrupt
+			 */
+			if ((irq !=  INVALID_IRQ) &&
+			    (irq == atmel_port->gpio.cts_irq))
+				pending |= ATMEL_US_CTSIC;
+			gpio_handled = true;
+		}
 		if (!pending)
 			break;
 
@@ -1527,6 +1578,22 @@ static void atmel_get_ip_name(struct uart_port *port)
 	}
 }
 
+static int atmel_request_gpio_irq(struct uart_port *port, int irq,
+				  const char *name)
+{
+	int err = 0;
+
+	if (irq == INVALID_IRQ)
+		goto out;
+
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	err = request_irq(irq, atmel_interrupt, IRQ_TYPE_EDGE_BOTH, name, port);
+	if (err)
+		dev_err(port->dev, "atmel_startup - Can't get %s\n", name);
+out:
+	return err;
+}
+
 /*
  * Perform initialization and enable port for reception
  */
@@ -1543,6 +1610,7 @@ static int atmel_startup(struct uart_port *port)
 	 * handle an unexpected interrupt
 	 */
 	UART_PUT_IDR(port, -1);
+	atmel_port->ms_irq_enabled = false;
 
 	/*
 	 * Allocate the IRQ
@@ -1555,6 +1623,14 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/*
+	 * Get the GPIO lines IRQ
+	 */
+	retval = atmel_request_gpio_irq(port, atmel_port->gpio.cts_irq,
+					"atmel_cts_irq");
+	if (retval)
+		goto free_ctrl_irq;
+
+	/*
 	 * Initialize DMA (if necessary)
 	 */
 	atmel_init_property(atmel_port, pdev);
@@ -1572,7 +1648,7 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/* Save current CSR for comparison in atmel_tasklet_func() */
-	atmel_port->irq_status_prev = UART_GET_CSR(port);
+	atmel_port->irq_status_prev = atmel_get_lines_status(port);
 	atmel_port->irq_status = atmel_port->irq_status_prev;
 
 	/*
@@ -1618,6 +1694,11 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	return 0;
+
+free_ctrl_irq:
+	free_irq(port->irq, port);
+
+	return retval;
 }
 
 /*
@@ -1665,9 +1746,13 @@ static void atmel_shutdown(struct uart_port *port)
 	atmel_port->rx_ring.tail = 0;
 
 	/*
-	 * Free the interrupt
+	 * Free the interrupts
 	 */
 	free_irq(port->irq, port);
+	if (atmel_port->gpio.cts_irq != INVALID_IRQ)
+		free_irq(atmel_port->gpio.cts_irq, port);
+
+	atmel_port->ms_irq_enabled = false;
 }
 
 /*
@@ -2367,6 +2452,8 @@ static int atmel_init_gpios(struct atmel_uart_port *atmel_port,
 
 	ret = atmel_request_gpio(&pdev->dev, atmel_port->gpio.rts,
 				 "RTS", NULL);
+	ret += atmel_request_gpio(&pdev->dev, atmel_port->gpio.cts,
+				  "CTS", &atmel_port->gpio.cts_irq);
 	return ret;
 }
 
@@ -2406,10 +2493,15 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->backup_imr = 0;
 	port->uart.line = ret;
 	port->gpio.rts = -EINVAL; /* Invalid, zero could be valid */
-	if (pdata)
+	port->gpio.cts = -EINVAL;
+	port->gpio.cts_irq = INVALID_IRQ;
+	if (pdata) {
 		port->gpio.rts = pdata->rts_gpio;
-	else if (np)
+		port->gpio.cts = pdata->cts_gpio;
+	} else if (np) {
 		port->gpio.rts = of_get_named_gpio(np, "rts-gpios", 0);
+		port->gpio.cts = of_get_named_gpio(np, "cts-gpios", 0);
+	}
 
 	ret = atmel_init_gpios(port, pdev);
 	if (ret)
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index e26b0c14edea..166a99ca911f 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -85,6 +85,7 @@ struct atmel_uart_data {
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
 	int			rts_gpio;	/* optional RTS GPIO */
+	int			cts_gpio;	/* optional CTS GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.5

