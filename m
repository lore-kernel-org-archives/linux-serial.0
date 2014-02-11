From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v2 4/4] tty/serial: at91: use mctrl_gpio helpers
Date: Tue, 11 Feb 2014 18:45:15 +0100
Message-ID: <1392140715-15295-5-git-send-email-richard.genoud@gmail.com>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:33376 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaBKRp7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Feb 2014 12:45:59 -0500
Received: by mail-ea0-f174.google.com with SMTP id z10so544039ead.5
        for <linux-serial@vger.kernel.org>; Tue, 11 Feb 2014 09:45:57 -0800 (PST)
In-Reply-To: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
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
 .../devicetree/bindings/serial/atmel-usart.txt     |  12 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |  25 ++
 arch/arm/mach-at91/at91sam9260_devices.c           |  35 +++
 arch/arm/mach-at91/at91sam9261_devices.c           |  20 ++
 arch/arm/mach-at91/at91sam9263_devices.c           |  20 ++
 arch/arm/mach-at91/at91sam9g45_devices.c           |  25 ++
 arch/arm/mach-at91/at91sam9rl_devices.c            |  25 ++
 drivers/tty/serial/atmel_serial.c                  | 290 ++++++++++++++++++---
 include/linux/platform_data/atmel.h                |   5 +
 9 files changed, 417 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 17c1042b2df8..77edc6504a29 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -13,8 +13,9 @@ Required properties:
 Optional properties:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
-- rts-gpios: specify a GPIO for RTS line. It will use specified PIO instead of the peripheral
-  function pin for the USART RTS feature. If unsure, don't specify this property.
+- {rts,cts,dtr,dsr,ri,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
+  It will use specified PIO instead of the peripheral function pin for the USART feature.
+  If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -35,7 +36,12 @@ Example:
 		clock-names = "usart";
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
-		rts-gpios = <&pioD 15 0>;
+		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
+		cts-gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
+		dtr-gpios = <&pioD 17 GPIO_ACTIVE_LOW>;
+		dsr-gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
+		dcd-gpios = <&pioD 20 GPIO_ACTIVE_LOW>;
+		ri-gpios = <&pioD 19 GPIO_ACTIVE_LOW>;
 	};
 
 - use DMA:
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 605add05af7e..288421f38b42 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -923,6 +923,11 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -962,6 +967,11 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1013,6 +1023,11 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1065,6 +1080,11 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1109,6 +1129,11 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index b52527c78b12..0e20ba04d43f 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -820,6 +820,11 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -859,6 +864,11 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -911,6 +921,11 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -955,6 +970,11 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -999,6 +1019,11 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
@@ -1043,6 +1068,11 @@ static struct atmel_uart_data uart4_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart4_dmamask = DMA_BIT_MASK(32);
@@ -1082,6 +1112,11 @@ static struct atmel_uart_data uart5_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart5_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 6c1a2ecc306f..d3d7a546db9b 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -881,6 +881,11 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -920,6 +925,11 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -964,6 +974,11 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1008,6 +1023,11 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 97cc2a0d6f90..5fcb2a0383d1 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1325,6 +1325,11 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1364,6 +1369,11 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1408,6 +1418,11 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1452,6 +1467,11 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index c10149588e21..bd44970403e5 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1588,6 +1588,11 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -1627,6 +1632,11 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1671,6 +1681,11 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1715,6 +1730,11 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1759,6 +1779,11 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 4120af972b61..e43623dc1c9e 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -957,6 +957,11 @@ static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
@@ -996,6 +1001,11 @@ static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
@@ -1048,6 +1058,11 @@ static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart1_dmamask = DMA_BIT_MASK(32);
@@ -1092,6 +1107,11 @@ static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart2_dmamask = DMA_BIT_MASK(32);
@@ -1136,6 +1156,11 @@ static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 	.rts_gpio	= -EINVAL,
+	.cts_gpio	= -EINVAL,
+	.dtr_gpio	= -EINVAL,
+	.dsr_gpio	= -EINVAL,
+	.ri_gpio	= -EINVAL,
+	.dcd_gpio	= -EINVAL,
 };
 
 static u64 uart3_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a51b3a762948..7cb6d1954062 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -43,6 +43,8 @@
 #include <linux/platform_data/atmel.h>
 #include <linux/timer.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -57,6 +59,8 @@
 
 #include <linux/serial_core.h>
 
