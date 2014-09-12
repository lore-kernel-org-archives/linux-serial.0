From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals
Date: Fri, 12 Sep 2014 17:36:43 +0200
Message-ID: <1410536203-20591-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:51328 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751296AbaILPeK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Sep 2014 11:34:10 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry pervushin <dimka@embeddedalley.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Dedicated CTS and RTS pins are unusable together with a lot of other
peripherals because they share the same line. Pinctrl is limited.

Moreover, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
so we have to control them via GPIO.

This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
signals.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 10 +++++-
 drivers/tty/serial/Kconfig           |  1 +
 drivers/tty/serial/mxs-auart.c       | 38 ++++++++++++++++++++--
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
index 59a40f1..7c408c8 100644
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
@@ -11,8 +11,13 @@ Required properties:
 - dma-names: "rx" for RX channel, "tx" for TX channel.
 
 Optional properties:
-- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines,
+- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines
+  for hardware flow control,
 	it also means you enable the DMA support for this UART.
+- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
+  line respectively. It will use specified PIO instead of the peripheral
+  function pin for the USART feature.
+  If unsure, don't specify this property.
 
 Example:
 auart0: serial@8006a000 {
@@ -21,6 +26,9 @@ auart0: serial@8006a000 {
 	interrupts = <112>;
 	dmas = <&dma_apbx 8>, <&dma_apbx 9>;
 	dma-names = "rx", "tx";
+	cts-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+	dsr-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	dcd-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 };
 
 Note: Each auart port should have an alias correctly numbered in "aliases"
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4fe8ca1..90e8516 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1357,6 +1357,7 @@ config SERIAL_MXS_AUART
 	depends on ARCH_MXS
 	tristate "MXS AUART support"
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  This driver supports the MXS Application UART (AUART) port.
 
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 024e54f..f200237 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -38,6 +38,18 @@
 
 #include <asm/cacheflush.h>
 
+/* based on clps711x.c from linux-next:
+ *  serial: clps711x: Use mctrl_gpio helpers for handling modem signals
+ *  serial: clps711x: Fix COMPILE_TEST build for target without GPIOLIB support
+ * based on Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt from linux-next:
+ *  serial: clps711x: Use mctrl_gpio helpers for handling modem signals
+ * based on atmel_serial.c from linux-next:
+ *  tty/serial: at91: use mctrl_gpio helpers
+ *  TODO: tty/serial: at91: add interrupts for modem control lines
+ *  */
+#include <linux/err.h>
+#include "serial_mctrl_gpio.h"
+
 #define MXS_AUART_MAJOR 242
 #define MXS_AUART_PORTS 5
 #define MXS_AUART_FIFO_SIZE		16
@@ -156,6 +168,8 @@ struct mxs_auart_port {
 	struct scatterlist rx_sgl;
 	struct dma_chan	*rx_dma_chan;
 	void *rx_dma_buf;
+
+	struct mctrl_gpios *gpios;
 };
 
 static struct platform_device_id mxs_auart_devtype[] = {
@@ -417,6 +431,8 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 
 	s->ctrl = mctrl;
 	writel(ctrl, u->membase + AUART_CTRL2);
+
+	mctrl_gpio_set(s->gpios, mctrl);
 }
 
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
@@ -433,7 +449,9 @@ static u32 mxs_auart_get_mctrl(struct uart_port *u)
 	if (ctrl2 & AUART_CTRL2_RTS)
 		mctrl |= TIOCM_RTS;
 
-	return mctrl;
+	/*TODO: delta: uart_handle_dcd_change, uart_handle_cts_change, RI, DSR,
+	 * it should be in interrupt only?*/
+	return mctrl_gpio_get(s->gpios, &mctrl);
 }
 
 static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s);
@@ -637,7 +655,12 @@ static void mxs_auart_settermios(struct uart_port *u,
 		ctrl |= AUART_LINECTRL_STP2;
 
 	/* figure out the hardware flow control settings */
-	if (cflag & CRTSCTS) {
+	/*FIXME: DMA for hardware flow control only? */
+	if (cflag & CRTSCTS &&
+			(IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
+					 UART_GPIO_RTS)) ||
+			 IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
+					 UART_GPIO_CTS)))) {
 		/*
 		 * The DMA has a bug(see errata:2836) in mx23.
 		 * So we can not implement the DMA for auart in mx23,
@@ -696,8 +719,12 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
 
+	/* TODO: get mctrl, see atmel_serial.c atmel_tasklet_func() */
 	if (istat & AUART_INTR_CTSMIS) {
-		uart_handle_cts_change(&s->port, stat & AUART_STAT_CTS);
+		if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
+						UART_GPIO_CTS)))
+			uart_handle_cts_change(&s->port,
+					stat & AUART_STAT_CTS);
 		writel(AUART_INTR_CTSMIS,
 				s->port.membase + AUART_INTR_CLR);
 		istat &= ~AUART_INTR_CTSMIS;
@@ -1084,6 +1111,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, s);
 
+	s->gpios = mctrl_gpio_init(&pdev->dev, 0);
+
 	auart_port[s->port.line] = s;
 
 	mxs_auart_reset(&s->port);
@@ -1100,6 +1129,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	return 0;
 
 out_free_irq:
+	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
 	auart_port[pdev->id] = NULL;
 	free_irq(s->irq, s);
 out_free_clk:
@@ -1118,6 +1148,8 @@ static int mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
+	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
+
 	clk_put(s->clk);
 	free_irq(s->irq, s);
 	kfree(s);
-- 
1.7.11.3

