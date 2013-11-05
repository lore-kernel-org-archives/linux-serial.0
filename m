From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/4] ARM/serial: at91: move machine quirk into machine
Date: Tue,  5 Nov 2013 10:28:42 +0100
Message-ID: <1383643722-14189-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

This removes the dependency on <mach/gpio.h> from the AT91 serial
driver by adding an mctrl callback quirk.

Long term it is better if the driver calls the generic GPIO
interface (gpio_set_value()), but this gets a hairy cross-depency
into the machine-local headers out of the way for now.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Greg, if you're OK with this approach please give me an ACK
so I can take this through the ARM SoC or GPIO tree in the end.
---
 arch/arm/mach-at91/at91rm9200_devices.c | 14 ++++++++++++++
 drivers/tty/serial/atmel_serial.c       | 19 ++++---------------
 include/linux/platform_data/atmel.h     |  1 +
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 3ebc9792560c..3ce6ba6341ed 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -12,6 +12,7 @@
  */
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/termios.h>
 
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
@@ -957,9 +958,22 @@ static struct resource uart0_resources[] = {
 	},
 };
 
+static void uart0_set_mctrl(unsigned int mctrl)
+{
+	/*
+	 * AT91RM9200 Errata #39: RTS0 is not internally connected
+	 * to PA21. We need to drive the pin manually.
+	 */
+	if (mctrl & TIOCM_RTS)
+		at91_set_gpio_value(AT91_PIN_PA21, 0);
+	else
+		at91_set_gpio_value(AT91_PIN_PA21, 1);
+}
+
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.set_mctrl	= uart0_set_mctrl,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d067285a2d20..5b29e3152d7e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -47,7 +47,6 @@
 
 #ifdef CONFIG_ARM
 #include <mach/cpu.h>
-#include <asm/gpio.h>
 #endif
 
 #define PDC_BUFFER_SIZE		512
@@ -176,6 +175,7 @@ struct atmel_uart_port {
 	void (*schedule_tx)(struct uart_port *port);
 	void (*release_rx)(struct uart_port *port);
 	void (*release_tx)(struct uart_port *port);
+	void (*set_mctrl)(unsigned int mctrl);
 };
 
 static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
@@ -300,20 +300,8 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
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
-	}
-#endif
+	if (atmel_port->set_mctrl)
+		atmel_port->set_mctrl(mctrl);
 
 	if (mctrl & TIOCM_RTS)
 		control |= ATMEL_US_RTSEN;
@@ -2365,6 +2353,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
+	port->set_mctrl = pdata->set_mctrl;
 
 	ret = atmel_init_port(port, pdev);
 	if (ret)
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index cea9f70133c5..59991aae0217 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -84,6 +84,7 @@ struct atmel_uart_data {
 	short			use_dma_rx;	/* use receive DMA? */
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
+	void (*set_mctrl)(unsigned int mctrl);	/* mctrl callback */
 };
 
  /* Touchscreen Controller */
-- 
1.8.3.1