+#include "serial_mctrl_gpio.h"
+
 static void atmel_start_rx(struct uart_port *port);
 static void atmel_stop_rx(struct uart_port *port);
 
@@ -162,8 +166,10 @@ struct atmel_uart_port {
 	struct circ_buf		rx_ring;
 
 	struct serial_rs485	rs485;		/* rs485 settings */
-	int			rts_gpio;	/* optional RTS GPIO */
+	struct mctrl_gpios	gpios;
+	int			gpio_irq[UART_GPIO_MAX_INPUT];
 	unsigned int		tx_done_mask;
+	bool			ms_irq_enabled;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
 	int (*prepare_rx)(struct uart_port *port);
@@ -237,6 +243,46 @@ static bool atmel_use_dma_rx(struct uart_port *port)
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
@@ -296,17 +342,6 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
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
@@ -319,6 +354,8 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 
 	UART_PUT_CR(port, control);
 
+	mctrl_gpio_set(&atmel_port->gpios, mctrl);
+
 	/* Local loopback mode? */
 	mode = UART_GET_MR(port) & ~ATMEL_US_CHMODE;
 	if (mctrl & TIOCM_LOOP)
@@ -346,7 +383,8 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
  */
 static u_int atmel_get_mctrl(struct uart_port *port)
 {
-	unsigned int status, ret = 0;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int ret = 0, status;
 
 	status = UART_GET_CSR(port);
 
@@ -362,7 +400,7 @@ static u_int atmel_get_mctrl(struct uart_port *port)
 	if (!(status & ATMEL_US_RI))
 		ret |= TIOCM_RI;
 
-	return ret;
+	return mctrl_gpio_get(&atmel_port->gpios, &ret);
 }
 
 /*
@@ -449,8 +487,38 @@ static void atmel_stop_rx(struct uart_port *port)
  */
 static void atmel_enable_ms(struct uart_port *port)
 {
-	UART_PUT_IER(port, ATMEL_US_RIIC | ATMEL_US_DSRIC
-			| ATMEL_US_DCDIC | ATMEL_US_CTSIC);
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	uint32_t ier = 0;
+
+	/*
+	 * Interrupt should not be enabled twice
+	 */
+	if (atmel_port->ms_irq_enabled)
+		return;
+
+	atmel_port->ms_irq_enabled = true;
+
+	if (atmel_port->gpio_irq[UART_GPIO_CTS] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_CTS]);
+	else
+		ier |= ATMEL_US_CTSIC;
+
+	if (atmel_port->gpio_irq[UART_GPIO_DSR] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_DSR]);
+	else
+		ier |= ATMEL_US_DSRIC;
+
+	if (atmel_port->gpio_irq[UART_GPIO_RI] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_RI]);
+	else
+		ier |= ATMEL_US_RIIC;
+
+	if (atmel_port->gpio_irq[UART_GPIO_DCD] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_DCD]);
+	else
+		ier |= ATMEL_US_DCDIC;
+
+	UART_PUT_IER(port, ier);
 }
 
 /*
@@ -1039,11 +1107,35 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
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
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_CTS]))
+				pending |= ATMEL_US_CTSIC;
+
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_DSR]))
+				pending |= ATMEL_US_DSRIC;
+
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_RI]))
+				pending |= ATMEL_US_RIIC;
+
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_DCD]))
+				pending |= ATMEL_US_DCDIC;
+
+			gpio_handled = true;
+		}
 		if (!pending)
 			break;
 
@@ -1523,6 +1615,45 @@ static void atmel_get_ip_name(struct uart_port *port)
 	}
 }
 
+static void atmel_free_gpio_irq(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	enum mctrl_gpio_idx i;
+
+	for (i = UART_GPIO_MIN; i < UART_GPIO_MAX_INPUT; i++)
+		if (atmel_port->gpio_irq[i] >= 0)
+			free_irq(atmel_port->gpio_irq[i], port);
+}
+
+static int atmel_request_gpio_irq(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	int *irq = atmel_port->gpio_irq;
+	enum mctrl_gpio_idx i;
+	int err = 0;
+
+	for (i = UART_GPIO_MIN; (i < UART_GPIO_MAX_INPUT) && !err; i++) {
+		if (irq[i] < 0)
+			continue;
+
+		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
+		err = request_irq(irq[i], atmel_interrupt, IRQ_TYPE_EDGE_BOTH,
+				  get_mctrl_gpio_name(i), port);
+		if (err)
+			dev_err(port->dev, "atmel_startup - Can't get %s irq\n",
+				get_mctrl_gpio_name(i));
+	}
+
+	/*
+	 * If something went wrong, rollback.
+	 */
+	while (err && --i)
+		if (irq[i] >= 0)
+			free_irq(irq[i], port);
+
+	return err;
+}
+
 /*
  * Perform initialization and enable port for reception
  */
@@ -1539,6 +1670,7 @@ static int atmel_startup(struct uart_port *port)
 	 * handle an unexpected interrupt
 	 */
 	UART_PUT_IDR(port, -1);
+	atmel_port->ms_irq_enabled = false;
 
 	/*
 	 * Allocate the IRQ
@@ -1551,6 +1683,13 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/*
+	 * Get the GPIO lines IRQ
+	 */
+	retval = atmel_request_gpio_irq(port);
+	if (retval)
+		goto free_irq;
+
+	/*
 	 * Initialize DMA (if necessary)
 	 */
 	atmel_init_property(atmel_port, pdev);
@@ -1568,7 +1707,7 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/* Save current CSR for comparison in atmel_tasklet_func() */
-	atmel_port->irq_status_prev = UART_GET_CSR(port);
+	atmel_port->irq_status_prev = atmel_get_lines_status(port);
 	atmel_port->irq_status = atmel_port->irq_status_prev;
 
 	/*
@@ -1614,6 +1753,11 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	return 0;
+
+free_irq:
+	free_irq(port->irq, port);
+
+	return retval;
 }
 
 /*
@@ -1661,9 +1805,12 @@ static void atmel_shutdown(struct uart_port *port)
 	atmel_port->rx_ring.tail = 0;
 
 	/*
-	 * Free the interrupt
+	 * Free the interrupts
 	 */
 	free_irq(port->irq, port);
+	atmel_free_gpio_irq(port);
+
+	atmel_port->ms_irq_enabled = false;
 }
 
 /*
@@ -2327,6 +2474,86 @@ static int atmel_serial_resume(struct platform_device *pdev)
 #define atmel_serial_resume NULL
 #endif
 
+/*
+ * TODO:
+ * Suppress that stuff when the platform data is eradicated
+ */
+static int atmel_get_pdata_gpio(struct atmel_uart_port *p, struct device *dev)
+{
+	struct atmel_uart_data *pdata = dev_get_platdata(dev);
+	enum mctrl_gpio_idx i;
+	int err;
+	int ret = 0;
+
+	if (gpio_is_valid(pdata->cts_gpio))
+		p->gpios.gpio[UART_GPIO_CTS] = gpio_to_desc(pdata->cts_gpio);
+	if (gpio_is_valid(pdata->rts_gpio))
+		p->gpios.gpio[UART_GPIO_RTS] = gpio_to_desc(pdata->rts_gpio);
+	if (gpio_is_valid(pdata->dtr_gpio))
+		p->gpios.gpio[UART_GPIO_DTR] = gpio_to_desc(pdata->dtr_gpio);
+	if (gpio_is_valid(pdata->dsr_gpio))
+		p->gpios.gpio[UART_GPIO_DSR] = gpio_to_desc(pdata->dsr_gpio);
+	if (gpio_is_valid(pdata->dcd_gpio))
+		p->gpios.gpio[UART_GPIO_DCD] = gpio_to_desc(pdata->dcd_gpio);
+	if (gpio_is_valid(pdata->ri_gpio))
+		p->gpios.gpio[UART_GPIO_RI] = gpio_to_desc(pdata->ri_gpio);
+
+	for (i = UART_GPIO_MIN; i < UART_GPIO_MAX; i++) {
+		/*
+		 * The GPIOs are maybe not all filled,
+		 * this is not an error.
+		 */
+		if (IS_ERR_OR_NULL(p->gpios.gpio[i]))
+			continue;
+
+		err = devm_gpio_request(dev, desc_to_gpio(p->gpios.gpio[i]),
+					get_mctrl_gpio_name(i));
+		if (err) {
+			dev_err(dev, "error requesting %s GPIO\n",
+				get_mctrl_gpio_name(i));
+			ret--;
+			continue;
+		}
+
+		/* Default to 1 as all signals are active low */
+		(void) gpiod_sysfs_set_active_low(p->gpios.gpio[i], 1);
+
+		if (i < UART_GPIO_MAX_INPUT)
+			err = gpiod_direction_input(p->gpios.gpio[i]);
+		else
+			err = gpiod_direction_output(p->gpios.gpio[i], 0);
+		if (err) {
+			dev_err(dev, "Unable to set direction for %s GPIO",
+				get_mctrl_gpio_name(i));
+			devm_gpio_free(dev, desc_to_gpio(p->gpios.gpio[i]));
+			p->gpios.gpio[i] = NULL;
+			ret--;
+		}
+	}
+
+	return ret;
+}
+
+static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
+{
+	struct atmel_uart_data *pdata = dev_get_platdata(dev);
+	enum mctrl_gpio_idx i;
+	int err;
+
+	if (pdata)
+		err = atmel_get_pdata_gpio(p, dev);
+	else
+		err = mctrl_gpio_init(dev, &p->gpios);
+
+	for (i = UART_GPIO_MIN; i < UART_GPIO_MAX_INPUT; i++)
+		if (IS_ERR_OR_NULL(p->gpios.gpio[i]))
+			p->gpio_irq[i] = -EINVAL;
+		else
+			p->gpio_irq[i] = gpiod_to_irq(p->gpios.gpio[i]);
+
+	return err;
+}
+
 static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
@@ -2362,25 +2589,11 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
-	port->rts_gpio = -EINVAL; /* Invalid, zero could be valid */
-	if (pdata)
-		port->rts_gpio = pdata->rts_gpio;
-	else if (np)
-		port->rts_gpio = of_get_named_gpio(np, "rts-gpios", 0);
 
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
+	ret = atmel_init_gpios(port, &pdev->dev);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Failed to initialize %d GPIOs. The serial port may not work as expected",
+			ret * -1);
 
 	ret = atmel_init_port(port, pdev);
 	if (ret)
@@ -2434,6 +2647,7 @@ err_alloc_ring:
 		port->clk = NULL;
 	}
 err:
+	mctrl_gpio_free(&port->gpios);
 	return ret;
 }
 
@@ -2457,6 +2671,8 @@ static int atmel_serial_remove(struct platform_device *pdev)
 
 	clk_put(atmel_port->clk);
 
+	mctrl_gpio_free(&atmel_port->gpios);
+
 	return ret;
 }
 
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index e26b0c14edea..565c5c693c7f 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -85,6 +85,11 @@ struct atmel_uart_data {
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
 	int			rts_gpio;	/* optional RTS GPIO */
+	int			cts_gpio;	/* optional CTS GPIO */
+	int			dtr_gpio;	/* optional DTR GPIO */
+	int			dsr_gpio;	/* optional DSR GPIO */
+	int			dcd_gpio;	/* optional DCD GPIO */
+	int			ri_gpio;	/* optional Ring GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.5

